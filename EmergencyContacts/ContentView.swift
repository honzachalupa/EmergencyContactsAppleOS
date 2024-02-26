import SwiftUI

enum TabLabels: String {
    case services
    case map
    case list
}

struct ContentView: View {
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    @State private var selectedTabKey: TabLabels = .map
    
    func navigationTitleForSelectedTab(_ key: TabLabels) -> String {
        switch key {
            case .services:
                return String(localized: "Phone Numbers")
            case .map:
                return String(localized: "Map")
            case .list:
                return String(localized: "List")
        }
    }
    
    var body: some View {
        NavigationStack {
            DataProviderView() { receivedData in
                TabView(selection: $selectedTabKey) {
                    IzsView().tabItem {
                        Label(navigationTitleForSelectedTab(.services), systemImage: "phone.fill")
                    }.tag(TabLabels.services)
                    
                    MapView(data: receivedData).tabItem {
                        Label(navigationTitleForSelectedTab(.map), systemImage: "map")
                    }.tag(TabLabels.map)
                    
                    ItemsListView(data: receivedData).tabItem {
                        Label(navigationTitleForSelectedTab(.list),systemImage: "list.bullet")
                    }.tag(TabLabels.list)
                }
                .navigationTitle(navigationTitleForSelectedTab(selectedTabKey))
                .toolbarTitleDisplayMode(.inlineLarge)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                        }
                    }
                }
            }
            
                /* VStack {
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
                } */
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.locale, .init(identifier: "cs"))
            
            ContentView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
