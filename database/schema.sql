-- ============================================================
-- LearnEnglish - SQL Server Schema
-- Teacher Katrine Riccaldoni
-- PKs: UNIQUEIDENTIFIER DEFAULT NEWID()
-- ============================================================
USE master;
GO
-- Force all connections to close before dropping
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'learnenglish')
BEGIN
    ALTER DATABASE learnenglish SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE learnenglish;
END
GO
CREATE DATABASE learnenglish;
GO
USE learnenglish;
GO
-- ============================================================
-- TABELAS PRINCIPAIS
-- ============================================================
CREATE TABLE Users (
    UserId      UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    Name        NVARCHAR(150)     NOT NULL,
    Email       NVARCHAR(200)     NOT NULL UNIQUE,
    AvatarUrl   NVARCHAR(500)     NULL,
    CreatedAt   DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt   DATETIME2         NULL
);

CREATE TABLE Lessons (
    LessonId      UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    LessonNumber  INT               NOT NULL UNIQUE,
    Title         NVARCHAR(200)     NOT NULL,
    Topic         NVARCHAR(200)     NOT NULL,
    Description   NVARCHAR(1000)    NOT NULL,
    OrderIndex    INT               NOT NULL,
    IsActive      BIT               NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt     DATETIME2         NULL
);

CREATE TABLE Slides (
    SlideId      UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    LessonId     UNIQUEIDENTIFIER  NOT NULL REFERENCES Lessons(LessonId),
    OrderIndex   INT               NOT NULL,
    SlideTitle   NVARCHAR(200)     NULL,
    ContentType  NVARCHAR(50)      NOT NULL,
    Content      NVARCHAR(MAX)     NOT NULL,
    CreatedAt    DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt    DATETIME2         NULL,
    CONSTRAINT UQ_Slides_Lesson_Order UNIQUE (LessonId, OrderIndex)
);

CREATE TABLE Words (
    WordId               UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    WordEn               NVARCHAR(200)     NOT NULL,
    WordPt               NVARCHAR(200)     NOT NULL,
    Phonetic             NVARCHAR(200)     NULL,
    ExampleSentence      NVARCHAR(500)     NULL,
    ExampleTranslation   NVARCHAR(500)     NULL,
    WordType             NVARCHAR(50)      NULL,
    AudioUrl             NVARCHAR(500)     NULL,
    CreatedAt            DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt            DATETIME2         NULL
);

CREATE TABLE LessonWords (
    LessonId  UNIQUEIDENTIFIER  NOT NULL REFERENCES Lessons(LessonId),
    WordId    UNIQUEIDENTIFIER  NOT NULL REFERENCES Words(WordId),
    PRIMARY KEY (LessonId, WordId)
);

CREATE TABLE Exercises (
    ExerciseId    UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    LessonId      UNIQUEIDENTIFIER  NOT NULL REFERENCES Lessons(LessonId),
    ExerciseType  NVARCHAR(50)      NOT NULL,
    Question      NVARCHAR(1000)    NOT NULL,
    CorrectAnswer NVARCHAR(500)     NOT NULL,
    Options       NVARCHAR(MAX)     NULL,
    Explanation   NVARCHAR(1000)    NULL,
    OrderIndex    INT               NOT NULL DEFAULT 0,
    IsActive      BIT               NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt     DATETIME2         NULL
);

CREATE TABLE UserProgress (
    UserProgressId  UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    UserId          UNIQUEIDENTIFIER  NOT NULL REFERENCES Users(UserId),
    LessonId        UNIQUEIDENTIFIER  NOT NULL REFERENCES Lessons(LessonId),
    Status          NVARCHAR(20)      NOT NULL DEFAULT 'not_started',
    CurrentSlide    INT               NOT NULL DEFAULT 0,
    Score           DECIMAL(5,2)      NULL,
    StartedAt       DATETIME2         NULL,
    CompletedAt     DATETIME2         NULL,
    CreatedAt       DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt       DATETIME2         NULL,
    CONSTRAINT UQ_UserProgress_User_Lesson UNIQUE (UserId, LessonId)
);

CREATE TABLE ExerciseAttempts (
    AttemptId    UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    UserId       UNIQUEIDENTIFIER  NOT NULL REFERENCES Users(UserId),
    ExerciseId   UNIQUEIDENTIFIER  NOT NULL REFERENCES Exercises(ExerciseId),
    UserAnswer   NVARCHAR(500)     NOT NULL,
    IsCorrect    BIT               NOT NULL,
    AttemptedAt  DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    CreatedAt    DATETIME2         NOT NULL DEFAULT GETUTCDATE()
);

CREATE TABLE WordInteractions (
    InteractionId       UNIQUEIDENTIFIER  NOT NULL PRIMARY KEY DEFAULT NEWID(),
    UserId              UNIQUEIDENTIFIER  NOT NULL REFERENCES Users(UserId),
    WordId              UNIQUEIDENTIFIER  NOT NULL REFERENCES Words(WordId),
    InteractionType     NVARCHAR(30)      NOT NULL,
    PronunciationScore  DECIMAL(5,2)      NULL,
    CreatedAt           DATETIME2         NOT NULL DEFAULT GETUTCDATE()
);
GO
-- ============================================================
-- ÍNDICES
-- ============================================================
CREATE INDEX IX_Slides_LessonId        ON Slides(LessonId);
CREATE INDEX IX_LessonWords_WordId     ON LessonWords(WordId);
CREATE INDEX IX_Exercises_LessonId     ON Exercises(LessonId);
CREATE INDEX IX_UserProgress_UserId    ON UserProgress(UserId);
CREATE INDEX IX_ExerciseAttempts_User  ON ExerciseAttempts(UserId, ExerciseId);
CREATE INDEX IX_WordInteractions_User  ON WordInteractions(UserId, WordId);
GO
-- ============================================================
-- SEED DATA
-- ============================================================
DECLARE @L1 UNIQUEIDENTIFIER = NEWID();
DECLARE @L2 UNIQUEIDENTIFIER = NEWID();
DECLARE @L3 UNIQUEIDENTIFIER = NEWID();
DECLARE @L4 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L1, 1, 'Verb to Be', 'Verb to Be',
 'Aprenda o verbo mais fundamental do inglês: to be (ser/estar). Conjugações no presente, passado e futuro.', 1),
(@L2, 2, 'Verb to Be - Prática', 'Verb to Be',
 'Estruturas afirmativa, negativa e interrogativa do verbo to be com exemplos práticos.', 2),
(@L3, 3, 'Simple Present', 'Simple Present',
 'O Simple Present é usado para hábitos, rotinas, sentimentos e verdades universais.', 3),
(@L4, 4, 'Simple Past', 'Simple Past',
 'O Simple Past indica ações concluídas no passado. Verbos regulares e irregulares.', 4);

-- SLIDES - Lição 1: Verb to Be
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L1, 1, 'Verb to Be', 'intro',
 '{"heading":"Verb to Be","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 1"}'),
(@L1, 2, 'O que é o Verb to Be?', 'theory',
 '{"heading":"O que é o Verb to Be?","points":["Para entender o sentido do verbo to be na frase, é necessário entender o contexto da mensagem como um todo.","O verbo to be é classificado como um verbo irregular, já que não segue as regras de formação do simple past e do past participle.","O verbo to be pode ser utilizado como verbo principal, mas também como verbo auxiliar de alguns tempos verbais."]}'),
(@L1, 3, 'Conjugação: Simple Present', 'table',
 '{"heading":"Conjugação: Simple Present","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","am","am not"],["You","are","are not"],["He/She/It","is","is not"],["We","are","are not"],["You","are","are not"],["They","are","are not"]]}'),
(@L1, 4, 'Conjugação: Simple Past', 'table',
 '{"heading":"Conjugação: Simple Past","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","was","was not"],["You","were","were not"],["He/She/It","was","was not"],["We","were","were not"],["You","were","were not"],["They","were","were not"]]}'),
(@L1, 5, 'Conjugação: Simple Future', 'table',
 '{"heading":"Conjugação: Simple Future","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","will be","will not be"],["You","will be","will not be"],["He/She/It","will be","will not be"],["We","will be","will not be"],["You","will be","will not be"],["They","will be","will not be"]]}'),
(@L1, 6, 'Estrutura', 'examples',
 '{"heading":"Estrutura","subheading":"Affirmative form","formula":"Subject + verb to be + complement","examples":["He is a mechanical engineer","He was a mechanical engineer","He will be a mechanical engineer"]}'),
(@L1, 7, 'Formas Negativa e Interrogativa', 'examples',
 '{"heading":"Formas Negativa e Interrogativa","sections":[{"title":"Negative form","formula":"Subject + verb to be + not + complement","examples":["He is not a mechanical engineer","He was not a mechanical engineer","He will not be a mechanical engineer"]},{"title":"Interrogative form","formula":"Verb to be + subject + complement","examples":["Is he a mechanical engineer?","Was he a mechanical engineer?","Will he be a mechanical engineer?"]}]}'),
(@L1, 8, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Make an affirmative sentence about you"},{"number":2,"text":"Ask a question"},{"number":3,"text":"Make a negative sentence about someone"}]}');

-- SLIDES - Lição 3: Simple Present
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L3, 1, 'Simple Present', 'intro',
 '{"heading":"Simple Present","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 3"}'),
(@L3, 2, 'What is Simple Present?', 'theory',
 '{"heading":"What is Simple Present?","points":["The Simple Present is a verb tense used to talk about habits and routines.","We also use it to express feelings, opinions, and universal truths."],"example":"I like to play videogames"}'),
(@L3, 3, 'The Structure', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + complement","example":"I like cookies"},{"title":"Negative Form","formula":"Subject + auxiliary verb + not + main verb + complement","example":"I do not like chocolate"}]}'),
(@L3, 4, 'The Structure - Interrogative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Auxiliary verb + subject + main verb + complement","example":"Do we have class today?"},{"title":"Affirmative answer","formula":"Yes + subject + auxiliary verb","example":"Yes, we do"},{"title":"Negative answer","formula":"No + subject + auxiliary verb + not","example":"No, we do not"}]}'),
(@L3, 5, 'Conjugação - He/She/It', 'table',
 '{"heading":"Important","subheading":"The verb form changes according to the subject","headers":["Subject","Verb form","Examples"],"rows":[["I","infinitive form","work"],["You","infinitive form","work"],["He/She/It","infinitive form + s/es/ies","works"],["We","infinitive form","work"],["You","infinitive form","work"],["They","infinitive form","work"]]}'),
(@L3, 6, 'Verbs - Regras de conjugação', 'theory',
 '{"heading":"Verbs","rules":[{"rule":"Ending in -o, -z, -ss, -ch, -sh, -x: add -es","examples":["to teach > teaches","to kiss > kisses","to go > goes"]},{"rule":"Ending in -y after a consonant: remove -y and add -ies","examples":["to fly > flies","to study > studies","to worry > worries"]},{"rule":"Ending in -y after a vowel: add -s","examples":["to say > says","to play > plays"]}]}'),
(@L3, 7, 'Contractions', 'examples',
 '{"heading":"Contractions","contractions":[{"full":"Do + not","short":"Don''t","example":"I don''t go to the gym"},{"full":"Does + not","short":"Doesn''t","example":"He doesn''t eat sushi"}]}'),
(@L3, 8, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Talk about your interests"},{"number":2,"text":"Ask about the other person"},{"number":3,"text":"Identify similarities between your interests and talk about that"}]}');

-- SLIDES - Lição 4: Simple Past
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L4, 1, 'Simple Past', 'intro',
 '{"heading":"Simple Past","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 4"}'),
(@L4, 2, 'What is Simple Past?', 'theory',
 '{"heading":"What is Simple Past?","points":["O simple past é equivalente ao passado simples do português.","O simple past é usado para indicar ações já concluídas, ou seja, para falar de fatos que já aconteceram (começaram e terminaram no passado)."]}'),
(@L4, 3, 'Expressões Temporais', 'theory',
 '{"heading":"Expressões Temporais","description":"Para reforçar o uso do simple past, muitas expressões temporais são utilizadas nas frases.","words":[{"en":"yesterday","pt":"ontem"},{"en":"the day before yesterday","pt":"anteontem"},{"en":"last night","pt":"ontem à noite"},{"en":"last year","pt":"ano passado"},{"en":"last month","pt":"mês passado"},{"en":"last week","pt":"semana passada"},{"en":"ago","pt":"atrás"}],"example":"We did not work yesterday"}'),
(@L4, 4, 'The Structure - Affirmative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + d/ed/ied + complement","example":"I liked cookies","note":"Verbos irregulares não possuem um padrão de formação. Eles possuem uma forma própria."}]}'),
(@L4, 5, 'Verbos Regulares - Parte 1', 'theory',
 '{"heading":"Verbos Regulares","rules":[{"number":1,"rule":"Terminados em -e: acrescenta-se -d no final","examples":["to love > loved","to lie > lied"]},{"number":2,"rule":"Terminados em consoante + vogal + consoante: duplica-se a última consoante e acrescenta-se -ed","examples":["to stop > stopped","to control > controlled"]}]}'),
(@L4, 6, 'Verbos Regulares - Parte 2', 'theory',
 '{"heading":"Verbos Regulares","rules":[{"number":3,"rule":"Terminados em -y precedido de consoante: retira-se o -y e acrescenta-se -ied no final","examples":["to study > studied","to try > tried"]},{"number":4,"rule":"Terminados em -y precedido de vogal: acrescenta-se o -ed no final","examples":["to enjoy > enjoyed","to play > played"]}]}'),
(@L4, 7, 'Verbos Irregulares - Parte 1', 'table',
 '{"heading":"Verbos Irregulares","pairs":[["to be","was"],["to become","became"],["to begin","began"],["to break","broke"],["to bring","brought"],["to build","built"],["to buy","bought"],["to choose","chose"],["to come","came"],["to do","did"],["to drink","drank"],["to drive","drove"],["to eat","ate"],["to feed","fed"],["to feel","felt"],["to find","found"],["to forbid","forbade"],["to forget","forgot"],["to get","got"],["to give","gave"],["to go","went"],["to have","had"],["to hear","heard"],["to hide","hid"],["to keep","kept"],["to know","knew"],["to lead","led"]]}'),
(@L4, 8, 'Verbos Irregulares - Parte 2', 'table',
 '{"heading":"Verbos Irregulares","pairs":[["to lose","lost"],["to make","made"],["to mean","meant"],["to meet","met"],["to pay","paid"],["to put","put"],["to read","read"],["to ride","rode"],["to run","ran"],["to say","said"],["to see","saw"],["to sell","sold"],["to send","sent"],["to sleep","slept"],["to speak","spoke"],["to take","took"],["to tell","told"],["to think","thought"],["to wake","woke"],["to win","won"],["to write","wrote"]]}'),
(@L4, 9, 'The Structure - Negative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Negative form","formula":"Subject + did + not + main verb + complement","example":"She did not like the restaurant","note":"Atenção! O verbo auxiliar faz o trabalho pelo verbo principal: o auxiliar no passado e o principal na forma infinitiva (sem o to)."}]}'),
(@L4, 10, 'The Structure - Interrogative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Did + subject + main verb + complement","example":"Did she like the restaurant?"}]}'),
(@L4, 11, 'Contractions', 'examples',
 '{"heading":"Contractions","contractions":[{"full":"Did + not","short":"didn''t","example":"She didn''t like the restaurant"}]}'),
(@L4, 12, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Identify the past of some words"},{"number":2,"text":"Talk about what you did yesterday"},{"number":3,"text":"Try to have a quick conversation"}]}');

-- EXERCÍCIOS - Lição 1: Verb to Be
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L1, 'multiple_choice',
 'Complete the sentence: I ___ a student.',
 'am',
 '["am","is","are","were"]',
 'Para o sujeito "I" no Simple Present, usamos "am". Ex: I am happy.',
 1),
(@L1, 'multiple_choice',
 'Choose the correct sentence:',
 'She is a teacher.',
 '["She am a teacher.","She is a teacher.","She are a teacher.","She be a teacher."]',
 'He/She/It usa "is" no Simple Present.',
 2),
(@L1, 'fill_blank',
 'Complete: They ___ students.',
 'are',
 NULL,
 'Para "They" (e We, You), usamos "are" no Simple Present.',
 3),
(@L1, 'multiple_choice',
 'What is the past form of "is"?',
 'was',
 '["was","were","be","been"]',
 'I/He/She/It → was no Simple Past. We/You/They → were.',
 4);

-- EXERCÍCIOS - Lição 3: Simple Present
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L3, 'multiple_choice',
 'She ___ to school every day.',
 'goes',
 '["go","goes","going","gone"]',
 'Com He/She/It, verbos terminados em -o recebem -es: go → goes.',
 1),
(@L3, 'multiple_choice',
 'Which is the correct NEGATIVE form?',
 'He does not like coffee.',
 '["He not like coffee.","He does not like coffee.","He do not likes coffee.","He doesn''t likes coffee."]',
 'Na forma negativa com He/She/It: does + not + verbo na forma base.',
 2),
(@L3, 'fill_blank',
 'Complete: She ___ (study) English every morning.',
 'studies',
 NULL,
 'study → estudar. Com She, remova o -y e adicione -ies: studies.',
 3),
(@L3, 'multiple_choice',
 'I ___ like chocolate.',
 'do not',
 '["not","does not","do not","am not"]',
 'Com I/You/We/They, a forma negativa é: do + not.',
 4),
(@L3, 'multiple_choice',
 '___ he work on weekends?',
 'Does',
 '["Do","Does","Is","Has"]',
 'Na forma interrogativa com He/She/It, usamos "Does" no início.',
 5);

-- EXERCÍCIOS - Lição 4: Simple Past
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L4, 'identify_past',
 'What is the Simple Past of "go"?',
 'went',
 '["goed","went","gone","going"]',
 '"go" é irregular: go → went. Não siga a regra do -ed!',
 1),
(@L4, 'identify_past',
 'What is the Simple Past of "study"?',
 'studied',
 '["studyed","studied","studid","studed"]',
 'study termina em -y precedido de consoante: remove -y, adiciona -ied.',
 2),
(@L4, 'multiple_choice',
 'She ___ not work yesterday.',
 'did',
 '["was","did","does","had"]',
 'Na forma negativa do Simple Past, usamos "did not" + verbo na forma base.',
 3),
(@L4, 'multiple_choice',
 '___ you eat sushi last night?',
 'Did',
 '["Were","Did","Do","Have"]',
 'Na interrogativa do Simple Past, "Did" vai para o início.',
 4),
(@L4, 'identify_past',
 'What is the Simple Past of "stop"?',
 'stopped',
 '["stoped","stopped","stopd","stoping"]',
 'Consoante + vogal + consoante → dobra a última consoante + -ed: stop → stopped.',
 5),
(@L4, 'identify_past',
 'What is the Simple Past of "buy"?',
 'bought',
 '["buyed","boughted","bought","buied"]',
 '"buy" é irregular: buy → bought.',
 6),
(@L4, 'translation',
 'Traduza para o inglês: "Ela viu um filme ontem."',
 'She saw a movie yesterday.',
 NULL,
 'saw = Simple Past de "see". Lembre da expressão temporal: yesterday.',
 7);

-- VOCABULÁRIO - Verbos Irregulares (Lesson 4)
DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
DECLARE @W9 UNIQUEIDENTIFIER = NEWID();
DECLARE @W10 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, 'was/were', 'era/estava', '/wɒz/ /wɜː/', 'verb', 'She was happy yesterday.', 'Ela estava feliz ontem.'),
(@W2, 'became', 'tornou-se', '/bɪˈkeɪm/', 'verb', 'He became a doctor.', 'Ele se tornou médico.'),
(@W3, 'began', 'começou', '/bɪˈɡæn/', 'verb', 'She began to study.', 'Ela começou a estudar.'),
(@W4, 'broke', 'quebrou', '/brəʊk/', 'verb', 'He broke the glass.', 'Ele quebrou o copo.'),
(@W5, 'brought', 'trouxe', '/brɔːt/', 'verb', 'She brought flowers.', 'Ela trouxe flores.'),
(@W6, 'built', 'construiu', '/bɪlt/', 'verb', 'They built a house.', 'Eles construíram uma casa.'),
(@W7, 'bought', 'comprou', '/bɔːt/', 'verb', 'I bought a new car.', 'Eu comprei um carro novo.'),
(@W8, 'went', 'foi', '/wɛnt/', 'verb', 'We went to the beach.', 'Fomos à praia.'),
(@W9, 'saw', 'viu', '/sɔː/', 'verb', 'She saw a movie yesterday.', 'Ela viu um filme ontem.'),
(@W10, 'said', 'disse', '/sɛd/', 'verb', 'He said goodbye.', 'Ele disse tchau.');

INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L4, @W1), (@L4, @W2), (@L4, @W3), (@L4, @W