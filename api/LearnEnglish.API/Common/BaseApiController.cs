using LearnEnglish.Domain.Common;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace LearnEnglish.API.Common;

[ApiController]
[Route("api/[controller]")]
public abstract class BaseApiController : ControllerBase
{
    private ISender? _sender;
    protected ISender Sender => _sender ??= HttpContext.RequestServices.GetRequiredService<ISender>();

    protected IActionResult FromResult<T>(Result<T> result) =>
        result.IsSuccess ? Ok(result.Value) : Problem(result.Error);

    protected IActionResult FromResult(Result result) =>
        result.IsSuccess ? NoContent() : Problem(result.Error);

    private IActionResult Problem(Error error) => error.Code switch
    {
        var c when c.EndsWith(".NotFound") => NotFound(new ProblemDetail(error.Code, error.Description)),
        var c when c.EndsWith(".AlreadyExists") => Conflict(new ProblemDetail(error.Code, error.Description)),
        _ => BadRequest(new ProblemDetail(error.Code, error.Description))
    };
}

public sealed record ProblemDetail(string Code, string Description);
