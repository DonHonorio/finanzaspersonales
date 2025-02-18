# Etapa base: usa la imagen de runtime de .NET 9
# PRODUCCIÓN
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
# DESARROLLO
# FROM mcr.microsoft.com/dotnet/sdk:9.0 as base

WORKDIR /app

# Etapa de compilación: usa la imagen de SDK de .NET 9
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src
COPY ["FinanzasApi.csproj", "./"]
RUN dotnet restore "FinanzasApi.csproj"
COPY . .
RUN dotnet publish "FinanzasApi.csproj" -c Release -o /app/publish

# Etapa final: copia los archivos publicados a la imagen final
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
COPY --from=build /app/publish .
# DESARROLLO
# CMD ["dotnet", "watch", "run"]


# PRODUCCIÓN
EXPOSE 8080
ENTRYPOINT ["dotnet", "FinanzasApi.dll"]
