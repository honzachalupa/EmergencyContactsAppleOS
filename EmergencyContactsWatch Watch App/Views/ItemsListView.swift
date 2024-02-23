import SwiftUI

struct ItemsListView: View {
    var data: [DataItem.CategoryType: [DataItem]]
    
    var body: some View {
        List {
            ForEach(data.keys.sorted(), id: \.self) { category in
                Section {
                    ForEach(data[category] ?? [], id: \.name) { item in
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
