//
//  CounterFeature.swift
//  SwiftUI-The-Composable-Architecture
//
//  Created by Melih Çulha on 28.12.2023.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CounterFeature {
    struct State: Equatable {
        var count: Int = 0
        var isLoading: Bool = false
        var fact: String?
    }
    
    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
        case factButtonTapped
        case factResponse(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                state.fact = nil
                return .none
            case .incrementButtonTapped:
                state.count += 1
                state.fact = nil
                return .none
            case .factResponse(let fact):
                state.fact = fact
                state.isLoading = false
                return .none
            case .factButtonTapped:
                state.fact = nil
                state.isLoading = true
                
                return .run { [count = state.count] send in
                    let (data,_) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(count)")!)
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact ))
                }
            }
        }
    }
}

