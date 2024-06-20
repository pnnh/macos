import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {

    var windowController: MainWindowController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {        
        app.setActivationPolicy(.regular)
        app.activate(ignoringOtherApps: true)

        self.windowController = MainWindowController()
        self.windowController.showWindow(self)
    }
}