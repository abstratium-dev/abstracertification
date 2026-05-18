package dev.abstratium.certification.boundary.admin;

import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import dev.abstratium.certification.service.TokenUsageService;
import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

/**
 * Admin endpoints for monitoring and managing AI token usage.
 * Requires admin role for access.
 */
@Path("/public/admin/token-usage")
// TODO FIXME @Path("/api/admin/token-usage")
@Tag(name = "Admin Token Usage", description = "Admin endpoints for AI token usage monitoring")
public class TokenUsageResource {

    @Inject
    TokenUsageService tokenUsageService;

    /**
     * Get comprehensive cache statistics and IP usage information.
     * Returns cache stats, all IP addresses in cache, and bytes per IP.
     */
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response getCacheInfo() {
        try {
            TokenUsageService.CacheInfo cacheInfo = tokenUsageService.getCacheInfo();
            return Response.ok(cacheInfo).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(new ErrorResponse("Error retrieving cache information: " + e.getMessage()))
                    .build();
        }
    }

    /**
     * Get all IP addresses currently in the cache with their token usage.
     */
    @GET
    @Path("/ips")
    @Produces(MediaType.APPLICATION_JSON)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response getAllIpUsage() {
        try {
            var ipUsage = tokenUsageService.getAllIpUsage();
            return Response.ok(ipUsage).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(new ErrorResponse("Error retrieving IP usage: " + e.getMessage()))
                    .build();
        }
    }

    /**
     * Get bytes usage per IP address.
     */
    @GET
    @Path("/bytes")
    @Produces(MediaType.APPLICATION_JSON)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response getBytesPerIp() {
        try {
            var bytesPerIp = tokenUsageService.getBytesPerIp();
            return Response.ok(bytesPerIp).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(new ErrorResponse("Error retrieving bytes per IP: " + e.getMessage()))
                    .build();
        }
    }

    /**
     * Get cache statistics as a formatted string.
     */
    @GET
    @Path("/stats")
    @Produces(MediaType.TEXT_PLAIN)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response getCacheStats() {
        try {
            String stats = tokenUsageService.getCacheStats();
            return Response.ok(stats).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.TEXT_PLAIN)
                    .entity("Error retrieving cache stats: " + e.getMessage())
                    .build();
        }
    }

    /**
     * Get current usage for a specific IP address.
     */
    @GET
    @Path("/ip/{ipAddress}")
    @Produces(MediaType.APPLICATION_JSON)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response getIpUsage(@PathParam("ipAddress") String ipAddress) {
        try {
            int currentUsage = tokenUsageService.getCurrentUsage(ipAddress);
            int remainingTokens = tokenUsageService.getRemainingTokens(ipAddress);
            int dailyLimit = tokenUsageService.getDailyLimit();
            
            IpUsageInfo info = new IpUsageInfo(ipAddress, currentUsage, remainingTokens, dailyLimit);
            return Response.ok(info).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(new ErrorResponse("Error retrieving IP usage: " + e.getMessage()))
                    .build();
        }
    }

    /**
     * Clear all token usage data from cache.
     * WARNING: This will reset all rate limiting counters.
     */
    @GET
    @Path("/clear")
    @Produces(MediaType.APPLICATION_JSON)
    // TODO FIXME @RolesAllowed({Roles.ADMIN})
    public Response clearCache() {
        try {
            tokenUsageService.clearCache();
            return Response.ok(new SuccessResponse("Token usage cache cleared successfully")).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .type(MediaType.APPLICATION_JSON)
                    .entity(new ErrorResponse("Error clearing cache: " + e.getMessage()))
                    .build();
        }
    }

    /**
     * Error response record.
     */
    @RegisterForReflection
    public static class ErrorResponse {
        public String error;
        
        public ErrorResponse(String error) {
            this.error = error;
        }
    }

    /**
     * Success response record.
     */
    @RegisterForReflection
    public static class SuccessResponse {
        public String message;
        
        public SuccessResponse(String message) {
            this.message = message;
        }
    }

    /**
     * IP usage information record.
     */
    @RegisterForReflection
    public static class IpUsageInfo {
        public String ipAddress;
        public int currentUsage;
        public int remainingTokens;
        public int dailyLimit;
        
        public IpUsageInfo(String ipAddress, int currentUsage, int remainingTokens, int dailyLimit) {
            this.ipAddress = ipAddress;
            this.currentUsage = currentUsage;
            this.remainingTokens = remainingTokens;
            this.dailyLimit = dailyLimit;
        }
    }
}
