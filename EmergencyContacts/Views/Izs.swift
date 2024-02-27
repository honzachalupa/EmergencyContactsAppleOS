import SwiftUI

struct IzsView: View {
    var body: some View {
        VStack {
            Izs_ItemView(item: izsFeaturedItem, featured: true)
                .padding(.bottom, 3)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 10) {
                ForEach(izsItems, id: \.name) { item in
                    Izs_ItemView(item: item)
                }
            }
            
            Text("Doporučení: Uložte si tyto kontakty přímo do kontaktů ve vašem iPhone, ať je máte vždy hned poruce")
                .font(.footnote)
                .opacity(0.6)
                .padding(.top, 10)
            
            Spacer()
        }
        .padding()
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
