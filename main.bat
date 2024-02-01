@ECHO OFF
chcp 936>nul
cd /d %~dp0
if exist bin (cd bin) else (ECHO.找不到bin & goto FATAL)
set root=%~dp0
set admin=未知
setlocal enabledelayedexpansion

if exist conf\fixed.bat (call conf\fixed) else (ECHO.找不到conf\fixed.bat & goto FATAL)
if exist conf\user.bat call conf\user

if "%framwork_theme%"=="" set framwork_theme=default
call framwork theme %framwork_theme%
COLOR %c_i%

TITLE 工具启动中...
mode con:cols=47 lines=30

if not exist tool\Windows\gap.exe ECHO.找不到gap.exe & goto FATAL
if exist %windir%\System32\bff-test rd %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT
md %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT
rd %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT

call framwork startpre

net.exe session 1>NUL 2>NUL && set admin=YES || set admin=NO

cls

:home
title CMD刷机君2.0
echo.===============================================
echo.
echo.     cmd刷机君2.0
echo.                  ---by  一位不愿透露姓名的憨憨
echo.  请勿拖动调整此窗口大小，会导致显示兼容问题！
echo.                                       
echo.===============================================
echo.       您可以将此工具二改发布,但请留下署名
echo.      管理员权限状态:%admin%
echo.===============================================
echo.1.adb
echo.2.fastboot
echo.3.rec
echo.4.edl
echo.5.sideload
echo.6.安全专区(一些救砖操作)
echo.7.about
echo.8.激活专区
echo.9.检查连接
echo.10.exit
echo.===============================================
call choice common [1][2][3][4][5][6][7][8][9][10]
if "%choice%"=="1" goto ADB
if "%choice%"=="2" goto FASTBOOT
if "%choice%"=="3" goto REC
if "%choice%"=="4" goto EDL
if "%choice%"=="5" goto Sideload
if "%choice%"=="6" goto SAFE
if "%choice%"=="7" goto ABOUT
if "%choice%"=="8" goto adb_start
if "%choice%"=="9" goto devices
if "%choice%"=="10" goto EXIT

:ADB
cls
title adb操作
echo.===============================================
echo.       ADB操作
echo.===============================================
echo.1.重启菜单
echo.2.刷写img(需root)
echo.3.进程管理
echo.4.APP管理
echo.5.激活专区
echo.6.推送文件
echo.7.ADB投屏
echo.8.信息查看
echo.9.回首页
echo.===============================================
call choice common [1][2][3][4][5][6][7][8][9]
if "%choice%"=="1" goto adb_restart
if "%choice%"=="2" goto ADB_write
if "%choice%"=="3" goto ADB_process
if "%choice%"=="4" goto ADB_app
if "%choice%"=="5" goto ADB_activate
if "%choice%"=="6" goto ADB_push
if "%choice%"=="7" goto ADB_screen
if "%choice%"=="8" goto ADB_info
if "%choice%"=="9" cls&goto home

:FASTBOOT
cls
title fastboot操作
echo.===============================================
echo.       fastboot操作    
echo.===============================================
echo.1.重启菜单
echo.2.刷写img
echo.3.分区管理
echo.4.临时启动img
echo.5.回首页
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto fastboot_restart
if "%choice%"=="2" goto FASTBOOT_write
if "%choice%"=="3" goto FASTBOOT_partition
if "%choice%"=="4" goto FASTBOOT_temp
if "%choice%"=="5" cls&goto home

:REC
cls
title rec操作
echo.===============================================
echo.       rec操作    
echo.===============================================
echo.1.分区管理
echo.2.回首页
echo.===============================================
call choice common [1][2]
if "%choice%"="1" goto rec_partition
if "%choice%"="2" cls&goto home

:EDL
cls
title edl操作
echo.===============================================
echo.1.烧录单个img
echo.2.全量烧录
echo.3.回首页
echo.===============================================
call choice common [1][2][3]
if "%choice%"=="1" goto edl_single
if "%choice%"=="2" goto edl_all
if "%choice%"=="3" cls&goto home

:Sideload
cls
title sideload操作
echo.===============================================
echo.1.推送zip并刷入
echo.2.回首页
echo.===============================================
call choice common [1][2]
if "%choice%"=="1" goto sideload_push
if "%choice%"=="2" cls&goto home

:SAFE
cls
title 安全区
echo.===============================================
echo.1.尝试删除magisk模块挂载路径
echo.2.尝试重建data目录
echo.3.恢复默认设置
echo.4.尝试以adb shll删除文件
echo.5.备份分区表,分区,引导
echo.6.回首页
echo.===============================================
call choice common [1][2][3][4][5][6]
if "%choice%"=="1" goto SAFE_del
if "%choice%"=="2" goto SAFE_data
if "%choice%"=="3" goto SAFE_default
if "%choice%"=="4" goto SAFE_del_file
if "%choice%"=="5" goto SAFE_backup
if "%choice%"=="6" cls&goto home

:adb_restart
cls
title adb重启
echo.===============================================
echo.       ADB重启
echo.===============================================
echo.1.到rec
echo.2.到fastboot
echo.3.重启系统
echo.4.到edl
echo.5.软重启
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto adb_restart_to_rec
if "%choice%"=="2" goto adb_restart_to_fastboot
if "%choice%"=="3" goto adb_restart_to_system
if "%choice%"=="4" goto adb_restart_to_edl
if "%choice%"=="5" goto adb_restart_to_system_x

:fastboot_restart
cls 
title fastboot重启  
echo.===============================================
echo.       fastboot重启
echo.===============================================
echo.1.到edl(需解开bl)
echo.2.到edl(成功率较低)
echo.3.到rec
echo.4.到fastboot
echo.5.重启到系统
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto fastboot_restart_to_edl
if "%choice%"=="2" goto fastboot_restart_to_edl_x
if "%choice%"=="3" goto fastboot_restart_to_rec
if "%choice%"=="4" goto fastboot_restart_to_fastboot
if "%choice%"=="5" goto fastboot_restart_to_system

:devices
cls
title 设备列表
echo.===============================================
call chkdev all rechk
echo.===============================================
pause
cls&goto home

:ADB_write
cls
echo.选择img!
call sel file s %user_adbflashimg_pash% [img]
set /p user_asbflashname=请输入刷写分区名:
生成了命令:call write system %user_asbflashname% %user_adbflashimg_pash%（感谢bff框架）
echo.是否执行？取消请直接关闭窗口
pause
call write system %user_asbflashname% %user_adbflashimg_pash%
echo.已执行!!!
pause&&cls&goto home

:ADB_process
echo.===============================================
echo.       进程操作
echo.===============================================
echo.1.结束进程（使用pid）
echo.2.强制kill进程（使用应用包名）
echo.3.显示所有进程和正在前台的进程
echo.4.回首页
echo.===============================================
call choice common [1][2][3][4]
if "%choice%"=="1" goto kill_app
if "%choice%"=="2" goto kill_app_x
if "%choice%"=="3" goto app_list
if "%choice%"=="4" cls&goto 

:app_list
cls
echo.即将显示所有进程:
cd bin\adb
adb adb shell ps
echo.===============================================
echo.即将显示前台进程:
adb shell dumpsys activity activities | grep mResumedActivity
echo.执行完毕，按任意键回首页
pause&&cls&goto home

:kill_app
cd bin\adb
set /p kill_app_name=请输入包名:
echo.生成了命令:adb shell am force-stop %kill_app_name%
echo.是否要执行？取消请直接关闭窗口
pause
adb shell am force-stop %kill_app_name%
echo.已执行!!!
echo.执行完毕，按任意键回首页
pause&&cls&goto home

:kill_app_x
cd bin\adb
set /p kill_app_x=请输入应用pid:
echo.警告!强行终止可能会导致app不稳定
echo.生成了命令:adb shell kill -9 %kill_app_pid%
echo.是否要执行？取消请直接关闭窗口
pause
adb shell kill -9 %kill_app_pid%
echo.已执行!!!
echo.执行完毕，按任意键回首页
pause&&cls&goto home


:about
title about
cls
echo.===============================================
echo.
echo.
echo.   cmd刷机助手2.0
echo.                  ---by  一位不愿透露姓名的憨憨
echo.  感谢酷安@某贼帮助开发,和他的bff of bat框架  
echo.                                       
echo.===============================================
echo.       您可以将此工具二改发布,但请留下署名
echo.      管理员权限状态:%admin%
echo.项目地址:https://github.com/fw-QWQ/Batch-Flash-tool
echo.   其余皆为转载
echo.===============================================
pause
cls
goto home

:FATAL
ECHO. & if exist tool\Windows\ECHOC.exe (tool\Windows\ECHOC {%c_e%}抱歉, 脚本遇到问题, 无法继续运行. 请查看日志. {%c_h%}按任意键退出...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO.抱歉, 脚本遇到问题, 无法继续运行. 按任意键退出...& pause>nul & EXIT)