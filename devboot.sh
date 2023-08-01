#!/usr/bin/zsh

# This script is used to boot a dev environment from a template.
# Currently available templates
declare -a templates=("TypeScript" "JavaScript")

function tsconfig() {
  cp ~/Templates/tsconfig.json ./
  cp ~/Templates/gitignore ./.gitignore
  cp ~/Templates/prettierrc.json ./.prettierrc
  cp ~/Templates/eslintrc.js ./.eslintrc.js
  cp ~/Templates/eslintignore ./.eslintignore
  cp ~/Templates/prettierignore ./.prettierignore
}

function jsconfig() {
  cp ~/Templates/gitignore ./.gitignore
  cp ~/Templates/prettierrc.json ./.prettierrc
  cp ~/Templates/eslintrc_js.js ./.eslintrc.js
  cp ~/Templates/eslintignore ./.eslintignore
  cp ~/Templates/prettierignore ./.prettierignore
}

# Parse arguments
while getopts ":n:" opt; do
  case $opt in
    n) name="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

# Ask for name if not provided
if [ -z "$name" ]; then
  echo "Enter a name for the project: "
  read name
fi

mkdir $name && cd $name

echo "Select a template: \n"

# Print available templates
select template in "${templates[@]}"; do
  case $template in
    "TypeScript")
      echo "Booting-up a new TypeScript project...\n"
      break
      ;;
    "JavaScript")
      echo "Booting-up a new JavaScript project...\n"
      break
      ;;
    *) echo "invalid option $REPLY";;
  esac
done

echo "Creating a new $template project: $name\n"

case $template in 
"TypeScript")
  tsconfig
  mkdir src && touch ./src/index.ts
  yarn init -y && \
    yarn add -D typescript ts-node @types/node prettier eslint eslint-config-prettier eslint-plugin-prettier @typescript-eslint/eslint-plugin @typescript-eslint/parser
  ;;
"JavaScript")
  jsconfig
  mkdir src && touch ./src/index.js
  yarn init -y && \
    yarn add -D prettier eslint eslint-config-prettier eslint-plugin-prettier  
  ;;
esac

cd $name
echo "Your new project is ready!: $name\n"

