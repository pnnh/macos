
//纯代码创建的ViewController
import Cocoa

class JFProgrammaticallyViewController: NSViewController {

    var mView : NSView!
    
    //这一端是重重之中，对于无法通过Nib加载view，就要通过loadView()方法来进行补救，
    override func loadView() {
        self.view = NSView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mView = NSView(frame: NSRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        mView.wantsLayer = true
        mView.layer?.backgroundColor = NSColor.red.cgColor
        self.view.addSubview(mView)
    }
    
}