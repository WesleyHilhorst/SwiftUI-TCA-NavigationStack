import SwiftUI

enum ListFeatureDestination: Hashable {
    
    case detail(Int)
}

struct ListRouterView: View {
    
    @State private var path: [ListFeatureDestination] = []
    
    var body: some View {

        NavigationStack(path: $path) {
            
            ListView(model: ListViewModel(router: route))
                .navigationDestination(for: ListFeatureDestination.self, destination: { destination in
                    
                    switch destination {
                    case .detail(let i):
                        ListView(model: ListViewModel(initialNumber: i, router: route))
                    }
                })
        }
    }
    
    func route(destination: ListFeatureDestination) {
        
        path.append(destination)
    }
}
