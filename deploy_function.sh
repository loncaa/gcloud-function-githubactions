#!/bin/bash

# Set your desired values

RUNTIME="nodejs16"

PROJECT_ID=$1
FUNCTION_NAME=$2
FUNCTION_ENTRY_POINT=$3
ENV_FILE=$4
ACCEPT_ALL=$5

if [[ -z "$PROJECT_ID" ]] && [[ -z "$FUNCTION_NAME" ]] && [[ -z "$ENV_FILE" ]]; then
  # Echo message and wait for user input
  echo "Enter a project ID (Can be found in Google Cloud Platform url, ?project=<id>): "
  read PROJECT_ID
  echo "Enter a function name: "
  read FUNCTION_NAME
  echo "Enter a function entry point name (Function entry point should be found in 'index.ts' as exported const. If leaved empty, it will be same as function name.): "
  read FUNCTION_ENTRY_POINT
  echo "Enter a enviormet variables file name: "
  read ENV_FILE

  if [[ -z "$PROJECT_ID" ]]; then
    echo "Project id is empty"
    exit 1
  elif [[ -z "$FUNCTION_NAME" ]]; then
    echo "Project name is empty"
    exit 1
  elif [[ -z "$ENV_FILE" ]]; then
    echo "Project enviroment variables not defined"
    exit 1
  fi
fi

FUNCTION_ENTRY_POINT="${FUNCTION_ENTRY_POINT:-$FUNCTION_NAME}"

echo "Selected project $PROJECT_ID, function name $FUNCTION_NAME, function entry point $FUNCTION_ENTRY_POINT, env variables from $ENV_FILE"

if [ $ACCEPT_ALL != "Y" ]; then
  echo "To continue, enter 'Y':"
  read input

  # Check if the user input is 'Y' or 'y'
  if [[ $input == "Y" || $input == "y" ]]; then
    echo "Continuing with the script..."
    # Add your script logic here
  else
    echo "Invalid input. Exiting the script."
    exit 1
  fi
fi

echo "Deployment started..."

# Deploy the function
gcloud functions deploy $FUNCTION_NAME \
  --entry-point $FUNCTION_ENTRY_POINT \
  --runtime $RUNTIME \
  --project $PROJECT_ID \
  --trigger-http \
  --env-vars-file $ENV_FILE \
  --allow-unauthenticated
