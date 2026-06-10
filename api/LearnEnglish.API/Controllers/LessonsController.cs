using LearnEnglish.API.Data;
using LearnEnglish.API.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LearnEnglish.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class LessonsController(AppDbContext db) : ControllerBase
{
    // GET /api/lessons — trilha completa de lições
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        var lessons = await db.Lessons
            .Where(l => l.IsActive)
            .OrderBy(l => l.OrderIndex)
            .Select(l => new {
                l.LessonId, l.LessonNumber, l.Title,
                l.Topic, l.Description, l.OrderIndex,
                SlideCount = l.Slides.Count,
                ExerciseCount = l.Exercises.Count(e => e.IsActive)
            })
            .ToListAsync();
        return Ok(lessons);
    }

    // GET /api/lessons/{id} — lição com slides e palavras
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var lesson = await db.Lessons
            .Include(l => l.Slides.OrderBy(s => s.OrderIndex))
            .Include(l => l.LessonWords).ThenInclude(lw => lw.Word)
            .FirstOrDefaultAsync(l => l.LessonId == id && l.IsActive);

        if (lesson is null) return NotFound();
        return Ok(lesson);
    }

    // GET /api/lessons/{id}/exercises — exercícios da lição
    [HttpGet("{id:int}/exercises")]
    public async Task<IActionResult> GetExercises(int id)
    {
        var exercises = await db.Exercises
            .Where(e => e.LessonId == id && e.IsActive)
            .OrderBy(e => e.OrderIndex)
            .ToListAsync();
        return Ok(exercises);
    }
}

[ApiController]
[Route("api/[controller]")]
public class WordsController(AppDbContext db) : ControllerBase
{
    // GET /api/words?lessonId=4
    [HttpGet]
    public async Task<IActionResult> GetWords([FromQuery] int? lessonId)
    {
        var query = db.Words.AsQueryable();
        if (lessonId.HasValue)
            query = query.Where(w => w.LessonWords.Any(lw => lw.LessonId == lessonId));
        return Ok(await query.OrderBy(w => w.WordEn).ToListAsync());
    }

    // GET /api/words/{id}
    [HttpGet("{id:int}")]
    public async Task<IActionResult> GetById(int id)
    {
        var word = await db.Words.FindAsync(id);
        return word is null ? NotFound() : Ok(word);
    }

    // POST /api/words/{id}/interaction — registra clique/TTS/pronunciação
    [HttpPost("{id:int}/interaction")]
    public async Task<IActionResult> RecordInteraction(int id,
        [FromBody] WordInteractionRequest req)
    {
        db.WordInteractions.Add(new WordInteraction
        {
            UserId = req.UserId,
            WordId = id,
            InteractionType = req.Type,
            PronunciationScore = req.Score
        });
        await db.SaveChangesAsync();
        return Ok(new { message = "Interaction recorded." });
    }
}

public record WordInteractionRequest(int UserId, string Type, decimal? Score);

[ApiController]
[Route("api/[controller]")]
public class ProgressController(AppDbContext db) : ControllerBase
{
    // GET /api/progress/{userId} — progresso do usuário em todas as lições
    [HttpGet("{userId:int}")]
    public async Task<IActionResult> GetProgress(int userId)
    {
        var progress = await db.UserProgress
            .Where(up => up.UserId == userId)
            .Include(up => up.Lesson)
            .Select(up => new {
                up.UserProgressId, up.LessonId,
                up.Lesson.Title, up.Status,
                up.CurrentSlide, up.Score,
                up.StartedAt, up.CompletedAt
            })
            .ToListAsync();
        return Ok(progress);
    }

    // POST /api/progress — cria ou atualiza progresso
    [HttpPost]
    public async Task<IActionResult> Upsert([FromBody] UpsertProgressRequest req)
    {
        var existing = await db.UserProgress
            .FirstOrDefaultAsync(up => up.UserId == req.UserId && up.LessonId == req.LessonId);

        if (existing is null)
        {
            existing = new UserProgress
            {
                UserId = req.UserId,
                LessonId = req.LessonId,
                Status = req.Status,
                CurrentSlide = req.CurrentSlide,
                StartedAt = req.Status == "in_progress" ? DateTime.UtcNow : null
            };
            db.UserProgress.Add(existing);
        }
        else
        {
            existing.Status = req.Status;
            existing.CurrentSlide = req.CurrentSlide;
            existing.Score = req.Score;
            if (req.Status == "completed") existing.CompletedAt = DateTime.UtcNow;
        }

        await db.SaveChangesAsync();
        return Ok(existing);
    }
}

public record UpsertProgressRequest(
    int UserId, int LessonId,
    string Status, int CurrentSlide, decimal? Score);

[ApiController]
[Route("api/[controller]")]
public class ExercisesController(AppDbContext db) : ControllerBase
{
    // POST /api/exercises/{id}/submit — submete resposta
    [HttpPost("{id:int}/submit")]
    public async Task<IActionResult> Submit(int id, [FromBody] SubmitAnswerRequest req)
    {
        var exercise = await db.Exercises.FindAsync(id);
        if (exercise is null) return NotFound();

        bool isCorrect = string.Equals(
            req.Answer.Trim(),
            exercise.CorrectAnswer.Trim(),
            StringComparison.OrdinalIgnoreCase);

        db.ExerciseAttempts.Add(new ExerciseAttempt
        {
            UserId = req.UserId,
            ExerciseId = id,
            UserAnswer = req.Answer,
            IsCorrect = isCorrect
        });
        await db.SaveChangesAsync();

        return Ok(new {
            isCorrect,
            correctAnswer = isCorrect ? null : exercise.CorrectAnswer,
            explanation = exercise.Explanation
        });
    }
}

public record SubmitAnswerRequest(int UserId, string Answer);
