import SwiftUI

struct IzsDataItem {
    let name: String
    let phoneNumber: Int
    let color: Color
}

struct CellView: View {
    var item: IzsDataItem
    var featured: Bool = false
    
    var body: some View {
        Button(action: {
            if let phoneURL = URL(string: "tel://\(item.phoneNumber)") {
                UIApplication.shared.open(phoneURL)
            }
        }, label: {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .fill(.regularMaterial)
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(item.color)
                                    .frame(width: 40, height: 40)
                                
                                Image(systemName: "phone.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                            }
                            
                            Spacer(minLength: 5)
                            
                            Text(String(item.phoneNumber))
                                .font(.largeTitle)
                        }
                    
                        Spacer(minLength: 15)
                        
                        Text(item.name)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                    }
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .padding()
            }
        })
        .frame(height: featured ? 100 : nil)
    }
}

struct IzsView: View {
    var items: [IzsDataItem] = [
        IzsDataItem(
            name: String(localized: "International Emergency Service"),
            phoneNumber: 112,
            color: .green
        ),
        IzsDataItem(
            name: String(localized: "Medical Service"),
            phoneNumber: 155,
            color: .red
        ),
        IzsDataItem(
            name: String(localized: "Firefighters"),
            phoneNumber: 150,
            color: .orange
        ),
        IzsDataItem(
            name: String(localized: "Police"),
            phoneNumber: 158,
            color: .blue
        ),
        IzsDataItem(
            name: String(localized: "Municipal Police"),
            phoneNumber: 156,
            color: .blue.opacity(0.6)
        ),
    ]
    
    var firstItem: IzsDataItem
        
    init() {
        firstItem = items.removeFirst()
    }
    
    var body: some View {
        VStack {
            CellView(item: firstItem, featured: true)
                .padding(.bottom, 3)
            
            LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2), spacing: 10) {
                ForEach(items, id: \.name) { item in
                    CellView(item: item)
                }
            }
            
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
