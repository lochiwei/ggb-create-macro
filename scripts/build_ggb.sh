#!/usr/bin/env bash
# Portable template for packaging GeoGebra XML files into a .ggb archive.
#
# Usage:
#   ./scripts/build_ggb.sh [output-file.ggb] [source-dir]
#
# Environment variables:
#   OUTPUT_FILE  Output .ggb path. Overridden by argument 1.
#   SOURCE_DIR   Directory containing geogebra*.xml/js files. Overridden by argument 2.
#   WORK_DIR     Temporary build directory. Created automatically when omitted.

set -euo pipefail

OUTPUT_FILE="${1:-${OUTPUT_FILE:-my_tool.ggb}}"
SOURCE_DIR="${2:-${SOURCE_DIR:-}}"
WORK_DIR="${WORK_DIR:-}"

cleanup_work_dir=false

case "$OUTPUT_FILE" in
  /*) OUTPUT_PATH="$OUTPUT_FILE" ;;
  *) OUTPUT_PATH="$PWD/$OUTPUT_FILE" ;;
esac

if [[ -z "$SOURCE_DIR" ]]; then
  if [[ -n "$WORK_DIR" ]]; then
    BUILD_DIR="$WORK_DIR"
    mkdir -p "$BUILD_DIR"
  else
    BUILD_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ggb-build.XXXXXX")"
    cleanup_work_dir=true
  fi

  cat > "$BUILD_DIR/geogebra_macro.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<macro cmdName="MyCmdName" toolName="My Tool"
       toolHelp="MyCmdName(&lt;Point&gt;,&lt;Point&gt;)"
       iconFile="" showInToolBar="true" copyCaptions="true" viewId="1">
  <macroInput a0="A" a1="B"/>
  <macroOutput a0="s"/>
<construction title="" author="" date="">

<expression label="A" exp="(-2, 0)" type="point"/>
<element type="point" label="A">
  <show object="true" label="true"/>
  <objColor r="21" g="101" b="192" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
  <coords x="-2.0" y="0.0" z="1.0"/>
</element>

<expression label="B" exp="(2, 0)" type="point"/>
<element type="point" label="B">
  <show object="true" label="true"/>
  <objColor r="21" g="101" b="192" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
  <coords x="2.0" y="0.0" z="1.0"/>
</element>

<command name="Segment">
  <input a0="A" a1="B"/>
  <output a0="s"/>
</command>
<element type="segment" label="s">
  <show object="true" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0" typeHidden="1"/>
</element>

</construction>
</macro>

</geogebra>
XMLEOF

  cat > "$BUILD_DIR/geogebra.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          id="00000000-0000-0000-0000-000000000000"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggb.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<gui>
  <window width="1280" height="800"/>
  <perspectives>
<perspective id="tmp">
  <panes>
  <pane location="" divider="0.25" orientation="1"/>
  </panes>
  <views>
  <view id="1" visible="true" inframe="false" stylebar="true" location="1,3" size="963" window="100,100,600,400"/>
  <view id="2" visible="true" inframe="false" stylebar="true" location="3" size="310" tab="ALGEBRA" window="100,100,600,400"/>
  </views>
  <toolbar show="true" items="0 1 2 3 4" position="1" help="true"/>
  <input show="true" cmd="true" top="algebra"/>
  <dockBar show="false" east="false"/>
</perspective>
  </perspectives>
  <labelingStyle val="0"/>
  <font size="16"/>
</gui>
<euclidianView>
  <viewNumber viewNo="1"/>
  <size width="963" height="697"/>
  <coordSystem xZero="481.5" yZero="348.5" scale="60.0" yscale="60.0"/>
  <evSettings axes="true" grid="true" gridIsBold="false"
              pointCapturing="3" rightAngleStyle="2" checkboxSize="26" gridType="3"/>
  <bgColor r="255" g="255" b="255"/>
  <axesColor r="0" g="0" b="0"/>
  <gridColor r="192" g="192" b="192"/>
  <lineStyle axes="1" grid="0"/>
  <axis id="0" show="true" label="" unitLabel="" tickStyle="1" showNumbers="true"/>
  <axis id="1" show="true" label="" unitLabel="" tickStyle="1" showNumbers="true"/>
</euclidianView>
<algebraView>
  <mode val="1"/>
</algebraView>
<kernel>
  <continuous val="false"/>
  <usePathAndRegionParameters val="true"/>
  <decimals val="2"/>
  <angleUnit val="degree"/>
  <algebraStyle val="2" spreadsheet="0"/>
  <coordStyle val="0"/>
</kernel>
<scripting blocked="false" disabled="false"/>
<construction title="Demo" author="" date="">

<expression label="P1" exp="(-3, 0)" type="point"/>
<element type="point" label="P1">
  <show object="true" label="true"/>
  <objColor r="21" g="101" b="192" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <animation step="0.1" type="1" playing="false"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
  <coords x="-3.0" y="0.0" z="1.0"/>
</element>

<expression label="P2" exp="(3, 0)" type="point"/>
<element type="point" label="P2">
  <show object="true" label="true"/>
  <objColor r="21" g="101" b="192" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <animation step="0.1" type="1" playing="false"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
  <coords x="3.0" y="0.0" z="1.0"/>
</element>

<command name="MyCmdName">
  <input a0="P1" a1="P2"/>
  <output a0="s1"/>
</command>
<element type="segment" label="s1">
  <show object="true" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0" typeHidden="1"/>
</element>

</construction>
</geogebra>
XMLEOF

  cat > "$BUILD_DIR/geogebra_defaults2d.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra-defaults>
</geogebra-defaults>
XMLEOF

  cat > "$BUILD_DIR/geogebra_defaults3d.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra-defaults3d>
</geogebra-defaults3d>
XMLEOF

  : > "$BUILD_DIR/geogebra_javascript.js"
else
  BUILD_DIR="$SOURCE_DIR"
fi

required_files=(
  geogebra.xml
  geogebra_macro.xml
  geogebra_defaults2d.xml
  geogebra_defaults3d.xml
  geogebra_javascript.js
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$BUILD_DIR/$file" ]]; then
    echo "Missing required file: $BUILD_DIR/$file" >&2
    exit 1
  fi
done

if command -v xmllint >/dev/null 2>&1; then
  xmllint --noout "$BUILD_DIR/geogebra_macro.xml"
  xmllint --noout "$BUILD_DIR/geogebra.xml"
else
  echo "Warning: xmllint not found; skipping XML syntax validation." >&2
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"

(
  cd "$BUILD_DIR"
  zip -q -j "$OUTPUT_PATH" "${required_files[@]}"
)

echo "Created: $OUTPUT_PATH"
unzip -l "$OUTPUT_PATH"

if [[ "$cleanup_work_dir" == true ]]; then
  rm -rf "$BUILD_DIR"
fi
