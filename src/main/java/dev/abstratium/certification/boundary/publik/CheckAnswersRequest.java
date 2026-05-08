package dev.abstratium.certification.boundary.publik;

import java.util.Map;

/**
 * Request payload for checking answers.
 * Maps question IDs to the selected answer option IDs.
 */
public class CheckAnswersRequest {

    private Map<String, String> answers;

    public Map<String, String> getAnswers() {
        return answers;
    }

    public void setAnswers(Map<String, String> answers) {
        this.answers = answers;
    }
}
