# #!/bin/bash

# INPUT_FILE="sudoless_commands.txt"

# if [ ! -f "$INPUT_FILE" ]; then
#     echo "Input file not found: $INPUT_FILE"
#     exit 1
# fi

# USERNAME=$(whoami)

# SUDOERS_LINE="$USERNAME ALL=NOPASSWD:"

# FILE_TO_CHANGE="/etc/sudoers"

# SUDOERS_UNCHANGED=$(sudo cat "$FILE_TO_CHANGE")

# INPUT_STRING=$(<"$INPUT_FILE" tr '\n' ',' | sed 's/,$//')

# TO_ADD="$SUDOERS_LINE $INPUT_STRING"

# TEMP_FILE=$(mktemp)

# sudo sed -e "/$SUDOERS_LINE/d" "$FILE_TO_CHANGE" > "$TEMP_FILE"

# echo -e "\n$TO_ADD" >> "$TEMP_FILE"

# sudo chown root:root "$TEMP_FILE"

# cat "$TEMP_FILE"

# sudo mv "$TEMP_FILE" "$FILE_TO_CHANGE"

# rm "$TEMP_FILE"

#!/bin/bash

SUDOERS_PATH="/etc/sudoers.d"

INPUT_FILE="sudoless_commands.txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file not found: $INPUT_FILE"
    exit 1
fi

USERNAME=$(whoami)

if [ ! -f "$SUDOERS_PATH/$USERNAME.conf" ]; then
    echo "Creating sudoers file for $USERNAME"
    sudo touch "$SUDOERS_PATH/$USERNAME.conf"
    sudo chown root:root "$SUDOERS_PATH/$USERNAME.conf"
    sudo chmod 440 "$SUDOERS_PATH/$USERNAME.conf"
fi

INPUT_STRING=$(<"$INPUT_FILE" tr '\n' ',' | sed 's/,$//')

SUDOERS_LINE="$USERNAME ALL=NOPASSWD: $INPUT_STRING"

echo "$SUDOERS_LINE" | sudo tee -a "$SUDOERS_PATH/$USERNAME.conf" > /dev/null

echo "Added $INPUT_STRING to $SUDOERS_PATH/$USERNAME.conf"

exit 0
