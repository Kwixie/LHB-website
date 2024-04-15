# Copy csproj and restore as distinct layers
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

COPY . .
# WORKDIR /sources

# Copy everything else and build website
# COPY /*.csproj .

# COPY /appsettings.json .
# COPY /Program.cs .

# COPY /Properties ./Properties
# COPY /Views ./Views

# Build umbraco
RUN dotnet restore
RUN dotnet build
RUN dotnet publish -c release -o /output --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /output
COPY --from=build /output ./


ENTRYPOINT ["dotnet", "LHB_website.dll"]