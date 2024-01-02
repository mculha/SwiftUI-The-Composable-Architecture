//
//  AddContactFeature.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 1.01.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AddContactFeature {
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none
            case .saveButtonTapped:
                return .none
            case .setName(let name):
                state.contact.name = name
                return .none
            }
        }
    }
}
