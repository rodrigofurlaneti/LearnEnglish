using FluentValidation;

namespace LearnEnglish.Application.Exercises.Commands.SubmitAnswer;

public sealed class SubmitAnswerCommandValidator : AbstractValidator<SubmitAnswerCommand>
{
    public SubmitAnswerCommandValidator()
    {
        RuleFor(x => x.UserId).NotEmpty().WithMessage("UserId must be a valid Guid.");
        RuleFor(x => x.ExerciseId).NotEmpty().WithMessage("ExerciseId must be a valid Guid.");
        RuleFor(x => x.UserAnswer).NotEmpty().WithMessage("Answer cannot be empty.");
    }
}
