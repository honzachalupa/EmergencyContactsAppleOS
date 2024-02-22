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
                    .padding(.leading, -15)
                    .padding(.top, 15)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
