FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

COPY *.sln .
COPY *.csproj ./
RUN dotnet restore shnurok.sln

COPY . ./
RUN dotnet publish shnurok.sln -c release -o /app/build /p:AssemblyName=point

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS start
WORKDIR /app

COPY --from=build /app/build .

###########
# Устанавливаем переменные среды
ENV AWS_ACCESS_KEY=
ENV AWS_SECRET_KEY=
ENV AWS_REGION=
ENV AWS_BUCKET=
ENV POSTGRES_CONN=
#############

ENTRYPOINT ["dotnet", "point.dll"]

