---
name: ggb-create-macro
description: Create GeoGebra .ggb files that contain Custom Tools / Macros by writing GeoGebra XML directly, without launching the GeoGebra app. Use this skill when the user asks to build a GeoGebra custom tool, macro, self-made tool, custom command, .ggb file with a tool, or XML-based GeoGebra construction, including Chinese requests such as「GeoGebra 自製工具」、「自製指令」、「直接產生 .ggb 檔」、「寫 XML 做 GeoGebra 工具」.
---

# GeoGebra XML Macro Builder

Use this skill to create a GeoGebra `.ggb` file containing one or more Custom Tools / Macros by writing XML and packaging the required files directly. Do not rely on launching or automating the GeoGebra desktop app unless the user explicitly asks for that.

## Core File Structure

A `.ggb` file is a ZIP archive. A macro-enabled file should contain:

```text
myfile.ggb
├── geogebra.xml
├── geogebra_macro.xml
├── geogebra_defaults2d.xml
├── geogebra_defaults3d.xml
└── geogebra_javascript.js
```

Important rules verified from real GeoGebra files:

- Custom Tool definitions live in `geogebra_macro.xml`, not inside a `macros` block in `geogebra.xml`.
- `geogebra_macro.xml` uses the `ggt.xsd` schema.
- `geogebra.xml` uses the `ggb.xsd` schema and calls Custom Tools with `<command name="ToolCmdName">`.
- `macroInput` and `macroOutput` use attributes such as `a0="A" a1="B"`, not child elements.
- In multi-tool files, place lower-level macros before higher-level macros that call them.

## Workflow

1. Clarify the intended tools.
   - Confirm how many Custom Tools are needed.
   - For each tool, identify command name, display name, input objects, output objects, and construction logic.
   - If tools depend on each other, build the dependency order from lowest-level tool to highest-level tool.

2. Decide whether the main canvas needs examples.
   - Ask or infer whether to include demonstration objects in `geogebra.xml`.
   - Free demonstration points may use fixed coordinates; derived objects should be produced by GeoGebra commands.

3. Read only the references needed for the construction.
   - `references/xml-schema.md`: full XML structure and complete examples.
   - `references/element-types.md`: supported element types and common attributes.
   - `references/commands-in-macro.md`: GeoGebra command XML patterns, including macro nesting.

4. Generate the files.
   - Write `geogebra_macro.xml` for all Custom Tool definitions.
   - Write `geogebra.xml` for the main canvas and optional demonstration calls.
   - Include minimal defaults and JavaScript files, even when empty.

5. Validate and package.
   - Run `xmllint --noout` on `geogebra_macro.xml` and `geogebra.xml` when available.
   - Package all five required files into a `.ggb` ZIP archive.
   - Use `scripts/build_ggb.sh` as a portable template if helpful.

6. Deliver the result.
   - Provide the path to the generated `.ggb` file.
   - Summarize each tool's purpose, inputs, outputs, and dependency order.
   - Explain how to use the highest-level tool in GeoGebra.

## XML Requirements

### `geogebra_macro.xml`

- Root schema:
  `xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggt.xsd"`
- Put all `<macro>` elements under the root `<geogebra>` element.
- Use attribute-form inputs and outputs:
  `<macroInput a0="A" a1="B"/>`
  `<macroOutput a0="cOut"/>`
- Inside each macro construction, declare objects with the GeoGebra command sequence needed to compute outputs.
- When a higher-level macro calls a lower-level macro in an expression, use bracket syntax such as `LowLevelTool[arg1, arg2]`.

### `geogebra.xml`

- Root schema:
  `xsi:noNamespaceSchemaLocation="https://www.geogebra.org/apps/xsd/ggb.xsd"`
- Do not add a `macros` block.
- Call a Custom Tool directly in the construction:

```xml
<command name="MyTool">
  <input a0="P1" a1="P2"/>
  <output a0="result"/>
</command>
```

## Naming Rules

- Points: uppercase or point-like names, for example `A`, `B`, `P1`, `Qout`.
- Vectors: lowercase or vector-like names, for example `v`, `u1`.
- Numbers: lowercase numeric names, for example `r`, `n1`.
- Avoid reserved or fragile labels such as `π`, `ℯ`, and `ί`.
- Prefer simple ASCII object labels inside macros. Avoid subscript labels such as `A_{1}` in `macroInput` and `macroOutput`.

## Do Not Do These

- Do not put macro definitions inside `geogebra.xml`.
- Do not use `ggb.xsd` for `geogebra_macro.xml`.
- Do not use child elements for `macroInput` or `macroOutput`.
- Do not hard-code coordinates for derived objects; use GeoGebra commands.
- Do not compute geometry externally and paste numeric results when GeoGebra can compute them.

## Reference Index

- `references/xml-schema.md`: complete XML tags, structure, and examples.
- `references/element-types.md`: element types and common attributes.
- `references/commands-in-macro.md`: command XML patterns for common constructions.
- `scripts/build_ggb.sh`: portable packaging template.
