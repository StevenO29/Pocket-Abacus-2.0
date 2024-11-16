//
//  Router.swift
//  Pocket Abacus 2.0
//
//  Created by Steven Ongkowidjojo on 15/11/24.
//

import SwiftUI
import Observation

@Observable
class Router  {
    var navPath = NavigationPath()
    
    public enum Destination  : Codable, Hashable {
        case freeMode
        case relaxMode
        case howToPlay
    }
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}
