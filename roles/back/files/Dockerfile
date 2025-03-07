FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY *.sln .
COPY *.csproj ./
RUN dotnet restore shnurok.sln

###### new
RUN dotnet add package AWSSDK.RDS
RUN dotnet add package AWSSDK.Core
######

COPY . ./
RUN dotnet publish shnurok.sln -c release -o /app/build /p:AssemblyName=point

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS start
WORKDIR /app

# add validate certs db and s3
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        tzdata \
    && rm -rf /var/lib/apt/lists/*

# add user and privileges
RUN adduser --disabled-password --gecos "" --home /app appuser \
    && chown -R appuser:appuser /app

COPY --from=build --chown=appuser:appuser /app/build .
USER appuser

EXPOSE 5000
ENTRYPOINT ["dotnet", "point.dll"]

