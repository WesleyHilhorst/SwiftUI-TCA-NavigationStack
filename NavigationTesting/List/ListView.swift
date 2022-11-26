import SwiftUI
import ComposableArchitecture

struct ListViewReducer: ReducerProtocol {
    
    let router: (ListFeatureDestination) -> ()
    
    struct State: Equatable {
        
        var initialNumber = 0
        var numbers: [Int] = []
    }
    
    enum Action {
        
        case onAppear
        case onGenerate([Int])
        case didTapNumber(Int)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            
            return .task { [state] in
                let clock = ContinuousClock()
                try await clock.sleep(for: .seconds(1))
                return .onGenerate(Array(state.initialNumber...state.initialNumber+10))
            }
        case let .onGenerate(numbers):
            
            print("did generate", numbers)
            state.numbers = numbers
            return .none
        case let .didTapNumber(number):
            
            router(.detail(number))
            return .none
        }
    }
}

struct ListView: View {
    
    let store: StoreOf<ListViewReducer>
    
    init(store: StoreOf<ListViewReducer>) {
        
        self.store = store
        print("view init with new store")
    }
    
    var body: some View {
        
        WithViewStore(store) { viewStore in
         
            List(viewStore.numbers, id: \.self) { i in
                Button("\(i)") {
                    viewStore.send(.didTapNumber(i))
                }
            }
            .onAppear { viewStore.send(.onAppear) }
        }
    }
}
