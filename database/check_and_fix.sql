-- ============================================================
-- LearnEnglish — Diagnóstico e correção rápida
-- Execute no SQL Server Management Studio / Azure Data Studio
-- ============================================================

-- 1. Ver usuários cadastrados no banco
SELECT UserId, Name, Email, CreatedAt FROM Users ORDER BY CreatedAt DESC;

-- 2. Ver tentativas registradas (pode estar vazio se UserId não existia)
SELECT TOP 20 a.AttemptId, u.Name, u.Email, e.Question, a.UserAnswer, a.IsCorrect, a.AttemptedAt
FROM ExerciseAttempts a
LEFT JOIN Users u ON u.UserId = a.UserId
LEFT JOIN Exercises e ON e.ExerciseId = a.ExerciseId
ORDER BY a.AttemptedAt DESC;

-- 3. Se o banco foi resetado e você precisa recriar seu usuário rapidamente:
-- (substitua os valores pelo seu nome e email)
-- INSERT INTO Users (UserId, Name, Email, CreatedAt)
-- VALUES (NEWID(), 'Rodrigo Furlaneti', 'rodrigofurlaneti31@gmail.com', GETUTCDATE());

-- 4. Verificar exercícios existentes
SELECT e.ExerciseId, l.Title AS Lesson, e.ExerciseType, e.Question, e.CorrectAnswer, e.IsActive
FROM Exercises e
JOIN Lessons l ON l.LessonId = e.LessonId
ORDER BY l.OrderIndex, e.OrderIndex;
