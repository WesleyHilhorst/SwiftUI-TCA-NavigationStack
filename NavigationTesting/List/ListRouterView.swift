import SwiftUI

enum ListFeatureDestination: Hashable {
    
    case detail(Int)
}

struct ListRouterView: View {
    
    @State private var path: [ListFeatureDestination] = []
    
    var body: some View {

        NavigationStack(path: $path) {
            
            ListView(model: ListViewModel(router: route))
                .navigationDestination(for: ListFeatureDestination.self, destination: viewForDestination)
        }
    }
    
    func route(destination: ListFeatureDestination) {
        
        path.append(destination)
    }
    
    @ViewBuilder
    func viewForDestination(destination: ListFeatureDestination) -> some View {

        switch destination {
        case .detail(let i):
            
            ListView(model: ListViewModel(initialNumber: i, router: route))
                .navigationTitle("Depth \(path.count)")
        }
    }
}
