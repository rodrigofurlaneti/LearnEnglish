-- ============================================================
-- LearnEnglish - SQL Server Schema
-- Teacher Katrine Riccaldoni
-- ============================================================

USE master;
GO

IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'LearnEnglishDB')
    CREATE DATABASE LearnEnglishDB;
GO

USE LearnEnglishDB;
GO

-- ============================================================
-- TABELAS PRINCIPAIS
-- ============================================================

-- Usuários
CREATE TABLE Users (
    UserId      INT IDENTITY(1,1) PRIMARY KEY,
    Name        NVARCHAR(150)     NOT NULL,
    Email       NVARCHAR(200)     NOT NULL UNIQUE,
    AvatarUrl   NVARCHAR(500)     NULL,
    CreatedAt   DATETIME2         NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt   DATETIME2         NOT NULL DEFAULT GETUTCDATE()
);

-- Lições (trilha de aprendizado)
CREATE TABLE Lessons (
    LessonId      INT IDENTITY(1,1) PRIMARY KEY,
    LessonNumber  INT            NOT NULL UNIQUE,
    Title         NVARCHAR(200)  NOT NULL,
    Topic         NVARCHAR(200)  NOT NULL,
    Description   NVARCHAR(1000) NOT NULL,
    OrderIndex    INT            NOT NULL,
    IsActive      BIT            NOT NULL DEFAULT 1,
    CreatedAt     DATETIME2      NOT NULL DEFAULT GETUTCDATE()
);

-- Slides de cada lição
CREATE TABLE Slides (
    SlideId      INT IDENTITY(1,1) PRIMARY KEY,
    LessonId     INT            NOT NULL REFERENCES Lessons(LessonId),
    OrderIndex   INT            NOT NULL,
    SlideTitle   NVARCHAR(200)  NULL,
    ContentType  NVARCHAR(50)   NOT NULL, -- 'intro','theory','table','examples','practice','closing'
    Content      NVARCHAR(MAX)  NOT NULL, -- JSON estruturado
    CONSTRAINT UQ_Slides_Lesson_Order UNIQUE (LessonId, OrderIndex)
);

-- Vocabulário / palavras
CREATE TABLE Words (
    WordId           INT IDENTITY(1,1) PRIMARY KEY,
    WordEn           NVARCHAR(200)  NOT NULL,
    WordPt           NVARCHAR(200)  NOT NULL,
    Phonetic         NVARCHAR(200)  NULL,     -- IPA  ex: /wɜːrd/
    ExampleSentence  NVARCHAR(500)  NULL,
    ExampleTranslation NVARCHAR(500) NULL,
    WordType         NVARCHAR(50)   NULL,     -- 'verb','noun','adverb','expression'
    AudioUrl         NVARCHAR(500)  NULL
);

-- Relação Lesson <-> Word (many-to-many)
CREATE TABLE LessonWords (
    LessonId  INT NOT NULL REFERENCES Lessons(LessonId),
    WordId    INT NOT NULL REFERENCES Words(WordId),
    PRIMARY KEY (LessonId, WordId)
);

-- Exercícios
CREATE TABLE Exercises (
    ExerciseId    INT IDENTITY(1,1) PRIMARY KEY,
    LessonId      INT            NOT NULL REFERENCES Lessons(LessonId),
    ExerciseType  NVARCHAR(50)   NOT NULL, -- 'multiple_choice','fill_blank','identify_past','translation','pronunciation'
    Question      NVARCHAR(1000) NOT NULL,
    CorrectAnswer NVARCHAR(500)  NOT NULL,
    Options       NVARCHAR(MAX)  NULL,     -- JSON array ["opt1","opt2",...]
    Explanation   NVARCHAR(1000) NULL,
    OrderIndex    INT            NOT NULL DEFAULT 0,
    IsActive      BIT            NOT NULL DEFAULT 1
);

-- Progresso do usuário por lição
CREATE TABLE UserProgress (
    UserProgressId  INT IDENTITY(1,1) PRIMARY KEY,
    UserId          INT            NOT NULL REFERENCES Users(UserId),
    LessonId        INT            NOT NULL REFERENCES Lessons(LessonId),
    Status          NVARCHAR(20)   NOT NULL DEFAULT 'not_started', -- 'not_started','in_progress','completed'
    CurrentSlide    INT            NOT NULL DEFAULT 0,
    Score           DECIMAL(5,2)   NULL,     -- 0.00 a 100.00
    StartedAt       DATETIME2      NULL,
    CompletedAt     DATETIME2      NULL,
    CONSTRAINT UQ_UserProgress_User_Lesson UNIQUE (UserId, LessonId)
);

-- Tentativas de exercícios
CREATE TABLE ExerciseAttempts (
    AttemptId    INT IDENTITY(1,1) PRIMARY KEY,
    UserId       INT            NOT NULL REFERENCES Users(UserId),
    ExerciseId   INT            NOT NULL REFERENCES Exercises(ExerciseId),
    UserAnswer   NVARCHAR(500)  NOT NULL,
    IsCorrect    BIT            NOT NULL,
    AttemptedAt  DATETIME2      NOT NULL DEFAULT GETUTCDATE()
);

-- Histórico de palavras clicadas (para tracking de aprendizado)
CREATE TABLE WordInteractions (
    InteractionId  INT IDENTITY(1,1) PRIMARY KEY,
    UserId         INT            NOT NULL REFERENCES Users(UserId),
    WordId         INT            NOT NULL REFERENCES Words(WordId),
    InteractionType NVARCHAR(30)  NOT NULL, -- 'click','tts','pronunciation_check'
    PronunciationScore DECIMAL(5,2) NULL,
    CreatedAt      DATETIME2      NOT NULL DEFAULT GETUTCDATE()
);

-- ============================================================
-- ÍNDICES
-- ============================================================
CREATE INDEX IX_Slides_LessonId       ON Slides(LessonId);
CREATE INDEX IX_LessonWords_WordId    ON LessonWords(WordId);
CREATE INDEX IX_Exercises_LessonId    ON Exercises(LessonId);
CREATE INDEX IX_UserProgress_UserId   ON UserProgress(UserId);
CREATE INDEX IX_ExerciseAttempts_User ON ExerciseAttempts(UserId, ExerciseId);
CREATE INDEX IX_WordInteractions_User ON WordInteractions(UserId, WordId);

-- ============================================================
-- SEED DATA
-- ============================================================

-- LIÇÕES
INSERT INTO Lessons (LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(1, 'Verb to Be', 'Verb to Be',
 'Aprenda o verbo mais fundamental do inglês: to be (ser/estar). Conjugações no presente, passado e futuro.',
 1),
(2, 'Verb to Be - Prática', 'Verb to Be',
 'Estruturas afirmativa, negativa e interrogativa do verbo to be com exemplos práticos.',
 2),
(3, 'Simple Present', 'Simple Present',
 'O Simple Present é usado para hábitos, rotinas, sentimentos e verdades universais.',
 3),
(4, 'Simple Past', 'Simple Past',
 'O Simple Past indica ações concluídas no passado. Verbos regulares e irregulares.',
 4);

-- SLIDES - Lição 1: Verb to Be
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(1, 1, 'Verb to Be', 'intro',
 '{"heading":"Verb to Be","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 1"}'),
(1, 2, 'O que é o Verb to Be?', 'theory',
 '{"heading":"O que é o Verb to Be?","points":["Para entender o sentido do verbo to be na frase, é necessário entender o contexto da mensagem como um todo.","O verbo to be é classificado como um verbo irregular, já que não segue as regras de formação do simple past e do past participle.","O verbo to be pode ser utilizado como verbo principal, mas também como verbo auxiliar de alguns tempos verbais."]}'),
(1, 3, 'Conjugação: Simple Present', 'table',
 '{"heading":"Conjugação: Simple Present","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","am","am not"],["You","are","are not"],["He/She/It","is","is not"],["We","are","are not"],["You","are","are not"],["They","are","are not"]]}'),
(1, 4, 'Conjugação: Simple Past', 'table',
 '{"heading":"Conjugação: Simple Past","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","was","was not"],["You","were","were not"],["He/She/It","was","was not"],["We","were","were not"],["You","were","were not"],["They","were","were not"]]}'),
(1, 5, 'Conjugação: Simple Future', 'table',
 '{"heading":"Conjugação: Simple Future","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","will be","will not be"],["You","will be","will not be"],["He/She/It","will be","will not be"],["We","will be","will not be"],["You","will be","will not be"],["They","will be","will not be"]]}'),
(1, 6, 'Estrutura', 'examples',
 '{"heading":"Estrutura","subheading":"Affirmative form","formula":"Subject + verb to be + complement","examples":["He is a mechanical engineer","He was a mechanical engineer","He will be a mechanical engineer"]}'),
(1, 7, 'Formas Negativa e Interrogativa', 'examples',
 '{"heading":"Formas Negativa e Interrogativa","sections":[{"title":"Negative form","formula":"Subject + verb to be + not + complement","examples":["He is not a mechanical engineer","He was not a mechanical engineer","He will not be a mechanical engineer"]},{"title":"Interrogative form","formula":"Verb to be + subject + complement","examples":["Is he a mechanical engineer?","Was he a mechanical engineer?","Will he be a mechanical engineer?"]}]}'),
(1, 8, 'Vamos Praticar!', 'practice',
 '{"heading":"Let'\''s Practice!","activities":[{"number":1,"text":"Make an affirmative sentence about you"},{"number":2,"text":"Ask a question"},{"number":3,"text":"Make a negative sentence about someone"}]}');

-- SLIDES - Lição 3: Simple Present
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(3, 1, 'Simple Present', 'intro',
 '{"heading":"Simple Present","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 3"}'),
(3, 2, 'What is Simple Present?', 'theory',
 '{"heading":"What is Simple Present?","points":["The Simple Present is a verb tense used to talk about habits and routines.","We also use it to express feelings, opinions, and universal truths."],"example":"I like to play videogames"}'),
(3, 3, 'The Structure', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + complement","example":"I like cookies"},{"title":"Negative Form","formula":"Subject + auxiliary verb + not + main verb + complement","example":"I do not like chocolate"}]}'),
(3, 4, 'The Structure - Interrogative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Auxiliary verb + subject + main verb + complement","example":"Do we have class today?"},{"title":"Affirmative answer","formula":"Yes + subject + auxiliary verb","example":"Yes, we do"},{"title":"Negative answer","formula":"No + subject + auxiliary verb + not","example":"No, we do not"}]}'),
(3, 5, 'Conjugação - He/She/It', 'table',
 '{"heading":"Important","subheading":"The verb form changes according to the subject","headers":["Subject","Verb form","Examples"],"rows":[["I","infinitive form","work"],["You","infinitive form","work"],["He/She/It","infinitive form + s/es/ies","works"],["We","infinitive form","work"],["You","infinitive form","work"],["They","infinitive form","work"]]}'),
(3, 6, 'Verbs - Regras de conjugação', 'theory',
 '{"heading":"Verbs","rules":[{"rule":"Ending in -o, -z, -ss, -ch, -sh, -x: add -es","examples":["to teach > teaches","to kiss > kisses","to go > goes"]},{"rule":"Ending in -y after a consonant: remove -y and add -ies","examples":["to fly > flies","to study > studies","to worry > worries"]},{"rule":"Ending in -y after a vowel: add -s","examples":["to say > says","to play > plays"]}]}'),
(3, 7, 'Contractions', 'examples',
 '{"heading":"Contractions","contractions":[{"full":"Do + not","short":"Don'\''t","example":"I don'\''t go to the gym"},{"full":"Does + not","short":"Doesn'\''t","example":"He doesn'\''t eat sushi"}]}'),
(3, 8, 'Vamos Praticar!', 'practice',
 '{"heading":"Let'\''s Practice!","activities":[{"number":1,"text":"Talk about your interests"},{"number":2,"text":"Ask about the other person"},{"number":3,"text":"Identify similarities between your interests and talk about that"}]}');

-- SLIDES - Lição 4: Simple Past
INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(4, 1, 'Simple Past', 'intro',
 '{"heading":"Simple Past","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 4"}'),
(4, 2, 'What is Simple Past?', 'theory',
 '{"heading":"What is Simple Past?","points":["O simple past é equivalente ao passado simples do português.","O simple past é usado para indicar ações já concluídas, ou seja, para falar de fatos que já aconteceram (começaram e terminaram no passado)."]}'),
(4, 3, 'Expressões Temporais', 'theory',
 '{"heading":"Expressões Temporais","description":"Para reforçar o uso do simple past, muitas expressões temporais são utilizadas nas frases.","words":[{"en":"yesterday","pt":"ontem"},{"en":"the day before yesterday","pt":"anteontem"},{"en":"last night","pt":"ontem à noite"},{"en":"last year","pt":"ano passado"},{"en":"last month","pt":"mês passado"},{"en":"last week","pt":"semana passada"},{"en":"ago","pt":"atrás"}],"example":"We did not work yesterday"}'),
(4, 4, 'The Structure - Affirmative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + d/ed/ied + complement","example":"I liked cookies","note":"Verbos irregulares não possuem um padrão de formação. Eles possuem uma forma própria."}]}'),
(4, 5, 'Verbos Regulares - Parte 1', 'theory',
 '{"heading":"Verbos Regulares","rules":[{"number":1,"rule":"Terminados em -e: acrescenta-se -d no final","examples":["to love > loved","to lie > lied"]},{"number":2,"rule":"Terminados em consoante + vogal + consoante: duplica-se a última consoante e acrescenta-se -ed","examples":["to stop > stopped","to control > controlled"]}]}'),
(4, 6, 'Verbos Regulares - Parte 2', 'theory',
 '{"heading":"Verbos Regulares","rules":[{"number":3,"rule":"Terminados em -y precedido de consoante: retira-se o -y e acrescenta-se -ied no final","examples":["to study > studied","to try > tried"]},{"number":4,"rule":"Terminados em -y precedido de vogal: acrescenta-se o -ed no final","examples":["to enjoy > enjoyed","to play > played"]}]}'),
(4, 7, 'Verbos Irregulares - Parte 1', 'table',
 '{"heading":"Verbos Irregulares","pairs":[["to be","was"],["to become","became"],["to begin","began"],["to break","broke"],["to bring","brought"],["to build","built"],["to buy","bought"],["to choose","chose"],["to come","came"],["to do","did"],["to drink","drank"],["to drive","drove"],["to eat","ate"],["to feed","fed"],["to feel","felt"],["to find","found"],["to forbid","forbade"],["to forget","forgot"],["to get","got"],["to give","gave"],["to go","went"],["to have","had"],["to hear","heard"],["to hide","hid"],["to keep","kept"],["to know","knew"],["to lead","led"]]}'),
(4, 8, 'Verbos Irregulares - Parte 2', 'table',
 '{"heading":"Verbos Irregulares","pairs":[["to lose","lost"],["to make","made"],["to mean","meant"],["to meet","met"],["to pay","paid"],["to put","put"],["to read","read"],["to ride","rode"],["to run","ran"],["to say","said"],["to see","saw"],["to sell","sold"],["to send","sent"],["to sleep","slept"],["to speak","spoke"],["to take","took"],["to tell","told"],["to think","thought"],["to wake","woke"],["to win","won"],["to write","wrote"]]}'),
(4, 9, 'The Structure - Negative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Negative form","formula":"Subject + did + not + main verb + complement","example":"She did not like the restaurant","note":"Atenção! O verbo auxiliar faz o trabalho pelo verbo principal: o auxiliar no passado e o principal na forma infinitiva (sem o to)."}]}'),
(4, 10, 'The Structure - Interrogative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Did + subject + main verb + complement","example":"Did she like the restaurant?"}]}'),
(4, 11, 'Contractions', 'examples',
 '{"heading":"Contractions","contractions":[{"full":"Did + not","short":"didn'\''t","example":"She didn'\''t like the restaurant"}]}'),
(4, 12, 'Vamos Praticar!', 'practice',
 '{"heading":"Let'\''s Practice!","activities":[{"number":1,"text":"Identify the past of some words"},{"number":2,"text":"Talk about what you did yesterday"},{"number":3,"text":"Try to have a quick conversation"}]}');

-- VOCABULÁRIO - Verbos Irregulares (Lesson 4)
INSERT INTO Words (WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
('was/were', 'era/estava', '/wɒz/ /wɜː/', 'verb', 'She was happy yesterday.', 'Ela estava feliz ontem.'),
('became', 'tornou-se', '/bɪˈkeɪm/', 'verb', 'He became a doctor.', 'Ele se tornou médico.'),
('began', 'começou', '/bɪˈɡæn/', 'verb', 'She began to study.', 'Ela começou a estudar.'),
('broke', 'quebrou', '/brəʊk/', 'verb', 'He broke the glass.', 'Ele quebrou o copo.'),
('brought', 'trouxe', '/brɔːt/', 'verb', 'She brought flowers.', 'Ela trouxe flores.'),
('built', 'construiu', '/bɪlt/', 'verb', 'They built a house.', 'Eles construíram uma casa.'),
('bought', 'comprou', '/bɔːt/', 'verb', 'I bought a new car.', 'Eu comprei um carro novo.'),
('came', 'veio', '/keɪm/', 'verb', 'She came early.', 'Ela chegou cedo.'),
('did', 'fez', '/dɪd/', 'verb', 'He did his homework.', 'Ele fez a lição de casa.'),
('drank', 'bebeu', '/dræŋk/', 'verb', 'She drank the water.', 'Ela bebeu a água.'),
('drove', 'dirigiu', '/drəʊv/', 'verb', 'He drove to work.', 'Ele dirigiu até o trabalho.'),
('ate', 'comeu', '/eɪt/', 'verb', 'They ate pizza.', 'Eles comeram pizza.'),
('felt', 'sentiu', '/felt/', 'verb', 'She felt tired.', 'Ela se sentiu cansada.'),
('found', 'encontrou', '/faʊnd/', 'verb', 'He found the keys.', 'Ele encontrou as chaves.'),
('forgot', 'esqueceu', '/fəˈɡɒt/', 'verb', 'She forgot her bag.', 'Ela esqueceu a bolsa.'),
('got', 'obteve/ficou', '/ɡɒt/', 'verb', 'He got a promotion.', 'Ele conseguiu uma promoção.'),
('gave', 'deu', '/ɡeɪv/', 'verb', 'She gave a gift.', 'Ela deu um presente.'),
('went', 'foi', '/went/', 'verb', 'They went to the park.', 'Eles foram ao parque.'),
('had', 'tinha/teve', '/hæd/', 'verb', 'She had breakfast.', 'Ela tomou café da manhã.'),
('heard', 'ouviu', '/hɜːd/', 'verb', 'He heard the news.', 'Ele ouviu a notícia.'),
('kept', 'manteve', '/kept/', 'verb', 'She kept the secret.', 'Ela guardou o segredo.'),
('knew', 'sabia', '/njuː/', 'verb', 'He knew the answer.', 'Ele sabia a resposta.'),
('lost', 'perdeu', '/lɒst/', 'verb', 'She lost her wallet.', 'Ela perdeu a carteira.'),
('made', 'fez/fabricou', '/meɪd/', 'verb', 'He made a cake.', 'Ele fez um bolo.'),
('met', 'conheceu/encontrou', '/met/', 'verb', 'They met at school.', 'Eles se conheceram na escola.'),
('ran', 'correu', '/ræn/', 'verb', 'She ran in the park.', 'Ela correu no parque.'),
('said', 'disse', '/sed/', 'verb', 'He said hello.', 'Ele disse olá.'),
('saw', 'viu', '/sɔː/', 'verb', 'She saw a movie.', 'Ela viu um filme.'),
('spoke', 'falou', '/spəʊk/', 'verb', 'He spoke in English.', 'Ele falou em inglês.'),
('took', 'pegou/levou', '/tʊk/', 'verb', 'She took a photo.', 'Ela tirou uma foto.'),
('wrote', 'escreveu', '/rəʊt/', 'verb', 'He wrote a letter.', 'Ele escreveu uma carta.'),
-- Expressões Temporais
('yesterday', 'ontem', '/ˈjestədeɪ/', 'expression', 'I worked yesterday.', 'Eu trabalhei ontem.'),
('last night', 'ontem à noite', '/lɑːst naɪt/', 'expression', 'She studied last night.', 'Ela estudou ontem à noite.'),
('last week', 'semana passada', '/lɑːst wiːk/', 'expression', 'We met last week.', 'Nos encontramos semana passada.'),
('last month', 'mês passado', '/lɑːst mʌnθ/', 'expression', 'He traveled last month.', 'Ele viajou mês passado.'),
('last year', 'ano passado', '/lɑːst jɪr/', 'expression', 'They moved last year.', 'Eles se mudaram ano passado.'),
('ago', 'atrás', '/əˈɡəʊ/', 'expression', 'She called two hours ago.', 'Ela ligou duas horas atrás.');

-- Vincular palavras à Lição 4
INSERT INTO LessonWords (LessonId, WordId)
SELECT 4, WordId FROM Words;

-- EXERCÍCIOS - Lição 1: Verb to Be
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(1, 'multiple_choice',
 'Which form of "to be" is correct for "I" in the Simple Present?',
 'am',
 '["am","is","are","were"]',
 'Para o sujeito "I" no Simple Present, usamos "am". Ex: I am happy.',
 1),
(1, 'multiple_choice',
 'Choose the correct sentence:',
 'She is a teacher.',
 '["She am a teacher.","She is a teacher.","She are a teacher.","She be a teacher."]',
 'He/She/It usa "is" no Simple Present.',
 2),
(1, 'fill_blank',
 'Complete: They ___ students.',
 'are',
 NULL,
 'Para "They" (e We, You), usamos "are" no Simple Present.',
 3),
(1, 'multiple_choice',
 'What is the past form of "is"?',
 'was',
 '["was","were","be","been"]',
 'I/He/She/It → was no Simple Past. We/You/They → were.',
 4);

-- EXERCÍCIOS - Lição 3: Simple Present
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(3, 'multiple_choice',
 'She ___ to school every day.',
 'goes',
 '["go","goes","going","gone"]',
 'Com He/She/It, verbos terminados em -o recebem -es: go → goes.',
 1),
(3, 'multiple_choice',
 'Which is the correct NEGATIVE form?',
 'He does not like coffee.',
 '["He not like coffee.","He does not like coffee.","He do not likes coffee.","He doesn''t likes coffee."]',
 'Na forma negativa com He/She/It: does + not + verbo na forma base.',
 2),
(3, 'fill_blank',
 'Complete: She ___ (study) English every morning.',
 'studies',
 NULL,
 'study → estudar. Com She, remova o -y e adicione -ies: studies.',
 3),
(3, 'multiple_choice',
 'I ___ like chocolate.',
 'do not',
 '["not","does not","do not","am not"]',
 'Com I/You/We/They, a forma negativa é: do + not.',
 4),
(3, 'multiple_choice',
 '___ he work on weekends?',
 'Does',
 '["Do","Does","Is","Has"]',
 'Na forma interrogativa com He/She/It, usamos "Does" no início.',
 5);

-- EXERCÍCIOS - Lição 4: Simple Past
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(4, 'identify_past',
 'What is the Simple Past of "go"?',
 'went',
 '["goed","went","gone","going"]',
 '"go" é irregular: go → went. Não siga a regra do -ed!',
 1),
(4, 'identify_past',
 'What is the Simple Past of "study"?',
 'studied',
 '["studyed","studied","studid","studed"]',
 'study termina em -y precedido de consoante: remove -y, adiciona -ied.',
 2),
(4, 'multiple_choice',
 'She ___ not work yesterday.',
 'did',
 '["was","did","does","had"]',
 'Na forma negativa do Simple Past, usamos "did not" + verbo na forma base.',
 3),
(4, 'multiple_choice',
 '___ you eat sushi last night?',
 'Did',
 '["Were","Did","Do","Have"]',
 'Na interrogativa do Simple Past, "Did" vai para o início.',
 4),
(4, 'identify_past',
 'What is the Simple Past of "stop"?',
 'stopped',
 '["stoped","stopped","stopd","stoping"]',
 'Consoante + vogal + consoante → dobra a última consoante + -ed: stop → stopped.',
 5),
(4, 'identify_past',
 'What is the Simple Past of "buy"?',
 'bought',
 '["buyed","boughted","bought","buied"]',
 '"buy" é irregular: buy → bought.',
 6),
(4, 'translation',
 'Traduza para o inglês: "Ela viu um filme ontem."',
 'She saw a movie yesterday.',
 NULL,
 'saw = Simple Past de "see". Lembre da expressão temporal: yesterday.',
 7);

PRINT 'Schema e seed data criados com sucesso!';
GO
