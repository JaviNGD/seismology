# Seismology

Aplicación que por medio de una task obtiene la data sismológica desde el sitio USGS, de los últimos 30 días <a href="https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson">(API)</a> y persiste la información en una base de datos de acuerdo a ciertos parámetros.

## Correr el proyecto localmente

### Clonar el proyecto
```plaintext
https://github.com/JaviNGD/seismology.git
```

### Ir al directorio del proyecto
```plaintext
cd seismology
```

### Instalar gemas
```plaintext
bundle install
```

### Crear en el directorio raíz un archivo .env para la conexión con la base de datos
```plaintext
DB_USERNAME=
DB_PASSWORD=
DB_HOST=
DB_PORT=
```

### Crear la base de datos
```plaintext
rails db:create
```

### Migrar la base de datos
```plaintext
rails db:migrate
```

### Iniciar el servidor 
```plaintext
rails server
```

### Se puede ingresar al servidor local desde:
```plaintext
http://127.0.0.1:3000/ ó http://localhost:3000/
```
*La dirección cambia respecto al valor ingresado en DB_HOST, del archivo .env*

## Para correr la tarea ejecutar el siguiente comando
```plaintext
rails import_earthquake_data:earthquake_data
```

## Endpoint 1

```plaintext
curl -X GET
'http://127.0.0.1:3000/api/features'
-H 'Content-Type: application/vnd.api+json' 
-H 'cache-control: no-cache'
```

### Filtrar por mag_type
```plaintext
curl -X GET \
'http://localhost:3000/api/features?filters[mag_type]=valor' \
-H 'Content-Type: application/vnd.api+json' \
-H 'cache-control: no-cache'
```

### Paginación
```plaintext
'http://127.0.0.1:3000/api/features?page=valor'
-H 'Content-Type: application/vnd.api+json' 
-H 'cache-control: no-cache'
```

🌍
