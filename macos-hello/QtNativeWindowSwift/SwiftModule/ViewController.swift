import Cocoa

class ViewController: NSViewController {

    var button : NSButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        button = NSButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.red.cgColor
        button.title = "启动新窗口"
        button.target = self
        button.action = #selector(clickAction(sender:))
        self.view.addSubview(button)
    }

    @objc func clickAction(sender:NSButton) {
        print("clicked")
    }
}
