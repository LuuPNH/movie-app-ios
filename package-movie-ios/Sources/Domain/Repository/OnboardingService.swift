//
//  File.swift
//  
//
//  Created by Luu Phan on 13/02/2023.
//

import Foundation

public protocol OnboardingService {
    
    func checkShowOnboarding() -> ShowOnboarding
    
    func getStartedApp() -> ShowOnboarding

}
public enum ShowOnboarding: Encodable, Decodable {
    case isShowedOnboarding
    case unShowed
}
