# STAGE 01 - Build application and its dependencies
FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build-env
WORKDIR /app
COPY netdockernew/*.csproj ./
COPY . ./
RUN dotnet restore 

# STAGE 02 - Publish the application
FROM build-env AS publish
RUN dotnet publish -c Release -o /app/publish

# STAGE 03 - Create the final image
FROM mcr.microsoft.com/dotnet/aspnet:5.0
WORKDIR /app
LABEL Author="Atta Rasul"
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "netdockernew.dll", "--server.urls", "http://*:80"]
