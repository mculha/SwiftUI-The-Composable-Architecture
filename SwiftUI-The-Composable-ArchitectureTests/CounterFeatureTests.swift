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
    
    func testTimer() async {
        let clock = TestClock()
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) { state in
            state.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) { state in
            state.count = 1
        }
        
        await store.send(.toggleTimerButtonTapped) { state in
            state.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number" }
        }
        
        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }
        
        await store.receive(\.factResponse, timeout: .seconds(1)) {
            $0.isLoading = false
            $0.fact = "0 is a good number"
        }
    }
    
    
}
