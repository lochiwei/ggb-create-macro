# ggb-create-macro

直接手寫 XML 產生含自製工具 (Custom Tools / Macros) 的 GeoGebra `.ggb` 檔，無需啟動 GeoGebra app。

這是一個 Claude / Cowork 的 **skill**。內容包含：

- `SKILL.md` — skill 主說明
- `references/` — XML schema、元件型別、macro 內可用指令等參考文件
- `scripts/build_ggb.sh` — 將 XML 打包成 `.ggb` 的腳本
- `ggb-create-macro.skill` — 打包好的 skill 檔（可直接安裝）

## 使用方式

當使用者要求「做一個含自製工具的 `.ggb` 檔」時觸發，依 `SKILL.md` 的流程撰寫 XML 並打包為 `.ggb`。
