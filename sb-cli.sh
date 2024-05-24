#!/bin/bash

# Function to display ASCII Art
display_ascii_art() {
  echo "                                 "
  echo " _____             _____         "
  echo "|   __|_ _ ___ ___| __  |_ _ _ _ "
  echo "|__   | | | . | .'|    -| | | | |"
  echo "|_____|___|  _|__,|__|__|___|\_/ "
  echo "          |_|                    "
  echo "  🦄 created by rUv + bots       "
  echo "                                 "
}

# Function to check if Node.js and npm are installed
is_node_npm_installed() {
  if command -v node &> /dev/null && command -v npm &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Function to install Node.js and npm
install_node_npm() {
  printf "🚀 Installing Node.js and npm...\n"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    brew install node
  else
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi
  printf "✅ Node.js and npm installed successfully.\n\n"
}

# Function to check if an environment variable is set
check_env_var() {
  local var_name=$1
  local var_value=$(printenv $var_name)
  if [[ -z "$var_value" ]]; then
    printf "⚠️  $var_name environment variable is not set.\n"
    read -p "Enter your $var_name (or press Enter to skip): " var_value
    if [[ -n "$var_value" ]]; then
      export $var_name=$var_value
      printf "✅ $var_name has been set for this session.\n\n"
    else
      printf "⏭️  Skipping setting $var_name.\n\n"
    fi
  else
    printf "✅ $var_name is already set.\n\n"
  fi
}

# Function to display instructions for setting environment variables manually
manual_instructions() {
  printf "📋 To set the environment variables manually, follow these steps:\n"
  printf "1. Open your terminal.\n"
  printf "2. Run the following commands:\n"
  printf "   export SUPABASE_API_KEY=your_supabase_api_key\n"
  printf "   export SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key\n"
  printf "   export SUPABASE_JWT_SECRET=your_supabase_jwt_secret\n"
  printf "3. To make these changes permanent, add the above lines to your shell's configuration file (e.g., ~/.bashrc, ~/.zshrc).\n\n"
}

# Function to display deployment options
deployment_options() {
  printf "Please choose a deployment option:\n"
  PS3='Please enter your choice: '
  options=("Local Deployment" "Remote Deployment" "Hybrid Deployment" "Back to Main Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Local Deployment")
        printf "🌐 Local Deployment: Develop and test your project locally without any network latency or internet disruptions.\n"
        printf "Advantages:\n"
        printf "  - Faster development\n"
        printf "  - Easier collaboration\n"
        printf "  - Cost-effective\n"
        printf "  - Work offline\n\n"
        npx supabase init
        npx supabase start
        break
        ;;
      "Remote Deployment")
        printf "☁️ Remote Deployment: Develop and deploy your project directly on the Supabase Platform.\n"
        printf "Advantages:\n"
        printf "  - No local setup required\n"
        printf "  - Access to Supabase's managed services\n"
        printf "  - Scalable infrastructure\n\n"
        npx supabase login
        npx supabase link --project-ref your-project-id
        break
        ;;
      "Hybrid Deployment")
        printf "🔄 Hybrid Deployment: Combine local development with remote deployment for the best of both worlds.\n"
        printf "Advantages:\n"
        printf "  - Develop locally and deploy remotely\n"
        printf "  - Capture all changes in code\n"
        printf "  - Work offline and sync with remote\n\n"
        npx supabase init
        npx supabase start
        npx supabase login
        npx supabase link --project-ref your-project-id
        break
        ;;
      "Back to Main Menu")
        main_menu
        break
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
        ;;
    esac
  done
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
        printf "👋 Exiting...\n"
        exit 0
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        npx supabase init
        ;;
      "Start Supabase")
        npx supabase start
        ;;
      "Stop Supabase")
        npx supabase stop
        ;;
      "Enable Local Logging")
        echo "[analytics]" >> supabase/config.toml
        echo "enabled = true" >> supabase/config.toml
        printf "✅ Local logging enabled.\n\n"
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        printf "✅ Auth provider $provider enabled.\n\n"
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        printf "❌ Invalid option $REPLY\n\n"
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
        npx supabase migration
        ;;
      "Push Schema")
        npx supabase db push
        ;;
      "Generate Types")
        generate_types_menu
        ;;
      "Execute SQL")
        execute_sql
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        npx supabase functions new $function_name
        ;;
      "Deploy Edge Function")
        echo "Enter function name:"
        read function_name
        npx supabase functions deploy $function_name
        ;;
      "Serve Edge Function")
        npx supabase functions serve
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        printf "🔧 Setting up CI/CD...\n"
        # Add CI/CD setup commands here
        ;;
      "Run CI/CD Pipeline")
        printf "🏃 Running CI/CD pipeline...\n"
        # Add CI/CD run commands here
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
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
        npx supabase functions deploy $function_name
        ;;
      "Optimize/Create SQL")
        echo "Enter SQL query:"
        read sql_query
        npx supabase db query "$sql_query"
        ;;
      "Execute SQL Functions")
        echo "Enter SQL function:"
        read sql_function
        npx supabase db query "SELECT $sql_function();"
        ;;
      "Manage Projects")
        npx supabase projects
        ;;
      "Manage Organizations")
        npx supabase orgs list
        ;;
      "Migrate to Production")
        npx supabase db push
        ;;
      "Back to Main Menu")
        main_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
        ;;
    esac
  done
}

# Function to guide through generating types
generate_types_menu() {
  printf "Generate types from Postgres schema\n"
  PS3='Please enter your choice: '
  options=("Generate TypeScript types" "Back to Database Management Menu")
  select opt in "${options[@]}"
  do
    case $opt in
      "Generate TypeScript types")
        npx supabase gen types typescript
        ;;
      "Back to Database Management Menu")
        database_management_menu
        ;;
      *)
        printf "❌ Invalid option $REPLY\n\n"
        ;;
    esac
  done
}

# Function to guide through executing SQL
execute_sql() {
  printf "Enter your SQL query:\n"
  read sql_query
  npx supabase db query "$sql_query"
}

# Main script execution
display_ascii_art

# Check if Node.js and npm are installed first
if is_node_npm_installed; then
  printf "✅ Node.js and npm are already installed.\n\n"
else
  printf "⚠️  Node.js and npm are not installed.\n"
  read -p "Would you like to install Node.js and npm? (y/n): " install_node_npm
  if [[ "$install_node_npm" == "y" ]]; then
    install_node_npm
  else
    printf "⏭️  Skipping Node.js and npm installation.\n\n"
    exit 1
  fi
fi

# Check environment variables
check_env_var "SUPABASE_API_KEY"
check_env_var "SUPABASE_SERVICE_ROLE_KEY"
check_env_var "SUPABASE_JWT_SECRET"

# Display manual instructions
manual_instructions

# Show the main menu
main_menu
