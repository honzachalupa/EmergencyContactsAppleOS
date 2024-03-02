import SwiftUI

struct PillView: View {
    var value: String
    
    var body: some View {
        Text(value)
            .font(.caption)
            .foregroundStyle(.white)
            .lineLimit(1)
            .padding(.horizontal, 10)
            .padding(.vertical, 3)
            .background(
                Capsule()
                    .fill(.blue)
            )
            .padding(-2)
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            PillView(value: "Value 1")
            PillView(value: "Value 2")
            PillView(value: "Value 3")
        }
    }
}
