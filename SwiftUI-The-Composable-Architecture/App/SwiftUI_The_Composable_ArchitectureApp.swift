//
//  SwiftUI_The_Composable_ArchitectureApp.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 27.12.2023.
//

import SwiftUI
import ComposableArchitecture

@main
struct SwiftUI_The_Composable_ArchitectureApp: App {
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: Self.store)
        }
    }
}
