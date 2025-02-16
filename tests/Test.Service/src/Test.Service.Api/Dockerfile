FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG FEED_USERNAME
ARG FEED_PASSWORD

WORKDIR /src

COPY ["./src", "./"]
RUN dotnet nuget add source https://pkgs.dev.azure.com/m1kes-lab/Households/_packaging/ml-nuget/nuget/v3/index.json --store-password-in-clear-text -u "${FEED_USERNAME}" -p "${FEED_PASSWORD}"
RUN dotnet restore "Test.Service.Api/Test.Service.Api.csproj"

WORKDIR "/src/Test.Service.Api"
RUN dotnet build "Test.Service.Api.csproj" -c Release -o /app/build --no-restore

FROM build AS publish
RUN dotnet publish "Test.Service.Api.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Test.Service.Api.dll"]