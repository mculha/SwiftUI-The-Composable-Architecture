//
//  ContactDetailView.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 5.01.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContactDetailView: View {
    let store: StoreOf<ContactDetailFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Button("Delete") {
                    viewStore.send(.deleteButtonTapped)
                }
            }
            .navigationTitle(Text(viewStore.contact.name))
        }
        .alert(store: self.store.scope(state: \.$alert, action: \.alert))
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: Contact(id: UUID(), name: "Blob")), reducer: {
            ContactDetailFeature()
        }))
    }
}
