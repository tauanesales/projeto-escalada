

# PostgreSQL details
PG_CONTAINER="projeto-escalada_postgres_1"
PG_PASSWORD="postgres"
PG_HOST="localhost"
PG_PORT="5432"
PG_USER="postgres"
PG_DB="escalada"

# MongoDB details
MONGO_CONTAINER="projeto-escalada_mongo_1"
MONGO_URI="mongodb://root:example@localhost:27017/escalada?authSource=admin"

# Directory for temporary JSON files
EXPORT_DIR="./exported_tables"
mkdir -p $EXPORT_DIR

# Export the Usuarios table with Notificacoes as a nested array
podman exec -e PGPASSWORD="$PG_PASSWORD" -t $PG_CONTAINER \
  psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB -c \
  "COPY (
    SELECT jsonb_agg(u)
    FROM (
      SELECT
        u.*,
        (SELECT jsonb_agg(n)
         FROM \"Notificacoes\" n
         WHERE n.\"fk_Usuarios_id\" = u.id) AS notificacoes
      FROM \"Usuarios\" u
    ) u
  ) TO STDOUT;" > "$EXPORT_DIR/UsuariosComNotificacoes.json"

# Copy the JSON file to the MongoDB container
podman cp "$EXPORT_DIR/UsuariosComNotificacoes.json" $MONGO_CONTAINER:/tmp/UsuariosComNotificacoes.json

# Import JSON data into MongoDB
podman exec -i $MONGO_CONTAINER mongoimport --uri="$MONGO_URI" \
  --collection="UsuariosComNotificacoes" --file="/tmp/UsuariosComNotificacoes.json" --jsonArray

# Get a list of all tables
TABLES=($(podman exec -e PGPASSWORD="$PG_PASSWORD" -t $PG_CONTAINER \
  psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB -t -c \
    "SELECT tablename FROM pg_tables WHERE schemaname = 'public' AND tablename not in ('alembic_version', 'Usuarios', 'Notificacoes');" | tr -s '[:space:]' ' ' ))

# Loop through each table and transfer data
for TABLE in "${TABLES[@]}"; do
  echo "Processing table: $TABLE"

  # Export table data as JSON
  podman exec -e PGPASSWORD="$PG_PASSWORD" -t $PG_CONTAINER \
    psql -h $PG_HOST -p $PG_PORT -U $PG_USER -d $PG_DB -c \
  "COPY (SELECT jsonb_agg(t) FROM \"$TABLE\" t) TO STDOUT;" > "$EXPORT_DIR/$TABLE.json"

  # Copy the JSON file to the MongoDB container
  podman cp "$EXPORT_DIR/$TABLE.json" $MONGO_CONTAINER:/tmp/$TABLE.json

  # Import JSON data into MongoDB
  podman exec -i $MONGO_CONTAINER mongoimport --uri="$MONGO_URI" \
    --collection=$TABLE --file="/tmp/$TABLE.json" --jsonArray
done

echo "Data transfer complete!"
