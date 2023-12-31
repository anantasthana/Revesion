FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env 
WORKDIR /app

# copy csproj files
COPY */*.csproj ./
RUN ls .
RUN dotnet restore ./myweb.csproj

COPY myweb/ ./
RUN dotnet build ./myweb.csproj

RUN dotnet publish ./myweb.csproj -c Release -o output 

# Runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/output .
ENTRYPOINT ["dotnet", "myweb.dll"]
