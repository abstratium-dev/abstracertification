package dev.abstratium.core;

import io.vertx.ext.web.RoutingContext;
import jakarta.ws.rs.core.HttpHeaders;

public final class IpAddressUtil {

    private IpAddressUtil() {}

    public static String extractIpAddress(HttpHeaders headers, RoutingContext rc) {
        String forwarded = headers.getHeaderString("X-Forwarded-For");
        if (forwarded != null && !forwarded.isBlank()) {
            return forwarded.split(",")[0].trim();
        }
        String realIp = headers.getHeaderString("X-Real-IP");
        if (realIp != null && !realIp.isBlank()) {
            return realIp.trim();
        }
        return rc.request().remoteAddress().host();
    }
}
