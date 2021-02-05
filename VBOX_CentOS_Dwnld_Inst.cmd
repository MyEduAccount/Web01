:: PRE Requirements are installed Virtualbox and GUEST Additions
:: https://www.virtualbox.org/manual/ch02.html
::
:: Fetch CentOs latest Stream installation ISO image from as follows:
SET PROGPATH=\Users\%USERNAME%\Desktop\
SET VIRTUAL_DISK_HOME=%SystemDrive%\Users\%USERNAME%\VirtualBox VMs
::
:: How many cpus /cores
SET CPUS=2
:: Virtual Machine Name
SET VMACHINE=XWeb01
::
SET USERX=xweb01
SET FULL_USER=Web01-log-browser
SET MEMORY=2047
SET VRAM=128
SET PWD=nova1
SET DISKSIZE=20480
SET HOSTNAMEX=127.0.0.1
:: SET DISKFORMAT=VDI
::
:: CentoS Version Url And FileName
SET CENTOS_VER_URL=http://centos.mirror.far.fi/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20210126-dvd1.iso
SET CENTOS_FILENAME=CentOS-Stream-8-x86_64-20210126-dvd1.iso
::
SET dwnld_file_path=%SystemDrive%%PROGPATH%%CENTOS_FILENAME%
::
if not exist %dwnld_file_path% (
    ::
    pushd %PROGPATH%
    echo Changed Directory to %PROGPATH%
    :: Download from
    curl %CENTOS_VER_URL% --output %dwnld_file_path%
    if %errorlevel% gtr 0 GOTO :ERR
    echo CentOS downloaded to folder %PROGPATH%
) else (
    echo file in path %dwnld_file_path% exists - no download - Continue... !
)
::
SET PROGPATH2=\Program Files\Oracle\VirtualBox\
pushd %PROGPATH2%
:: VBoxManage list ostypes
echo Installing RedHat_64 - CentOS
:: Next Create VirtualBoxMachine
VBoxManage createvm --name %VMACHINE% --ostype RedHat_64 --register
if %errorlevel% gtr 0 GOTO :ERR
ECHO Virtual machine %VMACHINE% created to %PROGPATH%
::
:: Creating Virtual Disk
echo "Creating Virtual Disk"
VBoxManage createmedium --filename "%SystemDrive%\Users\%USERNAME%\VirtualBox VMs\%VMACHINE%\%VMACHINE%.vdi" --format VDI --size 20480
if %errorlevel% gtr 0 GOTO :ERR
ECHO CentOS Virtual Disk creteated to folder \Users\%USERNAME%\VirtualBox VMs\%VMACHINE%\%VMACHINE%.vdi
::
:: Create Sata controllers
VBoxManage storagectl %VMACHINE% --name SATA --add SATA --controller IntelAhci --bootable on
VBoxManage storageattach %VMACHINE% --storagectl SATA --port 0 --device 0 --type hdd --medium "%VIRTUAL_DISK_HOME%\%VMACHINE%\%VMACHINE%.vdi"
::
:: Create IDE Controllers
VBoxManage storagectl %VMACHINE% --name IDE --add ide --bootable on
VBoxManage storageattach %VMACHINE% --storagectl IDE --port 0 --device 0 --type dvddrive --medium C:\Users\Juha\Desktop\CentOS-Stream-8-x86_64-20210126-dvd1.iso
::
:: Memory size and Video memory
VBoxManage modifyvm %VMACHINE% --memory %MEMORY% --vram %VRAM%
::
VBoxManage modifyvm %VMACHINE% --ioapic on
::
VBoxManage modifyvm %VMACHINE% --hwvirtex on
::
VBoxManage modifyvm %VMACHINE% --accelerate3d on
:: --firmware bios|efi|efi32|efi64
VBoxManage modifyvm %VMACHINE% --firmware bios
::
VBoxManage modifyvm %VMACHINE% --boot1 dvd --boot2 disk --boot3 floppy --boot4 none
::
VBoxManage modifyvm %VMACHINE% --cpus %CPUS%
::
VBoxManage modifyvm %VMACHINE% --audio none
::
VBoxManage modifyvm %VMACHINE% --usb on
VBoxManage modifyvm %VMACHINE% --usbehci on
VBoxManage modifyvm %VMACHINE% --usbxhci on
::
VBoxManage modifyvm %VMACHINE% --nic1 nat 
::
VBoxManage unattended install %VMACHINE% --user=%USERX% --password=%PWD% --full-user-name=%FULL_USER% --country=FI --time-zone=EET --hostname=%HOSTNAMEX% --iso=%dwnld_file_path%  --install-additions --start-vm=gui 
::
:: If no errors GoTo Exit
GOTO :XIT
:: When error occured next ...
:ERR
EXIT /B %ERRORLEVEL%
:XIT
popd

