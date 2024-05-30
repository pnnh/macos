import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
    override func showWindow(_ sender: Any?) {
        print("showWindow")

        let viewController = ViewController()
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 270),
            styleMask: [.miniaturizable, .closable, .resizable, .titled],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = true
        window.center()
        window.title = "No Storyboard Window"
        window.contentViewController = viewController

        self.window = window
        self.window?.delegate = self
        self.window?.makeKeyAndOrderFront(sender)
    }

    func windowWillClose(_ notification: Notification) {
        print("Window will close")
        NSApplication.shared.terminate(self)
    }
}

public func sayHello() {
    print("Hello, World!")
    let controller = MainWindowController();
    controller.showWindow(nil);
}