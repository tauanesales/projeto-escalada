#!/bin/bash

CONTAINER_NAME="projeto-escalada_mongo_1"
DB_NAME="escalada"
INPUT_FILE="./docs/P2/CSVs/mdb_input_queries.csv"
OUTPUT_FILE="./docs/P2/CSVs/mdb_output_with_times.csv"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input CSV file '$INPUT_FILE' not found."
  exit 1
fi

HEADER=$(head -n 1 "$INPUT_FILE")
echo "$HEADER,ExecutionTime(s)" > "$OUTPUT_FILE"

# Debug: print the total number of lines in the input file
total_lines=$(wc -l < "$INPUT_FILE")
echo "Total lines in input file: $total_lines"

while IFS=, read -r INITIAL_QUERY REST_OF_THE_LINE || [[ -n "$INITIAL_QUERY" ]]; do
  echo "Processing line: $INITIAL_QUERY"  # Debug: print the current query being processed

  QUERY=$(echo "$INITIAL_QUERY" | sed 's/^"//; s/"$//; s/""/"/g')

  if [[ -z "$QUERY" ]]; then
    echo 'Empty query, skipping...'
    continue
  fi

  echo "Executing query: $QUERY"

  # Use the `time` command to measure execution time
  START_TIME=$(date +%s%3) # Get start time in milliseconds
  RESULT=$(podman exec -it "$CONTAINER_NAME" \
    mongosh "mongodb://root:example@localhost:27017/escalada?authSource=admin" --quiet --eval "db.getSiblingDB('$DB_NAME').${QUERY}" 2>&1)
  END_TIME=$(date +%s%3) # Get end time in milliseconds

  # Ensure we have numeric time values
  if [[ ! "$START_TIME" =~ ^[0-9]+$ ]] || [[ ! "$END_TIME" =~ ^[0-9]+$ ]]; then
    echo "Error: Non-numeric start or end time"
    echo "$RESULT"
    TIME="ERROR"
  else
    TIME=$((END_TIME - START_TIME)) # Calculate time difference
    TIME=$(echo "scale=3; ($END_TIME - $START_TIME) / 1000" | bc)

    if [[ -z "$TIME" ]]; then
      echo "Could not extract execution time for query: $QUERY"
      echo "Result: $RESULT"
      TIME="N/A"
    fi
  fi

  # Append the query and execution time to the output file
  echo "$INITIAL_QUERY${REST_OF_THE_LINE:+,$REST_OF_THE_LINE},$TIME" >> "$OUTPUT_FILE"
done < <(tail -n +2 "$INPUT_FILE")

echo "Execution times appended to $OUTPUT_FILE"
