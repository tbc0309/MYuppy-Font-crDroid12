#!/system/bin/sh

ui_print "- MYuppy Font 1.0.0"
ui_print "- Target: Android 16"
ui_print "- Systemless overlay; stock files remain unchanged"
ui_print "- KernelSU Next requires a system-mount metamodule"
ui_print "- Install Hybrid Mount or another compatible metamodule first"

SDK="$(getprop ro.build.version.sdk)"

[ "$SDK" = "36" ] || abort "Unsupported Android SDK: $SDK (Android 16 required)"

for ROOT in /data/adb/modules /data/adb/modules_update; do
  [ -d "$ROOT" ] || continue
  for OTHER in "$ROOT"/*; do
    [ -d "$OTHER" ] || continue
    [ "$OTHER" = "$MODPATH" ] && continue
    [ "$(basename "$OTHER")" = "$MODID" ] && continue
    [ -f "$OTHER/disable" ] && continue
    [ -f "$OTHER/remove" ] && continue
    if [ -f "$OTHER/system/etc/fonts.xml" ] || \
       [ -f "$OTHER/system/etc/font_fallback.xml" ] || \
       [ -f "$OTHER/product/etc/fonts_customization.xml" ] || \
       [ -f "$OTHER/system/fonts/Roboto-Regular.ttf" ] || \
       [ -f "$OTHER/system/fonts/MYuppy-Regular.ttf" ]; then
      abort "Conflicting font module: $(basename "$OTHER")"
    fi
  done
done

[ -f "$MODPATH/system/etc/fonts.xml" ] || abort "Module fonts.xml is missing"
[ -f "$MODPATH/system/etc/font_fallback.xml" ] || abort "Module font_fallback.xml is missing"
[ -f "$MODPATH/product/etc/fonts_customization.xml" ] || abort "Module product font configuration is missing"
[ -f "$MODPATH/system/fonts/MYuppy-Regular.ttf" ] || abort "MYuppy Regular font is missing"
[ -f "$MODPATH/system/fonts/MYuppy-Bold.ttf" ] || abort "MYuppy Bold font is missing"
[ -f "$MODPATH/product/fonts/MYuppy-Regular.ttf" ] || abort "Product MYuppy Regular font is missing"
[ -f "$MODPATH/product/fonts/MYuppy-Bold.ttf" ] || abort "Product MYuppy Bold font is missing"

set_perm_recursive "$MODPATH/system" 0 0 0755 0644
set_perm_recursive "$MODPATH/product" 0 0 0755 0644
ui_print "- Validation passed"
ui_print "- Reboot after installation"
