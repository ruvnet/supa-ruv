#!/bin/bash

# Function to install Supabase CLI
install_supabase_cli() {
  echo "Installing Supabase CLI..."
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    brew install supabase/tap/supabase
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    brew install supabase/tap/supabase
  elif [[ "$OSTYPE" == "msys" ]]; then
    scoop bucket add supabase https://github.com/supabase/scoop-bucket.git
    scoop install supabase
  else
    echo "Unsupported OS. Please install Supabase CLI manually."
  fi
  echo "Supabase CLI installed successfully."
}

# Function to check if SUPABASE_KEY environment variable is set
check_supabase_key() {
  if [[ -z "${SUPABASE_KEY}" ]]; then
    echo "SUPABASE_KEY environment variable is not set."
    read -p "Enter your Supabase key (or press Enter to skip): " SUPABASE_KEY
    if [[ -n "$SUPABASE_KEY" ]]; then
      export SUPABASE_KEY
      echo "SUPABASE_KEY has been set for this session."
    else
      echo "Skipping setting SUPABASE_KEY."
    fi
  else
    echo "SUPABASE_KEY is already set."
  fi
}

# Function to display instructions for setting SUPABASE_KEY manually
manual_instructions() {
  echo "To set the SUPABASE_KEY environment variable manually, follow these steps:"
  echo "1. Open your terminal."
  echo "2. Run the following command:"
  echo "   export SUPABASE_KEY=your_supabase_key"
  echo "3. To make this change permanent, add the above line to your shell's configuration file (e.g., ~/.bashrc, ~/.zshrc)."
}

# Function to display the main menu
main_menu() {
  PS3='Please enter your choice: '
  options=("Local Setup" "Configuration & Settings" "Database Management" "Edge Functions" "CI/CD" "Advanced User Options" "Exit")
  select opt in "${options[@]}"
  do
    case $opt in
      "Local Setup")
        local_setup_menu
        ;;
      "Configuration & Settings")
        config_settings_menu
        ;;
      "Database Management")
        database_management_menu
        ;;
      "Edge Functions")
        edge_functions_menu
        ;;
      "CI/CD")
        cicd_menu
        ;;
      "Advanced User Options")
        advanced_user_menu
        ;;
      "Exit")
        break
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for Local Setup menu
local_setup_menu() {
  PS3='Please enter your choice: '
  options=("Initialize Project" "Start Supabase" "Stop Supabase" "Enable Local Logging" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Initialize Project")
        supabase init
        ;;
      "Start Supabase")
        supabase start
        ;;
      "Stop Supabase")
        supabase stop
        ;;
      "Enable Local Logging")
        echo "[analytics]" >> supabase/config.toml
        echo "enabled = true" >> supabase/config.toml
        echo "Local logging enabled."
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for Configuration & Settings menu
config_settings_menu() {
  PS3='Please enter your choice: '
  options=("View Config" "Edit Config" "Manage Secrets" "Manage Auth" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "View Config")
        cat supabase/config.toml
        ;;
      "Edit Config")
        nano supabase/config.toml
        ;;
      "Manage Secrets")
        manage_secrets_menu
        ;;
      "Manage Auth")
        echo "Enter provider (e.g., github):"
        read provider
        echo "[auth.external.$provider]" >> supabase/config.toml
        echo "enabled = true" >> supabase/config.toml
        echo "client_id = \"env(YOUR_CLIENT_ID)\"" >> supabase/config.toml
        echo "client_secret = \"env(YOUR_CLIENT_SECRET)\"" >> supabase/config.toml
        echo "Auth provider $provider enabled."
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for managing secrets
manage_secrets_menu() {
  PS3='Please enter your choice: '
  options=("Add Secret" "View Secrets" "Back to Config Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Add Secret")
        echo "Enter secret key:"
        read key
        echo "Enter secret value:"
        read value
        echo "$key = \"$value\"" >> supabase/config.toml
        ;;
      "View Secrets")
        grep -i "secret" supabase/config.toml
        ;;
      "Back to Config Menu")
        config_settings_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for Database Management menu
database_management_menu() {
  PS3='Please enter your choice: '
  options=("Run Migration" "Push Schema" "Generate Types" "Execute SQL" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Run Migration")
        supabase migration
        ;;
      "Push Schema")
        supabase db push
        ;;
      "Generate Types")
        supabase gen types
        ;;
      "Execute SQL")
        echo "Enter SQL query:"
        read sql_query
        supabase db query "$sql_query"
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for Edge Functions menu
edge_functions_menu() {
  PS3='Please enter your choice: '
  options=("Create Edge Function" "Deploy Edge Function" "Serve Edge Function" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Create Edge Function")
        echo "Enter function name:"
        read function_name
        supabase functions new $function_name
        ;;
      "Deploy Edge Function")
        echo "Enter function name:"
        read function_name
        supabase functions deploy $function_name
        ;;
      "Serve Edge Function")
        supabase functions serve
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for CI/CD menu
cicd_menu() {
  PS3='Please enter your choice: '
  options=("Setup CI/CD" "Run CI/CD Pipeline" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Setup CI/CD")
        echo "Setting up CI/CD..."
        # Add CI/CD setup commands here
        ;;
      "Run CI/CD Pipeline")
        echo "Running CI/CD pipeline..."
        # Add CI/CD run commands here
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Function for Advanced User Options menu
advanced_user_menu() {
  PS3='Please enter your choice: '
  options=("Deploy Serverless Edge Functions" "Optimize/Create SQL" "Execute SQL Functions" "Manage Projects" "Manage Organizations" "Migrate to Production" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Deploy Serverless Edge Functions")
        echo "Enter function name:"
        read function_name
        supabase functions deploy $function_name
        ;;
      "Optimize/Create SQL")
        echo "Enter SQL query:"
        read sql_query
        supabase db query "$sql_query"
        ;;
      "Execute SQL Functions")
        echo "Enter SQL function:"
        read sql_function
        supabase db query "SELECT $sql_function();"
        ;;
      "Manage Projects")
        supabase projects
        ;;
      "Manage Organizations")
        supabase orgs list
        ;;
      "Migrate to Production")
        supabase db push
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        echo "Invalid option $REPLY"
        ;;
    esac
  done
}

# Main script execution
install_supabase_cli
check_supabase_key
manual_instructions
main_menu
