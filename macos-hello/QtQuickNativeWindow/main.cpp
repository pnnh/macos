#include <QtWidgets/QtWidgets>
#include <QQuickView>
#include <QUrl>
#include <QDebug>

#include "checkeredwindow.h"
#include "macwindow.h"

// This example supports quickly iterating over different NSWindow
// configurations, and also shows how to use the MacWindow API.

class MacWindowController : public QWidget
{
public:
    MacWindowController(MacWindow *macWindow) 
        :m_macWindow(macWindow)
    {
        setWindowTitle("MacWindow Configurator");

        auto titleBarAppearsTransparent = createCheckBox(Qt::Unchecked, "Titlebar appears transparent", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setTitlebarAppearsTransparent(enabled);
        });
        auto fullSizeontentView = createCheckBox(Qt::Unchecked, "Full size content view", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setFullSizeContentView(enabled);
            titleBarAppearsTransparent->setEnabled(enabled);
        });
        auto showsBaselineSeparator = createCheckBox(Qt::Checked, "Shows baseline separator", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setShowsBaselineSeparator(enabled);
        });
        auto toolbar = createCheckBox(Qt::Unchecked, "Toolbar", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setToolbarEnabled(enabled);
            showsBaselineSeparator->setEnabled(enabled);
        });
        auto windowTitleText = createCheckBox(Qt::Checked, "Window Title text", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setTitleText(enabled ? "MacWindow" : "");
        });
        auto windowTitleVisiblity = createCheckBox(Qt::Checked, "Window Title visibility", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setTitleVisibility(enabled);
            windowTitleText->setEnabled(enabled);
        });
        auto accessoryView = createCheckBox(Qt::Unchecked, "Accessory views", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setAccessoryViewsEnabled(enabled);
        });
        auto movableByWindowBackground = createCheckBox(Qt::Unchecked, "Movable by window background", [=](Qt::CheckState state) {
            bool enabled = state == Qt::Checked;
            m_macWindow->setMovableByWindowBackgropund(enabled);
        });

        auto m_layout = new QVBoxLayout();
        setLayout(m_layout);
        m_layout->addWidget(fullSizeontentView);
        m_layout->addWidget(titleBarAppearsTransparent);
        m_layout->addWidget(toolbar);
        m_layout->addWidget(showsBaselineSeparator);
        m_layout->addWidget(windowTitleVisiblity);
        m_layout->addWidget(windowTitleText);
        m_layout->addWidget(accessoryView);
        m_layout->addWidget(movableByWindowBackground);
    }
    
    template <typename F>
    QCheckBox *createCheckBox(Qt::CheckState state, const QString &title, F onStateChanged)
    {
        auto checkBox = new QCheckBox(title);
        checkBox->setCheckState(state);
        connect(checkBox, &QCheckBox::stateChanged, [onStateChanged](int state) {
           onStateChanged(Qt::CheckState(state));
        });
        
        onStateChanged(state);
        return checkBox;
    }

    MacWindow *m_macWindow;
};

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    
    QTimer::singleShot(200, []() {
        
        // Create the application content windows
        // auto contentWindow = new CheckeredWindow();
        // contentWindow->setColor(QColor(10, 60, 130));
        auto contentWindow = new QQuickView();
        //contentWindow -> setSurfaceType(QSurface::OpenGLSurface);
        const QUrl url(QStringLiteral(u"qrc:/qt/qml/quick/views/main.qml"));
        contentWindow -> setSource(url);
        contentWindow -> setResizeMode(QQuickView::SizeRootObjectToView);
        //contentWindow -> setColor(QColor(10, 60, 130));
        contentWindow -> resize(400, 400);

        auto leftAccessoryWindow = new CheckeredWindow();
        leftAccessoryWindow->resize(80, 1);
        leftAccessoryWindow->setColor(QColor(60, 100, 80, 150));
        auto rigthAccessoryWindow = new CheckeredWindow();
        rigthAccessoryWindow->resize(80, 1);
        rigthAccessoryWindow->setColor(QColor(70, 40, 50, 150));

        //  Wrap the appplication content window in a MacWindow
        MacWindow *macWindow = new MacWindow(contentWindow, leftAccessoryWindow);
        macWindow->setContentWindow(contentWindow);
        macWindow->setLeftAcccessoryWindow(leftAccessoryWindow);
        macWindow->setRightAcccessoryWindow(rigthAccessoryWindow);           
    
        // Create Controller Widget (window)
        MacWindowController *controller = new MacWindowController(macWindow);
        
        macWindow->show();
        controller->show();

        // 此处需要调用以下3个Window的show方法，否则不会显示
        contentWindow -> show();
        leftAccessoryWindow -> show();
        rigthAccessoryWindow -> show();
    });

    return app.exec();
}