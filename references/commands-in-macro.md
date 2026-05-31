# 常用 GeoGebra 指令的 XML 寫法（Macro 內使用）

> 每個指令條目格式：
> - 指令列語法（參考用）
> - XML `<command>` 寫法
> - 輸出 element 的 type

---

## 點與中點類

### `Midpoint(A, B)` — 兩點中點

```xml
<command name="Midpoint">
  <input a0="A" a1="B"/>
  <output a0="M"/>
</command>
<element type="point" label="M">
  <show object="false" label="false"/>
  <objColor r="0" g="150" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="3"/>
  <pointStyle val="0"/>
</element>
```

### `Centroid(poly)` — 多邊形重心

```xml
<!-- 先建立多邊形 -->
<command name="Polygon">
  <input a0="A" a1="B" a2="C"/>
  <output a0="poly1" a1="seg_{AB}" a2="seg_{BC}" a3="seg_{CA}"/>
</command>
<element type="polygon" label="poly1">
  <show object="false" label="false"/>
  <objColor r="153" g="51" b="255" alpha="0.1"/>
  <layer val="0"/>
  <labelMode val="0"/>
</element>
<element type="segment" label="seg_{AB}">
  <show object="false" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0" typeHidden="1"/>
</element>
<!-- seg_{BC}, seg_{CA} 同上格式 -->

<!-- 再求重心 -->
<command name="Centroid">
  <input a0="poly1"/>
  <output a0="G"/>
</command>
<element type="point" label="G">
  <show object="true" label="true"/>
  <objColor r="255" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
</element>
```

---

## 圓類

### `Circle(M, r)` — 圓心+半徑

```xml
<command name="Circle">
  <input a0="M" a1="r"/>
  <output a0="c"/>
</command>
<element type="conic" label="c">
  <show object="true" label="true"/>
  <objColor r="0" g="0" b="255" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0"/>
</element>
```

### `Circle(A, B, C)` — 三點外接圓

```xml
<command name="Circle">
  <input a0="A" a1="B" a2="C"/>
  <output a0="c_{circ}"/>
</command>
<element type="conic" label="c_{circ}">
  <show object="true" label="true"/>
  <objColor r="0" g="0" b="255" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0"/>
</element>
```

### `Circumcenter(A, B, C)` — 三點外心

```xml
<command name="Circumcenter">
  <input a0="A" a1="B" a2="C"/>
  <output a0="O_{circ}"/>
</command>
<element type="point" label="O_{circ}">
  <show object="true" label="true"/>
  <objColor r="255" g="100" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
</element>
```

---

## 線段、直線、射線

### `Segment(A, B)` — 線段

```xml
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
```

### `Line(A, B)` — 過兩點直線

```xml
<command name="Line">
  <input a0="A" a1="B"/>
  <output a0="l"/>
</command>
<element type="line" label="l">
  <show object="true" label="true"/>
  <objColor r="100" g="100" b="100" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="3" type="0"/>
</element>
```

### `PerpendicularLine(P, l)` — 過點作直線的垂線

```xml
<command name="PerpendicularLine">
  <input a0="P" a1="l"/>
  <output a0="l_{perp}"/>
</command>
<element type="line" label="l_{perp}">
  <show object="false" label="false"/>
  <objColor r="150" g="150" b="150" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="2" type="1"/>
</element>
```

### `PerpendicularBisector(A, B)` — 線段中垂線

```xml
<command name="PerpendicularBisector">
  <input a0="A" a1="B"/>
  <output a0="pb_{AB}"/>
</command>
<element type="line" label="pb_{AB}">
  <show object="false" label="false"/>
  <objColor r="150" g="150" b="150" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="2" type="1"/>
</element>
```

---

## 多邊形

### `Polygon(A, B, C, ...)` — 多邊形

```xml
<command name="Polygon">
  <input a0="A" a1="B" a2="C" a3="D"/>
  <output a0="quad1" a1="s_{AB}" a2="s_{BC}" a3="s_{CD}" a4="s_{DA}"/>
</command>
```

> ⚠️ 輸出順序：a0=多邊形本身，a1 起依序為各邊（按輸入點順序）。  
> 需為每個輸出物件各自建立對應的 `<element>`。

### `RegularPolygon(A, B, n)` — 正 n 邊形

```xml
<command name="RegularPolygon">
  <input a0="A" a1="B" a2="n"/>
  <output a0="poly_{reg}" a1="C" a2="D" a3="s_{AB}" a4="s_{BC}" a5="s_{CD}" a6="s_{DA}"/>
</command>
```

> `n` 必須是已定義的 GeoGebra 數值物件，不可以是 hard-coded 數字。  
> 輸出：a0=多邊形, a1~a(n-2)=新生成的點, a(n-1)起=各邊。

---

## 幾何變換

### `Rotate(X, α, C)` — 繞點旋轉

```xml
<!-- α 必須是已定義的角度物件或數值物件 -->
<command name="Rotate">
  <input a0="A" a1="alpha" a2="C"/>
  <output a0="A_{rot}"/>
</command>
<element type="point" label="A_{rot}">
  <show object="true" label="true"/>
  <objColor r="255" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
</element>
```

### `Translate(X, v)` — 平移（v 為向量）

```xml
<command name="Translate">
  <input a0="A" a1="v"/>
  <output a0="A_{tr}"/>
</command>
```

### `Dilate(X, k, C)` — 以 C 為中心縮放 k 倍

```xml
<command name="Dilate">
  <input a0="A" a1="k" a2="C"/>
  <output a0="A_{dl}"/>
</command>
```

---

## 交點與求值

### `Intersect(f, g)` — 兩物件交點

```xml
<command name="Intersect">
  <input a0="c_{1}" a1="c_{2}"/>
  <output a0="X_{1}" a1="X_{2}"/>
</command>
```

### `Distance(A, B)` — 兩點距離（numeric）

```xml
<command name="Distance">
  <input a0="A" a1="B"/>
  <output a0="d_{AB}"/>
</command>
<element type="numeric" label="d_{AB}">
  <show object="false" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <value val="0.0"/>
</element>
```

### `Angle(A, B, C)` — 角度（∠ABC）

```xml
<command name="Angle">
  <input a0="A" a1="B" a2="C"/>
  <output a0="alpha_{ABC}"/>
</command>
<element type="angle" label="alpha_{ABC}">
  <show object="false" label="false"/>
  <objColor r="255" g="170" b="0" alpha="0.1"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <arcSize val="30"/>
</element>
```

---

## Sequence / Zip 批量建立

### `Sequence(expr, var, from, to)` — 序列

```xml
<command name="Sequence">
  <input a0="Rotate(A, (k - 1) * 2 * pi / n, O)" a1="k" a2="1" a3="n"/>
  <output a0="pts"/>
</command>
<element type="list" label="pts">
  <show object="false" label="false"/>
  <objColor r="0" g="0" b="255" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
</element>
```

> ⚠️ `n` 必須是已定義的 GeoGebra 數值物件。  
> `2 * pi` 在 XML 的 input 表達式中寫成 GeoGebra 語法：`6.283185307179586`... **不行！**  
> 應在 macro 外（或 macro 的 construction 內）先定義 `n = ...` 再使用。  
> 實際上 Sequence 在 XML 中使用 GGBScript 語法字串，較複雜時建議用 JavaScript 替代。

---

## 文字物件

### `Text(content, position)` — 文字標籤

```xml
<command name="Text">
  <input a0="&quot;文字內容&quot;" a1="A"/>
  <output a0="t_{1}"/>
</command>
<element type="text" label="t_{1}">
  <show object="true" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <isLaTeX val="false"/>
</element>
```

> XML 中引號必須轉義：`"` → `&quot;`

---

## 數值物件（numeric）作為輸入

若工具需要接收一個數值參數（例如比例、迭代次數），將它列為 macroInput 的一個 slot：

```xml
<macroInput a0="v0" a1="t" a2="m"/>
```

然後在 construction 中用 expression + element 雙重宣告：

```xml
<expression label="t" exp="0.2"/>
<element type="numeric" label="t">
	<value val="0.2"/>
	<symbolic val="true"/>
	<show object="true" label="true"/>
	<objColor r="0" g="0" b="0" alpha="0"/>
	<layer val="0"/>
	<labelMode val="1"/>
</element>
```

---

## 套疊自製工具（Nested Macros）

複雜的作圖任務可以把多個自製工具分層設計，高層工具在內部呼叫低層工具。
這是從真實 GeoGebra 檔案（nested_spirals_rosette_corrected.ggb）驗證過的做法。

### 排列規則：同一個 geogebra_macro.xml，依賴順序在前

所有 macro 並列寫在同一個 `geogebra_macro.xml` 檔案中，**被呼叫的低層工具必須定義在高層工具之前**，GeoGebra 會按順序載入。

```xml
<!-- geogebra_macro.xml -->
<geogebra ... xsi:noNamespaceSchemaLocation=".../ggt.xsd" ...>

<!-- ① 低層工具先定義 -->
<macro cmdName="NextGen" ...>
    <macroInput a0="v0" a1="t"/>
    <macroOutput a0="l1"/>
    <construction ...>
        <!-- 只用內建指令，不呼叫其他自製工具 -->
        <command name="Sequence">
            <input a0="Dilate[v0(1 + Mod[k, n]), t, v0(k)]" a1="k" a2="1" a3="n"/>
            <output a0="l1"/>
        </command>
        ...
    </construction>
</macro>

<!-- ② 高層工具後定義，內部呼叫 NextGen -->
<macro cmdName="NestedSpiral" ...>
    <macroInput a0="v0" a1="t" a2="m"/>
    <macroOutput a0="spiral"/>
    <construction ...>
        <!-- 在表達式字串中用方括號語法呼叫低層工具 -->
        <command name="IterationList">
            <input a0="NextGen[L, t]" a1="L" a2="{v0}" a3="m"/>
            <output a0="nested"/>
        </command>
        ...
    </construction>
</macro>

</geogebra>
```

### 兩種呼叫自製工具的語法

在 construction 內有兩種地方可以呼叫自製工具，語法不同：

**① 頂層呼叫**（construction 的直接子元素）：用 `<command name="ToolName">` XML 標籤

```xml
<command name="NestedSpiral">
    <input a0="v0" a1="t" a2="m"/>
    <output a0="spiral"/>
</command>
```

**② 嵌入表達式字串內呼叫**（作為另一個指令的參數）：用**方括號語法** `ToolName[arg1, arg2]`

```xml
<!-- NextGen 被當作 IterationList 的迭代函數參數 -->
<command name="IterationList">
    <input a0="NextGen[L, t]" a1="L" a2="{v0}" a3="m"/>
    <output a0="nested"/>
</command>

<!-- 也可出現在 Sequence 的表達式中 -->
<command name="Sequence">
    <input a0="MyTool[pts(k), t]" a1="k" a2="1" a3="n"/>
    <output a0="result"/>
</command>
```

> 方括號語法是 GeoGebra 的內嵌指令語法，等同於指令列中的 `ToolName(arg1, arg2)`。
> 在 XML 屬性值字串裡必須用方括號 `[]` 而非圓括號 `()`，以避免 XML 解析衝突。

### 套疊工具設計原則

1. **單一職責**：每個低層工具只做一件事（如「產生下一代點列表」）
2. **由下而上**：先設計並測試低層工具，再組合成高層工具
3. **命名清晰**：低層工具名稱反映其功能（`NextGen`），高層工具名稱反映整體效果（`NestedSpiral`）
4. **深度不限**：可以三層甚至更多層套疊，只要在 geogebra_macro.xml 中按依賴順序排列

### 常用的適合套疊的高層指令

| 指令 | 用途 | 嵌入語法範例 |
|------|------|-------------|
| `IterationList` | 反覆套用一個函數 n 次，收集每次結果 | `IterationList[MyTool[L, t], L, {v0}, n]` |
| `Sequence` | 對序號 k 逐一套用表達式 | `Sequence[MyTool[pts(k)], k, 1, n]` |
| `Zip` | 對列表元素逐一套用表達式 | `Zip[MyTool[p, t], p, pts]` |
| `Mirror` / `Rotate` | 對整個列表做幾何變換 | `Rotate[{s1, s2}, k * theta]`（可對列表操作） |

---

## 常見錯誤與解法

| 錯誤 | 原因 | 解法 |
|------|------|------|
| 指令執行失敗 | input 名稱與 element label 不一致 | 逐字核對大小寫 |
| 輸出物件消失 | element 在 command 之前宣告 | 確保 output element 在 command 之後 |
| 圓型別錯誤 | 圓的 type 用了 `circle` | GeoGebra 的圓屬於 `conic` type |
| 多邊形邊遺漏 | Polygon 輸出沒列出所有邊 | 輸出數量 = 頂點數 + 1（多邊形本身） |
| 套疊工具找不到低層工具 | 高層工具定義在低層工具之前 | geogebra_macro.xml 中低層工具必須排在前面 |
| 嵌入表達式中工具呼叫失敗 | 在字串屬性中用了圓括號 `()` | 改用方括號 `[]`：`MyTool[arg1, arg2]` |
| macroInput/Output 格式錯誤 | 用了子元素格式 `<element .../>` | 改用屬性格式 `<macroInput a0="A" a1="B"/>` |
