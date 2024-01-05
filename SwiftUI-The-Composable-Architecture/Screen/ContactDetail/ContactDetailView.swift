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
                
            }
            .navigationTitle(Text(viewStore.contact.name))
        }
    }
}

#Preview {
    NavigationStack {
        ContactDetailView(store: Store(initialState: ContactDetailFeature.State(contact: Contact(id: UUID(), name: "Blob")), reducer: {
            ContactDetailFeature()
        }))
    }
}
