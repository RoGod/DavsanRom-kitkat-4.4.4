#!/sbin/sh

SUMOD=06755
MKSH="/system/bin/mksh"

if [ ! -f $MKSH ]; then
  MKSH="/system/bin/sh"
fi;


# Placing files
mkdir /system/bin/.ext
cp /system/xbin/su /system/xbin/daemonsu
cp /system/xbin/su /system/xbin/sugote
cp $MKSH /system/xbin/sugote-mksh
cp /system/xbin/su /system/bin/.ext/.su
ln -s /system/etc/install-recovery.sh /system/bin/install-recovery.sh
ln -s /system/xbin/su /system/bin/su
echo 1 > /system/etc/.installed_su_daemon
sed -i "s/persist.sys.root_access=1/persist.sys.root_access=0/g" "/system/build.prop"

# Setting permissions
set_perm 0 0 0777 /system/bin/.ext
set_perm 0 0 $SUMOD /system/bin/.ext/.su
set_perm 0 0 $SUMOD /system/xbin/su
set_perm 0 0 $SUMOD /system/xbin/daemonsu
set_perm 0 0 0755 /system/xbin/supolicy
set_perm 0 0 0755 /system/xbin/sugote
set_perm 0 0 0755 /system/xbin/sugote-mksh
set_perm 0 0 0755 /system/etc/install-recovery.sh
set_perm 0 0 0755 /system/etc/init.d/99SuperSUDaemon
set_perm 0 0 0644 /system/etc/.installed_su_daemon

# Post-installation script
/system/xbin/su --install
sh ./system/etc/install-recovery.sh

