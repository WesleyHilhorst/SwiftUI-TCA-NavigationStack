import SwiftUI

struct ApplicationRouterView: View {
    
    var body: some View {
        
        TabView {
            ListRouterView()
                .tabItem {
                    Label("Tasks", systemImage: "list.dash")
                }
        }
    }
}
