import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Section {
                Button(action: openSystemSettings, label: {
                    Text("Change location service settings")
                })
            } header: {
                Text("Location Service")
            }
        }
    }
}

#Preview {
    SettingsView()
}
