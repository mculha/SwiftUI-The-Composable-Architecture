//
//  AppFeatureTests.swift
//  SwiftUI-The-Composable-ArchitectureTests
//
//  Created by Melih Çulha on 31.12.2023.
//

import XCTest
import ComposableArchitecture
@testable import SwiftUI_The_Composable_Architecture

@MainActor
final class AppFeatureTests: XCTestCase {

    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(.tab1(.incrementButtonTapped)) {
            $0.tab1.count = 1
        }
        
        await store.send(.tab1(.decrementButtonTapped)) {
            $0.tab1.count = 0
        }
        
       
    }
    
    func testIncrementInSecondTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        await store.send(.tab2(.incrementButtonTapped)) {
            $0.tab2.count = 1
        }
        
        await store.send(.tab2(.decrementButtonTapped)) {
            $0.tab2.count = 0
        }
    }

}
