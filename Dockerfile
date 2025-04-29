FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY *.sln .
COPY *.csproj ./
RUN dotnet restore shnurok.sln
COPY . ./
RUN dotnet publish shnurok.sln -c release -o /app/build /p:AssemblyName=point

###
# FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine AS start
# WORKDIR /app
# RUN apk update && \
#     apk upgrade --no-cache && \
#     apk add --no-cache \
#     ca-certificates \
#     tzdata \
#     libcrypto3>=3.3.3-r0 \
#     libssl3>=3.3.3-r0 \
#     musl>=1.2.5-r1 \
#     musl-utils>=1.2.5-r1

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS start
WORKDIR /app

RUN adduser -D -h /app appuser \
    && chown -R appuser:appuser /app
COPY --from=build --chown=appuser:appuser /app/build .
USER appuser
# EXPOSE 5000
ENTRYPOINT ["dotnet", "point.dll"]
