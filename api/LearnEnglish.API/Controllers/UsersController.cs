using LearnEnglish.API.Common;
using LearnEnglish.Application.Users.Commands.CreateUser;
using Microsoft.AspNetCore.Mvc;

namespace LearnEnglish.API.Controllers;

public sealed class UsersController : BaseApiController
{
    /// <summary>Creates a new user.</summary>
    [HttpPost]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public async Task<IActionResult> Create(
        [FromBody] CreateUserCommand command,
        CancellationToken cancellationToken)
    {
        var result = await Sender.Send(command, cancellationToken);

        if (result.IsFailure)
            return FromResult(result);

        return CreatedAtAction(nameof(Create), new { id = result.Value }, new { id = result.Value });
    }
}
