import SwiftUI

struct ContentView: View {
    @State private var data: [String: [DataItem]]?
    @State private var errorMessage: String?
    @State private var isSheetOpened: Bool = true
    @State private var initialSheetDetent = PresentationDetent.medium
    
    var body: some View {
        NavigationStack {
            DataErrorHandlerView(data: data, errorMessage: errorMessage) { receivedData in
                List {
                    ForEach(receivedData.keys.sorted(), id: \.self) { category in
                        Section {
                            ForEach(receivedData[category] ?? [], id: \.name) { item in
                                ListItemView(item: item)
                            }
                        } header: {
                            HStack {
                                Image(systemName: "cross.fill").foregroundColor(colorForCategory(category))
                                Text(category)
                            }
                            .padding(.leading, -15)
                            .padding(.top, 15)
                        }
                    }
                }
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
