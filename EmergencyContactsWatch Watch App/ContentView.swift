import SwiftUI

struct ContentView: View {
    @State private var data: [DataItem.CategoryType: [DataItem]]?
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationStack {
            DataErrorHandlerView(data: data, errorMessage: errorMessage) { receivedData in
                ItemsListView(data: receivedData)
                    .navigationTitle("Emergency Contacts")
            }
        }
        .onAppear {
            DataManager().fetch() { result in
                switch result {
                    case .success(let fetchedData):
                        self.data = fetchedData
                    case .failure(let error):
                        self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
