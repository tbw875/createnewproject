#!/bin/bash

# Function to load colors
load_colors() {
    source ~/.my_shell_colors
}

# Load colors initially
load_colors

# Default values
VISIBILITY="private"
CREATE_VENV=true
TEMPLATE="basic"

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --public) VISIBILITY="public" ;;
        --no-venv) CREATE_VENV=false ;;
        --template) TEMPLATE="$2"; shift ;;
        *) PROJECT_NAME="$1" ;;
    esac
    shift
done

# Check if a project name was provided
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${BRED}Usage: $0 <project_name> [--public] [--no-venv] [--template <template-name>]${Color_Off}"
    echo -e "Available templates: basic, flask, jupyter, fastapi, cli, nodejs, bun, rust, go, nextjs, vite, svelte, react, vue, express"
    exit 1
fi

PROJECT_PATH="$HOME/Documents/Projects/$PROJECT_NAME"

echo -e "Setting up new project: ${BPURPLE}$PROJECT_NAME${Color_Off}"
echo -e "Template: ${BGREEN}$TEMPLATE${Color_Off}"
echo -e "Visibility: ${BGREEN}$VISIBILITY${Color_Off}"

# Create the project directory
echo -e "Creating directory at ${BBABY_BLUE}$PROJECT_PATH${Color_Off} ..."
mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH" || exit

# Create project files based on template
case $TEMPLATE in
    "basic")
        echo "def main():
    print('Hello, $PROJECT_NAME!')

if __name__ == '__main__':
    main()" > main.py
        echo "pytest" > requirements.txt
        ;;
    "flask")
        echo "from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def hello():
    return render_template('index.html', project_name='$PROJECT_NAME')

if __name__ == '__main__':
    app.run(debug=True)" > app.py
        mkdir templates
        echo "<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>{{ project_name }}</title>
</head>
<body>
    <h1>Welcome to {{ project_name }}!</h1>
</body>
</html>" > templates/index.html
        echo "Flask==2.0.1
pytest" > requirements.txt
        ;;
    "jupyter")
        echo "{
 \"cells\": [
  {
   \"cell_type\": \"markdown\",
   \"metadata\": {},
   \"source\": [
    \"# $PROJECT_NAME\\n\",
    \"\\n\",
    \"This is a Jupyter notebook for the $PROJECT_NAME project.\"
   ]
  },
  {
   \"cell_type\": \"code\",
   \"execution_count\": null,
   \"metadata\": {},
   \"outputs\": [],
   \"source\": [
    \"import pandas as pd\\n\",
    \"import matplotlib.pyplot as plt\\n\",
    \"\\n\",
    \"# Your code here\"
   ]
  }
 ],
 \"metadata\": {
  \"kernelspec\": {
   \"display_name\": \"Python 3\",
   \"language\": \"python\",
   \"name\": \"python3\"
  },
  \"language_info\": {
   \"codemirror_mode\": {
    \"name\": \"ipython\",
    \"version\": 3
   },
   \"file_extension\": \".py\",
   \"mimetype\": \"text/x-python\",
   \"name\": \"python\",
   \"nbconvert_exporter\": \"python\",
   \"pygments_lexer\": \"ipython3\",
   \"version\": \"3.8.5\"
  }
 },
 \"nbformat\": 4,
 \"nbformat_minor\": 4
}" > notebook.ipynb
        echo "jupyter
pandas
matplotlib
pytest" > requirements.txt
        ;;
    "fastapi")
        echo "from fastapi import FastAPI

app = FastAPI()

@app.get(\"/\")
async def root():
    return {\"message\": \"Welcome to $PROJECT_NAME!\"}

if __name__ == \"__main__\":
    import uvicorn
    uvicorn.run(app, host=\"0.0.0.0\", port=8000)" > main.py
        echo "fastapi
uvicorn
pytest" > requirements.txt
        ;;
    "cli")
        echo "import click

@click.command()
@click.option('--name', prompt='Your name',
              help='The person to greet.')
def hello(name):
    \"\"\"Simple program that greets NAME for a total of COUNT times.\"\"\"
    click.echo(f'Hello, {name}!')

if __name__ == '__main__':
    hello()" > cli.py
        echo "click
pytest" > requirements.txt
        ;;
    "nodejs")
        echo -e "Initializing Node.js project..."
        npm init -y
        echo "console.log('Hello, $PROJECT_NAME!');" > index.js
        # Update package.json to add start script and set main to index.js
        node -e "
        const pkg = require('./package.json');
        pkg.name = '$PROJECT_NAME';
        pkg.main = 'index.js';
        pkg.scripts = { ...pkg.scripts, start: 'node index.js', dev: 'node index.js' };
        require('fs').writeFileSync('package.json', JSON.stringify(pkg, null, 2));
        "
        ;;
    "bun")
        echo -e "Initializing Bun project..."
        bun init -y
        echo "console.log('Hello, $PROJECT_NAME!');" > index.ts
        ;;
    "rust")
        echo -e "Initializing Rust project..."
        cargo init --name "$PROJECT_NAME" .
        ;;
    "go")
        echo -e "Initializing Go project..."
        go mod init "$PROJECT_NAME"
        echo "package main

import \"fmt\"

func main() {
    fmt.Println(\"Hello, $PROJECT_NAME!\")
}" > main.go
        ;;
    "nextjs")
        echo -e "Initializing Next.js project..."
        npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
        ;;
    "vite")
        echo -e "Initializing Vite project..."
        npm create vite@latest . -- --template vanilla-ts
        npm install
        ;;
    "svelte")
        echo -e "Initializing Svelte project..."
        npm create svelte@latest .
        npm install
        ;;
    "react")
        echo -e "Initializing React project..."
        npx create-react-app . --template typescript
        ;;
    "vue")
        echo -e "Initializing Vue project..."
        npm create vue@latest .
        npm install
        ;;
    "express")
        echo -e "Initializing Express project..."
        npm init -y
        npm install express
        npm install --save-dev @types/express typescript ts-node nodemon
        echo "import express from 'express';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());

app.get('/', (req, res) => {
    res.json({ message: 'Hello from $PROJECT_NAME!' });
});

app.listen(PORT, () => {
    console.log(\`Server running on port \${PORT}\`);
});" > index.ts
        echo "{
  \"compilerOptions\": {
    \"target\": \"ES2020\",
    \"module\": \"commonjs\",
    \"strict\": true,
    \"esModuleInterop\": true,
    \"skipLibCheck\": true,
    \"forceConsistentCasingInFileNames\": true,
    \"outDir\": \"./dist\",
    \"rootDir\": \"./\"
  },
  \"include\": [\"**/*\"],
  \"exclude\": [\"node_modules\", \"dist\"]
}" > tsconfig.json
        # Update package.json to add scripts
        node -e "
        const pkg = require('./package.json');
        pkg.name = '$PROJECT_NAME';
        pkg.main = 'dist/index.js';
        pkg.scripts = {
            ...pkg.scripts,
            start: 'node dist/index.js',
            dev: 'nodemon --exec ts-node index.ts',
            build: 'tsc'
        };
        require('fs').writeFileSync('package.json', JSON.stringify(pkg, null, 2));
        "
        ;;
    *)
        echo -e "${BRED}Unknown template: $TEMPLATE. Using basic template.${Color_Off}"
        echo "def main():
    print('Hello, $PROJECT_NAME!')

if __name__ == '__main__':
    main()" > main.py
        echo "pytest" > requirements.txt
        ;;
esac

# Create a virtual environment (Python projects only)
if $CREATE_VENV && [[ "$TEMPLATE" =~ ^(basic|flask|jupyter|fastapi|cli)$ ]]; then
    echo -e "Setting up new ${BPURPLE}venv${Color_Off} ..."
    python3 -m venv venv
fi

# Create .gitignore
echo "# Python
venv/
__pycache__/
*.pyc
.pytest_cache/
.ipynb_checkpoints/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Rust
target/
Cargo.lock

# Go
*.exe
*.exe~
*.dll
*.so
*.dylib
*.test
*.out
go.work

# General
.DS_Store
*.log
.vscode/
.idea/
*.swp
*.swo
*~
dist/
build/" > .gitignore

# Create README.md with template-specific instructions
case $TEMPLATE in
    "basic"|"flask"|"jupyter"|"fastapi"|"cli")
        echo "# $PROJECT_NAME

This project was created using the createnewproject script with the $TEMPLATE template.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

2. Set up a virtual environment:
   \`\`\`
   python3 -m venv venv
   source venv/bin/activate  # On Windows, use \`venv\Scripts\activate\`
   \`\`\`

3. Install dependencies:
   \`\`\`
   pip install -r requirements.txt
   \`\`\`

## Usage

Run the main script:
\`\`\`
python main.py
\`\`\`

## Running Tests

\`\`\`
pytest
\`\`\`" > README.md
        ;;
    "nodejs")
        echo "# $PROJECT_NAME

A Node.js project created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

2. Install dependencies:
   \`\`\`
   npm install
   \`\`\`

## Usage

\`\`\`
npm start
\`\`\`

## Development

\`\`\`
npm run dev
\`\`\`" > README.md
        ;;
    "bun")
        echo "# $PROJECT_NAME

A Bun project created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

2. Install dependencies:
   \`\`\`
   bun install
   \`\`\`

## Usage

\`\`\`
bun run index.ts
\`\`\`" > README.md
        ;;
    "rust")
        echo "# $PROJECT_NAME

A Rust project created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

## Usage

\`\`\`
cargo run
\`\`\`

## Building

\`\`\`
cargo build --release
\`\`\`" > README.md
        ;;
    "go")
        echo "# $PROJECT_NAME

A Go project created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

## Usage

\`\`\`
go run main.go
\`\`\`

## Building

\`\`\`
go build
\`\`\`" > README.md
        ;;
    "nextjs"|"vite"|"svelte"|"react"|"vue")
        echo "# $PROJECT_NAME

A $TEMPLATE project created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

2. Install dependencies:
   \`\`\`
   npm install
   \`\`\`

## Development

\`\`\`
npm run dev
\`\`\`

## Building

\`\`\`
npm run build
\`\`\`" > README.md
        ;;
    "express")
        echo "# $PROJECT_NAME

An Express.js server created with the createnewproject script.

## Installation

1. Clone the repository:
   \`\`\`
   git clone https://github.com/yourusername/$PROJECT_NAME.git
   cd $PROJECT_NAME
   \`\`\`

2. Install dependencies:
   \`\`\`
   npm install
   \`\`\`

## Development

\`\`\`
npm run dev
\`\`\`

## Building and Running

\`\`\`
npm run build
npm start
\`\`\`

The server will run on http://localhost:3000" > README.md
        ;;
esac

# Create tests directory and a basic test file (Python projects only)
if [[ "$TEMPLATE" =~ ^(basic|flask|jupyter|fastapi|cli)$ ]]; then
    echo -e "Creating ${BGREEN}tests${Color_Off} ..."
    mkdir tests
    echo "def test_sample():
    assert True  # Replace with actual tests for your project

def test_main():
    # This is a placeholder test. Replace with actual tests for your main function.
    assert True  # This test will always pass" > tests/test_main.py
fi

# Initialize git repository
echo -e "Initializing ${BGREEN}git${Color_Off} ..."
git init --initial-branch=main

# Create GitHub repository
echo -e "Creating GitHub repository..."
gh repo create "$PROJECT_NAME" --"$VISIBILITY" --source=. --remote=origin

# Add all files
git add .

# Commit changes
git commit -m "Initial commit"

# Push to GitHub
echo -e "Pushing to GitHub..."
git push -u origin main

echo -e "Initialization complete. '${BPURPLE}$PROJECT_NAME${Color_Off}' has been set up in ${BYELLOW}$PROJECT_PATH${Color_Off} and linked to GitHub."
