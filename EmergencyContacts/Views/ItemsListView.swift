import SwiftUI

struct ItemsListView: View {
    var data: [DataItem]
    let dataGrouped: [DataItem.CategoryType: [DataItem]]
    
    let allCategories: [DataItem.CategoryType]
    let allDistricts: [DataItem.AddressType.DiscrictType]
    
    init(data: [DataItem]) {
        self.data = data
        self.dataGrouped = Dictionary(grouping: data, by: { $0.category })
        
        self.allCategories = data.map {
            $0.category
        }.unique()
        
        self.allDistricts = data.map {
            $0.address.district
        }.unique().sorted(using: .localizedStandard)
    }
    
    @State var selectedCategory: DataItem.CategoryType = "all"
    @State var selectedDistrict: DataItem.AddressType.DiscrictType = "all"
    @State var filteredDataGrouped: [DataItem.CategoryType: [DataItem]] = [:]
    
    var filterChanged: Int {
       var hasher = Hasher()
       
       hasher.combine(selectedCategory)
       hasher.combine(selectedDistrict)
            
       return hasher.finalize()
    }
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker("Category", selection: $selectedCategory) {
                        Text("All").tag("all")
                        
                        ForEach(allCategories, id: \.self) {
                            Text(getCategoryLabel($0)).tag($0)
                        }
                    }
                    
                    Picker("District", selection: $selectedDistrict) {
                        Text("All").tag("all")
                        
                        ForEach(allDistricts, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    
                    Button("Reset") {
                        selectedCategory = "all"
                        selectedDistrict = "all"
                    }
                } header: {
                    Text("Filter")
                }
            }
            .frame(height: 170)
            
            List {
                ForEach(filteredDataGrouped.keys.sorted(), id: \.self) { category in
                    Section {
                        ForEach(filteredDataGrouped[category] ?? [], id: \.name) { item in
                            ListItemView(item: item)
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
        .onAppear() {
            filteredDataGrouped = dataGrouped;
        }
        .onChange(of: filterChanged) {
            print(filterChanged)
            
            filteredDataGrouped = dataGrouped.filter {
                $0.key == selectedCategory || selectedCategory == "all"
            }
        }
    }
}

struct ItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsListView(data: mockedItems)
    }
}
