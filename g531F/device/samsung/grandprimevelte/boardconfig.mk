#
# Copyright (C) 2015-2026 TeamWin Recovery Project
# BoardConfig.mk pour Samsung Galaxy Grand Prime VE (G531F / grandprimevelte)
# SoC: Marvell Armada PXA1908 (Kernel 3.10.x)
# Cible: TWRP 3.2.x avec Correctif Marvell ADB Sideload & Résolution 540x960
#

LOCAL_PATH := device/samsung/grandprimevelte

# Identifiants de la Carte et du Bootloader
TARGET_BOOTLOADER_BOARD_NAME := grandprimevelte
TARGET_OTA_ASSERT_DEVICE := grandprimevelte,grandprimevelteg531f,g531f

# Architecture (ARM 32-bit armeabi-v7a - Optimal pour Kernel Stock 3.10)
TARGET_ARCH := arm
TARGET_NO_BOOTLOADER := true
TARGET_BOARD_PLATFORM := mrvl
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a53
ARCH_ARM_HAVE_TLS_REGISTER := true

# Inherit from proprietary vendor if present
-include vendor/samsung/grandprimevelte/BoardConfigVendor.mk

# =========================================================================
# CONFIGURATION DU KERNEL LINUX 3.10 & BOOTIMG
# =========================================================================
TARGET_PREBUILT_KERNEL := device/samsung/grandprimevelte/kernel
BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_CMDLINE := console=ttyS1,115200n8 androidboot.hardware=grandprimevelte androidboot.selinux=permissive
BOARD_FLASH_BLOCK_SIZE := 131072

# Marvell PXA1908 Custom mkbootimg / DTB Handling
BOARD_CUSTOM_MKBOOTIMG := device/samsung/grandprimevelte/tools/marvell-mkbootimg
BOARD_CUSTOM_BOOTIMG_MK := device/samsung/grandprimevelte/custom_mkbootimg.mk
BOARD_MKBOOTIMG_ARGS := --dt device/samsung/grandprimevelte/dt.img

# =========================================================================
# TABLES DES PARTITIONS (EMMC MARVELL PXA1908)
# =========================================================================
BOARD_BOOTIMAGE_PARTITION_SIZE     := 17145856   # 0x0105C000 (~16.35 MB)
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 17145856   # 0x0105C000 (~16.35 MB)
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 2147483648 # 2048 MB (2.0 GB)
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5368709120 # 5120 MB (5.0 GB)
BOARD_CACHEIMAGE_PARTITION_SIZE    := 209715200  # 200 MB
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USES_MMCUTILS := true
TARGET_USERIMAGES_USE_EXT4 := true

# =========================================================================
# CONFIGURATION FSTAB RECOVERY
# =========================================================================
TARGET_RECOVERY_FSTAB := device/samsung/grandprimevelte/recovery.fstab

# =========================================================================
# CONFIGURATION GRAPHIQUE & RÉSOLUTION TWRP (540x960)
# =========================================================================
DEVICE_RESOLUTION := 540x960
TW_THEME := portrait_mdpi
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel/brightness"
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 160
TW_SCREEN_BLANK_ON_BOOT := true

# =========================================================================
# CORRECTIF USB MARVELL PXA1908 (RÉPARATION ADB SIDELOAD & MTP)
# =========================================================================
# Le noyau 3.10 Marvell ne supporte pas ConfigFS moderne.
# On force le pilote gadget USB Android hérité avec points de montage sysfs dédiés.
TW_USE_CONFIGFS := false
TW_EXCLUDE_DEFAULT_USB_INIT := true
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun%d/file"

# VID / PID Samsung pour ADB et MTP sous Recovery
TARGET_RECOVERY_INITRC := device/samsung/grandprimevelte/recovery/root/init.recovery.grandprimevelte.rc
TW_MTP_DEVICE := "/dev/usb_mtp_gadget"

# Propriétés USB forcées pour le bon basculement de sys.usb.config=sideload
# Utilisé par init.recovery.usb.rc pour réarmer le contrôleur USB gadget
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.secure=0 \
    ro.adb.secure=0 \
    ro.debuggable=1 \
    persist.sys.usb.config=adb \
    sys.usb.config=adb

# =========================================================================
# DRIVERS GPU & ACCÉLÉRATION MARVELL VIVANTE
# =========================================================================
MRVL_ION := true
BOARD_USE_VIVANTE_GRALLOC := true
MRVL_INTERFACE_ANIMATION := true
MRVL_LAUNCH_DMS_IN_SURFACEFLINGER := true
TARGET_FORCE_CPU_UPLOAD := true

# =========================================================================
# FONCTIONNALITÉS TWRP 3.2.x
# =========================================================================
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_ENCRYPTED_BACKUPS := true
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_FB2PNG := true
TW_NO_EXFAT_FUSE := false
TW_EXTRA_LANGUAGES := true
TW_INPUT_BLACKLIST := "accelerometer"

#test
