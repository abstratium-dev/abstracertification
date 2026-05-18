package dev.abstratium.certification.boundary.publik;

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

    @ConfigProperty(name = "warning.message", defaultValue = "-")
    String warningMessage;

    @ConfigProperty(name = "abstratium.stage", defaultValue = "dev")
    String stage;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public SuccessResponse config() {
        return new SuccessResponse(clientLogLevel, BuildInfo.BUILD_TIMESTAMP, warningMessage, stage, provideAiHelp);
    }

    @RegisterForReflection
    public static class SuccessResponse {
        public String logLevel;
        public boolean provideAiHelp;
        public String baselineBuildTimestamp;
        public String warningMessage;
        public String stage;
        
        public SuccessResponse(String logLevel, String baselineBuildTimestamp, String warningMessage, String stage, boolean provideAiHelp) {
            this.logLevel = logLevel;
            this.provideAiHelp = provideAiHelp;
            this.baselineBuildTimestamp = baselineBuildTimestamp;
            this.warningMessage = warningMessage;
            this.stage = stage;
        }
    }
}
