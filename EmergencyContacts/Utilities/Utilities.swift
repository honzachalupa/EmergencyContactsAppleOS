import SwiftUI
import MapKit

var fallbackPosition = MapCameraPosition.region(
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 50.08804,
            longitude: 14.42076
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.2,
            longitudeDelta: 0.2
        )
    )
)

func getKeywordLabel(_ keyword: DataItem.KeywordType) -> String {
    switch keyword.lowercased() {
        case "adult-care":
            return String(localized: "Adult Care")
        case "child-care":
            return String(localized: "Child Care")
        case "stomatology":
            return String(localized: "Stomatology")
        case "ophthalmology":
            return String(localized: "Ophthalmology")
        default:
            return keyword
    }
}

func getCategoryLabel(_ category: DataItem.CategoryType) -> String {
    switch category.lowercased() {
        case "hospital":
            return String(localized: "Hospital")
        case "pharmacy":
            return String(localized: "Pharmacy")
        case "vet":
            return String(localized: "Vet")
        default:
            return category
    }
}

func getCategoryColor(_ category: DataItem.CategoryType) -> Color {
    switch category {
        case "pharmacy":
            return .orange
        case "vet":
            return .yellow
        default:
            return .red
    }
}

func formatPhoneNumber(_ value: DataItem.ContactType.PhoneNumberType) -> String {
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

func groupByCategory(_ data: [DataItem]) -> [DataItem.CategoryType: [DataItem]] {
    return Dictionary(grouping: data, by: { $0.category })
}

func openSystemSettings() {
#if os(iOS)
    if let bundleId = Bundle.main.bundleIdentifier,
        let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\(bundleId)")
    {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
#endif
}

extension Array where Element: Hashable {
  func unique() -> [Element] {
    Array(Set(self))
  }
}
