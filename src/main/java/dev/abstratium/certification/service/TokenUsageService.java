package dev.abstratium.certification.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jboss.logging.Logger;

import com.google.common.cache.Cache;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.Weigher;

import jakarta.enterprise.context.ApplicationScoped;

/**
 * Service for tracking AI token usage per IP address using Guava cache.
 * Enforces daily token limits to prevent abuse and manage costs.
 */
@ApplicationScoped
public class TokenUsageService {

    private static final Logger LOG = Logger.getLogger(TokenUsageService.class);
    private static final int BYTES_PER_CACHE_ENTRY = 104;

    @ConfigProperty(name = "ai.token.limit.per.day")
    int dailyTokenLimit;

    @ConfigProperty(name = "ai.token.cache.max.size")
    long cacheMaxSizeBytes;

    /**
     * Cache key: IP address + date string (YYYY-MM-DD)
     * Cache value: Token usage count for that IP on that date
     */
    private final Cache<String, Integer> tokenUsageCache;

    public TokenUsageService() {
        this.tokenUsageCache = CacheBuilder.newBuilder()
                .maximumWeight(cacheMaxSizeBytes())
                .weigher(new TokenUsageWeigher())
                .expireAfterWrite(24, TimeUnit.HOURS) // Auto-expire after 24 hours
                .build();
    }

    /**
     * Initialize the cache with configuration values.
     * This method is called after CDI injection is complete.
     */
    private long cacheMaxSizeBytes() {
        // Default to 10MB if not configured
        return cacheMaxSizeBytes > 0 ? cacheMaxSizeBytes : 10_485_760L;
    }

    /**
     * Check if the given IP address can consume the specified number of tokens.
     * Returns true if allowed, false if the daily limit would be exceeded.
     */
    public boolean canConsumeTokens(String clientIp, int tokensRequested) {
        String cacheKey = getCacheKey(clientIp);
        
        try {
            int currentUsage = tokenUsageCache.get(cacheKey, () -> 0);
            int newUsage = currentUsage + tokensRequested;
            
            LOG.debugf("Token usage check for IP %s: current=%d, requested=%d, limit=%d", 
                      clientIp, currentUsage, tokensRequested, dailyTokenLimit);
            
            return newUsage <= dailyTokenLimit;
        } catch (ExecutionException e) {
            LOG.errorf(e, "Error checking token usage for IP: %s", clientIp);
            // Fail open - allow the request but log the error
            return true;
        }
    }

    /**
     * Record token consumption for the given IP address.
     * Should be called after successful AI response generation.
     */
    public void recordTokenUsage(String clientIp, int tokensConsumed) {
        String cacheKey = getCacheKey(clientIp);
        
        try {
            int currentUsage = tokenUsageCache.get(cacheKey, () -> 0);
            int newUsage = currentUsage + tokensConsumed;
            tokenUsageCache.put(cacheKey, newUsage);
            
            LOG.infof("Recorded token usage for IP %s: +%d tokens (total: %d/%d)", 
                     clientIp, tokensConsumed, newUsage, dailyTokenLimit);
        } catch (ExecutionException e) {
            LOG.errorf(e, "Error recording token usage for IP: %s", clientIp);
        }
    }

    /**
     * Get the current token usage for the given IP address today.
     */
    public int getCurrentUsage(String clientIp) {
        String cacheKey = getCacheKey(clientIp);
        
        try {
            return tokenUsageCache.get(cacheKey, () -> 0);
        } catch (ExecutionException e) {
            LOG.errorf(e, "Error getting current token usage for IP: %s", clientIp);
            return 0;
        }
    }

    /**
     * Get the remaining tokens available for the given IP address today.
     */
    public int getRemainingTokens(String clientIp) {
        int currentUsage = getCurrentUsage(clientIp);
        return Math.max(0, dailyTokenLimit - currentUsage);
    }

    /**
     * Generate cache key combining IP address and current date.
     */
    private String getCacheKey(String clientIp) {
        LocalDate today = LocalDate.now(ZoneId.of("UTC"));
        return clientIp + ":" + today.toString();
    }

    /**
     * Custom weigher to estimate memory usage of cache entries.
     * Each entry is estimated as: key (IP + date) ~ 50 bytes + value (int) ~ 4 bytes + overhead ~ 50 bytes
     */
    private static class TokenUsageWeigher implements Weigher<String, Integer> {
        @Override
        public int weigh(String key, Integer value) {
            return BYTES_PER_CACHE_ENTRY;
        }
    }

    /**
     * Get cache statistics for monitoring.
     */
    public String getCacheStats() {
        var stats = tokenUsageCache.stats();
        return String.format("Cache Stats - Size: %d, Hit Rate: %.2f%%, Miss Rate: %.2f%%, Evictions: %d",
                tokenUsageCache.size(),
                stats.hitRate() * 100,
                stats.missRate() * 100,
                stats.evictionCount());
    }

    /**
     * Clear all token usage data (for testing or admin purposes).
     */
    public void clearCache() {
        tokenUsageCache.invalidateAll();
        LOG.info("Token usage cache cleared");
    }

    /**
     * Get the configured daily token limit.
     */
    public int getDailyLimit() {
        return dailyTokenLimit;
    }

    /**
     * Get approximate memory usage of the cache in bytes.
     */
    public long getEstimatedMemoryUsage() {
        return tokenUsageCache.size() * BYTES_PER_CACHE_ENTRY; // Using same estimate as weigher
    }

    /**
     * Get all IP addresses currently in the cache with their usage.
     * Returns a map of IP address -> token usage count.
     */
    public java.util.Map<String, Integer> getAllIpUsage() {
        java.util.Map<String, Integer> result = new java.util.HashMap<>();
        var cacheMap = tokenUsageCache.asMap();
        
        for (var entry : cacheMap.entrySet()) {
            String cacheKey = entry.getKey();
            Integer tokenUsage = entry.getValue();
            
            // Extract IP from cache key (format: "ip:YYYY-MM-DD")
            String ip = cacheKey.substring(0, cacheKey.lastIndexOf(':'));
            result.put(ip, tokenUsage);
        }
        
        return result;
    }

    /**
     * Get bytes usage per IP address.
     * Returns a map of IP address -> estimated bytes used in cache.
     */
    public java.util.Map<String, Long> getBytesPerIp() {
        java.util.Map<String, Long> result = new java.util.HashMap<>();
        var cacheMap = tokenUsageCache.asMap();
        
        for (var entry : cacheMap.entrySet()) {
            String cacheKey = entry.getKey();
            
            // Extract IP from cache key (format: "ip:YYYY-MM-DD")
            String ip = cacheKey.substring(0, cacheKey.lastIndexOf(':'));
            
            // Each entry uses BYTES_PER_CACHE_ENTRY bytes
            result.merge(ip, (long) BYTES_PER_CACHE_ENTRY, Long::sum);
        }
        
        return result;
    }

    /**
     * Get detailed cache information including all stats.
     */
    public CacheInfo getCacheInfo() {
        var stats = tokenUsageCache.stats();
        return new CacheInfo(
            tokenUsageCache.size(),
            getEstimatedMemoryUsage(),
            stats.hitRate(),
            stats.missRate(),
            stats.evictionCount(),
            stats.requestCount(),
            getAllIpUsage(),
            getBytesPerIp()
        );
    }

    /**
     * Record for cache information response.
     */
    public static class CacheInfo {
        public final long size;
        public final long estimatedMemoryUsage;
        public final double hitRate;
        public final double missRate;
        public final long evictionCount;
        public final long requestCount;
        public final java.util.Map<String, Integer> ipUsage;
        public final java.util.Map<String, Long> bytesPerIp;

        public CacheInfo(long size, long estimatedMemoryUsage, double hitRate, double missRate,
                        long evictionCount, long requestCount,
                        java.util.Map<String, Integer> ipUsage,
                        java.util.Map<String, Long> bytesPerIp) {
            this.size = size;
            this.estimatedMemoryUsage = estimatedMemoryUsage;
            this.hitRate = hitRate;
            this.missRate = missRate;
            this.evictionCount = evictionCount;
            this.requestCount = requestCount;
            this.ipUsage = ipUsage;
            this.bytesPerIp = bytesPerIp;
        }
    }
}
