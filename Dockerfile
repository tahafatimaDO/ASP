FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
#EXPOSE 80
EXPOSE 443
# ==================================================
EXPOSE 80
#ENV ASPNETCORE_URLS=https://*:443;http://*:80
ARG ASPNETCORE_URLS
ENV ASPNETCORE_URLS=${ASPNETCORE_URLS}

ARG ASPNETCORE_HTTPS_PORT
ENV ASPNETCORE_HTTPS_PORT=${ASPNETCORE_HTTPS_PORT}
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
