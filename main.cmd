:Loading
@echo off
chcp 65001 >nul
set root=%~dp0
cd /d %root%
mode con:cols=47 lines=30
echo.Loading...
set admin=未知
if exist bin (cd bin&echo.加载成功&goto admin_as) else (ECHO.失败!&echo.按任意键退出&pause>nul&exit)

:home
title CMD刷机君 1.01
echo.===============================================
echo.
echo.   cmd刷机君1.01一款真正开源的工具！                                         
echo.                  ---by  一位不愿透露姓名的憨憨
echo.                                      
echo.                                       
echo.===============================================
echo.       您可以将此工具二改发布,但请留下署名
echo.      管理员权限状态:%admin%
echo.===============================================
echo.1.adb
echo.2.fastboot
echo.3.特殊模式(9008,mtk)(此区感谢酷安@某贼耐心解释)
echo.4.about
echo.5.exit
echo.===============================================
CHOICE /C 12345 /m 请输入：
if "%ERRORLEVEL%"=="1" goto adb
if "%ERRORLEVEL%"=="2" goto fastboot
if "%ERRORLEVEL%"=="3" goto edl
if "%ERRORLEVEL%"=="4" goto about
if "%ERRORLEVEL%"=="5" goto exit_bat

:adb
title adb操作
cls
echo.1.推文件
echo.             
echo.2.激活冰箱
echo.              
echo.3.激活shizuku
echo.               
echo.4.执行自定义adb指令
CHOICE /C 1234 /m 请输入：
if "%ERRORLEVEL%"=="1" goto adb_push
if "%ERRORLEVEL%"=="2" goto adb_start_icebox
if "%ERRORLEVEL%"=="3" goto adb_start_shizuku
if "%ERRORLEVEL%"=="4" goto adb_diy

:fastboot
title fastboot操作
cls
echo.1.刷写分区
echo.2.临时启动img
echo.3.执行自定义fastboot指令
CHOICE /C 123 /m 请输入：
if "%ERRORLEVEL%"=="1" goto flash
if "%ERRORLEVEL%"=="2" goto flash_boot
if "%ERRORLEVEL%"=="3" goto flash_diy

:edl
title edl操作(待开发)
cls
echo.待开发
pause
cls
goto home

:about
title about
cls
echo.===============================================
echo.
echo.   cmd刷机助手1.01一款真正开源的工具！                                                                 
echo.                  ---by  一位不愿透露姓名的憨憨
echo.                                      
echo.                                       
echo.===============================================
echo.       您可以将此工具二改发布,但请留下署名
echo.      管理员权限状态:%admin%
echo.     该工具仅在个人网盘发布,其他皆为转载
echo.===============================================
pause
cls
goto home

:flash
title flash img
cd %root%\bin\adb
set /p user_partition_name=输入分区名:
set /p user_img_file=输入img路径:
echo.生成了fastboot指令:fastboot flash %user_partition_name% %user_img_file%
echo.是否执行?取消请直接关闭窗口
pause
fastboot flash %user_partition_name% %user_img_file%
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:flash_boot
title 临时启动
cd %root%\bin\adb
set /p user_img_file=输入img路径:
echo.生成了fastboot指令:fastboot boot %user_img_file%
echo.是否执行?取消请直接关闭窗口
pause
fastboot boot %user_img_file%
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:admin_as
net.exe session 1>NUL 2>NUL && (
    goto as_admin
) || (
    goto not_admin
)

:as_admin
set admin=YES
goto home

:not_admin
set admin=NO
goto home

:adb_push
cd %root%\bin\adb
title adb push
set /p user_pc_file=输入pc文件路径:
set /p user_Android_file=输入Android存放路径:
echo.生成了adb指令:adb push %user_pc_file% %user_Android_file%
echo.是否执行?取消请直接关闭窗口
pause
adb push %user_pc_file% %user_Android_file%
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:adb_start_icebox
cd %root%\bin\adb
title 激活冰箱
echo.准备了adb指令:adb shell sh /sdcard/Android/data/com.catchingnow.icebox/files/start.sh
echo.是否执行?取消请直接关闭窗口
pause
adb shell sh /sdcard/Android/data/com.catchingnow.icebox/files/start.sh
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:adb_start_shizuku
cd %root%\bin\adb
title 激活shizuku
echo.准备了adb指令:adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
echo.是否执行?取消请直接关闭窗口
pause
adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:adb_diy
cd %root%\bin\adb
title 自定义adb指令
set /p user_adb_diy=输入自定义adb指令:
echo.生成了adb指令:adb %user_adb_diy%
echo.是否执行?取消请直接关闭窗口
pause
adb shell %user_adb_diy%
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home

:exit_bat
echo.结束adb.exe
taskkill /IM adb.exe /F
echo.等待您的下次使用
pause
exit

:fast_diy
cd %root%\bin\adb
title 自定义fastboot指令
set /p user_fastboot_diy=输入自定义fastboot指令:
echo.生成了fastboot指令:fastboot %user_fastboot_diy%
echo.是否执行?取消请直接关闭窗口
pause
adb %user_fastboot_diy%
echo.已执行!!!
echo.按任意键回首页
pause>nul
cls
goto home