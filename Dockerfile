FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["src/PickaMeet.Web/PickaMeet.Web.csproj", "src/PickaMeet.Web/"]
COPY ["src/PickaMeet.Application/PickaMeet.Application.csproj", "src/PickaMeet.Application/"]
COPY ["src/PickaMeet.Infrastructure/PickaMeet.Infrastructure.csproj", "src/PickaMeet.Infrastructure/"]
COPY ["src/PickaMeet.Domain/PickaMeet.Domain.csproj", "src/PickaMeet.Domain/"]

RUN dotnet restore "src/PickaMeet.Web/PickaMeet.Web.csproj"

COPY . .

RUN dotnet publish "src/PickaMeet.Web/PickaMeet.Web.csproj" \
    -c Release \
    -o /app/publish \
    /p:UseAppHost=false

FROM mcr.microsoft.com/dotnet/aspnet:10.0 AS runtime
WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 8080

USER app

ENTRYPOINT ["sh", "-c", "exec dotnet PickaMeet.Web.dll --urls http://0.0.0.0:${PORT:-8080}"]
