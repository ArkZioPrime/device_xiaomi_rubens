#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=rubens
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}"

# Warning headers and guards
write_headers

write_makefiles "${MY_DIR}/proprietary-files.txt" true

VIBRATOR_XML="vendor_overlay/33/etc/vintf/manifest/vendor.xiaomi.hardware.vibratorfeature.service.xml"
printf '\n%s\n' "PRODUCT_COPY_FILES += \\" >> "$PRODUCTMK"
printf '    %s/proprietary/%s:$(TARGET_COPY_OUT_PRODUCT)/%s\n' \
                "$OUTDIR" "product/$VIBRATOR_XML" "$VIBRATOR_XML" >> "$PRODUCTMK"

# Finish
write_footers
