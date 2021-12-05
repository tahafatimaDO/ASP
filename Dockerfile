FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
#EXPOSE 80
EXPOSE 443
# ==================================================
EXPOSE 8080
#ENV ASPNETCORE_URLS=https://*:443;http://*:8080
ENV ASPNETCORE_URLS=http://*:8080
ENV ASPNETCORE_HTTPS_PORT=443
# ==================================================

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["WebApplication2.csproj", "."]
RUN dotnet restore "./WebApplication2.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "WebApplication2.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "WebApplication2.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WebApplication2.dll"]
