//
//  ContactsFeature.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 1.01.2024.
//

import Foundation
import ComposableArchitecture

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    
    struct State: Equatable {
        @PresentationState var addContact: AddContactFeature.State?
        
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
        case addContact(PresentationAction<AddContactFeature.Action>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .addButtonTapped:
                state.addContact = AddContactFeature.State(
                    contact: Contact(id: UUID(), name: "")
                )
                return .none
            case .addContact(.presented(.cancelButtonTapped)):
                state.addContact = nil
                return .none
            case .addContact(.presented(.saveButtonTapped)):
                guard let contact = state.addContact?.contact else { return .none }
                state.contacts.append(contact)
                state.addContact = nil
                return .none
            case .addContact(.dismiss):
                return .none
            case .addContact(.presented(.setName(_))):
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
    
}
