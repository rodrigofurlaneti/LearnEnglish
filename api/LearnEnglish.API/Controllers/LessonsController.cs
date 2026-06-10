using LearnEnglish.API.Common;
using LearnEnglish.Application.Lessons.Queries.GetLessonById;
using LearnEnglish.Application.Lessons.Queries.GetLessons;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace LearnEnglish.API.Controllers;

public sealed class LessonsController : BaseApiController
{
    /// <summary>Returns all active lessons ordered by OrderIndex.</summary>
    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> GetAll(CancellationToken cancellationToken)
    {
        var result = await Sender.Send(new GetLessonsQuery(), cancellationToken);
        return Ok(result);
    }

    /// <summary>Returns a lesson with all slides and exercises.</summary>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(Guid id, CancellationToken cancellationToken)
    {
        var result = await Sender.Send(new GetLessonByIdQuery(id), cancellationToken);
        return FromResult(result);
    }
}
