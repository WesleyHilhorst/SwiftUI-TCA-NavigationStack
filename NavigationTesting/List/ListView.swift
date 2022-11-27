import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var initialNumber: Int
    @Published var numbers: [Int]
    
    let router: (ListFeatureDestination) -> ()
    
    init(
        initialNumber: Int = 0,
        numbers: [Int] = [],
        router: @escaping (ListFeatureDestination) -> Void
    ) {
        
        self.initialNumber = initialNumber
        self.numbers = numbers
        self.router = router
    }
    
    @MainActor
    func load() async throws {
        
        let clock = ContinuousClock()
        try await clock.sleep(until: .now.advanced(by: .seconds(1)))
        return numbers = Array(initialNumber...initialNumber+10)
    }
    
    func didTapNumber(_ number: Int) {
        
        router(.detail(number))
    }
}

struct ListView: View {
    
    @ObservedObject var model: ListViewModel
    
    var body: some View {
        
        List(model.numbers, id: \.self) { i in
            Button("\(i)") {
                model.didTapNumber(i)
            }
        }
        .task { try? await model.load() }
    }
}
