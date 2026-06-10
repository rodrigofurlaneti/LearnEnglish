using LearnEnglish.Application.Common.Interfaces;
using LearnEnglish.Domain.Repositories;
using LearnEnglish.Infrastructure.Persistence;
using LearnEnglish.Infrastructure.Persistence.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace LearnEnglish.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddDbContext<AppDbContext>(options =>
            options.UseSqlServer(
                configuration.GetConnectionString("DefaultConnection"),
                sqlOptions => sqlOptions.EnableRetryOnFailure()));

        services.AddScoped<IUnitOfWork>(sp => sp.GetRequiredService<AppDbContext>());

        services.AddScoped<ILessonRepository, LessonRepository>();
        services.AddScoped<IUserRepository, UserRepository>();
        services.AddScoped<IWordRepository, WordRepository>();
        services.AddScoped<IExerciseRepository, ExerciseRepository>();

        return services;
    }
}
