import SwiftUI

struct ItemsListView: View {
    var data: [DataItem]
    
    @State var filteredDataGrouped: [DataItem.CategoryType: [DataItem]] = [:]
    
    var body: some View {
        VStack {
            ItemsList_Filter(data: data, filteredDataGrouped: $filteredDataGrouped)
                .frame(height: 170)
            
            List {
                ForEach(filteredDataGrouped.keys.sorted(), id: \.self) { category in
                    Section {
                        ForEach(filteredDataGrouped[category] ?? [], id: \.name) { item in
                            ItemsList_ItemView(item: item)
                        }
                    } header: {
                        HStack {
                            Image(systemName: "cross.fill")
                                .foregroundColor(getCategoryColor(category))
                            
                            Text(getCategoryLabel(category))
                        }
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView(data: mockedItems)
    }
}
