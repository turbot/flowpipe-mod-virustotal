#!/bin/bash

# Function to clean URLs from text
clean_urls() {
    local input_text="$1"
    local url_regex="http[s]?://[^\ ]*"
    local replacement_text="(**Malicious url removed by Turbot**)"

    local cleaned_text
    cleaned_text=$(echo "$input_text" | sed -E "s@$url_regex@$replacement_text@g")

    echo "$cleaned_text"
}

# Example input text
input_text="Hey. Follow this link to get an all expenses paid trip to Scamland http://clicnews.com/"

# Call the function to clean URLs
cleaned_text=$(clean_urls "$input_text")

# Print the cleaned text
echo "$cleaned_text"
