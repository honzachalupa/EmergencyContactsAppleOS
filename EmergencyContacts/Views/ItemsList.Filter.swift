import SwiftUI

struct ItemsList_Filter: View {
    @Binding var filteredDataGrouped: [DataItem.CategoryType: [DataItem]]
    
    @StateObject var store = DataStore()
    
    @State var allCategories: [DataItem.CategoryType] = []
    @State var allDistricts: [DataItem.AddressType.DiscrictType] = []
    @State var selectedCategory: DataItem.CategoryType = "all"
    @State var selectedDistrict: DataItem.AddressType.DiscrictType = "all"
    
    var filterChanged: Int {
       var hasher = Hasher()
       
       hasher.combine(selectedCategory)
       hasher.combine(selectedDistrict)
            
       return hasher.finalize()
    }
    
    var body: some View {
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
        .scrollDisabled(true)
        .onChange(of: store.data) {
            filteredDataGrouped = store.dataGrouped
            
            allCategories = store.data.map { $0.category }.unique()
            allDistricts = store.data.map { $0.address.district }.unique().sorted(using: .localizedStandard)
        }
        .onChange(of: filterChanged) {
            let filtered = store.data.filter {
                ($0.category == selectedCategory || selectedCategory == "all") &&
                ($0.address.district == selectedDistrict || selectedDistrict == "all")
            }
            
            filteredDataGrouped = groupByCategory(filtered)
        }
    }
}
