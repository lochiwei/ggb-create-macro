---
name: ggb-create-macro
description: 直接手寫 XML 產生含自製工具 (Custom Tools / Macros) 的 GeoGebra .ggb 檔，無需啟動 GeoGebra app。當使用者說「幫我做一個 GeoGebra 自製工具」、「直接產生 .ggb 檔」、「寫 XML 做 GeoGebra 工具」、「Custom Tool」、「macro」、「自製指令」、「做一個 ggb 檔包含自製工具」等說法時，務必啟用本 skill。即使使用者只是說「幫我做一個可以畫外接圓的 GeoGebra 工具」，只要意圖是製作含自製工具的 .ggb 檔，也應觸發本 skill。
---

# GeoGebra XML Macro 製作專家

你的任務是不啟動任何 GeoGebra app，直接透過撰寫 XML 原始碼，產生包含一個或多個自製工具（Custom Tools / Macros）的 .ggb 檔，交付給使用者。

---

## 核心概念：.ggb 的正確檔案結構

.ggb 是一個 ZIP 壓縮包。含自製工具時，必須包含以下檔案：

    myfile.ggb  (ZIP)
    ├── geogebra.xml            ← 主畫布內容（必要）
    ├── geogebra_macro.xml      ← 自製工具定義（有 macro 時必要）
    ├── geogebra_defaults2d.xml ← 2D 預設樣式（可為空殼）
    ├── geogebra_defaults3d.xml ← 3D 預設樣式（可為空殼）
    └── geogebra_javascript.js  ← 全域 JS（可為空檔）

最關鍵的三個事實（從真實 .ggb 檔驗證）：

1. 自製工具定義在獨立的 geogebra_macro.xml 中，不是嵌在 geogebra.xml 的 macros 區塊
2. geogebra_macro.xml 的 schema 是 ggt.xsd，不是 ggb.xsd
3. geogebra.xml 裡沒有 macros 區塊，主畫布直接用 command name="MyTool" 呼叫

---

## 製作流程

### Step 1：釐清整體需求

首先確認工具的整體規模：

**問題 A（必問）：** 「你要建立幾個自製工具？它們之間有沒有套疊關係（高層工具呼叫低層工具）？」

根據回答分兩條路：

- **單一工具** → 直接進入 Step 1B
- **多個工具** → 先請使用者描述整體目標與工具之間的依賴關係，畫出層次結構，再從最底層工具開始逐一進入 Step 1B

### Step 1B：逐一訪談每個工具（由低層到高層）

對每個工具依序確認（若使用者已在描述中說清楚則跳過）：

1. **工具名稱**：cmdName（英文，供指令列使用）與 toolName（顯示名稱，可中文）
2. **輸入物件**：型別、個數、名稱（例：3 個點 A, B, C）
3. **輸出物件**：型別、個數、名稱（例：1 個圓 cOut）
4. **作圖邏輯**：用哪些內建指令或已定義的低層工具，依序產生輸出
5. **是否還有下一個工具？** → 若有，重複 Step 1B；若無，進入 Step 1C

### Step 1C：確認排列順序與主畫布

1. 整理所有工具的依賴關係，確認 geogebra_macro.xml 中的排列順序（被呼叫者在前）
2. 詢問主畫布示範需求：「需要在主畫布放示範用的物件嗎？」

完成後向使用者展示彙整結果（工具清單、層次結構、排列順序），請使用者確認後再進入 Step 2。

---

### Step 2：設計 XML 結構

閱讀 references/xml-schema.md 了解完整的 XML 格式規範。
閱讀 references/element-types.md 了解所有 element type 與屬性。
閱讀 references/commands-in-macro.md 了解常用 GeoGebra 指令在 XML 中的寫法（含套疊工具語法）。

### Step 3：撰寫兩個 XML 檔案

詳細格式規範見 references/xml-schema.md。重點摘要：

**geogebra_macro.xml**：
- 根元素 schema：xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"
- 所有 macro 並列寫在同一個檔案，低層工具排在前、高層工具排在後
- macroInput/Output 用屬性格式：macroInput a0="A" a1="B"，不是子元素格式
- macro 內 construction 的物件用 expression + element 雙重宣告
- 高層工具在表達式字串中呼叫低層工具時，用方括號語法：LowLevelTool[arg1, arg2]

**geogebra.xml**：
- 根元素 schema：xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggb.xsd"
- 沒有 macros 區塊，直接在 construction 裡用 command name="ToolName" 呼叫工具

### Step 4：打包 .ggb

見 scripts/build_ggb.sh 的模板。必須打包的檔案：
  geogebra.xml, geogebra_macro.xml, geogebra_defaults2d.xml,
  geogebra_defaults3d.xml, geogebra_javascript.js

打包前用 xmllint 驗證兩個 XML 的格式。

### Step 5：交付

使用 present_files 工具將 .ggb 交付給使用者，並附上：
- 所有工具的說明（層次結構、各工具的輸入／輸出／功能）
- 在 GeoGebra 中使用方式（從最高層工具開始呼叫）
- 主畫布範例說明

---

## 命名規則

點 (point)：大寫字母，例如 A, P1, Qout
向量 (vector)：小寫字母，例如 v, u1
數值 (numeric)：小寫字母，例如 r, n1
禁用名稱：π, ℯ, ί 不可用於任何物件名稱

注意：macro 內部物件名稱建議避免使用下標格式（A_{1}），
改用簡單駝峰命名（Oc, cOut, pbAB），在 macroInput/Output 屬性中更安全可靠。

---

## 嚴禁事項

- 嚴禁把 macro 寫進 geogebra.xml 的 macros 區塊（這是錯誤格式）
- 嚴禁 geogebra_macro.xml 使用 ggb.xsd（必須用 ggt.xsd）
- 嚴禁 macroInput/macroOutput 使用子元素格式（必須用屬性 a0=, a1= 格式）
- 嚴禁 hard-coded 座標（除非是必要的自由物件，須說明理由）
- 嚴禁使用外部計算的數字（所有計算必須在 GeoGebra 的 command 中完成）

---

## 參考檔案索引

references/xml-schema.md      完整 XML 標籤與屬性規範，含 geogebra_macro.xml 正確格式與完整範例
references/element-types.md   所有 element type 與可用屬性
references/commands-in-macro.md 常用 GeoGebra 指令的 XML 寫法
scripts/build_ggb.sh          打包腳本模板
