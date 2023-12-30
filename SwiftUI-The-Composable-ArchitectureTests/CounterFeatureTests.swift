//
//  CounterFeatureTests.swift
//  SwiftUI-The-Composable-ArchitectureTests
//
//  Created by Melih Çulha on 30.12.2023.
//

import XCTest
import ComposableArchitecture
@testable import SwiftUI_The_Composable_Architecture

@MainActor
final class CounterFeatureTests: XCTestCase {

    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State() ) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }
}
