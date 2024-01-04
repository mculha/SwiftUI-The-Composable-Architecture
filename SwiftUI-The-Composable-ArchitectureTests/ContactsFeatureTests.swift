//
//  ContactsFeatureTests.swift
//  SwiftUI-The-Composable-ArchitectureTests
//
//  Created by Melih Çulha on 4.01.2024.
//

import XCTest
@testable import SwiftUI_The_Composable_Architecture
import ComposableArchitecture

@MainActor
final class ContactsFeatureTests: XCTestCase {

    func testAddFlow() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        await store.send(.addButtonTapped) {
            $0.destination = .addContact(
                AddContactFeature.State(contact: Contact(id: UUID(0), name: ""))
            )
        }
        
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
            $0.$destination[case: \.addContact]?.contact.name = "Blob Jr."
        }
        
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        
        await store.receive(.destination(.presented(.addContact(.delegate(.saveContact(Contact(id: UUID(0), name: "Blob Jr."))))))) {
            $0.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
        }
        
        await store.receive(\.destination.dismiss) {
            $0.destination = nil
        }
    }
    
    func testAddFlow_NonExhaustive() async {
        let store = TestStore(initialState: ContactsFeature.State()) {
            ContactsFeature()
        } withDependencies: {
            $0.uuid = .incrementing
        }
        
        store.exhaustivity = .off
        
        await store.send(.addButtonTapped)
        await store.send(.destination(.presented(.addContact(.setName("Blob Jr.")))))
        await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
        await store.skipReceivedActions()
        
        await store.assert { state in
            state.contacts = [
                Contact(id: UUID(0), name: "Blob Jr.")
            ]
            state.destination = nil
        }
    }
    
    func testDeleteContact() async {
        let store = TestStore(initialState: ContactsFeature.State(
            contacts: [
                Contact(id: UUID(0), name: "Blob"),
                Contact(id: UUID(1), name: "Blob Jr."),
            ]
        )) {
            ContactsFeature()
        }
        
        await store.send(.deleteButtonTapped(id: UUID(1))) {
            $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
        }
        
        await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
            $0.contacts.remove(id: UUID(1))
            $0.destination = nil
        }
    }
}
