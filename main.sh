#!/bin/bash

# Function to load colors
load_colors() {
    source ~/.my_shell_colors
}

# Load colors initially
load_colors

# Check if a project name was provided
if [ "$#" -ne 1 ]; then
    echo -e "${BRED}Usage: $0 <project_name>${Color_Off}"
    exit 1
fi

PROJECT_NAME=$1
PROJECT_PATH="$HOME/Documents/Projects/$PROJECT_NAME"

echo -e "Setting up new Python project: ${BPURPLE}$PROJECT_NAME${Color_Off}"

# Create the project directory
echo -e "Creating directory at ${BBABY_BLUE}$PROJECT_PATH${Color_Off} ..."
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH" || exit

# Create main.py
echo "def main():
    print('Hello, $PROJECT_NAME!')

if __name__ == '__main__':
    main()" > main.py

# Create a virtual environment
echo -e "Setting up new ${BPURPLE}venv${Color_Off} ..."
python3 -m venv venv

# Create requirements.txt with pytest
echo "pytest" > requirements.txt

# Create .gitignore
echo "venv/
__pycache__/
*.pyc
.DS_Store
.pytest_cache/" > .gitignore

# Create README.md
echo "# $PROJECT_NAME
This project was created using the new_python_project script.

## Setup
1. Activate the virtual environment:
\`\`\`
venv
\`\`\`
2. Install dependencies:
\`\`\`
pip install -r requirements.txt
\`\`\`
3. Run the main script:
\`\`\`
python main.py
\`\`\`
4. Run tests:
\`\`\`
pytest
\`\`\`" > README.md

# Create tests directory and a basic test file
echo -e "Creating ${BGREEN}tests${Color_Off} ..."
mkdir tests
echo "def test_sample():
    assert True  # Replace with actual tests for your project

def test_main():
    # This is a placeholder test. Replace with actual tests for your main function.
    assert True  # This test will always pass" > tests/test_main.py

# Initialize git repository
echo -e "Initializing ${BGREEN}git${Color_Off} ..."
git init

# Create GitHub repository
echo -e "Creating GitHub repository..."
gh repo create "$PROJECT_NAME" --private --source=. --remote=origin

# Add all files
git add .

# Commit changes
git commit -m "Initial commit"

# Push to GitHub
echo -e "Pushing to GitHub..."
git push -u origin main

echo -e "Initialization complete. '${BPURPLE}$PROJECT_NAME${Color_Off}' has been set up in ${BYELLOW}$PROJECT_PATH${Color_Off} and linked to GitHub."

