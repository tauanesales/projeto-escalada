#!/bin/bash

CONTAINER_NAME="projeto-escalada_postgres_1"
DB_NAME="escalada"
DB_USER="postgres"
INPUT_FILE="docs/P2/CSVs/psql_input_queries.csv"
OUTPUT_FILE="docs/P2/CSVs/psql_output_with_times.csv"

if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input CSV file '$INPUT_FILE' not found."
  exit 1
fi

HEADER=$(head -n 1 "$INPUT_FILE")
echo "$HEADER,ExecutionTime(ms)" > "$OUTPUT_FILE"

while IFS=, read -r INITIAL_QUERY REST_OF_THE_LINE || [[ -n "$INITIAL_QUERY" ]]; do
  QUERY=$(echo "$INITIAL_QUERY" | sed 's/^"//; s/"$//; s/""/"/g')

  if [[ -z "$QUERY" ]]; then
    continue
  fi

  echo "Executing query: $QUERY"

  RESULT=$(podman exec "$CONTAINER_NAME" \
    psql -U "$DB_USER" -d "$DB_NAME" \
    --no-align --tuples-only -c "EXPLAIN ANALYZE $QUERY" 2>&1)

  if echo "$RESULT" | grep -q "ERROR:"; then
    echo "Error executing query: $QUERY"
    echo "$RESULT"
    TIME="ERROR"
  else
    TIME=$(echo "$RESULT" | grep "Execution Time" | tail -n 1 | awk '{print $3}')

    if [[ -z "$TIME" ]]; then
      echo "Could not extract execution time for query: $QUERY"
      echo "Result: $RESULT"
      TIME="N/A"
    fi
  fi

  echo "$INITIAL_QUERY${REST_OF_THE_LINE:+,$REST_OF_THE_LINE},$TIME" >> "$OUTPUT_FILE"
done < <(tail -n +2 "$INPUT_FILE")

echo "Execution times appended to $OUTPUT_FILE"
