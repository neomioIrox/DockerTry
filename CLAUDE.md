# CLAUDE.md

This file provides guidance for AI assistants working with this codebase.

## Project Overview

**WebApplication2** is an ASP.NET Core 8.0 Web API project with Docker support. It serves as a containerized REST API template with Swagger/OpenAPI documentation.

## Technology Stack

- **.NET 8.0** - Target framework
- **ASP.NET Core Web API** - REST API framework
- **Swashbuckle.AspNetCore 6.6.2** - Swagger/OpenAPI integration
- **Docker** - Containerization (Linux containers)

## Project Structure

```
DockerTry/
├── Controllers/
│   └── WeatherForecastController.cs  # Sample API controller
├── Properties/
│   └── launchSettings.json           # Development launch profiles
├── bin/                              # Build output (Debug/Release)
├── obj/                              # Intermediate build files
├── publish/                          # Published application output
├── Program.cs                        # Application entry point & configuration
├── WeatherForecast.cs                # Model class
├── WebApplication2.csproj            # Project file
├── WebApplication2.http              # HTTP request test file
├── Dockerfile                        # Multi-stage Docker build
├── appsettings.json                  # Production configuration
└── appsettings.Development.json      # Development configuration
```

## Build Commands

```bash
# Restore dependencies
dotnet restore

# Build the project
dotnet build

# Run in development mode
dotnet run

# Publish for production
dotnet publish -c Release -o ./publish
```

## Docker Commands

```bash
# Build Docker image
docker build -t webapplication2 .

# Run container
docker run -p 8080:8080 -p 8081:8081 webapplication2

# Docker exposes ports 8080 (HTTP) and 8081 (HTTPS)
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/weatherforecast` | Returns 5-day weather forecast sample data |
| GET | `/swagger` | Swagger UI (Development only) |

## Development URLs

- **HTTP**: `http://localhost:5214`
- **HTTPS**: `https://localhost:7217`
- **Docker HTTP**: `http://localhost:8080`
- **Docker HTTPS**: `https://localhost:8081`
- **Swagger UI**: Append `/swagger` to any base URL

## Code Conventions

### Controllers
- Use `[ApiController]` attribute on all controllers
- Inherit from `ControllerBase`
- Use `[Route("[controller]")]` for automatic route naming
- Use `[HttpGet]`, `[HttpPost]`, etc. with named routes

### Models
- Use file-scoped namespaces
- Enable nullable reference types (`string?`)
- Use C# records or classes as appropriate

### Dependency Injection
- Register services in `Program.cs` using `builder.Services`
- Use constructor injection in controllers

## Configuration

### Environment Variables
- `ASPNETCORE_ENVIRONMENT`: Set to `Development` or `Production`
- `ASPNETCORE_HTTP_PORTS`: HTTP port (Docker: 8080)
- `ASPNETCORE_HTTPS_PORTS`: HTTPS port (Docker: 8081)

### App Settings
- `appsettings.json` - Base configuration
- `appsettings.Development.json` - Development overrides
- Logging levels configurable per namespace

## Testing the API

Use the included `.http` file with VS Code REST Client extension or:

```bash
curl http://localhost:5214/weatherforecast
```

## Docker Build Details

The Dockerfile uses a multi-stage build:
1. **Build stage**: Uses `mcr.microsoft.com/dotnet/sdk:8.0` for compilation
2. **Runtime stage**: Uses `mcr.microsoft.com/dotnet/aspnet:8.0` for smaller image

## Key Files for Modification

When adding new features:
1. Add new controllers in `Controllers/`
2. Add models in the root directory or create a `Models/` folder
3. Register new services in `Program.cs`
4. Update `appsettings.json` for new configuration

## Notes for AI Assistants

- This is a minimal Web API template - extend it based on requirements
- Swagger is enabled only in Development environment
- The project uses implicit usings and nullable reference types
- No database is configured - add Entity Framework Core if needed
- No authentication is configured - add Identity or JWT as needed
