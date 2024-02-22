import SwiftUI

func colorForCategory(_ category: String) -> Color {
    switch category {
        case "pharmacy":
            return .orange
        case "vet":
            return .yellow
        default:
            return .red
    }
}

func formatPhoneNumber(_ value: Int) -> String {
    let digits = String(value).filter { "0"..."9" ~= $0 }
    let segmentLengths = [3, 3, 3]  // Define the segment lengths you want
    var formattedNumber = ""
    var index = digits.startIndex

    for length in segmentLengths {
        let segmentEnd = digits.index(index, offsetBy: length, limitedBy: digits.endIndex) ?? digits.endIndex
        let segment = digits[index..<segmentEnd]
        if !formattedNumber.isEmpty {
            formattedNumber += " "
        }
        formattedNumber += segment
        if segmentEnd == digits.endIndex {
            break
        }
        index = segmentEnd
    }

    return "+420 \(formattedNumber)"
}

/* func windowMode() -> String {
 let screenRect = UIScreen.main.bounds
   let appRect = UIApplication.shared.windows[0].bounds

 if (UIDevice.current.userInterfaceIdiom == .phone) {
   return "IPHONE_FULLSCREEN"
 } else if (screenRect == appRect) {
   return "IPAD_FULLSCREEN"
 } else if (appRect.size.height < screenRect.size.height) {
   return "IPAD_SLIDE_OVER"
 } else {
   return "IPAD_SPLIT_VIEW"
 }
} */
