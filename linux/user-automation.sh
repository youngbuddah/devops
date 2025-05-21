#!/bin/bash

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
   echo "❌ This script must be run as root. Use: sudo -i and then run this script."
   exit 1
fi

# Prompt for group name
read -p "Enter the group name: " group_name

# Create the group
groupadd "$group_name"
echo "✅ Group '$group_name' created successfully!"

# Prompt for number of users
read -p "Enter the number of users you want to create: " user_count

# Loop to create users
for ((i = 1; i <= user_count; i++)); do
    read -p "Enter username for user $i: " username
    read -s -p "Enter password for $username: " password
    echo
    read -s -p "Confirm password for $username: " password_confirm
    echo

    # Check if passwords match
    if [[ "$password" != "$password_confirm" ]]; then
        echo "❌ Passwords do not match. Please try again."
        ((i--))  # Retry for the same user
        continue
    fi

    # Create the user
    adduser --gecos "" --disabled-password "$username"

    # Set password
    echo "$username:$password" | chpasswd

    # Assign user to the group
    usermod -aG "$group_name" "$username"

    echo "✅ User '$username' created and added to group '$group_name'."
done

echo "🎉 All users created and assigned to '$group_name' successfully!"

# use sh <filename> to execute this file