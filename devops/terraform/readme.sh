#!/bin/bash

# Define the directories for the READMEs
SUBMODULES_README_DIR="./terraform/modules"
MAINMODULES_README_DIR="./terraform"

# Define the README file paths
SUBMODULES_README_FILE="${SUBMODULES_README_DIR}/README.md"
MAINMODULES_README_FILE="${MAINMODULES_README_DIR}/README.md"

# Function to generate a markdown version of tree output
generate_tree_markdown() {
    local directory=$1
    local readme_file=$2

    echo -e "\n## Project Directory Structure\n" >> "$readme_file"
    echo '```' >> "$readme_file"
    (cd "$directory" && tree -I '.terraform|README.md|*.sh' --noreport) >> "$readme_file"
    echo '```' >> "$readme_file"
}

# Check if the modules directory exists before proceeding
if [ -d "$SUBMODULES_README_DIR" ]; then
    # Create a README for Submodules
    echo "# Submodules Documentation" > "$SUBMODULES_README_FILE"
    echo -e "\n## Table of Contents\n" >> "$SUBMODULES_README_FILE"

    # Generate Table of Contents for submodules
    find "$SUBMODULES_README_DIR" -mindepth 1 -maxdepth 2 -type d ! -path "*/.terraform*" | while read -r dir; do
      module_name=$(basename "${dir}")
      echo "- [${module_name}](#${module_name})" >> "$SUBMODULES_README_FILE"
    done

    # Generate documentation for submodules
    find "$SUBMODULES_README_DIR" -mindepth 1 -maxdepth 2 -type d ! -path "*/.terraform*" | while read -r dir; do
      module_name=$(basename "${dir}")
      echo -e "\n\n## ${module_name}" >> "$SUBMODULES_README_FILE"
      echo -e "\n---\n" >> "$SUBMODULES_README_FILE"
      terraform-docs markdown table "${dir}" >> "$SUBMODULES_README_FILE"
    done
else
    echo "Modules directory not found: $SUBMODULES_README_DIR"
fi

# Create a README for Main Modules
echo "# Main Terraform Modules Documentation" > "$MAINMODULES_README_FILE"

# Add the markdown tree command output
generate_tree_markdown "$MAINMODULES_README_DIR" "$MAINMODULES_README_FILE"

# Continue with the Table of Contents and module documentation
echo -e "\n## Table of Contents\n" >> "$MAINMODULES_README_FILE"

# Generate Table of Contents for main modules
find "$MAINMODULES_README_DIR" -mindepth 1 -maxdepth 2 -type d ! -path "*/modules*" ! -path "*/.terraform*" | while read -r dir; do
  module_name=$(basename "${dir}")
  echo "- [${module_name}](#${module_name})" >> "$MAINMODULES_README_FILE"
done

# Generate documentation for main modules
find "$MAINMODULES_README_DIR" -mindepth 1 -maxdepth 2 -type d ! -path "*/modules*" ! -path "*/.terraform*" | while read -r dir; do
  module_name=$(basename "${dir}")
  echo -e "\n\n## ${module_name}" >> "$MAINMODULES_README_FILE"
  echo -e "\n---\n" >> "$MAINMODULES_README_FILE"
  terraform-docs markdown table "${dir}" >> "$MAINMODULES_README_FILE"
done
