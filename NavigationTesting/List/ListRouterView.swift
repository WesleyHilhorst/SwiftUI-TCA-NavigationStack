import SwiftUI

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
            
            ListView(model: ListViewModel(router: route))
        case .detail(let i):
            
            ListView(model: ListViewModel(initialNumber: i, router: route))
                .navigationTitle("Depth \(path.count)")
        }
    }
}
