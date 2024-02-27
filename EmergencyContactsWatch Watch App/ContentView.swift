import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            DataErrorHandlerView() {
                ItemsListView()
                    .navigationTitle("Emergency Contacts")
            }
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
