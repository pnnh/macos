import Cocoa


class MainWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        
        
           print("MainWindow init")
        
        super.init(contentRect: contentRect, styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView], backing: backingStoreType, defer: flag)
        
        self.backgroundColor = NSColor.white
        
        // 监听窗口大小变化
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowDidResize(_:)),
            name: NSWindow.didResizeNotification,
            object: self
        )
        // 监听全屏状态变化
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowWillEnterFullScreen(_:)),
            name: NSWindow.willEnterFullScreenNotification,
            object: self
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowDidEnterFullScreen(_:)),
            name: NSWindow.didEnterFullScreenNotification,
            object: self
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowWillExitFullScreen(_:)),
            name: NSWindow.willExitFullScreenNotification,
            object: self
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(windowDidExitFullScreen(_:)),
            name: NSWindow.didExitFullScreenNotification,
            object: self
        )
    }
    
    private var regularConstraints: [NSLayoutConstraint] = []
    private var fullScreenConstraints: [NSLayoutConstraint] = []
    
    private var customTitleBarConstraints: [NSLayoutConstraint] = []
    
    private func updateTitlebarConstraints(with notification: Notification?) {
        guard
            let window = notification?.object as? NSWindow,
            let titlebar = window.standardWindowButton(.closeButton)?.superview?.superview,
            let titlebarContainer = titlebar.superview,
            let contentView = window.contentView
        else { return }
        
        titlebar.translatesAutoresizingMaskIntoConstraints = false
        
        switch notification?.name {
        case NSWindow.willEnterFullScreenNotification:
            NSLayoutConstraint.deactivate(regularConstraints)
        case NSWindow.didEnterFullScreenNotification:
            if fullScreenConstraints.isEmpty {
                fullScreenConstraints = [
                
                    titlebar.leadingAnchor.constraint(equalTo: titlebarContainer.leadingAnchor),
                    titlebar.trailingAnchor.constraint(equalTo: titlebarContainer.trailingAnchor),
                    titlebar.topAnchor.constraint(equalTo: titlebarContainer.topAnchor),
                    titlebar.heightAnchor.constraint(equalToConstant: 22)
                ]
            }
            NSLayoutConstraint.activate(fullScreenConstraints)
        case NSWindow.willExitFullScreenNotification:
            NSLayoutConstraint.deactivate(fullScreenConstraints)
        case NSWindow.didExitFullScreenNotification:
            fallthrough
        default:
            if regularConstraints.isEmpty {
                regularConstraints = [
                    titlebar.leadingAnchor.constraint(equalTo: titlebarContainer.leadingAnchor),
                    titlebar.trailingAnchor.constraint(equalTo: titlebarContainer.trailingAnchor),
                    titlebar.topAnchor.constraint(equalTo: titlebarContainer.topAnchor),
                    titlebar.heightAnchor.constraint(equalToConstant: 52)
                ]
            }
            NSLayoutConstraint.activate(regularConstraints)
            
        }
        
        
        
    }
    
    @objc func windowWillEnterFullScreen(_ notification: Notification) {
        print("windowWillEnterFullScreen")
        updateTitlebarConstraints(with: notification)
    }
    
    @objc func windowDidEnterFullScreen(_ notification: Notification) {
        print("windowDidEnterFullScreen")
        updateTitlebarConstraints(with: notification)
        
        updateButtonGroupConstraints(notification)
    }
    
    @objc func windowWillExitFullScreen(_ notification: Notification) {
        print("windowWillExitFullScreen")
        updateTitlebarConstraints(with: notification)
        updateButtonGroupConstraints(notification)
    }
    
    @objc func windowDidExitFullScreen(_ notification: Notification) {
        print("windowDidExitFullScreen")
        updateTitlebarConstraints(with: notification)
    }
    
    @objc func windowDidResize(_ notification: Notification) {
        print("windowDidResize")
        updateTitlebarConstraints(with: notification)
        updateButtonGroupConstraints(notification)
    }
    
    private func updateButtonGroupTrackingArea(buttons: [NSView]) {
        let themeView = buttons.first?.superview?.superview?.superview
        
        if let trackingArea = themeView?.trackingAreas.first(where: {$0.options.contains(.activeAlways)}) {
            let trackingRect = buttons.reduce(NSZeroRect, { $0.union($1.frame) })
            let newTrackingArea = NSTrackingArea(rect: trackingRect, options: trackingArea.options, owner: trackingArea.owner, userInfo: trackingArea.userInfo)
            
            themeView?.removeTrackingArea(trackingArea)
            themeView?.addTrackingArea(newTrackingArea)
        }
        
    }
    
    private var buttonsConstraints: [NSLayoutConstraint] = []
    private var buttonGroupLeadingConstraint: NSLayoutConstraint?
    
    private func updateButtonGroupConstraints(_ notification: Notification?) {
        guard
            let window = notification?.object as? NSWindow,
            let titlebar = self.standardWindowButton(.closeButton)?.superview?.superview,
            let titlebarContainer = titlebar.superview,
            let closeButton = window.standardWindowButton(.closeButton),
            let miniaturizeButton = window.standardWindowButton(.miniaturizeButton),
            let zoomButton = window.standardWindowButton(.zoomButton)
        else {return}
        
        let barHeight = window.styleMask.contains(.fullScreen) ? 22 : 52
        let verticalSpacing = (barHeight - Int(closeButton.frame.height)) / 2
        let leadingOffset = max(7, min(verticalSpacing + 4, 12))
        
        let buttons = [closeButton, miniaturizeButton, zoomButton]
        
        if buttonsConstraints.isEmpty {
            buttons.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
            buttonGroupLeadingConstraint = closeButton.leadingAnchor.constraint(equalTo: titlebar.leadingAnchor, constant: CGFloat(leadingOffset))
            
            buttonsConstraints = [
                closeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor),
                miniaturizeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor),
                zoomButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor),
                buttonGroupLeadingConstraint!,
                miniaturizeButton.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 6),
                zoomButton.leadingAnchor.constraint(equalTo: miniaturizeButton.trailingAnchor, constant: 6),
            ]
            NSLayoutConstraint.activate(buttonsConstraints)
        }
        
        buttonGroupLeadingConstraint?.constant = CGFloat(leadingOffset)
        titlebarContainer.layoutSubtreeIfNeeded()
        updateButtonGroupTrackingArea(buttons: buttons)
    }
    
    override func awakeFromNib() {
     
        print("MainWindow awakeFromNib")
        
        // 在 NSWindow 初始化时设置
        self.styleMask.insert(.fullSizeContentView) // 允许内容视图延伸到标题栏区域
        self.titleVisibility = .hidden              // 隐藏标题文本
        self.titlebarAppearsTransparent = true      // 标题栏透明
//        self.toolbar?.showsBaselineSeparator = false // hide toolbar baseline separator
//        self.standardWindowButton(.closeButton)?.isHidden = true // 隐藏关闭按钮（可选）
//        self.standardWindowButton(.miniaturizeButton)?.isHidden = true // 隐藏最小化按钮
//        self.standardWindowButton(.zoomButton)?.isHidden = true // 隐藏全屏按钮
    
        
        super.awakeFromNib()
    }
}
