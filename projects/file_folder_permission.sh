#!/bin/bash

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use: sudo -i and then run this script."
   exit 1
fi

echo "Secure File & Folder Permission Manager"

# Get file/directory path
read -p "Enter the file or directory path: " target_path

# Check if path exists
if [[ ! -e "$target_path" ]]; then
    echo "Error: File or directory does not exist."
    exit 1
fi

# Get permission choice
echo "Select permission level:"
echo "1) Read-only (644 for files, 755 for directories)"
echo "2) Full access for owner, no access for others (700)"
echo "3) Custom permission"
read -p "Enter choice (1/2/3): " perm_choice

case $perm_choice in
    1)  
        if [[ -d "$target_path" ]]; then
            chmod 755 "$target_path"
        else
            chmod 644 "$target_path"
        fi
        echo "Permissions updated to secure defaults."
        ;;
    2)
        chmod 700 "$target_path"
        echo "Owner-only access set."
        ;;
    3)
        read -p "Enter custom permission (e.g., 750): " custom_perm
        chmod "$custom_perm" "$target_path"
        echo "Custom permission applied: $custom_perm"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Ownership Management
read -p "Enter username to set as owner: " owner
read -p "Enter group to set as owner group: " group

chown "$owner":"$group" "$target_path"
echo "Ownership set to $owner:$group"

# Save permission report
ls -l "$target_path" > permissions_report.txt
echo "Report saved to permissions_report.txt"

echo "Secure File & Folder Management Complete!"
