package dev.abstratium.core.boundary.publik;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import dev.abstratium.core.BuildInfo;
import io.quarkus.runtime.annotations.RegisterForReflection;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/public/config")
@Tag(name = "API", description = "Public API endpoints")
public class ConfigResource {

    @ConfigProperty(name = "client.log.level")
    String clientLogLevel;

    @ConfigProperty(name = "provide.ai.help")
    boolean provideAiHelp;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public SuccessResponse config() {
        return new SuccessResponse(clientLogLevel, provideAiHelp, BuildInfo.BUILD_TIMESTAMP);
    }

    @RegisterForReflection
    public static class SuccessResponse {
        public String logLevel;
        public boolean provideAiHelp;
        public String baselineBuildTimestamp;
        
        public SuccessResponse(String logLevel, boolean provideAiHelp, String baselineBuildTimestamp) {
            this.logLevel = logLevel;
            this.provideAiHelp = provideAiHelp;
            this.baselineBuildTimestamp = baselineBuildTimestamp;
        }
    }
}
