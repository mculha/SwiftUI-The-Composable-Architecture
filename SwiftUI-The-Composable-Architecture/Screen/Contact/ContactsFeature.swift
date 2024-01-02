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
            case .addContact(.presented(.delegate(.saveContact(let contact)))):
                state.contacts.append(contact)
                return .none
            case .addContact(.dismiss):
                return .none
            case .addContact(.presented(.setName(_))):
                return .none
            case .addContact(.presented(.cancelButtonTapped)):
                return .none
            case .addContact(.presented(.saveButtonTapped)):
                return .none
            }
        }
        .ifLet(\.$addContact, action: \.addContact) {
            AddContactFeature()
        }
    }
    
}
