#!/bin/bash
# ============================================================
# build_ggb.sh — 從 XML 原始碼打包 .ggb 檔的腳本模板
# 已根據真實 GeoGebra 檔案驗證過的正確格式
# ============================================================

set -e

OUTPUT_DIR="/mnt/user-data/outputs"
OUTPUT_FILE="my_tool.ggb"
BUILD_DIR="/home/claude/ggb_build_$(date +%s)"

mkdir -p "$BUILD_DIR" "$OUTPUT_DIR"

# ── 1. geogebra_macro.xml（自製工具定義）─────────────────
# 關鍵：schema 用 ggt.xsd，macroInput/Output 用屬性格式
cat > "$BUILD_DIR/geogebra_macro.xml" << 'XMLEOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<macro cmdName="MyCmdName" toolName="我的工具"
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

# ── 2. geogebra.xml（主畫布，無 macros 區塊）─────────────
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
<construction title="示範" author="" date="">

<!-- 自由點（自由物件：使用者操作的初始條件，無法由其他物件計算得出） -->
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

<!-- 呼叫自製工具 -->
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

# ── 3. 空殼 defaults 與 JS ────────────────────────────────
cat > "$BUILD_DIR/geogebra_defaults2d.xml" << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra-defaults>
</geogebra-defaults>
EOF

cat > "$BUILD_DIR/geogebra_defaults3d.xml" << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<geogebra-defaults3d>
</geogebra-defaults3d>
EOF

echo "" > "$BUILD_DIR/geogebra_javascript.js"

# ── 4. 驗證 XML 格式 ──────────────────────────────────────
xmllint --noout "$BUILD_DIR/geogebra_macro.xml" && echo "✓ geogebra_macro.xml 格式正確" || echo "✗ geogebra_macro.xml 有誤"
xmllint --noout "$BUILD_DIR/geogebra.xml"       && echo "✓ geogebra.xml 格式正確"       || echo "✗ geogebra.xml 有誤"

# ── 5. 打包成 .ggb ────────────────────────────────────────
cd "$BUILD_DIR"
zip -j "$OUTPUT_DIR/$OUTPUT_FILE" \
    geogebra.xml \
    geogebra_macro.xml \
    geogebra_defaults2d.xml \
    geogebra_defaults3d.xml \
    geogebra_javascript.js

echo ""
echo "=== ZIP 內容 ==="
unzip -l "$OUTPUT_DIR/$OUTPUT_FILE"

# ── 6. 清理 ──────────────────────────────────────────────
cd /home/claude
rm -rf "$BUILD_DIR"
echo ""
echo "✓ 完成：$OUTPUT_DIR/$OUTPUT_FILE"
