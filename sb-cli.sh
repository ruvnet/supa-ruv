#!/bin/bash

# Function to display ASCII Art
display_ascii_art() {
  echo "                                 "
  echo " _____             _____         "
  echo "|   __|_ _ ___ ___| __  |_ _ _ _ "
  echo "|__   | | | . | .'|    -| | | | |"
  echo "|_____|___|  _|__,|__|__|___|\_/ "
  echo "          |_|                    "
  echo "        created by rUv           "
  echo "                                 "
}

# Function to check if Homebrew is installed
is_homebrew_installed() {
  if command -v brew &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Function to install Homebrew
install_homebrew() {
  printf "🚀 Installing Homebrew...\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  printf "✅ Homebrew installed successfully.\n\n"
}

# Function to add Homebrew to PATH
add_homebrew_to_path() {
  printf "🔧 Adding Homebrew to PATH...\n"
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
  printf "✅ Homebrew added to PATH.\n\n"
}

# Function to check if Supabase CLI is installed
is_supabase_cli_installed() {
  if command -v supabase &> /dev/null; then
    return 0
  else
    return 1
  fi
}

# Function to install Supabase CLI
install_supabase_cli() {
  printf "🚀 Installing Supabase CLI...\n"
  brew install supabase/tap/supabase
  printf "✅ Supabase CLI installed successfully.\n\n"
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
        supabase init
        supabase start
        break
        ;;
      "Remote Deployment")
        printf "☁️ Remote Deployment: Develop and deploy your project directly on the Supabase Platform.\n"
        printf "Advantages:\n"
        printf "  - No local setup required\n"
        printf "  - Access to Supabase's managed services\n"
        printf "  - Scalable infrastructure\n\n"
        supabase login
        supabase link --project-ref your-project-id
        break
        ;;
      "Hybrid Deployment")
        printf "🔄 Hybrid Deployment: Combine local development with remote deployment for the best of both worlds.\n"
        printf "Advantages:\n"
        printf "  - Develop locally and deploy remotely\n"
        printf "  - Capture all changes in code\n"
        printf "  - Work offline and sync with remote\n\n"
        supabase init
        supabase start
        supabase login
        supabase link --project-ref your-project-id
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
        printf "❌ Invalid option $REPLY\n\n"
        ;;
    esac
  done
}

# Main script execution
display_ascii_art

# Check if Homebrew is installed
if is_homebrew_installed; then
  printf "✅ Homebrew is already installed.\n\n"
else
  printf "⚠️  Homebrew is not installed.\n"
  read -p "Would you like to install Homebrew? (y/n): " install_homebrew
  if [[ "$install_homebrew" == "y" ]]; then
    install_homebrew
    add_homebrew_to_path
  else
    printf "⏭️  Skipping Homebrew installation.\n\n"
    main_menu
  fi
fi

# Check if Supabase CLI is installed
if is_supabase_cli_installed; then
  printf "✅ Supabase CLI is already installed.\n\n"
else
  printf "⚠️  Supabase CLI is not installed.\n"
  read -p "Would you like to install the Supabase CLI? (y/n): " install_cli
  if [[ "$install_cli" == "y" ]]; then
    install_supabase_cli
    deployment_options
  else
    printf "⏭️  Skipping Supabase CLI installation.\n\n"
    main_menu
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