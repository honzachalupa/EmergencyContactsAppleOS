import SwiftUI

struct ContentView: View {
    @State private var data: [DataItem.CategoryType: [DataItem]]?
    @State private var errorMessage: String?
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    
    var body: some View {
        NavigationStack {
                VStack {
                    DataErrorHandlerView(data: data, errorMessage: errorMessage) { receivedData in
#if canImport(UIKit)
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            MapView(data: receivedData)
                                .sheet(isPresented: $isSheetOpened) {
                                    ItemsListView(data: receivedData)
                                        .presentationDetents([.height(100), .medium, .large], selection: $initialSheetDetent)
                                        .presentationBackground(.ultraThinMaterial)
                                        .interactiveDismissDisabled()
                                        .presentationBackgroundInteraction(.enabled)
                                        .padding(.all, -10)
                                }
                        } else {
                            MapView(data: receivedData)
                            ItemsListView(data: receivedData)
                        }
#else
                        MapView(data: receivedData)
                        ItemsListView(data: receivedData)
#endif
                    }
                }
                .navigationTitle("Map")
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.locale, .init(identifier: "cs"))
                .frame(minWidth: 800, minHeight: 600)
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
                .frame(minWidth: 800, minHeight: 600)
        }
    }
}
