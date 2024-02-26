import SwiftUI

struct DataProviderView<Content: View>: View {
    @State private var data: [DataItem]?
    @State private var errorMessage: String?
    
    @ViewBuilder let content: (_ data: [DataItem]) -> Content
    
    var body: some View {
        ZStack {
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
