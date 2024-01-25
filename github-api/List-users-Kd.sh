#!/bin/bash

#Github api url
Git_url= "https://api.github.com"

# we are taking github username and token
USERNAME=$username
TOKEN=$token

# user and repo info and $1 and $2 are the first nd second arguments given by user
REPO_OWNER=$1
REPO_NAME=$2

# Function to get Git request to the Gitapi
function github_api_get{
	local endpoint="$1"
	local url ="${Git_url}/${endpoint}"
	
	# send git request to the Github api authentication
	curl -s -u "${USERNAME}:${TOKEN}" "$url"
	

}

# Function for listing users with read access
function list_users_with_read_access {
	local endpoint= "repos/${REPO_OWNER}/${REPO_NAME}/collaborators"
	
	
	#Fetch the list of collaborators on the repo
	collaborators="$(github_api_get "endpoint" | jq -r '.[] | select(.permissions.pull == true) | .login')"
	
	# Dsiplay the list if collaborators with read access
	if [[ -z "$collaborators'"]]; then
		echo "No users with read access found in ${REPO_OWNER}/${REPO_NAME}."
	else
		echo "users with read access to ${REPO_OWNER}/${REPO_NAME}:"
		echo "$collaborators"
	fi
	
}

function helper{
	exp_cmd_argu=2
	if [ $# -ne $exp_cmd_argu]; then
		echo " please execute the cmd with crrt arguments like Repo owner and repo file"
}


# Main Script

echo " Listing the users with read access to ${REPO_OWNER}/${REPO_NAME}..."
list_users_with_read_access
