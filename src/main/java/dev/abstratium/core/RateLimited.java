package dev.abstratium.core;

import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import jakarta.enterprise.util.Nonbinding;
import jakarta.interceptor.InterceptorBinding;

/**
 * Annotation that enables IP-based rate limiting on JAX-RS resource methods.
 * The method's resource class must inject {@link jakarta.ws.rs.core.HttpHeaders}
 * and {@link io.vertx.ext.web.RoutingContext} as {@code @Context} parameters
 * (they are resolved from the method parameters automatically by the interceptor).
 *
 * @see RateLimitInterceptor
 */
@Inherited
@InterceptorBinding
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface RateLimited {

    /**
     * Maximum number of requests allowed within the time window.
     */
    @Nonbinding
    int maxRequests() default 5;

    /**
     * Time window in seconds.
     */
    @Nonbinding
    int windowSeconds() default 60;
}
