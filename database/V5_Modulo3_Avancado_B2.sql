-- ============================================================
-- LearnEnglish - Migration V5
-- Modulo 3 - Avancado (B2) - Licoes 25-36
-- Teacher Katrine Riccaldoni  |  Curriculo CEFR
-- ContentType: intro | theory | table | examples | practice | closing
-- ExerciseType: multiple_choice | fill_blank | identify_past | translation | pronunciation
-- ============================================================
USE learnenglish;
GO

-- ==========================================================
-- LESSON 25: Present Perfect Continuous  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 25, N'Present Perfect Continuous', N'Present Perfect Continuous', N'(B2) Enfatizar a duracao de acoes que continuam ou acabaram de terminar, com have/has been + -ing.', 25);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Present Perfect Continuous', N'intro', N'{"heading":"Present Perfect Continuous","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 25"}'),
(@L, 2, N'What is it?', N'theory', N'{"heading":"Focus on Duration","points":["Usado para acoes que comecaram no passado e continuam ate agora (ou acabaram de parar).","Estrutura: have/has + been + verbo-ing.","Enfatiza quanto tempo, nao quantas vezes."],"example":"I have been studying for two hours"}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative","formula":"Subject + have/has + been + verb-ing","examples":["She has been working all day","We have been waiting"]},{"title":"Question","formula":"How long + have/has + subject + been + -ing?","examples":["How long have you been learning English?"]}]}'),
(@L, 4, N'Perfect vs Perfect Continuous', N'table', N'{"heading":"Comparison","headers":["","Present Perfect","Present Perfect Cont."],"rows":[["Foco","resultado/quantidade","duracao/processo"],["Exemplo","I have read 3 books","I have been reading all day"]]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Say how long you have been doing something"},{"number":2,"text":"Explain a visible result (I''m tired because I have been running)"},{"number":3,"text":"Ask: How long have you been...?"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I ___ for two hours. I''m tired.', N'have been working', N'["work","worked","have been working","am working"]', N'Acao continua ate agora + duracao: have been + -ing.', 1),
(@L, N'multiple_choice', N'How long ___ you been learning English?', N'have', N'["did","have","has","are"]', N'you -> have been.', 2),
(@L, N'fill_blank', N'Complete: She ___ (cook) since morning.', N'has been cooking', NULL, N'She -> has been + cooking (acao continua).', 3),
(@L, N'multiple_choice', N'Choose the duration form:', N'It has been raining all day.', N'["It has rained three times.","It has been raining all day.","It rains a lot.","It rained yesterday."]', N'Duracao continua -> has been raining.', 4),
(@L, N'translation', N'Traduza: ''Eu estou estudando ingles ha dois anos.''', N'I have been studying English for two years.', NULL, N'have been + studying + for + periodo.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'been', N'estado/sido', N'/bin/', N'verb', N'I have been busy.', N'Eu tenho estado ocupado.'),
(@W2, N'wait', N'esperar', N'/weit/', N'verb', N'I have been waiting.', N'Eu estou esperando.'),
(@W3, N'all day', N'o dia todo', N'/ol dei/', N'phrase', N'I worked all day.', N'Trabalhei o dia todo.'),
(@W4, N'lately', N'ultimamente', N'/''leitli/', N'adverb', N'I''ve been tired lately.', N'Tenho estado cansado ultimamente.'),
(@W5, N'recently', N'recentemente', N'/''risentli/', N'adverb', N'Recently I''ve been busy.', N'Recentemente tenho estado ocupado.'),
(@W6, N'duration', N'duracao', N'/dju''reishen/', N'noun', N'The duration is long.', N'A duracao e longa.'),
(@W7, N'tired', N'cansado', N'/''taierd/', N'adjective', N'I''m tired.', N'Estou cansado.'),
(@W8, N'process', N'processo', N'/''prouses/', N'noun', N'A slow process.', N'Um processo lento.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 26: Past Perfect  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 26, N'Past Perfect', N'Past Perfect', N'(B2) Ordenar eventos no passado (o que aconteceu antes) com had + participio e past perfect continuous.', 26);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Past Perfect', N'intro', N'{"heading":"Past Perfect","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 26"}'),
(@L, 2, N'The Past Before the Past', N'theory', N'{"heading":"What is Past Perfect?","points":["Indica uma acao que aconteceu ANTES de outra acao no passado.","Estrutura: had + past participle.","Muito usado com before, after, by the time, already."],"example":"When I arrived, she had already left"}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative","formula":"Subject + had + past participle","examples":["I had finished before he came","They had eaten"]},{"title":"Continuous","formula":"Subject + had been + verb-ing","examples":["I had been waiting for an hour"]}]}'),
(@L, 4, N'Sequence of Events', N'table', N'{"heading":"Ordering Two Past Actions","headers":["1a acao (antes)","2a acao (depois)"],"rows":[["had + participle","simple past"],["She had cooked","when we arrived"]]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Tell a short story ordering two past events"},{"number":2,"text":"Use ''by the time'' + past perfect"},{"number":3,"text":"Explain a cause: I was tired because I had worked"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'When I arrived, the train ___ already left.', N'had', N'["has","had","have","was"]', N'Acao anterior a outra no passado: had + participio.', 1),
(@L, N'multiple_choice', N'She ___ before we got there.', N'had eaten', N'["eats","has eaten","had eaten","eating"]', N'Past perfect: had + eaten.', 2),
(@L, N'fill_blank', N'Complete: By the time he called, I ___ (finish) dinner.', N'had finished', NULL, N'had + finished (acao concluida antes da outra).', 3),
(@L, N'multiple_choice', N'I was tired because I ___ all day.', N'had been working', N'["work","had been working","am working","have worked"]', N'Past perfect continuous: had been + -ing.', 4),
(@L, N'translation', N'Traduza: ''Quando cheguei, ela ja tinha saido.''', N'When I arrived, she had already left.', NULL, N'had already + left (past participle).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'had', N'tinha', N'/haed/', N'verb', N'I had left.', N'Eu tinha saido.'),
(@W2, N'already', N'ja', N'/ol''redi/', N'adverb', N'She had already gone.', N'Ela ja tinha ido.'),
(@W3, N'before', N'antes', N'/bi''for/', N'preposition', N'Before he came.', N'Antes de ele vir.'),
(@W4, N'after', N'depois', N'/''aefter/', N'preposition', N'After we left.', N'Depois que saimos.'),
(@W5, N'by the time', N'quando/ate que', N'/bai dhe taim/', N'phrase', N'By the time I arrived...', N'Quando eu cheguei...'),
(@W6, N'leave', N'sair/partir', N'/liv/', N'verb', N'She left early.', N'Ela saiu cedo.'),
(@W7, N'arrive', N'chegar', N'/e''raiv/', N'verb', N'We arrived late.', N'Chegamos tarde.'),
(@W8, N'event', N'evento', N'/i''vent/', N'noun', N'A past event.', N'Um evento passado.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 27: Second & Third Conditionals  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 27, N'Second & Third Conditionals', N'Conditionals', N'(B2) Falar de situacoes irreais no presente (2o) e no passado (3o), e arrependimentos.', 27);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Second & Third Conditionals', N'intro', N'{"heading":"2nd & 3rd Conditionals","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 27"}'),
(@L, 2, N'Second Conditional', N'examples', N'{"heading":"Unreal Present/Future","sections":[{"title":"Estrutura","formula":"If + past simple, would + verb","examples":["If I had money, I would travel","If I were you, I would study"]}]}'),
(@L, 3, N'Third Conditional', N'examples', N'{"heading":"Unreal Past (regret)","sections":[{"title":"Estrutura","formula":"If + past perfect, would have + past participle","examples":["If I had studied, I would have passed","If she had called, I would have helped"]}]}'),
(@L, 4, N'Comparison', N'table', N'{"heading":"2nd x 3rd","headers":["","2nd (presente irreal)","3rd (passado irreal)"],"rows":[["If clause","past simple","past perfect"],["Result","would + verb","would have + participle"],["Exemplo","If I were rich...","If I had been rich..."]]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Give advice with ''If I were you...''"},{"number":2,"text":"Make 3 second-conditional dreams"},{"number":3,"text":"Rewrite a regret using the third conditional"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'If I ___ rich, I would travel the world.', N'were', N'["am","was","were","will be"]', N'2o condicional usa ''were'' para todos os sujeitos (If I were).', 1),
(@L, N'multiple_choice', N'If she had studied, she ___ the exam.', N'would have passed', N'["would pass","will pass","would have passed","passed"]', N'3o condicional: would have + participio.', 2),
(@L, N'fill_blank', N'Complete: If I had known, I ___ (come) earlier.', N'would have come', NULL, N'3o condicional: would have + come.', 3),
(@L, N'multiple_choice', N'If I had time, I ___ help you. (presente irreal)', N'would', N'["will","would","would have","had"]', N'2o condicional: would + verbo base.', 4),
(@L, N'translation', N'Traduza: ''Se eu fosse voce, eu estudaria mais.''', N'If I were you, I would study more.', NULL, N'If I were you = se eu fosse voce (conselho).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'would', N'ia/iria', N'/wud/', N'modal', N'I would help.', N'Eu ajudaria.'),
(@W2, N'rich', N'rico', N'/ritch/', N'adjective', N'If I were rich...', N'Se eu fosse rico...'),
(@W3, N'dream', N'sonho/sonhar', N'/drim/', N'noun', N'A big dream.', N'Um grande sonho.'),
(@W4, N'regret', N'arrependimento', N'/ri''gret/', N'noun', N'I have no regrets.', N'Nao tenho arrependimentos.'),
(@W5, N'imagine', N'imaginar', N'/i''maedjin/', N'verb', N'Imagine that.', N'Imagine isso.'),
(@W6, N'known', N'sabido', N'/noun/', N'verb', N'If I had known.', N'Se eu soubesse.'),
(@W7, N'pass', N'passar', N'/paes/', N'verb', N'I would have passed.', N'Eu teria passado.'),
(@W8, N'world', N'mundo', N'/werld/', N'noun', N'Travel the world.', N'Viajar pelo mundo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 28: Passive Voice  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 28, N'Passive Voice', N'Passive Voice', N'(B2) Focar na acao ou no objeto, nao em quem faz, com be + participio.', 28);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Passive Voice', N'intro', N'{"heading":"Passive Voice","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 28"}'),
(@L, 2, N'Active vs Passive', N'theory', N'{"heading":"What is the Passive?","points":["Na voz passiva, o foco esta no objeto/acao, nao em quem faz.","Estrutura: be (no tempo certo) + past participle.","Quem faz a acao (o agente) entra com ''by'', se necessario."],"example":"The book was written by Machado"}'),
(@L, 3, N'Passive in Different Tenses', N'table', N'{"heading":"Tenses","headers":["Tense","Passive"],"rows":[["Present","is/are + participle (is made)"],["Past","was/were + participle (was made)"],["Future","will be + participle (will be made)"],["Perfect","has been + participle (has been made)"]]}'),
(@L, 4, N'Active -> Passive', N'examples', N'{"heading":"Transformation","sections":[{"title":"Active","formula":"Subject + verb + object","examples":["They build houses"]},{"title":"Passive","formula":"Object + be + participle (+ by agent)","examples":["Houses are built (by them)"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Describe how a product is made (process)"},{"number":2,"text":"Transform 3 active sentences into passive"},{"number":3,"text":"Rewrite a news headline in the passive"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'The house ___ in 1990.', N'was built', N'["built","was built","is build","has build"]', N'Passiva no passado: was + built (participio).', 1),
(@L, N'multiple_choice', N'English ___ all over the world.', N'is spoken', N'["speaks","is speak","is spoken","spoke"]', N'Passiva no presente: is + spoken.', 2),
(@L, N'fill_blank', N'Passive: ''They will finish the project.'' -> The project ___ ___ ___.', N'will be finished', NULL, N'Futuro passivo: will be + finished.', 3),
(@L, N'multiple_choice', N'Who introduces the agent in passive voice?', N'by', N'["from","with","by","of"]', N'O agente entra com ''by'': written by...', 4),
(@L, N'translation', N'Traduza: ''O bolo foi feito pela minha mae.''', N'The cake was made by my mother.', NULL, N'was made by = foi feito por (passiva no passado).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'made', N'feito', N'/meid/', N'verb', N'Made in Brazil.', N'Feito no Brasil.'),
(@W2, N'built', N'construido', N'/bilt/', N'verb', N'It was built here.', N'Foi construido aqui.'),
(@W3, N'written', N'escrito', N'/''riten/', N'verb', N'Written by him.', N'Escrito por ele.'),
(@W4, N'spoken', N'falado', N'/''spouken/', N'verb', N'English is spoken.', N'Ingles e falado.'),
(@W5, N'agent', N'agente', N'/''eidjent/', N'noun', N'The agent of the action.', N'O agente da acao.'),
(@W6, N'product', N'produto', N'/''prod^kt/', N'noun', N'A new product.', N'Um novo produto.'),
(@W7, N'headline', N'manchete', N'/''hedlain/', N'noun', N'Read the headline.', N'Leia a manchete.'),
(@W8, N'cake', N'bolo', N'/keik/', N'noun', N'A chocolate cake.', N'Um bolo de chocolate.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 29: Reported Speech  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 29, N'Reported Speech', N'Reported Speech', N'(B2) Relatar o que outra pessoa disse ou perguntou, com recuo verbal (backshift).', 29);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Reported Speech', N'intro', N'{"heading":"Reported Speech","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 29"}'),
(@L, 2, N'Direct vs Reported', N'theory', N'{"heading":"What changes?","points":["Direct: He said, ''I am tired.'' Reported: He said (that) he was tired.","O verbo recua um tempo (backshift): present -> past, will -> would, etc.","Pronomes e expressoes de tempo tambem mudam."]}'),
(@L, 3, N'Backshift Table', N'table', N'{"heading":"Tense Changes","headers":["Direct","Reported"],"rows":[["present simple","past simple"],["present continuous","past continuous"],["past simple","past perfect"],["will","would"],["can","could"]]}'),
(@L, 4, N'say / tell / ask', N'examples', N'{"heading":"Reporting Verbs","sections":[{"title":"say (sem objeto)","formula":"say (that)","examples":["She said that she was busy"]},{"title":"tell (+ objeto)","formula":"tell + someone (that)","examples":["She told me that she was busy"]},{"title":"ask (perguntas)","formula":"ask (if/wh-)","examples":["He asked if I was ready"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Report what a friend told you today"},{"number":2,"text":"Transform 3 direct sentences into reported speech"},{"number":3,"text":"Report a question using ''asked if''"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Direct: ''I am happy.'' Reported: She said she ___ happy.', N'was', N'["is","was","were","will be"]', N'Backshift: present (am) -> past (was).', 1),
(@L, N'multiple_choice', N'Choose: He ___ me that he was tired.', N'told', N'["said","told","asked","say"]', N'tell + objeto (me): told me.', 2),
(@L, N'fill_blank', N'Direct: ''I will call you.'' Reported: She said she ___ call me.', N'would', NULL, N'Backshift: will -> would.', 3),
(@L, N'multiple_choice', N'Report a question: He asked ___ I was ready.', N'if', N'["that","if","what","to"]', N'Perguntas sim/nao no reported: ask + if.', 4),
(@L, N'translation', N'Traduza: ''Ela disse que estava cansada.''', N'She said (that) she was tired.', NULL, N'said (that) + backshift (was).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'say', N'dizer', N'/sei/', N'verb', N'She said hello.', N'Ela disse ola.'),
(@W2, N'tell', N'contar/dizer', N'/tel/', N'verb', N'Tell me a story.', N'Conte-me uma historia.'),
(@W3, N'ask', N'perguntar', N'/aesk/', N'verb', N'She asked a question.', N'Ela fez uma pergunta.'),
(@W4, N'claim', N'afirmar', N'/kleim/', N'verb', N'He claimed it was true.', N'Ele afirmou que era verdade.'),
(@W5, N'admit', N'admitir', N'/ed''mit/', N'verb', N'She admitted the mistake.', N'Ela admitiu o erro.'),
(@W6, N'suggest', N'sugerir', N'/se''djest/', N'verb', N'I suggest leaving now.', N'Eu sugiro sair agora.'),
(@W7, N'warn', N'avisar/alertar', N'/worn/', N'verb', N'He warned me.', N'Ele me avisou.'),
(@W8, N'ready', N'pronto', N'/''redi/', N'adjective', N'Are you ready?', N'Voce esta pronto?');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 30: Modals of Deduction & Probability  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 30, N'Modals of Deduction & Probability', N'Modals of Deduction', N'(B2) Especular e tirar conclusoes com graus de certeza: must, might, could, can''t (be / have).', 30);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Modals of Deduction', N'intro', N'{"heading":"Modals of Deduction","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 30"}'),
(@L, 2, N'Degrees of Certainty', N'table', N'{"heading":"Present Deduction","headers":["Modal","Certeza"],"rows":[["must be","quase certo (positivo)"],["might/could/may be","talvez/possivel"],["can''t be","quase certo (negativo)"]]}'),
(@L, 3, N'Present Examples', N'examples', N'{"heading":"Speculating about now","sections":[{"title":"Estrutura","formula":"Subject + modal + be/verb","examples":["She must be tired","He might be at home","That can''t be true"]}]}'),
(@L, 4, N'Past Deduction', N'examples', N'{"heading":"Speculating about the past","sections":[{"title":"Estrutura","formula":"modal + have + past participle","examples":["She must have left","He might have forgotten","They can''t have known"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Look at a photo and deduce what happened"},{"number":2,"text":"Speculate about a mystery (must/might/can''t)"},{"number":3,"text":"Explain a situation using ''must have''"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'The lights are off. They ___ be home.', N'can''t', N'["must","can''t","might","should"]', N'Quase certo que NAO -> can''t be.', 1),
(@L, N'multiple_choice', N'She''s not answering. She ___ be busy.', N'might', N'["might","can''t","mustn''t","wouldn''t"]', N'Possibilidade -> might be.', 2),
(@L, N'fill_blank', N'Past: He ___ ___ left already (quase certo).', N'must have', NULL, N'Deducao passada quase certa: must have + participio.', 3),
(@L, N'multiple_choice', N'They didn''t arrive. They ___ have missed the train.', N'might', N'["might","can''t","must not","would"]', N'Possibilidade no passado -> might have.', 4),
(@L, N'translation', N'Traduza: ''Ela deve estar cansada.''', N'She must be tired.', NULL, N'Deducao quase certa no presente: must be.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'must', N'deve (deducao)', N'/m^st/', N'modal', N'She must be tired.', N'Ela deve estar cansada.'),
(@W2, N'might', N'pode ser/talvez', N'/mait/', N'modal', N'He might come.', N'Ele talvez venha.'),
(@W3, N'could', N'poderia', N'/kud/', N'modal', N'It could be true.', N'Pode ser verdade.'),
(@W4, N'can''t', N'nao pode ser', N'/kaent/', N'modal', N'That can''t be right.', N'Isso nao pode estar certo.'),
(@W5, N'guess', N'adivinhar/supor', N'/ges/', N'verb', N'I guess so.', N'Eu suponho que sim.'),
(@W6, N'probably', N'provavelmente', N'/''probebli/', N'adverb', N'She''s probably home.', N'Ela provavelmente esta em casa.'),
(@W7, N'mystery', N'misterio', N'/''misteri/', N'noun', N'A real mystery.', N'Um verdadeiro misterio.'),
(@W8, N'forget', N'esquecer', N'/fe''get/', N'verb', N'Don''t forget.', N'Nao esqueca.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 31: Advanced Phrasal Verbs & Collocations  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 31, N'Advanced Phrasal Verbs & Collocations', N'Collocations', N'(B2) Soar mais natural com phrasal verbs de 3 partes e collocations fortes (make a decision, take responsibility).', 31);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Phrasal Verbs & Collocations', N'intro', N'{"heading":"Advanced Phrasal Verbs","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 31"}'),
(@L, 2, N'Three-part Phrasal Verbs', N'table', N'{"heading":"Verb + Particle + Preposition","headers":["Phrasal Verb","Portugues"],"rows":[["look forward to","ansiar por"],["put up with","tolerar"],["come up with","bolar/criar"],["get along with","dar-se bem com"],["run out of","ficar sem"]]}'),
(@L, 3, N'Strong Collocations', N'table', N'{"heading":"Common Collocations","headers":["Collocation","Portugues"],"rows":[["make a decision","tomar uma decisao"],["take responsibility","assumir responsabilidade"],["pay attention","prestar atencao"],["meet a deadline","cumprir um prazo"]]}'),
(@L, 4, N'Why Collocations Matter', N'theory', N'{"heading":"Sound Natural","points":["Nativos falam em ''blocos'' de palavras que combinam.","Dizemos ''make a decision'', nunca ''do a decision''.","Aprender collocations e mais eficaz que palavras isoladas."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Use 3 three-part phrasal verbs in sentences"},{"number":2,"text":"Replace formal verbs with phrasal verbs"},{"number":3,"text":"Build a collocation notebook by theme"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I''m looking ___ ___ ___ the holidays. (ansioso)', N'forward to', N'["forward to","up with","out of","along with"]', N'look forward to = ansiar por.', 1),
(@L, N'multiple_choice', N'Which is correct?', N'make a decision', N'["do a decision","make a decision","take a decision off","have decision"]', N'A collocation correta e ''make a decision''.', 2),
(@L, N'fill_blank', N'Complete: We ran ___ ___ milk. (ficamos sem)', N'out of', NULL, N'run out of = ficar sem.', 3),
(@L, N'multiple_choice', N'I can''t ___ ___ ___ his rudeness. (tolerar)', N'put up with', N'["put up with","come up with","get along with","look forward to"]', N'put up with = tolerar.', 4),
(@L, N'translation', N'Traduza: ''Voce precisa prestar atencao.''', N'You need to pay attention.', NULL, N'Collocation: pay attention = prestar atencao.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'look forward to', N'ansiar por', N'/luk ''forwed tu/', N'phrasal verb', N'I look forward to it.', N'Estou ansioso por isso.'),
(@W2, N'put up with', N'tolerar', N'/put ^p widh/', N'phrasal verb', N'I won''t put up with it.', N'Nao vou tolerar isso.'),
(@W3, N'come up with', N'bolar/criar', N'/k^m ^p widh/', N'phrasal verb', N'Come up with an idea.', N'Bole uma ideia.'),
(@W4, N'get along with', N'dar-se bem', N'/get e''long widh/', N'phrasal verb', N'I get along with her.', N'Eu me dou bem com ela.'),
(@W5, N'run out of', N'ficar sem', N'/r^n aut ev/', N'phrasal verb', N'We ran out of time.', N'Ficamos sem tempo.'),
(@W6, N'decision', N'decisao', N'/di''sijen/', N'noun', N'Make a decision.', N'Tome uma decisao.'),
(@W7, N'responsibility', N'responsabilidade', N'/risponse''biliti/', N'noun', N'Take responsibility.', N'Assuma a responsabilidade.'),
(@W8, N'deadline', N'prazo', N'/''dedlain/', N'noun', N'Meet the deadline.', N'Cumpra o prazo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 32: Wish / If only  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 32, N'Wish / If only', N'Wish', N'(B2) Expressar desejos e arrependimentos sobre o presente e o passado com wish e if only.', 32);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Wish / If only', N'intro', N'{"heading":"Wish / If only","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 32"}'),
(@L, 2, N'Three Uses of Wish', N'table', N'{"heading":"Wish + ...","headers":["Forma","Significado"],"rows":[["wish + past simple","desejo no presente (irreal)"],["wish + past perfect","arrependimento do passado"],["wish + would","irritacao / pedido de mudanca"]]}'),
(@L, 3, N'Examples', N'examples', N'{"heading":"Wishing","sections":[{"title":"Presente","formula":"I wish + past","examples":["I wish I had more time","I wish I were taller"]},{"title":"Passado","formula":"I wish + past perfect","examples":["I wish I had studied more"]},{"title":"Irritacao","formula":"I wish + would","examples":["I wish you would stop"]}]}'),
(@L, 4, N'If only', N'theory', N'{"heading":"If only (mais enfatico)","points":["''If only'' funciona como ''wish'', mas e mais forte/emotivo.","If only I had known! = Se eu ao menos soubesse!","Usa as mesmas estruturas de tempo do wish."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Write 3 present wishes (I wish I...)"},{"number":2,"text":"Write 2 past regrets (I wish I had...)"},{"number":3,"text":"React to situations with ''If only...''"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I wish I ___ more money. (presente)', N'had', N'["have","had","would have","has"]', N'wish + past simple para desejo presente: had.', 1),
(@L, N'multiple_choice', N'I wish I ___ harder for the test. (arrependimento)', N'had studied', N'["studied","study","had studied","would study"]', N'wish + past perfect = arrependimento: had studied.', 2),
(@L, N'fill_blank', N'Complete: I wish I ___ taller. (irreal presente)', N'were', NULL, N'wish + were (para todos os sujeitos).', 3),
(@L, N'multiple_choice', N'I wish you ___ stop interrupting! (irritacao)', N'would', N'["will","would","had","did"]', N'wish + would para irritacao/pedido de mudanca.', 4),
(@L, N'translation', N'Traduza: ''Eu queria ter estudado mais.''', N'I wish I had studied more.', NULL, N'wish + past perfect = arrependimento do passado.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'wish', N'desejar/queria', N'/wish/', N'verb', N'I wish I knew.', N'Eu queria saber.'),
(@W2, N'if only', N'se ao menos', N'/if ''ounli/', N'phrase', N'If only I knew!', N'Se ao menos eu soubesse!'),
(@W3, N'regret', N'arrepender-se', N'/ri''gret/', N'verb', N'I regret it.', N'Eu me arrependo disso.'),
(@W4, N'taller', N'mais alto', N'/''toler/', N'adjective', N'I wish I were taller.', N'Eu queria ser mais alto.'),
(@W5, N'interrupt', N'interromper', N'/inte''r^pt/', N'verb', N'Don''t interrupt.', N'Nao interrompa.'),
(@W6, N'stop', N'parar', N'/stop/', N'verb', N'Please stop.', N'Por favor, pare.'),
(@W7, N'emotion', N'emocao', N'/i''moushen/', N'noun', N'Strong emotion.', N'Emocao forte.'),
(@W8, N'miss', N'sentir falta', N'/mis/', N'verb', N'I miss you.', N'Sinto sua falta.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 33: Reduced & Participle Clauses  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 33, N'Reduced & Participle Clauses', N'Participle Clauses', N'(B2) Condensar frases para um estilo mais sofisticado com particípios e reducao de oracoes relativas.', 33);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Participle Clauses', N'intro', N'{"heading":"Reduced & Participle Clauses","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 33"}'),
(@L, 2, N'Present Participle (-ing)', N'examples', N'{"heading":"Active meaning","sections":[{"title":"Reducao","formula":"-ing clause = because/while/as...","examples":["Walking home, I saw an accident","Feeling tired, she went to bed"]}]}'),
(@L, 3, N'Past Participle (-ed/3rd form)', N'examples', N'{"heading":"Passive meaning","sections":[{"title":"Reducao","formula":"past participle clause","examples":["Built in 1900, the house is old","Made of gold, the ring is expensive"]}]}'),
(@L, 4, N'Reducing Relative Clauses', N'table', N'{"heading":"Shortening Sentences","headers":["Completa","Reduzida"],"rows":[["The man who is waiting","The man waiting"],["The book which was written","The book written"]]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Combine 3 pairs of sentences using -ing"},{"number":2,"text":"Rewrite a relative clause in reduced form"},{"number":3,"text":"Describe a scene using participle clauses"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'___ home, I met an old friend.', N'Walking', N'["Walked","Walking","To walk","Walk"]', N'Participio presente (-ing) com sentido ativo: Walking home...', 1),
(@L, N'multiple_choice', N'___ in 1990, the bridge is still strong.', N'Built', N'["Building","Built","Build","To build"]', N'Participio passado com sentido passivo: Built = construido.', 2),
(@L, N'fill_blank', N'Reduce: ''The woman who is sitting there'' -> The woman ___ there.', N'sitting', NULL, N'Reducao de oracao relativa ativa: who is sitting -> sitting.', 3),
(@L, N'multiple_choice', N'Reduce: ''The car which was stolen'' -> The car ___.', N'stolen', N'["stealing","stolen","steal","stole"]', N'Passiva reduzida: which was stolen -> stolen.', 4),
(@L, N'translation', N'Traduza: ''Sentindo-se cansada, ela foi dormir.''', N'Feeling tired, she went to bed.', NULL, N'Participle clause ativa: Feeling tired,...', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'walking', N'caminhando', N'/''woking/', N'verb', N'Walking fast.', N'Caminhando rapido.'),
(@W2, N'feeling', N'sentindo', N'/''filing/', N'verb', N'Feeling happy.', N'Sentindo-se feliz.'),
(@W3, N'built', N'construido', N'/bilt/', N'verb', N'Built in 1900.', N'Construido em 1900.'),
(@W4, N'bridge', N'ponte', N'/bridj/', N'noun', N'An old bridge.', N'Uma ponte antiga.'),
(@W5, N'accident', N'acidente', N'/''aeksident/', N'noun', N'A car accident.', N'Um acidente de carro.'),
(@W6, N'gold', N'ouro', N'/gould/', N'noun', N'Made of gold.', N'Feito de ouro.'),
(@W7, N'ring', N'anel', N'/ring/', N'noun', N'A gold ring.', N'Um anel de ouro.'),
(@W8, N'scene', N'cena', N'/sin/', N'noun', N'Describe the scene.', N'Descreva a cena.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 34: Discourse Markers & Cohesion  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 34, N'Discourse Markers & Cohesion', N'Discourse Markers', N'(B2) Conectar ideias com precisao em fala e escrita formais: however, therefore, moreover, nevertheless.', 34);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Discourse Markers', N'intro', N'{"heading":"Discourse Markers & Cohesion","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 34"}'),
(@L, 2, N'Linking Ideas Formally', N'table', N'{"heading":"Formal Connectors","headers":["Marker","Funcao"],"rows":[["however","contraste"],["therefore","consequencia"],["moreover / furthermore","adicao"],["nevertheless","concessao"],["in contrast","oposicao"]]}'),
(@L, 3, N'On the one hand...', N'examples', N'{"heading":"Balancing Arguments","sections":[{"title":"Dois lados","formula":"On the one hand... On the other hand...","examples":["On the one hand, it''s cheap. On the other hand, it''s slow."]}]}'),
(@L, 4, N'Punctuation Tip', N'theory', N'{"heading":"How to punctuate","points":["No inicio da frase, o marcador costuma vir com virgula: ''However, ...''.","Entre duas oracoes, use ponto e virgula: ''...; therefore, ...''.","Esses marcadores deixam o texto mais formal e coeso."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Write an argumentative paragraph (150 words)"},{"number":2,"text":"Insert connectors into a plain text"},{"number":3,"text":"Balance pros and cons with ''on the one hand''"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'It was raining; ___, we went out.', N'however', N'["therefore","however","moreover","so"]', N'Contraste -> however.', 1),
(@L, N'multiple_choice', N'He didn''t study; ___, he failed.', N'therefore', N'["however","therefore","nevertheless","moreover"]', N'Consequencia -> therefore.', 2),
(@L, N'fill_blank', N'Add an idea: The plan is cheap. ___, it is fast.', N'Moreover', NULL, N'Adicao -> Moreover/Furthermore.', 3),
(@L, N'multiple_choice', N'Which marker shows concession (still true despite)?', N'nevertheless', N'["therefore","moreover","nevertheless","so"]', N'nevertheless = no entanto/mesmo assim.', 4),
(@L, N'translation', N'Traduza: ''Estava chovendo; no entanto, sairmos.''', N'It was raining; however, we went out.', NULL, N'however = no entanto (contraste formal).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'however', N'no entanto', N'/hau''ever/', N'adverb', N'However, it''s late.', N'No entanto, esta tarde.'),
(@W2, N'therefore', N'portanto', N'/''dherfor/', N'adverb', N'Therefore, we agree.', N'Portanto, concordamos.'),
(@W3, N'moreover', N'alem disso', N'/mor''ouver/', N'adverb', N'Moreover, it''s cheap.', N'Alem disso, e barato.'),
(@W4, N'nevertheless', N'mesmo assim', N'/neverdhe''les/', N'adverb', N'Nevertheless, I agree.', N'Mesmo assim, concordo.'),
(@W5, N'furthermore', N'ademais', N'/''ferdhermor/', N'adverb', N'Furthermore, it works.', N'Ademais, funciona.'),
(@W6, N'cohesion', N'coesao', N'/kou''hijen/', N'noun', N'Text cohesion.', N'Coesao do texto.'),
(@W7, N'argument', N'argumento', N'/''argjument/', N'noun', N'A strong argument.', N'Um argumento forte.'),
(@W8, N'contrast', N'contraste', N'/''kontraest/', N'noun', N'In contrast.', N'Em contraste.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 35: Idioms & Figurative Language  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 35, N'Idioms & Figurative Language', N'Idioms', N'(B2) Entender e usar idioms comuns do ingles falado: break the ice, piece of cake, under the weather.', 35);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Idioms', N'intro', N'{"heading":"Idioms & Figurative Language","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 35"}'),
(@L, 2, N'What is an Idiom?', N'theory', N'{"heading":"Beyond Literal Meaning","points":["Idioms sao expressoes fixas cujo sentido nao e literal.","''It''s raining cats and dogs'' = chovendo muito (nao caem gatos!).","Aprender idioms ajuda a entender filmes, musicas e conversas reais."]}'),
(@L, 3, N'Common Idioms', N'table', N'{"heading":"Top Idioms","headers":["Idiom","Significado"],"rows":[["break the ice","quebrar o gelo"],["piece of cake","muito facil"],["under the weather","passando mal"],["hit the books","estudar muito"],["cost an arm and a leg","custar caro"]]}'),
(@L, 4, N'Using Idioms', N'examples', N'{"heading":"In Context","sections":[{"title":"Exemplos","formula":"idiom in a sentence","examples":["The test was a piece of cake","I''m feeling under the weather today","Let''s break the ice"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Match 10 idioms to their meanings"},{"number":2,"text":"Use 5 idioms in a short dialogue"},{"number":3,"text":"Find an idiom in a song you like"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'''It was a piece of cake'' means it was...', N'very easy', N'["very easy","very hard","delicious","expensive"]', N'piece of cake = muito facil.', 1),
(@L, N'multiple_choice', N'If you feel ''under the weather'', you are...', N'sick', N'["happy","sick","busy","rich"]', N'under the weather = passando mal.', 2),
(@L, N'fill_blank', N'Complete the idiom: Let''s break the ___.', N'ice', NULL, N'break the ice = quebrar o gelo.', 3),
(@L, N'multiple_choice', N'''It costs an arm and a leg'' means it is...', N'very expensive', N'["very cheap","very expensive","free","broken"]', N'cost an arm and a leg = custar muito caro.', 4),
(@L, N'translation', N'Traduza o sentido: ''I need to hit the books.''', N'I need to study hard.', NULL, N'hit the books = estudar muito.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'break the ice', N'quebrar o gelo', N'/breik dhe ais/', N'idiom', N'A joke can break the ice.', N'Uma piada pode quebrar o gelo.'),
(@W2, N'piece of cake', N'muito facil', N'/pis ev keik/', N'idiom', N'It was a piece of cake.', N'Foi muito facil.'),
(@W3, N'under the weather', N'passando mal', N'/''^nder dhe ''wedher/', N'idiom', N'I''m under the weather.', N'Estou passando mal.'),
(@W4, N'hit the books', N'estudar muito', N'/hit dhe buks/', N'idiom', N'Time to hit the books.', N'Hora de estudar muito.'),
(@W5, N'cost an arm and a leg', N'custar caro', N'/kost en arm/', N'idiom', N'It cost an arm and a leg.', N'Custou os olhos da cara.'),
(@W6, N'literal', N'literal', N'/''literel/', N'adjective', N'The literal meaning.', N'O sentido literal.'),
(@W7, N'meaning', N'significado', N'/''mining/', N'noun', N'The meaning is clear.', N'O significado e claro.'),
(@W8, N'expression', N'expressao', N'/ik''spreshen/', N'noun', N'A common expression.', N'Uma expressao comum.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 36: Formal vs Informal Register  (B2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 36, N'Formal vs Informal Register', N'Register', N'(B2) Adequar o ingles ao contexto: vocabulario formal x informal, polidez e estruturas indiretas.', 36);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Formal vs Informal', N'intro', N'{"heading":"Formal vs Informal Register","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 36"}'),
(@L, 2, N'Choosing the Right Register', N'theory', N'{"heading":"Why Register Matters","points":["Register = nivel de formalidade da linguagem.","Use informal com amigos; formal em e-mails de trabalho e documentos.","Palavras, contracoes e estruturas mudam conforme o contexto."]}'),
(@L, 3, N'Vocabulary: Formal x Informal', N'table', N'{"heading":"Word Choice","headers":["Informal","Formal"],"rows":[["ask for","request"],["get","receive/obtain"],["help","assist"],["buy","purchase"],["need","require"]]}'),
(@L, 4, N'Polite Structures', N'examples', N'{"heading":"Being Indirect & Polite","sections":[{"title":"Pedidos educados","formula":"Could you...? / Would you mind...?","examples":["Could you help me, please?","Would you mind opening the window?","I was wondering if you could..."]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Rewrite an informal message in a formal tone"},{"number":2,"text":"Write a formal email (request)"},{"number":3,"text":"Make 3 polite requests using ''Could you...?''"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Formal word for ''buy'':', N'purchase', N'["get","purchase","grab","take"]', N'purchase = comprar (formal).', 1),
(@L, N'multiple_choice', N'Which is the most polite request?', N'Could you help me, please?', N'["Help me.","I want help.","Could you help me, please?","Give me help now."]', N'''Could you...?'' e educado e indireto.', 2),
(@L, N'fill_blank', N'Formalize: ''Can I have more info?'' -> Could I ___ more information?', N'request', NULL, N'request = solicitar (formal).', 3),
(@L, N'multiple_choice', N'Formal word for ''help'' (verb):', N'assist', N'["assist","grab","get","fix"]', N'assist = auxiliar (formal).', 4),
(@L, N'translation', N'Traduza formalmente: ''Voce poderia me enviar o relatorio?''', N'Could you send me the report, please?', NULL, N'Could you...? + please para pedido educado.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'request', N'solicitar', N'/ri''kwest/', N'verb', N'I request your help.', N'Eu solicito sua ajuda.'),
(@W2, N'purchase', N'comprar (formal)', N'/''pertches/', N'verb', N'Purchase a ticket.', N'Compre um ingresso.'),
(@W3, N'assist', N'auxiliar', N'/e''sist/', N'verb', N'How can I assist you?', N'Como posso ajuda-lo?'),
(@W4, N'require', N'exigir/requerer', N'/ri''kwaier/', N'verb', N'This requires time.', N'Isto requer tempo.'),
(@W5, N'formal', N'formal', N'/''formel/', N'adjective', N'A formal email.', N'Um e-mail formal.'),
(@W6, N'polite', N'educado', N'/pe''lait/', N'adjective', N'Be polite.', N'Seja educado.'),
(@W7, N'report', N'relatorio', N'/ri''port/', N'noun', N'Send the report.', N'Envie o relatorio.'),
(@W8, N'context', N'contexto', N'/''kontekst/', N'noun', N'It depends on context.', N'Depende do contexto.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO
