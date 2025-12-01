using Microsoft.Extensions.Logging;
using Moq;
using WebApplication2;
using WebApplication2.Controllers;

namespace WebApplication2.Tests;

public class WeatherForecastControllerTests
{
    private readonly WeatherForecastController _controller;
    private readonly Mock<ILogger<WeatherForecastController>> _loggerMock;

    public WeatherForecastControllerTests()
    {
        _loggerMock = new Mock<ILogger<WeatherForecastController>>();
        _controller = new WeatherForecastController(_loggerMock.Object);
    }

    [Fact]
    public void Get_ReturnsExactlyFiveForecasts()
    {
        // Act
        var result = _controller.Get();

        // Assert
        Assert.Equal(5, result.Count());
    }

    [Fact]
    public void Get_ReturnsForecastsWithFutureDates()
    {
        // Act
        var result = _controller.Get().ToList();

        // Assert
        var today = DateOnly.FromDateTime(DateTime.Now);
        foreach (var forecast in result)
        {
            Assert.True(forecast.Date > today);
        }
    }

    [Fact]
    public void Get_ReturnsForecastsWithValidTemperatures()
    {
        // Act
        var result = _controller.Get().ToList();

        // Assert
        foreach (var forecast in result)
        {
            Assert.InRange(forecast.TemperatureC, -20, 55);
        }
    }

    [Fact]
    public void Get_ReturnsForecastsWithNonNullSummaries()
    {
        // Act
        var result = _controller.Get().ToList();

        // Assert
        foreach (var forecast in result)
        {
            Assert.NotNull(forecast.Summary);
        }
    }

    [Fact]
    public void Get_TemperatureFahrenheitIsCalculatedCorrectly()
    {
        // Arrange
        var forecast = new WeatherForecast
        {
            Date = DateOnly.FromDateTime(DateTime.Now),
            TemperatureC = 0,
            Summary = "Test"
        };

        // Assert
        Assert.Equal(32, forecast.TemperatureF);
    }
}
