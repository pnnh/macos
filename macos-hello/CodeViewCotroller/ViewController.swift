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
        let programmaticallyVC = JFProgrammaticallyViewController()

        // TODO: 似乎通过Ninja或Xcode构建时，以下两行需要注释或取消注释，否则会提示方法不存在错误
       // self.presentAsModalWindow(programmaticallyVC)
        self.presentViewControllerAsModalWindow(programmaticallyVC)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}
