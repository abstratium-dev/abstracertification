package dev.abstratium.certification.boundary.publik;

import java.util.Map;

import io.quarkus.runtime.annotations.RegisterForReflection;

/**
 * Response payload indicating which questions were answered correctly.
 * Maps question IDs to a boolean (true = correct, false = incorrect).
 */
@RegisterForReflection
public class CheckAnswersResponse {

    private Map<String, Boolean> results;

    public CheckAnswersResponse() {
    }

    public CheckAnswersResponse(Map<String, Boolean> results) {
        this.results = results;
    }

    public Map<String, Boolean> getResults() {
        return results;
    }

    public void setResults(Map<String, Boolean> results) {
        this.results = results;
    }
}
