import SwiftUI

struct ItemsListView: View {
    var data: [DataItem]
    let dataGrouped: [DataItem.CategoryType: [DataItem]]
    
    init(data: [DataItem]) {
        self.data = data
        self.dataGrouped = Dictionary(grouping: data, by: { $0.category })
    }
    
    var body: some View {
        List {
            ForEach(dataGrouped.keys.sorted(), id: \.self) { category in
                Section {
                    ForEach(dataGrouped[category] ?? [], id: \.name) { item in
                        ListItemView(item: item)
                    }
                } header: {
                    HStack {
                        Image(systemName: "cross.fill").foregroundColor(getCategoryColor(category))
                        Text(getCategoryLabel(category))
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemsListView(data: mockedItems)
        }
    }
}
