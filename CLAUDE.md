# CLAUDE.md

This file provides guidance for AI assistants working with this codebase.

## Project Overview

**WebApplication2** is an ASP.NET Core 8.0 Web API project with Docker support. It serves as a containerized REST API template with Swagger/OpenAPI documentation and a comprehensive test suite.

## Technology Stack

- **.NET 8.0** - Target framework
- **ASP.NET Core Web API** - REST API framework
- **Swashbuckle.AspNetCore 6.6.2** - Swagger/OpenAPI integration
- **Docker** - Containerization (Linux containers)
- **xUnit** - Unit and integration testing framework
- **Moq** - Mocking framework for tests

## Project Structure

```
DockerTry/
├── Controllers/
│   └── WeatherForecastController.cs  # Sample API controller
├── Properties/
│   └── launchSettings.json           # Development launch profiles
├── Tests/
│   ├── WebApplication2.Tests.csproj  # Test project file
│   ├── WeatherForecastControllerTests.cs  # Unit tests
│   └── IntegrationTests.cs           # Integration tests
├── Program.cs                        # Application entry point & configuration
├── WeatherForecast.cs                # Model class
├── WebApplication2.csproj            # Project file
├── WebApplication2.http              # HTTP request test file
├── Dockerfile                        # Multi-stage Docker build
├── .gitignore                        # Git ignore rules
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

## Test Commands

```bash
# Run all tests
dotnet test

# Run tests with verbose output
dotnet test --logger "console;verbosity=detailed"

# Run tests with code coverage
dotnet test --collect:"XPlat Code Coverage"

# Run specific test class
dotnet test --filter "FullyQualifiedName~WeatherForecastControllerTests"
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
| GET | `/health` | Health check endpoint for container orchestration |
| GET | `/swagger` | Swagger UI (Development only) |

## Development URLs

- **HTTP**: `http://localhost:5214`
- **HTTPS**: `https://localhost:7217`
- **Docker HTTP**: `http://localhost:8080`
- **Docker HTTPS**: `https://localhost:8081`
- **Swagger UI**: Append `/swagger` to any base URL
- **Health Check**: Append `/health` to any base URL

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

### Testing
- Place unit tests in `Tests/` directory
- Use xUnit for test framework
- Use Moq for mocking dependencies
- Use `WebApplicationFactory<Program>` for integration tests
- Name test methods: `MethodName_Scenario_ExpectedResult`

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
# Get weather forecast
curl http://localhost:5214/weatherforecast

# Check health status
curl http://localhost:5214/health
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
5. Add corresponding tests in `Tests/`

## Notes for AI Assistants

- This is a minimal Web API template - extend it based on requirements
- Swagger is enabled only in Development environment
- The project uses implicit usings and nullable reference types
- Health check endpoint is available at `/health` for Kubernetes/Docker health probes
- No database is configured - add Entity Framework Core if needed
- No authentication is configured - add Identity or JWT as needed
- Always add tests when implementing new features
