import SwiftUI
import ComposableArchitecture

enum ListFeatureDestination: Hashable {
    
    case list
    case detail(Int)
}

struct ListRouterView: View {
    
    @State private var path: [ListFeatureDestination] = []
    
    var body: some View {

        NavigationStack(path: $path) {
            
            viewForDestination(destination: .list)
                .navigationDestination(for: ListFeatureDestination.self, destination: viewForDestination)
        }
    }
    
    func route(destination: ListFeatureDestination) {
        
        path.append(destination)
    }
    
    @ViewBuilder
    func viewForDestination(destination: ListFeatureDestination) -> some View {

        switch destination {
        case .list:
            
            ListView(store: Store(
                initialState: ListViewReducer.State(),
                reducer: ListViewReducer(router: route)
            ))
        case .detail(let i):
            
            ListView(store: Store(
                initialState: ListViewReducer.State(initialNumber: i),
                reducer: ListViewReducer(router: route)
            ))
            .navigationTitle("Depth \(path.count)")
        }
    }
}
