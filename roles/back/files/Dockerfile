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

RUN apk add --no-cache \
    ca-certificates \
    tzdata \
    icu-libs \
    krb5-libs

RUN adduser -D -h /app appuser \
    && chown -R appuser:appuser /app

COPY --from=build --chown=appuser:appuser /app/build .
USER appuser

EXPOSE 5000
ENTRYPOINT ["dotnet", "point.dll"]

# FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS start
# WORKDIR /app

# # add validate certs db and s3
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#         ca-certificates \
#         tzdata \
#         libgnutls30 \
#         libgssapi-krb5-2 \
#         libk5crypto3 \
#         libkrb5-3 \
#         libkrb5support0 \
#         libtasn1-6 && \
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # add user and privileges
# RUN adduser --disabled-password --gecos "" --home /app appuser \
#     && chown -R appuser:appuser /app

# COPY --from=build --chown=appuser:appuser /app/build .
# USER appuser

# EXPOSE 5000
# ENTRYPOINT ["dotnet", "point.dll"]

