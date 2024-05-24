# Supabase CLI Management Script

```
                                 
 _____             _____         
|   __|_ _ ___ ___| __  |_ _ _ _ 
|__   | | | . | .'|    -| | | | |
|_____|___|  _|__,|__|__|___|\_/ 
          |_|                    
        
🦄 created by rUv + bots         

Please enter your choice: 
1) Local Setup
2) Configuration & Settings
3) Database Management
4) Edge Functions
5) CI/CD
6) Advanced User Options
7) Exit
                                 
```

## Overview

This script is designed to manage the installation and configuration of the Supabase CLI, as well as provide various options for local, remote, and hybrid deployments. It includes functionalities for checking and setting environment variables, managing secrets, and more.

## Features

- **ASCII Art Display**: Displays a custom ASCII art at the beginning of the script.
- **Homebrew Installation Check**: Checks if Homebrew is installed and prompts for installation if not.
- **Supabase CLI Installation Check**: Checks if the Supabase CLI is installed and prompts for installation if not.
- **Environment Variable Management**: Checks and sets necessary environment variables.
- **Deployment Options**: Provides options for local, remote, and hybrid deployments.
- **Main Menu**: Offers a comprehensive menu for various functionalities including local setup, configuration, database management, edge functions, CI/CD, and advanced user options.

## Usage

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Make the Script Executable**:
   ```bash
   chmod +x sb-cli.sh
   ```

3. **Run the Script**:
   ```bash
   ./sb-cli.sh
   ```

## Menu Options

### Local Setup

- **Initialize Project**: Initializes a new Supabase project.
- **Start Supabase**: Starts the Supabase services locally.
- **Stop Supabase**: Stops the Supabase services.
- **Enable Local Logging**: Enables local logging for the project.

### Configuration & Settings

- **View Config**: Displays the current configuration.
- **Edit Config**: Opens the configuration file for editing.
- **Manage Secrets**: Adds or views secrets in the configuration.
- **Manage Auth**: Configures authentication providers.

### Database Management

- **Run Migration**: Runs database migrations.
- **Push Schema**: Pushes the database schema to the remote.
- **Generate Types**: Generates types from the database schema.
- **Execute SQL**: Executes SQL queries.

### Edge Functions

- **Create Edge Function**: Creates a new edge function.
- **Deploy Edge Function**: Deploys an edge function.
- **Serve Edge Function**: Serves edge functions locally.

### CI/CD

- **Setup CI/CD**: Sets up CI/CD pipelines.
- **Run CI/CD Pipeline**: Runs the CI/CD pipeline.

### Advanced User Options

- **Deploy Serverless Edge Functions**: Deploys serverless edge functions.
- **Optimize/Create SQL**: Optimizes or creates SQL queries.
- **Execute SQL Functions**: Executes SQL functions.
- **Manage Projects**: Manages Supabase projects.
- **Manage Organizations**: Manages Supabase organizations.
- **Migrate to Production**: Migrates the setup to production.

## Environment Variables

The script checks and sets the following environment variables:

- `SUPABASE_API_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `SUPABASE_JWT_SECRET`

### Setting Environment Variables Manually

To set the environment variables manually, follow these steps:

1. Open your terminal.
2. Run the following commands:
   ```bash
   export SUPABASE_API_KEY=your_supabase_api_key
   export SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
   export SUPABASE_JWT_SECRET=your_supabase_jwt_secret
   ```
3. To make these changes permanent, add the above lines to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`).

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License.
