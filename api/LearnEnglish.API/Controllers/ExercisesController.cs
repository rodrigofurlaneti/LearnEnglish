using LearnEnglish.API.Common;
using LearnEnglish.Application.Exercises.Commands.SubmitAnswer;
using Microsoft.AspNetCore.Mvc;

namespace LearnEnglish.API.Controllers;

public sealed class ExercisesController : BaseApiController
{
    /// <summary>Submits an answer for an exercise and records the attempt.</summary>
    [HttpPost("{id:guid}/submit")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Submit(
        Guid id,
        [FromBody] SubmitAnswerRequest request,
        CancellationToken cancellationToken)
    {
        var command = new SubmitAnswerCommand(request.UserId, id, request.UserAnswer);
        var result = await Sender.Send(command, cancellationToken);
        return FromResult(result);
    }
}

public sealed record SubmitAnswerRequest(Guid UserId, string UserAnswer);
