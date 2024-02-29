import SwiftUI
// import Contacts

enum TabKey: String {
    case services
    case map
    case list
}

struct ContentView: View {
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    @State private var selectedTabKey: TabKey = .map
    
    func navigationTitleForSelectedTab(_ key: TabKey) -> String {
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
            DataErrorHandlerView() {
                TabView(selection: $selectedTabKey) {
                    IzsView().tabItem {
                        Label(navigationTitleForSelectedTab(.services), systemImage: "phone.fill")
                    }.tag(TabKey.services)
                    
                    MapView().tabItem {
                        Label(navigationTitleForSelectedTab(.map), systemImage: "map")
                    }.tag(TabKey.map)
                    
                    ItemsListView().tabItem {
                        Label(navigationTitleForSelectedTab(.list),systemImage: "list.bullet")
                    }.tag(TabKey.list)
                }
                .navigationTitle(navigationTitleForSelectedTab(selectedTabKey))
                .toolbarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
            }
        }
        /* .onAppear() {
            var status: Bool = false
            var store = CNContactStore()

            store.requestAccess(for: CNEntityType.contacts) { hasPermission, error in
                if error != nil {
                    print(error!)
                }
                
                status = hasPermission
            }
        } */
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
