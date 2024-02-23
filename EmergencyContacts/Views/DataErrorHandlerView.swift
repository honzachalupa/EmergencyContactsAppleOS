import SwiftUI

struct DataErrorHandlerView<Content: View>: View {
    var data: [DataItem.CategoryType: [DataItem]]?
    var errorMessage: String?
    
    @ViewBuilder let content: (_ data: [String: [DataItem]]) -> Content
    
    var body: some View {
        if let data = data {
            self.content(data)
        } else if let errorMessage = errorMessage {
            Text("Error: \(errorMessage)")
        } else {
            ProgressView(label: {
                Text("Loading...")
                    .font(.caption)
                    .foregroundColor(.secondary)
            })
            .progressViewStyle(.circular)
        }
    }
}
