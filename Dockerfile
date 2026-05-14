# Etapa 1: Etapa de construcción (build)
FROM python:3.11-slim AS build

# Definir directorio de trabajo
WORKDIR /workspace

# Copiar archivo de dependencias
COPY requirements.txt .

# Instalar dependencias
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 2: Etapa de ejecución
FROM python:3.11-slim

# Usuario para minimo privilegio
RUN useradd -m ev2user

WORKDIR /app

# Copiar las librerías
COPY --from=build /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=build /usr/local/bin /usr/local/bin

# Copiar el código fuente
COPY . .

# Cambiar al usuario
USER ev2user

# Exponer el puerto
EXPOSE 5000

# Comando para iniciar la aplicación
ENTRYPOINT ["python", "app.py"]
