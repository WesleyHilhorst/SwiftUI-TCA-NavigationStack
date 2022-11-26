//
//  NavigationStackRouterView.swift
//  NavigationTesting
//
//  Created by Wesley Hilhorst on 24/11/2022.
//

import SwiftUI

struct NavigationStackRouterView<RootView: View>: View {
    
    let rootView: RootView
    
    init(@ViewBuilder content: @escaping () -> RootView) {
        
        self.rootView = content()
    }
    
    var body: some View {
        NavigationStack {
            rootView
        }
    }
}

//struct NavigationStackRouterView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStackRouterView()
//    }
//}
