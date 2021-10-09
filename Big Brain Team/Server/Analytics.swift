//
//  Analytics.swift
//  Big Brain Team
//
//  Created by Nick Oltyan on 09.10.2021.
//

import Firebase


class ServerAnalytics {
    /// Initiates when user the first time open the app.
    func logStartOnboarding() {
        Analytics.logEvent(AnalyticsEventTutorialBegin, parameters: [:])
    }
    
    /// Initiates when user tap "finish" button during onboarding.
    func logFinishOnboarding() {
        Analytics.logEvent(AnalyticsEventTutorialComplete, parameters: [:])
    }
    
    func logLevelPassed(level: Int, successfully: Bool) {
        Analytics.logEvent("level_\(level)_passed", parameters: [
            "successfully": successfully,
        ])
    }
    
    func logRestart() {
        Analytics.logEvent("restart", parameters: [:])
    }
    
}
