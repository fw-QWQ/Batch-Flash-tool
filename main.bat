@ECHO OFF
chcp 936>nul
cd /d %~dp0
if exist bin (cd bin) else (ECHO.�Ҳ���bin & goto FATAL)
set root=%~dp0
set admin=δ֪
setlocal enabledelayedexpansion

if exist conf\fixed.bat (call conf\fixed) else (ECHO.�Ҳ���conf\fixed.bat & goto FATAL)
if exist conf\user.bat call conf\user

if "%framwork_theme%"=="" set framwork_theme=default
call framwork theme %framwork_theme%
COLOR %c_i%

TITLE ����������...
mode con:cols=47 lines=30

if not exist tool\Windows\gap.exe ECHO.�Ҳ���gap.exe & goto FATAL
if exist %windir%\System32\bff-test rd %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT
md %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT
rd %windir%\System32\bff-test 1>nul || start tool\Windows\gap.exe %0 && EXIT || EXIT

call framwork startpre

net.exe session 1>NUL 2>NUL && set admin=YES || set admin=NO

cls

:home
title CMDˢ����2.0
echo.===============================================
echo.
echo.     cmdˢ����2.0
echo.                  ---by  һλ��Ը͸¶�����ĺ���
echo.  �����϶������˴��ڴ�С���ᵼ����ʾ�������⣡
echo.                                       
echo.===============================================
echo.       �����Խ��˹��߶��ķ���,������������
echo.      ����ԱȨ��״̬:%admin%
echo.===============================================
echo.1.adb
echo.2.fastboot
echo.3.rec
echo.4.edl
echo.5.sideload
echo.6.��ȫר��(һЩ��ש����)
echo.7.about
echo.8.����ר��
echo.9.�������
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
title adb����
echo.===============================================
echo.       ADB����
echo.===============================================
echo.1.�����˵�
echo.2.ˢдimg(��root)
echo.3.���̹���
echo.4.APP����
echo.5.����ר��
echo.6.�����ļ�
echo.7.ADBͶ��
echo.8.��Ϣ�鿴
echo.9.����ҳ
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
title fastboot����
echo.===============================================
echo.       fastboot����    
echo.===============================================
echo.1.�����˵�
echo.2.ˢдimg
echo.3.��������
echo.4.��ʱ����img
echo.5.����ҳ
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto fastboot_restart
if "%choice%"=="2" goto FASTBOOT_write
if "%choice%"=="3" goto FASTBOOT_partition
if "%choice%"=="4" goto FASTBOOT_temp
if "%choice%"=="5" cls&goto home

:REC
cls
title rec����
echo.===============================================
echo.       rec����    
echo.===============================================
echo.1.��������
echo.2.����ҳ
echo.===============================================
call choice common [1][2]
if "%choice%"="1" goto rec_partition
if "%choice%"="2" cls&goto home

:EDL
cls
title edl����
echo.===============================================
echo.1.��¼����img
echo.2.ȫ����¼
echo.3.����ҳ
echo.===============================================
call choice common [1][2][3]
if "%choice%"=="1" goto edl_single
if "%choice%"=="2" goto edl_all
if "%choice%"=="3" cls&goto home

:Sideload
cls
title sideload����
echo.===============================================
echo.1.����zip��ˢ��
echo.2.����ҳ
echo.===============================================
call choice common [1][2]
if "%choice%"=="1" goto sideload_push
if "%choice%"=="2" cls&goto home

:SAFE
cls
title ��ȫ��
echo.===============================================
echo.1.����ɾ��magiskģ�����·��
echo.2.�����ؽ�dataĿ¼
echo.3.�ָ�Ĭ������
echo.4.������adb shllɾ���ļ�
echo.5.���ݷ�����,����,����
echo.6.����ҳ
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
title adb����
echo.===============================================
echo.       ADB����
echo.===============================================
echo.1.��rec
echo.2.��fastboot
echo.3.����ϵͳ
echo.4.��edl
echo.5.������
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto adb_restart_to_rec
if "%choice%"=="2" goto adb_restart_to_fastboot
if "%choice%"=="3" goto adb_restart_to_system
if "%choice%"=="4" goto adb_restart_to_edl
if "%choice%"=="5" goto adb_restart_to_system_x

:fastboot_restart
cls 
title fastboot����  
echo.===============================================
echo.       fastboot����
echo.===============================================
echo.1.��edl(��⿪bl)
echo.2.��edl(�ɹ��ʽϵ�)
echo.3.��rec
echo.4.��fastboot
echo.5.������ϵͳ
echo.===============================================
call choice common [1][2][3][4][5]
if "%choice%"=="1" goto fastboot_restart_to_edl
if "%choice%"=="2" goto fastboot_restart_to_edl_x
if "%choice%"=="3" goto fastboot_restart_to_rec
if "%choice%"=="4" goto fastboot_restart_to_fastboot
if "%choice%"=="5" goto fastboot_restart_to_system

:devices
cls
title �豸�б�
echo.===============================================
call chkdev all rechk
echo.===============================================
pause
cls&goto home

:ADB_write
cls
echo.ѡ��img!
call sel file s %user_adbflashimg_pash% [img]
set /p user_asbflashname=������ˢд������:
����������:call write system %user_asbflashname% %user_adbflashimg_pash%����лbff��ܣ�
echo.�Ƿ�ִ�У�ȡ����ֱ�ӹرմ���
pause
call write system %user_asbflashname% %user_adbflashimg_pash%
echo.��ִ��!!!
pause&&cls&goto home

:ADB_process
echo.===============================================
echo.       ���̲���
echo.===============================================
echo.1.�������̣�ʹ��pid��
echo.2.ǿ��kill���̣�ʹ��Ӧ�ð�����
echo.3.��ʾ���н��̺�����ǰ̨�Ľ���
echo.4.����ҳ
echo.===============================================
call choice common [1][2][3][4]
if "%choice%"=="1" goto kill_app
if "%choice%"=="2" goto kill_app_x
if "%choice%"=="3" goto app_list
if "%choice%"=="4" cls&goto 

:app_list
cls
echo.������ʾ���н���:
cd bin\adb
adb adb shell ps
echo.===============================================
echo.������ʾǰ̨����:
adb shell dumpsys activity activities | grep mResumedActivity
echo.ִ����ϣ������������ҳ
pause&&cls&goto home

:kill_app
cd bin\adb
set /p kill_app_name=���������:
echo.����������:adb shell am force-stop %kill_app_name%
echo.�Ƿ�Ҫִ�У�ȡ����ֱ�ӹرմ���
pause
adb shell am force-stop %kill_app_name%
echo.��ִ��!!!
echo.ִ����ϣ������������ҳ
pause&&cls&goto home

:kill_app_x
cd bin\adb
set /p kill_app_x=������Ӧ��pid:
echo.����!ǿ����ֹ���ܻᵼ��app���ȶ�
echo.����������:adb shell kill -9 %kill_app_pid%
echo.�Ƿ�Ҫִ�У�ȡ����ֱ�ӹرմ���
pause
adb shell kill -9 %kill_app_pid%
echo.��ִ��!!!
echo.ִ����ϣ������������ҳ
pause&&cls&goto home


:about
title about
cls
echo.===============================================
echo.
echo.
echo.   cmdˢ������2.0
echo.                  ---by  һλ��Ը͸¶�����ĺ���
echo.  ��л�ᰲ@ĳ����������,������bff of bat���  
echo.                                       
echo.===============================================
echo.       �����Խ��˹��߶��ķ���,������������
echo.      ����ԱȨ��״̬:%admin%
echo.��Ŀ��ַ:https://github.com/fw-QWQ/Batch-Flash-tool
echo.   �����Ϊת��
echo.===============================================
pause
cls
goto home

:FATAL
ECHO. & if exist tool\Windows\ECHOC.exe (tool\Windows\ECHOC {%c_e%}��Ǹ, �ű���������, �޷���������. ��鿴��־. {%c_h%}��������˳�...{%c_i%}{\n}& pause>nul & EXIT) else (ECHO.��Ǹ, �ű���������, �޷���������. ��������˳�...& pause>nul & EXIT)