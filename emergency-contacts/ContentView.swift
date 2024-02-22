import SwiftUI

struct ContentView: View {
    @State private var data: [String: [DataItem]]?
    @State private var errorMessage: String?
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    
    var body: some View {
        NavigationStack {
            VStack {
                DataErrorHandlerView(data: data, errorMessage: errorMessage) { receivedData in
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        MapView(data: receivedData)
                            .sheet(isPresented: $isSheetOpened) {
                                ItemsListView(data: receivedData)
                                    .presentationDetents([.height(100), .medium, .large], selection: $initialSheetDetent)
                                    .presentationBackground(.clear)
                                    .interactiveDismissDisabled()
                                    .presentationBackgroundInteraction(.enabled)
                            }
                    } else {
                        MapView(data: receivedData)
                        ItemsListView(data: receivedData)
                    }
                }
            }
            .navigationTitle("Emergency Contacts")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
