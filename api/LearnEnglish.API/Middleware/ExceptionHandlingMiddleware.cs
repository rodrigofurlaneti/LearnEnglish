using FluentValidation;
using LearnEnglish.Domain.Common;

namespace LearnEnglish.API.Middleware;

public sealed class ExceptionHandlingMiddleware(RequestDelegate next, ILogger<ExceptionHandlingMiddleware> logger)
{
    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await next(context);
        }
        catch (DomainException ex)
        {
            logger.LogWarning(ex, "Domain exception: {Message}", ex.Message);
            context.Response.StatusCode = StatusCodes.Status400BadRequest;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(new { code = "Domain.Error", description = ex.Message });
        }
        catch (ValidationException ex)
        {
            logger.LogWarning(ex, "Validation exception");
            context.Response.StatusCode = StatusCodes.Status422UnprocessableEntity;
            context.Response.ContentType = "application/json";
            var errors = ex.Errors.Select(e => new { code = e.PropertyName, description = e.ErrorMessage });
            await context.Response.WriteAsJsonAsync(new { errors });
        }
        catch (Exception ex)
        {
            logger.LogError(ex, "Unhandled exception");
            context.Response.StatusCode = StatusCodes.Status500InternalServerError;
            context.Response.ContentType = "application/json";
            await context.Response.WriteAsJsonAsync(new { code = "Server.Error", description = "An unexpected error occurred." });
        }
    }
}
