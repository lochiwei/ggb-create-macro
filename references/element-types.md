# GeoGebra Element Types 完整參考

## 一、所有 Element Type 一覧

| type 字串 | 對應物件 | 常見用途 |
|-----------|---------|---------|
| `point` | 點 | 幾何構造的基礎 |
| `segment` | 線段 | 兩點之間的有限線 |
| `line` | 直線 | 無限延伸的線 |
| `ray` | 射線 | 單向無限延伸 |
| `vector` | 向量 | 帶方向的線段 |
| `conic` | 圓錐曲線（含圓、橢圓、雙曲線、拋物線） | 所有圓都是 conic |
| `arc` | 弧 | 圓弧或橢圓弧 |
| `polygon` | 多邊形 | Polygon 指令的面輸出 |
| `polyline` | 折線 | 非封閉多邊形 |
| `numeric` | 數值 | 純數字物件 |
| `angle` | 角度 | 以弧度儲存，顯示為度 |
| `boolean` | 布林值 | true/false |
| `text` | 文字 | 畫布上的標籤 |
| `function` | 函數 | f(x) 型函數 |
| `list` | 列表 | Sequence 等指令的輸出 |
| `image` | 圖片 | 嵌入圖片 |
| `locus` | 軌跡 | Locus 指令輸出 |
| `implicit` | 隱函數曲線 | 隱式方程式的曲線 |

---

## 二、各 Type 的必要與選用屬性

### `point` — 點

**必要：**
```xml
<element type="point" label="P">
  <show object="true" label="true"/>
  <objColor r="21" g="101" b="192" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <pointSize val="5"/>
  <pointStyle val="0"/>
  <coords x="0.0" y="0.0" z="1.0"/>
</element>
```

**選用：**
```xml
<fixed val="false"/>                        <!-- 鎖定點，使用者不能移動 -->
<auxiliary val="true"/>                     <!-- 輔助物件（代數視圖隱藏） -->
<animation step="0.1" speed="1" type="1" playing="false"/>  <!-- 動畫 -->
<caption val="自訂標題"/>                  <!-- 覆蓋標籤顯示 -->
```

**`pointStyle` 值：**
- `0` = 實心圓點（預設）
- `1` = 十字 ×
- `2` = 空心圓
- `3` = 加號 +
- `4` = 實心菱形
- `5` = 空心菱形

---

### `segment` — 線段

```xml
<element type="segment" label="s_{AB}">
  <show object="true" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0" typeHidden="1"/>
  <auxiliary val="false"/>
</element>
```

**`lineStyle.type` 值：**
- `0` = 實線
- `1` = 虛線（長）
- `2` = 點線
- `3` = 點虛線
- `4` = 長虛線

**`thickness`：** 1–13，預設 5

---

### `line` / `ray` — 直線 / 射線

```xml
<element type="line" label="l">
  <show object="true" label="true"/>
  <objColor r="100" g="100" b="100" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="3" type="0"/>
</element>
```

---

### `conic` — 圓錐曲線（含圓）

> ⚠️ **重要：** GeoGebra 中所有的圓（Circle 指令輸出）的 element type 都是 `conic`，不是 `circle`！

```xml
<element type="conic" label="c">
  <show object="true" label="true"/>
  <objColor r="0" g="0" b="255" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0"/>
  <!-- 若要填色，alpha 設為非零值，例如 alpha="0.1" -->
</element>
```

---

### `polygon` — 多邊形

```xml
<element type="polygon" label="poly1">
  <show object="true" label="false"/>
  <objColor r="153" g="51" b="255" alpha="0.10000000149011612"/>
  <!-- alpha 控制填色透明度 -->
  <layer val="0"/>
  <labelMode val="0"/>
</element>
```

---

### `numeric` — 數值物件

```xml
<element type="numeric" label="r">
  <show object="false" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <value val="1.0"/>
  <!-- value 僅為初始值/預設值，實際值由計算決定 -->
</element>
```

若是滑桿（slider）還需加：
```xml
<slider min="-5" max="5" absoluteScreenLocation="false"
        width="200" x="0" y="0"
        fixed="false" horizontal="true" showAlgebra="true"/>
```

---

### `angle` — 角度

```xml
<element type="angle" label="alpha">
  <show object="true" label="true"/>
  <objColor r="255" g="170" b="0" alpha="0.10000000149011612"/>
  <layer val="0"/>
  <labelMode val="1"/>   <!-- 1 = 顯示值 -->
  <arcSize val="30"/>
  <angleStyle val="0"/>
  <!-- angleStyle: 0=逆時針, 1=順時針 -->
</element>
```

---

### `vector` — 向量

```xml
<element type="vector" label="v">
  <show object="true" label="true"/>
  <objColor r="0" g="150" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <lineStyle thickness="5" type="0"/>
  <coords x="1.0" y="0.0" z="0.0"/>
  <!-- 向量的 coords：z=0 表示方向向量 -->
</element>
```

---

### `text` — 文字

```xml
<element type="text" label="t_{1}">
  <show object="true" label="false"/>
  <objColor r="0" g="0" b="0" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <isLaTeX val="false"/>
  <!-- isLaTeX="true" 時支援 LaTeX 數學公式 -->
  <font serif="false" sizeM="1.0" bold="false" italic="false"/>
  <startPoint x="-3.0" y="2.0" z="1.0"/>
</element>
```

---

### `list` — 列表（Sequence 輸出）

```xml
<element type="list" label="pts">
  <show object="false" label="false"/>
  <objColor r="0" g="0" b="255" alpha="0"/>
  <layer val="0"/>
  <labelMode val="0"/>
  <listType val="0"/>
</element>
```

---

## 三、`<objColor>` 顏色參考

GeoGebra 預設配色（RGB 值）：

| 顏色 | r | g | b |
|------|---|---|---|
| 深藍（預設點色） | 21 | 101 | 192 |
| 紅色 | 255 | 0 | 0 |
| 綠色 | 0 | 150 | 0 |
| 橙色 | 255 | 100 | 0 |
| 紫色 | 153 | 51 | 255 |
| 黑色 | 0 | 0 | 0 |
| 灰色 | 150 | 150 | 150 |
| 金黃色 | 255 | 200 | 0 |

`alpha` 欄位：
- `alpha="0"` = 完全不透明的**線條**（對實心填色物件，0 = 無填色）
- `alpha="0.10000000149011612"` ≈ 10% 透明填色（多邊形常用）
- `alpha="1.0"` = 完全填色

---

## 四、`<layer>` 說明

- 範圍：`0`（最底層）到 `9`（最頂層）
- 相同 layer 的物件按定義順序疊加
- 建議：輸入點用 `layer="1"`，輸出物件用 `layer="0"`，輔助物件用 `layer="0"`

---

## 五、`<labelMode>` 值說明

| val | 顯示內容 |
|-----|---------|
| `0` | 物件名稱（label） |
| `1` | 名稱 = 值 |
| `2` | 值（不顯示名稱） |
| `3` | 標題（caption，需設定 `<caption val="..."/>`） |
