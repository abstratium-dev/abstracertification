package dev.abstratium.certification.boundary.publik;

import java.util.Map;

/**
 * Response payload indicating which questions were answered correctly.
 * Maps question IDs to a boolean (true = correct, false = incorrect).
 */
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
