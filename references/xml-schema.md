# GeoGebra XML 完整 Schema 參考

## 一、.ggb 檔案結構總覽

含自製工具的 .ggb 必須包含兩個核心 XML 檔：

    geogebra_macro.xml   ← 自製工具定義，schema = ggt.xsd
    geogebra.xml         ← 主畫布，schema = ggb.xsd，無 macros 區塊

---

## 二、geogebra_macro.xml 完整格式

這是從真實 GeoGebra 檔案驗證過的正確格式。

### 根元素

```xml
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
```

注意：schema 是 ggt.xsd，不是 ggb.xsd。無 id 屬性。

### macro 元素

```xml
<macro cmdName="MyCmdName" toolName="顯示名稱"
       toolHelp="MyCmdName(&lt;Point&gt;,&lt;Point&gt;)"
       iconFile="" showInToolBar="true" copyCaptions="true" viewId="1">
    <macroInput a0="A" a1="B" a2="C"/>
    <macroOutput a0="result"/>
<construction title="" author="" date="">

  <!-- 輸入物件：用 expression + element 雙重宣告 -->
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

  <!-- 作圖指令鏈 -->
  <command name="SomeCommand">
    <input a0="A" a1="B"/>
    <output a0="result"/>
  </command>
  <element type="conic" label="result">
    <show object="true" label="false"/>
    <objColor r="255" g="0" b="0" alpha="0"/>
    <layer val="0"/>
    <labelMode val="0"/>
    <lineStyle thickness="4" type="0"/>
  </element>

</construction>
</macro>

<!-- 可有多個 macro -->

</geogebra>
```

### macroInput / macroOutput 屬性說明

- 格式：屬性式，a0=, a1=, a2= ... 對應輸入/輸出物件的標籤名稱
- 不是子元素式（錯誤示範：`<macroInput><element .../></macroInput>`）
- 標籤名稱必須與 construction 內的 element label 完全一致

### macro 屬性說明

| 屬性 | 說明 |
|------|------|
| cmdName | 指令列呼叫名稱，英文無空格 |
| toolName | 工具列顯示名稱，可中文 |
| toolHelp | 懸停說明，用 &lt; &gt; 表示角括號 |
| showInToolBar | 是否出現在工具列，通常 "true" |
| copyCaptions | 通常 "true" |
| viewId | 通常 "1"（幾何視圖） |

### construction 內的輸入物件宣告方式

從真實檔案觀察，輸入物件建議用 expression + element 雙重宣告：

```xml
<!-- 點 -->
<expression label="A" exp="(-2, 0)" type="point"/>
<element type="point" label="A">
  ...
  <coords x="-2.0" y="0.0" z="1.0"/>
</element>

<!-- 數值 -->
<expression label="t" exp="0.2"/>
<element type="numeric" label="t">
  <value val="0.2"/>
  <symbolic val="true"/>
  ...
</element>

<!-- 列表 -->
<expression label="v0" exp="{(1, 1), (4, 1), (4, 4), (1, 4)}"/>
<element type="list" label="v0">
  ...
</element>
```

---

## 三、geogebra.xml 完整格式

### 根元素

```xml
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          id="00000000-0000-0000-0000-000000000000"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggb.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
```

### 完整結構

```xml
<geogebra ...>
<gui>
  <window width="1280" height="800"/>
  <perspectives>
    <perspective id="tmp">
      <panes>
        <pane location="" divider="0.25" orientation="1"/>
      </panes>
      <views>
        <view id="1" visible="true" inframe="false" stylebar="true"
              location="1,3" size="963" window="100,100,600,400"/>
        <view id="2" visible="true" inframe="false" stylebar="true"
              location="3" size="310" tab="ALGEBRA" window="100,100,600,400"/>
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

<!-- 注意：這裡沒有 macros 區塊！ -->

<construction title="作圖標題" author="" date="">

  <!-- 自由點（說明為何是自由物件） -->
  <expression label="P1" exp="(-3, -1)" type="point"/>
  <element type="point" label="P1">
    <show object="true" label="true"/>
    <objColor r="21" g="101" b="192" alpha="0"/>
    <layer val="0"/>
    <labelMode val="0"/>
    <animation step="0.1" type="1" playing="false"/>
    <pointSize val="5"/>
    <pointStyle val="0"/>
    <coords x="-3.0" y="-1.0" z="1.0"/>
  </element>

  <!-- 呼叫自製工具，與呼叫內建指令完全相同 -->
  <command name="MyCmdName">
    <input a0="P1" a1="P2" a2="P3"/>
    <output a0="result1"/>
  </command>
  <element type="conic" label="result1">
    <show object="true" label="false"/>
    <objColor r="255" g="0" b="0" alpha="0"/>
    <layer val="0"/>
    <labelMode val="0"/>
    <lineStyle thickness="4" type="0"/>
  </element>

</construction>
</geogebra>
```

---

## 四、euclidianView 的 coordSystem 說明

| 屬性 | 說明 |
|------|------|
| xZero, yZero | 原點在畫布像素中的位置 |
| scale, yscale | 每單位的像素數（60 = 每格 60px） |

---

## 五、點的齊次座標

GeoGebra 使用齊次座標表示點：

    coords x="X" y="Y" z="Z"  →  實際座標 (X/Z, Y/Z)

一般有限點：z="1.0"，所以 x, y 就是實際座標。

---

## 六、command 的 input/output 對應

```xml
<command name="CommandName">
  <input a0="物件1" a1="物件2" a2="物件3"/>
  <output a0="輸出1" a1="輸出2"/>
</command>
```

a0, a1, a2 對應 GeoGebra 指令文件中的參數順序。
多個輸出（如 Polygon）：a0=多邊形本身，a1 起依序為各邊。

---

## 八、套疊自製工具的 geogebra_macro.xml 結構

多個互相依賴的自製工具全部並列寫在同一個 `geogebra_macro.xml`，
**低層工具（被呼叫者）必須排在高層工具（呼叫者）之前**。

```xml
<?xml version="1.0" encoding="utf-8"?>
<geogebra format="5.0" version="5.4.925.3" app="classic" platform="d"
          xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"
          xmlns="" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<!-- ① 最底層工具（只用內建指令） -->
<macro cmdName="LowLevel" ...>
    <macroInput a0="pts" a1="t"/>
    <macroOutput a0="result"/>
    <construction ...>
        <!-- 只呼叫 GeoGebra 內建指令 -->
    </construction>
</macro>

<!-- ② 中層工具（呼叫 LowLevel） -->
<macro cmdName="MidLevel" ...>
    <macroInput a0="pts" a1="t" a2="n"/>
    <macroOutput a0="out"/>
    <construction ...>
        <!-- 在表達式字串中用方括號呼叫低層工具 -->
        <command name="IterationList">
            <input a0="LowLevel[L, t]" a1="L" a2="{pts}" a3="n"/>
            <output a0="out"/>
        </command>
        ...
    </construction>
</macro>

<!-- ③ 高層工具（呼叫 MidLevel） -->
<macro cmdName="HighLevel" ...>
    ...
</macro>

</geogebra>
```

詳細的套疊語法與設計原則見 `references/commands-in-macro.md` 的「套疊自製工具」一節。
