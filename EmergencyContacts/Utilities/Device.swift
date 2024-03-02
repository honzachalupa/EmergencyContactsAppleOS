import SwiftUI

struct DeviceInfo {
    enum DeviceName: String {
        case iPhone
        case iPad
        case unknown
    }
    
    var deviceName: DeviceName
    var isFullscreen: Bool?
}

func getDeviceInfo() -> DeviceInfo {
#if os(iOS)
  let screenRect = UIScreen.main.bounds
  let appRect = UIApplication.shared.windows[0].bounds

  if (UIDevice.current.userInterfaceIdiom == .phone) {
      return DeviceInfo(deviceName: .iPhone)
  } else if (screenRect == appRect) {
      return DeviceInfo(deviceName: .iPad, isFullscreen: true)
  } else {
    return DeviceInfo(deviceName: .iPad, isFullscreen: false)
  }
#else
    return DeviceInfo(deviceName: .unknown)
#endif
}
