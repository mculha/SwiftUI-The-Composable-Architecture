//
//  ContactsView.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 1.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    
    let store: StoreOf<ContactsFeature>
    
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: \.path)) {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        NavigationLink(state: ContactDetailFeature.State(contact: contact)) {
                            HStack {
                                Text(contact.name)
                                
                                Spacer()
                                
                                Button {
                                    viewStore.send(.deleteButtonTapped(id: contact.id))
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        } destination: { store in
            ContactDetailView(store: store)
        }
        .sheet(store: self.store.scope(state: \.$destination.addContact,
                                       action: \.destination.addContact)) { store in
            NavigationStack {
                AddContactView(store: store)
            }
        }
        .alert(store: self.store.scope(state: \.$destination.alert,
                                       action: \.destination.alert))
    }
}

#Preview {
    ContactsView(store: Store(initialState: ContactsFeature.State(
        contacts: [
            .init(id: UUID(), name: "Bob"),
            .init(id: UUID(), name: "John"),
            .init(id: UUID(), name: "Christina"),
        ]
    ), reducer: {
        ContactsFeature()
    }))
}
