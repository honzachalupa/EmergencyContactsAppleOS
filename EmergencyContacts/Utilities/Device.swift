import SwiftUI

struct DeviceInfo {
    enum DeviceName: String {
        case iPhone
        case iPad
        case unknown
    }
    
    var deviceName: DeviceName
    // var isFullscreen: Bool?
}

func getDeviceInfo() -> DeviceInfo {
#if os(iOS)
    /* let screenRect = UIScreen.main.bounds
    let appRect = UIApplication.shared.windows[0].bounds */
    
    /* let screenRect = UIScreen.main.bounds
     
     var appRect: CGRect? = nil

     // Find the active window scene
     if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
         // Get the first window which is usually the main one
         if let mainWindow = windowScene.windows.first(where: { $0.isKeyWindow }) {
             appRect = mainWindow.bounds
         }
     }

     // Safely unwrap appRect and use it
     if let rect = appRect {
         // Use rect here
         print("App rect: \(rect)")
     } else {
         print("Failed to get app rect")
     }
     
     if (UIDevice.current.userInterfaceIdiom == .phone) {
         return DeviceInfo(deviceName: .iPhone)
     } else if (screenRect == appRect) {
         return DeviceInfo(deviceName: .iPad, isFullscreen: true)
     } else {
       return DeviceInfo(deviceName: .iPad, isFullscreen: false)
     }*/
    
    if (UIDevice.current.userInterfaceIdiom == .phone) {
        return DeviceInfo(deviceName: .iPhone)
    } else {
      return DeviceInfo(deviceName: .iPad)
    }
#else
    return DeviceInfo(deviceName: .unknown)
#endif
}
