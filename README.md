# CMD刷机君 1.01

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## 简介
CMD刷机君是一款基于Windows命令行的开源工具，用于简化ADB和Fastboot操作流程，方便安卓设备爱好者执行常见的刷机、文件推送等任务。该工具由开发者昵称：一位不愿透露姓名的憨憨制作，允许个人进行二次修改并发布，但请保留原始作者署名。

## 功能特性
- **集成ADB**：支持文件推送、激活特定应用（如冰箱应用、Shizuku权限服务）、自定义ADB指令执行。
- **集成Fastboot**：提供分区刷写、临时启动镜像文件以及自定义Fastboot指令执行功能。
- **简易菜单系统**：通过交互式菜单选择相应操作，无需记忆复杂命令。
- **权限检测**：自动检测并显示当前脚本运行时的管理员权限状态。

### 主要操作：
- **ADB模式**
    - 文件推送
    - 激活冰箱应用
    - 激活Shizuku权限服务
    - 自定义ADB指令执行
- **Fastboot模式**
    - 分区刷写
    - 临时启动img文件
    - 自定义Fastboot指令执行
- **特殊模式（9008, mtk）**（待开发）
- **关于信息**：查看工具信息、版权声明和当前权限状态
- **退出程序**

## 使用说明
1. 下载或克隆此项目至本地。
2. 在命令行中导航至该项目根目录并运行批处理脚本`main.bat`。
3. 按照屏幕提示进行操作。
4. adb操作和fastboot操作中的自定义命令不需要加adb或fastboot。

## 环境要求
- Windows操作系统
- 推荐以管理员权限运行该脚本

## 更新日志
1. exit操作不再是exit,而是goto exit_bat以kill可能遗漏的进程adb.exe。
2. 解决echo连续时错误得把echo后的输出当作命令执行的问题。
3. 应用户要求上传GitHub，停止野传

## 注意事项
- 使用前，请充分了解所操作的内容，以防误操作导致设备数据丢失或其他不可逆问题。
- 如需将本工具应用于商业或非个人用途，请遵循MIT协议并与原作者取得联系。

## 获取与贡献
欢迎从[GitHub仓库](https://github.com/fw-QWQ/Batch-Flash-tool)下载或提交Pull Request改进项目。

## 许可证
CMD刷机君采用MIT许可证发布。详细内容请参阅[LICENSE](https://github.com/fw-QWQ/Batch-Flash-tool/edit/main/LICENSE)文件。
