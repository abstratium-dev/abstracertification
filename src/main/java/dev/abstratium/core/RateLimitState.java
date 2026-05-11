package dev.abstratium.core;

import java.time.Instant;
import java.util.ArrayDeque;
import java.util.Deque;
import java.util.Iterator;
import java.util.concurrent.ConcurrentHashMap;

import jakarta.enterprise.context.ApplicationScoped;

/**
 * Holds the in-memory rate limit state.
 * Separated from the interceptor so it can be injected in tests.
 */
@ApplicationScoped
public class RateLimitState {

    private final ConcurrentHashMap<String, Deque<Instant>> requestLog = new ConcurrentHashMap<>();

    /**
     * Check whether the given key is within the allowed rate limit.
     * If allowed, records the request and returns {@code true}.
     * If the limit is exceeded, returns {@code false}.
     */
    public boolean tryAcquire(String key, int maxRequests, int windowSeconds) {
        Instant now = Instant.now();
        Instant windowStart = now.minusSeconds(windowSeconds);

        Deque<Instant> timestamps = requestLog.computeIfAbsent(key, k -> new ArrayDeque<>());

        synchronized (timestamps) {
            Iterator<Instant> it = timestamps.iterator();
            while (it.hasNext()) {
                if (it.next().isBefore(windowStart)) {
                    it.remove();
                } else {
                    break;
                }
            }

            if (timestamps.size() >= maxRequests) {
                return false;
            }

            timestamps.addLast(now);
        }

        evictStaleEntries(windowSeconds);
        return true;
    }

    /**
     * Clears all rate-limit state. Useful for testing.
     */
    public void clear() {
        requestLog.clear();
    }

    private void evictStaleEntries(int windowSeconds) {
        Instant cutoff = Instant.now().minusSeconds(windowSeconds * 2L);
        requestLog.entrySet().removeIf(entry -> {
            Deque<Instant> deque = entry.getValue();
            synchronized (deque) {
                return deque.isEmpty() || deque.peekLast().isBefore(cutoff);
            }
        });
    }
}
