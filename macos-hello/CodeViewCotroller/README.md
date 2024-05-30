一个仅通过代码创建Cocoa窗口的示例。并通过SwiftUI实现ContentView

### 编译步骤

Xcode构建

```sh
$ mkdir build && cd build
$ cmake -GXcode ..
$ xcodebuild -scheme hello build # 通过Xcode构建
$ Debug/hello  # 通过内置终端运行程序，窗口可能没有置顶显示，移动下界面可以看到
Hello, world!  # 控制台输出提示并显示窗口
```
 
Ninja构建

```sh
$ mkdir build-ninja && cd build-ninja
$ cmake -GNinja ..
$ ninja hello # 通过ninja构建
$ ./hello  # 通过内置终端运行程序，窗口可能没有置顶显示，移动下界面可以看到
Hello, world!  # 控制台输出提示并显示窗口
```