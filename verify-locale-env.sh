#!/usr/bin/env bash
# ==============================================================================
# Blueprint: Core Desktop Integration & Localization Utility Deployment
# Target Use-Case: Minimalist System Provisioning & Verification Recovery
# Compatibility: Arch Linux (Pacman), Debian/Ubuntu (APT), RHEL/Fedora (DNF5/RPM)
# Script-Name/Title: verify-locale-env.sh
# ==============================================================================

set -Eeuo pipefail

# ------------------------------------------------------------------------------
# 1. Environment & Privilege Assessment
# ------------------------------------------------------------------------------
if [[ "${EUID}" -ne 0 ]]; then
    echo "[-] Error: Operational privileges required. Re-run script executing sudo." >&2
    exit 1
fi

# ------------------------------------------------------------------------------
# 2. Package Manager Architecture Detection
# ------------------------------------------------------------------------------
declare PKG_MANAGER=""
declare DNF_BIN="dnf5"

if command -v pacman &>/dev/null; then
    PKG_MANAGER="pacman"
elif command -v apt-get &>/dev/null; then
    PKG_MANAGER="apt"
elif command -v dnf5 &>/dev/null; then
    PKG_MANAGER="rpm"
    DNF_BIN="dnf5"
elif command -v dnf &>/dev/null; then
    PKG_MANAGER="rpm"
    DNF_BIN="dnf"
else
    echo "[-] Error: Unsupported runtime software infrastructure environment." >&2
    exit 1
fi

echo "[+] Target Package Manager Identified: ${PKG_MANAGER} (Binary: ${DNF_BIN})"

# ------------------------------------------------------------------------------
# 3. Execution Pipeline Mapping
# ------------------------------------------------------------------------------
case "${PKG_MANAGER}" in
    "pacman")
        echo "[+] Syncing database indices..."
        pacman -Sy

        # Clean array: strictly essentials, omitting redundant Haskell/Perl bloat
        declare -a ARCH_PACKAGES=(
            "xdg-user-dirs"
            "man-db"
            "man-pages"
            "less"
            "plocate"
        )

        echo "[+] Provisioning clean application array..."
        pacman -S --needed --noconfirm "${ARCH_PACKAGES[@]}"
        ;;

    "apt")
        echo "[+] Syncing repository states..."
        apt-get update -y

        declare -a DEB_PACKAGES=(
            "xdg-user-dirs"
            "man-db"
            "manpages"
            "less"
            "plocate"
        )

        echo "[+] Provisioning target applications..."
        apt-get install -y --no-install-recommends "${DEB_PACKAGES[@]}"
        ;;

    "rpm")
        echo "[+] Syncing metadata cache and executing deployment via ${DNF_BIN}..."

        "${DNF_BIN}" install -y \
            xdg-user-dirs \
            man-db \
            man-pages \
            less \
            plocate
        ;;
esac

# ------------------------------------------------------------------------------
# 4. Post-Installation Subsystem Anchoring
# ------------------------------------------------------------------------------
echo "[+] Initializing user-space directory arrays..."
if command -v xdg-user-dirs-update &>/dev/null; then
    xdg-user-dirs-update --force || true
fi

echo "[+] Generating initial file indexing database via plocate..."
if command -v updatedb &>/dev/null; then
    updatedb
fi

# ------------------------------------------------------------------------------
# 5. Verification Validation Run
# ------------------------------------------------------------------------------
echo "------------------------------------------------------------------------------"
echo "[+] Verification Check: Validating Core Localization Environment Base State..."
echo "------------------------------------------------------------------------------"

command -v xdg-user-dirs &>/dev/null && echo "[PASS] XDG Directory Engine Active" || echo "[FAIL] XDG Engine Missing"
command -v man &>/dev/null && echo "[PASS] Documentation Subsystem Available" || echo "[FAIL] Man-db Missing"
command -v plocate &>/dev/null && echo "[PASS] Search Indexer Installed" || echo "[FAIL] Search Indexer Missing"

echo -e "\n[+] System Provisioning Strategy Successfully Completed Cleanly."

#