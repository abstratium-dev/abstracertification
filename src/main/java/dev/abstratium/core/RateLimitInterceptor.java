package dev.abstratium.core;

import java.lang.reflect.Parameter;

import io.vertx.ext.web.RoutingContext;
import jakarta.annotation.Priority;
import jakarta.inject.Inject;
import jakarta.interceptor.AroundInvoke;
import jakarta.interceptor.Interceptor;
import jakarta.interceptor.InvocationContext;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.Response;

import org.jboss.logging.Logger;

/**
 * CDI interceptor that enforces IP-based rate limiting on methods
 * annotated with {@link RateLimited}.
 *
 * The interceptor inspects method parameters to find {@link HttpHeaders}
 * and {@link RoutingContext} instances, then delegates to
 * {@link IpAddressUtil#extractIpAddress} to obtain the client IP.
 *
 * Rate state is kept in {@link RateLimitState}.
 */
@RateLimited
@Interceptor
@Priority(Interceptor.Priority.PLATFORM_BEFORE + 100)
public class RateLimitInterceptor {

    private static final Logger LOG = Logger.getLogger(RateLimitInterceptor.class);

    @Inject
    RateLimitState rateLimitState;

    @AroundInvoke
    Object rateLimit(InvocationContext ctx) throws Exception {
        RateLimited annotation = ctx.getMethod().getAnnotation(RateLimited.class);
        if (annotation == null) {
            annotation = ctx.getTarget().getClass().getAnnotation(RateLimited.class);
        }
        if (annotation == null) {
            return ctx.proceed();
        }

        int maxRequests = annotation.maxRequests();
        int windowSeconds = annotation.windowSeconds();

        HttpHeaders headers = null;
        RoutingContext rc = null;

        Parameter[] params = ctx.getMethod().getParameters();
        Object[] args = ctx.getParameters();
        for (int i = 0; i < params.length; i++) {
            if (args[i] instanceof HttpHeaders h) {
                headers = h;
            } else if (args[i] instanceof RoutingContext r) {
                rc = r;
            }
        }

        if (headers == null || rc == null) {
            LOG.warn("@RateLimited method is missing HttpHeaders or RoutingContext parameters – skipping rate limit");
            return ctx.proceed();
        }

        String ip = IpAddressUtil.extractIpAddress(headers, rc);
        String key = ctx.getMethod().getDeclaringClass().getName() + "#" + ctx.getMethod().getName() + ":" + ip;

        if (!rateLimitState.tryAcquire(key, maxRequests, windowSeconds)) {
            LOG.infof("Rate limit exceeded for IP %s on %s#%s (%d requests in %ds window)",
                    ip, ctx.getMethod().getDeclaringClass().getSimpleName(),
                    ctx.getMethod().getName(), maxRequests, windowSeconds);
            return Response.status(Response.Status.TOO_MANY_REQUESTS)
                    .entity(new RateLimitError("Too many requests. Please try again later."))
                    .build();
        }

        LOG.debugf("Rate limit check passed for IP %s on %s#%s",
                ip, ctx.getMethod().getDeclaringClass().getSimpleName(), ctx.getMethod().getName());

        return ctx.proceed();
    }

    public static class RateLimitError {
        public String error;

        public RateLimitError() {}

        public RateLimitError(String error) {
            this.error = error;
        }
    }
}
