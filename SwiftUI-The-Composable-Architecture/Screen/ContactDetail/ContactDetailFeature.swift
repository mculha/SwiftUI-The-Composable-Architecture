//
//  ContactDetailFeature.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 5.01.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ContactDetailFeature {
    struct State: Equatable {
        let contact: Contact
    }
    
    enum Action: Equatable {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
