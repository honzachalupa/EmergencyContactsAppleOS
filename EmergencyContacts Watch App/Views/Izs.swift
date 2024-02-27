import SwiftUI

struct IzsView: View {
    var body: some View {
        List {
            Izs_ItemView(item: izsFeaturedItem)
                .padding(.bottom, 3)
            
            ForEach(izsItems, id: \.name) { item in
                Izs_ItemView(item: item)
            }
        }
    }
}

struct IzsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            IzsView()
                .environment(\.locale, .init(identifier: "cs"))
            
            IzsView()
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
