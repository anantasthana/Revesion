FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY myweb/*.csproj ./myweb/
RUN dotnet restore

# copy everything else and build app
COPY myweb/. ./myweb/
WORKDIR /app/myweb
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build /app/myweb/out ./
ENTRYPOINT ["dotnet", "aspnetapp.dll"]