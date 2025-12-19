# PlantUML Diagrams for Facade Pattern Implementation

This directory contains PlantUML diagrams that visualize the Facade Design Pattern implementation in the Network Layer.

## 📋 Diagrams Included

### 1. **facade_pattern_diagram.puml** - Class Structure Diagram
   - Shows the complete class hierarchy
   - Displays relationships between classes
   - Illustrates the Facade pattern structure
   - Shows responsibilities of each component

### 2. **facade_sequence_diagram.puml** - Request Flow Sequence
   - Shows the step-by-step flow of a request
   - Demonstrates how NetworkFacade simplifies the process
   - Highlights automatic token retrieval and header construction
   - Visualizes the interaction between components

### 3. **facade_comparison_diagram.puml** - Before vs After Comparison
   - Side-by-side comparison of old vs new implementation
   - Shows code reduction and simplification
   - Demonstrates the benefits of the Facade pattern

## 🚀 How to Use in VSCode

### Prerequisites
1. Install the **PlantUML** extension in VSCode:
   - Open VSCode Extensions (Ctrl+Shift+X)
   - Search for "PlantUML" by jebbs
   - Click Install

2. Install Java (required for PlantUML):
   - PlantUML requires Java to render diagrams
   - Download from: https://www.java.com/download/
   - Verify installation: `java -version` in terminal

3. Install Graphviz (optional, for better rendering):
   - Windows: Download from https://graphviz.org/download/
   - Or use Chocolatey: `choco install graphviz`

### Viewing the Diagrams

#### Method 1: Preview in VSCode
1. Open any `.puml` file in VSCode
2. Press `Alt+D` (or `Cmd+D` on Mac) to preview
3. Or right-click → "Preview PlantUML Diagram"

#### Method 2: Export as Image
1. Open the `.puml` file
2. Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
3. Type "PlantUML: Export Current Diagram"
4. Choose format: PNG, SVG, or PDF
5. Save to desired location

#### Method 3: Use Online Viewer (No Installation)
1. Copy the contents of any `.puml` file
2. Go to: http://www.plantuml.com/plantuml/uml/
3. Paste the code
4. View or download the diagram

## 📊 Diagram Details

### Class Structure Diagram
- **Purpose**: Shows the overall architecture
- **Key Elements**:
  - NetworkFacade (Facade class)
  - RemoteApi (Wrapped system)
  - API classes (Consumers)
  - Dependencies (SecureStorage, Headers)

### Sequence Diagram
- **Purpose**: Shows request flow
- **Key Elements**:
  - Step-by-step interaction
  - Token retrieval process
  - Header construction
  - Response handling

### Comparison Diagram
- **Purpose**: Demonstrates improvements
- **Key Elements**:
  - Before implementation (complex)
  - After implementation (simplified)
  - Code reduction metrics

## 🎨 Customization

You can customize the diagrams by editing the `.puml` files:

- **Colors**: Modify `BackgroundColor` and `BorderColor` in skinparam
- **Layout**: Adjust package positions and relationships
- **Content**: Add or remove classes, methods, or notes

## 📝 Quick Reference

### Common PlantUML Commands in VSCode

| Action | Shortcut | Description |
|--------|----------|-------------|
| Preview | `Alt+D` | Preview current diagram |
| Export PNG | `Ctrl+Shift+P` → "Export PNG" | Export as PNG image |
| Export SVG | `Ctrl+Shift+P` → "Export SVG" | Export as SVG image |
| Update Preview | `Alt+D` (when preview open) | Refresh diagram |

## 🔧 Troubleshooting

### Diagram not rendering?
1. Check Java installation: `java -version`
2. Restart VSCode after installing PlantUML extension
3. Check PlantUML output panel for errors

### Preview not showing?
1. Ensure `.puml` file is open and active
2. Try `Ctrl+Shift+P` → "PlantUML: Preview Current Diagram"
3. Check PlantUML extension is enabled

### Export failing?
1. Ensure Java is installed and in PATH
2. Check file permissions for export location
3. Try exporting to a different format

## 📚 Additional Resources

- [PlantUML Official Documentation](https://plantuml.com/)
- [PlantUML Language Reference](https://plantuml.com/guide)
- [VSCode PlantUML Extension](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml)

---

**Note**: These diagrams are automatically generated documentation of the Facade Pattern implementation. They help visualize the architecture and can be updated as the codebase evolves.

