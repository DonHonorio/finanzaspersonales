# Usa la imagen oficial de Node en la versión 22.13.1 (alpine para una imagen más ligera)
FROM node:22.13.1-alpine

# BUILD
# Define el argumento de build
ARG NEXT_PUBLIC_API_URL
# Establece la variable de entorno a partir del argumento
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

WORKDIR /app

# Copia y instala dependencias
COPY package*.json ./
RUN npm install

# PRODUCCIÓN
COPY . .

# PRODUCCIÓN
# Construye la aplicación Next.js
RUN npm run build

# Expone el puerto en el que Next.js escucha (por defecto 3000)
EXPOSE 3000

# Inicia la aplicación

# DESARROLLO
# CMD ["npm", "run", "dev"]

# PRODUCCIÓN
CMD ["npm", "start"]