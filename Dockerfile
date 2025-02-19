# Imagen base
FROM ubuntu:20.04

# Evita interacciones durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualiza el sistema e instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    supervisor \
    curl \
    gnupg \
    ca-certificates \
    wget \
    lsb-release \
    software-properties-common

# Instalar MySQL Server
RUN apt-get update && apt-get install -y mysql-server

# Instalar Node.js (ejemplo con Node 22 LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs

# Instalar .NET Runtime (para correr la API publicada)
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && apt-get update \
    && apt-get install -y apt-transport-https \
    && apt-get update \
    && apt-get install -y dotnet-runtime-9.0

# Crea directorio de trabajo
WORKDIR /app

# Copia el contenido del repositorio
COPY . /app

# Construye la API (suponiendo que ya tienes el código listo)
WORKDIR /app/api
RUN dotnet publish FinanzasApi.csproj -c Release -o ../publish

# Construye el frontend (instala dependencias y genera la build)
WORKDIR /app/frontend
RUN npm install && npm run build

# Copia los archivos de configuración de Supervisor
WORKDIR /app
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exponer el puerto 80 para el reverso proxy o acceso público
EXPOSE 80

# Comando de entrada: Supervisor iniciará todos los procesos
CMD ["/usr/bin/supervisord", "-n"]
