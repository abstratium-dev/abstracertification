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

<<<<<<< HEAD:src/main/java/dev/abstratium/certification/boundary/publik/ConfigResource.java
    @ConfigProperty(name = "provide.ai.help")
    boolean provideAiHelp;
=======
    @ConfigProperty(name = "warning.message", defaultValue = "-")
    String warningMessage;

    @ConfigProperty(name = "abstratium.stage", defaultValue = "dev")
    String stage;
>>>>>>> upstream/main:src/main/java/dev/abstratium/core/boundary/publik/ConfigResource.java

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public SuccessResponse config() {
<<<<<<< HEAD:src/main/java/dev/abstratium/certification/boundary/publik/ConfigResource.java
        return new SuccessResponse(clientLogLevel, provideAiHelp, BuildInfo.BUILD_TIMESTAMP);
=======
        return new SuccessResponse(clientLogLevel, BuildInfo.BUILD_TIMESTAMP, warningMessage, stage);
>>>>>>> upstream/main:src/main/java/dev/abstratium/core/boundary/publik/ConfigResource.java
    }

    @RegisterForReflection
    public static class SuccessResponse {
        public String logLevel;
        public boolean provideAiHelp;
        public String baselineBuildTimestamp;
<<<<<<< HEAD:src/main/java/dev/abstratium/certification/boundary/publik/ConfigResource.java
        
        public SuccessResponse(String logLevel, boolean provideAiHelp, String baselineBuildTimestamp) {
=======
        public String warningMessage;
        public String stage;

        public SuccessResponse(String logLevel, String baselineBuildTimestamp, String warningMessage, String stage) {
>>>>>>> upstream/main:src/main/java/dev/abstratium/core/boundary/publik/ConfigResource.java
            this.logLevel = logLevel;
            this.provideAiHelp = provideAiHelp;
            this.baselineBuildTimestamp = baselineBuildTimestamp;
            this.warningMessage = warningMessage;
            this.stage = stage;
        }
    }
}
