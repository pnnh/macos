演示如何将Qt窗口嵌入到Mac原生界面里

### 编译步骤

Ninja构建

```sh
$ mkdir build-ninja && cd build-ninja
$ cmake -GNinja ..
$ ninja hello # 通过ninja构建
$ ./hello  # 通过内置终端运行程序，窗口可能没有置顶显示，移动下界面可以看到
Hello, world!  # 控制台输出提示并显示窗口
```

Cmake Presets构建

```bash
cmake --preset macOS # 配置
cmake --build --preset macOS # 构建
build/Debug/QtQuickNativeWindow # 执行，需要在默认终端下
```