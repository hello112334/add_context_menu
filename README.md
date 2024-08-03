# Add Context Menu Entry

This batch script adds a context menu entry to open files, folders, and directory backgrounds with a specified executable. The context menu entry is created in the Windows Registry and includes a custom icon.

## Prerequisites

- Windows operating system.
- Administrative privileges to modify the Windows Registry.

## Usage

### Opening Command Prompt with Administrative Privileges

1. Click on the **Start** menu.
2. Type `cmd` or `Command Prompt` in the search bar.
3. Right-click on **Command Prompt** from the search results.
4. Select **Run as administrator**.

### Running the Batch Script

Run the batch script with the following parameters:

```batch
add_context_menu.bat "MenuName" "PathToExecutable" "PathToIcon"
```
