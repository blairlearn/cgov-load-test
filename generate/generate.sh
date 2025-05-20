#!/bin/bash

# Create results directory if it doesn't exist
mkdir -p results

# Output header
echo "path,size,md5" > 200.csv
echo "path,size,md5" > 30x.csv
echo "path,size,md5" > 404.csv

# Read the input file line by line, skip the header
tail -n +2 url-list.csv | while IFS=, read -r path rest; do
    # Form the complete URL
    url="https://www-dev-acsf.cancer.gov${path}"

    # Create a valid filename from the path
    sanitized_path=$(echo "${path}" | sed 's/^\/\+//; s/\//_/g')
    if [ -z "$sanitized_path" ]; then
        filename="results/root"
    else
        filename="results/${sanitized_path}"
    fi

    # Get the content and save it to a file
    # Capture both response code and content
    response=$(curl -s -w "%{http_code}" "$url" -o "$filename")
    http_code=$response

    # # Skip processing if not 200
    # if [ "$http_code" != "200" ]; then
    #     continue
    # fi

    case "$http_code" in

        200)
            # Get the size of the saved file
            size=$(wc -c < "$filename")

            # Calculate MD5 hash of the saved file
            md5=$(md5sum "$filename" | cut -d ' ' -f 1)

            # Output the results (with no extra whitespace)
            echo "$path,$size,$md5"  | tr -d ' ' >> 200.csv
            ;;

        30*)
            # If the response code is 30x, save to 30x.csv
            echo "$path" >> 30x.csv
            ;;

        404)
            # If the response code is 404, save to 404.csv
            echo "$path" >> 404.csv
            ;;

        *)
            # For any other response code, skip
            continue
            ;;
    esac


done
