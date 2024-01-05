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
        @PresentationState var alert: AlertState<Action.Alert>?
        let contact: Contact
    }
    
    enum Action: Equatable {
        case alert(PresentationAction<Alert>)
        case delegate(Delegate)
        case deleteButtonTapped
        
        enum Alert: Equatable {
            case confirmDeletion
        }
        
        enum Delegate: Equatable {
            case confirmDeletion
        }
    }
    @Dependency(\.dismiss) var dismiss
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .alert(.presented(.confirmDeletion)):
                return .run { send in
                    await send(.delegate(.confirmDeletion))
                    await self.dismiss()
                }
            case .alert:
                return .none
            case .delegate:
                return .none
            case .deleteButtonTapped:
                state.alert = .confirmDeletion
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}

extension AlertState where Action == ContactDetailFeature.Action.Alert {
    static let confirmDeletion = Self {
        TextState("Are you sure?")
    } actions: {
        ButtonState(role: .destructive, action: .confirmDeletion) {
            TextState("Delete")
        }
    }
}
