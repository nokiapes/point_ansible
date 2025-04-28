FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY *.sln .
COPY *.csproj ./
RUN dotnet restore shnurok.sln

RUN dotnet add package AWSSDK.RDS
RUN dotnet add package AWSSDK.Core
###### new
RUN dotnet add package MessagePack --version 2.5.187
RUN dotnet add package System.Drawing.Common --version 4.7.2
###### new

COPY . ./
RUN dotnet publish shnurok.sln -c release -o /app/build /p:AssemblyName=point

##################################################################
FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS start
WORKDIR /app

# Обновляем пакеты и устанавливаем зависимости с последними версиями
RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    ca-certificates \
    tzdata \
    icu-libs \
    krb5-libs \
    libcrypto3>=3.3.3-r0 \
    libssl3>=3.3.3-r0 \
    musl>=1.2.5-r1 \
    musl-utils>=1.2.5-r1

RUN adduser -D -h /app appuser \
    && chown -R appuser:appuser /app

COPY --from=build --chown=appuser:appuser /app/build .
USER appuser

# EXPOSE 5000
ENTRYPOINT ["dotnet", "point.dll"]


