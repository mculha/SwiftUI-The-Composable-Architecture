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
    
    @State var store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: self.store)
        }
    }
}
