#!/bin/zsh
set -eu
cd "${0:A:h}"
python3 Resources/maak-icoon.py
APP="$PWD/FMT Kladblok.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp Resources/FMT-Kladblok.icns "$APP/Contents/Resources/FMT-Kladblok.icns"
/usr/bin/swiftc -swift-version 5 -O -module-cache-path /private/tmp/fmt-swift-cache Sources/*.swift -o "$APP/Contents/MacOS/FMT Kladblok" -framework AppKit
cat > "$APP/Contents/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict><key>CFBundleExecutable</key><string>FMT Kladblok</string><key>CFBundleIdentifier</key><string>nl.fastmovingtargets.kladblok.opensource</string><key>CFBundleIconFile</key><string>FMT-Kladblok.icns</string><key>CFBundleName</key><string>FMT Kladblok</string><key>CFBundleVersion</key><string>2</string><key>CFBundleShortVersionString</key><string>1.1.0</string><key>LSUIElement</key><true/><key>NSHighResolutionCapable</key><true/></dict></plist>
PLIST
/usr/bin/codesign --force --sign - "$APP"
