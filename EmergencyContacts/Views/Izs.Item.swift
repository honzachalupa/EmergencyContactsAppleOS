import SwiftUI

struct Izs_ItemView: View {
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
                .foregroundStyle(.foreground)
                .fontWeight(.bold)
                .padding()
            }
        })
        .frame(height: featured ? 100 : nil)
    }
}

#Preview {
    Izs_ItemView(item: izsItems.first!)
}
