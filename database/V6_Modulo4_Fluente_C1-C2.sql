-- ============================================================
-- LearnEnglish - Migration V6
-- Modulo 4 - Fluente (C1-C2) - Licoes 37-48
-- Teacher Katrine Riccaldoni  |  Curriculo CEFR
-- ContentType: intro | theory | table | examples | practice | closing
-- ExerciseType: multiple_choice | fill_blank | identify_past | translation | pronunciation
-- ============================================================
USE learnenglish;
GO

-- ==========================================================
-- LESSON 37: Narrative Tenses & Nuance  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 37, N'Narrative Tenses & Nuance', N'Narrative Tenses', N'(C1) Alternar tempos verbais com fluidez para narrar com precisao. used to / would / be used to / get used to.', 37);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Narrative Tenses', N'intro', N'{"heading":"Narrative Tenses & Nuance","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 37"}'),
(@L, 2, N'Telling Stories', N'theory', N'{"heading":"Combining Past Tenses","points":["Narrativas combinam Simple Past, Past Continuous e Past Perfect.","Past Continuous: cenario; Simple Past: acoes principais; Past Perfect: o que veio antes.","A fluidez vem de alternar esses tempos naturalmente."]}'),
(@L, 3, N'used to / would', N'table', N'{"heading":"Past Habits","headers":["Forma","Uso"],"rows":[["used to + verb","habito ou estado passado (I used to live...)"],["would + verb","habito passado (acoes repetidas, nao estados)"],["be used to + -ing","estar acostumado a"],["get used to + -ing","acostumar-se a"]]}'),
(@L, 4, N'Examples', N'examples', N'{"heading":"In Context","sections":[{"title":"Habitos","formula":"used to / would","examples":["I used to play football","Every summer, we would go to the beach"]},{"title":"Acostumar","formula":"be/get used to + -ing","examples":["I''m used to working late","She got used to the cold"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Tell a story mixing three past tenses"},{"number":2,"text":"Describe a childhood habit (used to / would)"},{"number":3,"text":"Say what you are used to / getting used to"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I ___ live in Rio when I was a child.', N'used to', N'["use to","used to","am used to","would have"]', N'Estado passado: used to + verbo base.', 1),
(@L, N'multiple_choice', N'I''m ___ working late; it doesn''t bother me.', N'used to', N'["use to","used to","would","get used"]', N'be used to + -ing = estar acostumado.', 2),
(@L, N'fill_blank', N'Complete: Every winter we ___ go skiing. (habito repetido)', N'would', NULL, N'would + verbo para habitos repetidos no passado.', 3),
(@L, N'multiple_choice', N'She is getting used ___ the new job.', N'to', N'["to","for","with","of"]', N'get used TO + substantivo/-ing.', 4),
(@L, N'translation', N'Traduza: ''Eu costumava jogar futebol.''', N'I used to play football.', NULL, N'used to + verbo base = costumava.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'used to', N'costumava', N'/''just tu/', N'phrase', N'I used to swim.', N'Eu costumava nadar.'),
(@W2, N'would', N'costumava (repeticao)', N'/wud/', N'modal', N'We would travel a lot.', N'Costumavamos viajar muito.'),
(@W3, N'get used to', N'acostumar-se', N'/get just tu/', N'phrase', N'Get used to it.', N'Acostume-se.'),
(@W4, N'childhood', N'infancia', N'/''tchaildhud/', N'noun', N'A happy childhood.', N'Uma infancia feliz.'),
(@W5, N'habit', N'habito', N'/''haebit/', N'noun', N'A good habit.', N'Um bom habito.'),
(@W6, N'narrative', N'narrativa', N'/''naeretiv/', N'noun', N'A clear narrative.', N'Uma narrativa clara.'),
(@W7, N'bother', N'incomodar', N'/''bodher/', N'verb', N'It doesn''t bother me.', N'Nao me incomoda.'),
(@W8, N'skiing', N'esqui', N'/''skiing/', N'noun', N'We go skiing.', N'Nos vamos esquiar.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 38: Inversion & Emphatic Structures  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 38, N'Inversion & Emphatic Structures', N'Inversion', N'(C1) Dar enfase e formalidade com inversao: Never have I..., Not only..., Had I known...', 38);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Inversion', N'intro', N'{"heading":"Inversion & Emphasis","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 38"}'),
(@L, 2, N'Negative Inversion', N'examples', N'{"heading":"Fronting Negatives","sections":[{"title":"Estrutura","formula":"Negative adverb + auxiliary + subject + verb","examples":["Never have I seen such a thing","Not only did he win, but he also broke a record","Rarely do we get such a chance"]}]}'),
(@L, 3, N'Conditional Inversion', N'examples', N'{"heading":"Formal Conditionals","sections":[{"title":"Sem ''if''","formula":"Had/Were/Should + subject...","examples":["Had I known, I would have helped","Were I you, I would accept","Should you need help, call me"]}]}'),
(@L, 4, N'Why use Inversion?', N'theory', N'{"heading":"Style & Emphasis","points":["A inversao deixa o texto formal, literario e enfatico.","Comum em discursos, redacoes e literatura.","Ao trazer o negativo para o inicio, o auxiliar vem antes do sujeito."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Rewrite 3 sentences using negative inversion"},{"number":2,"text":"Make a formal conditional with ''Had I...''"},{"number":3,"text":"Write an emphatic opening line for a speech"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Never ___ I seen such beauty.', N'have', N'["have","has","did","do"]', N'Inversao negativa: Never + have + subject + participio.', 1),
(@L, N'multiple_choice', N'___ I known, I would have come.', N'Had', N'["If","Had","Have","Did"]', N'Condicional invertido (3o): Had + subject + participio.', 2),
(@L, N'fill_blank', N'Complete: Not only ___ he sing, but he also dances. (presente)', N'does', NULL, N'Not only + does + subject + verbo base.', 3),
(@L, N'multiple_choice', N'___ you need anything, let me know. (formal)', N'Should', N'["Should","Would","Did","Have"]', N'Should + subject = condicional formal (caso voce precise).', 4),
(@L, N'translation', N'Traduza: ''Raramente vemos tal coisa.''', N'Rarely do we see such a thing.', NULL, N'Rarely + do + we + verbo (inversao enfatica).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'never', N'nunca', N'/''never/', N'adverb', N'Never have I lied.', N'Nunca menti.'),
(@W2, N'rarely', N'raramente', N'/''rerli/', N'adverb', N'Rarely do I agree.', N'Raramente concordo.'),
(@W3, N'not only', N'nao apenas', N'/not ''ounli/', N'phrase', N'Not only that.', N'Nao apenas isso.'),
(@W4, N'should', N'caso/se', N'/shud/', N'modal', N'Should you need it.', N'Caso voce precise.'),
(@W5, N'emphasis', N'enfase', N'/''emfesis/', N'noun', N'Add emphasis.', N'Adicione enfase.'),
(@W6, N'record', N'recorde', N'/''rekord/', N'noun', N'Break a record.', N'Bater um recorde.'),
(@W7, N'speech', N'discurso', N'/spitch/', N'noun', N'A great speech.', N'Um grande discurso.'),
(@W8, N'beauty', N'beleza', N'/''bjuti/', N'noun', N'Natural beauty.', N'Beleza natural.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 39: Cleft Sentences  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 39, N'Cleft Sentences', N'Cleft Sentences', N'(C1) Destacar partes especificas da informacao com It was X that... e What I... is...', 39);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Cleft Sentences', N'intro', N'{"heading":"Cleft Sentences","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 39"}'),
(@L, 2, N'It-cleft', N'examples', N'{"heading":"Highlighting with ''It''","sections":[{"title":"Estrutura","formula":"It + be + highlighted + that/who...","examples":["It was John who broke the window","It is money that they want","It was in 2020 that we met"]}]}'),
(@L, 3, N'Wh-cleft', N'examples', N'{"heading":"Highlighting with ''What''","sections":[{"title":"Estrutura","formula":"What + clause + be + highlighted","examples":["What I need is some rest","What she did was amazing","What matters is your effort"]}]}'),
(@L, 4, N'Why Clefts?', N'theory', N'{"heading":"Focus & Correction","points":["Clivadas movem o foco para a informacao mais importante.","Otimas para corrigir mal-entendidos: ''It wasn''t me who said that.''","Dao enfase sem mudar o significado basico."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Rewrite 3 sentences as it-clefts"},{"number":2,"text":"Rewrite 3 sentences as wh-clefts"},{"number":3,"text":"Correct a misunderstanding using a cleft"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'___ was John who called, not Mary.', N'It', N'["It","There","That","This"]', N'It-cleft: It + was + highlighted + who/that.', 1),
(@L, N'multiple_choice', N'___ I need is more time.', N'What', N'["That","What","It","Which"]', N'Wh-cleft: What + clause + be + ...', 2),
(@L, N'fill_blank', N'Cleft: ''I want peace.'' -> ___ I want is peace.', N'What', NULL, N'What I want is peace (foco em ''peace'').', 3),
(@L, N'multiple_choice', N'Choose the it-cleft emphasizing the place:', N'It was in Paris that we met.', N'["We met in Paris.","It was in Paris that we met.","What we met was Paris.","In Paris we met there."]', N'It was + lugar + that = enfase no lugar.', 4),
(@L, N'translation', N'Traduza: ''O que importa e o seu esforco.''', N'What matters is your effort.', NULL, N'Wh-cleft: What matters is...', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'cleft', N'clivada', N'/kleft/', N'noun', N'A cleft sentence.', N'Uma frase clivada.'),
(@W2, N'highlight', N'destacar', N'/''hailait/', N'verb', N'Highlight the key point.', N'Destaque o ponto principal.'),
(@W3, N'focus', N'foco', N'/''foukes/', N'noun', N'Shift the focus.', N'Mude o foco.'),
(@W4, N'effort', N'esforco', N'/''efert/', N'noun', N'Make an effort.', N'Faca um esforco.'),
(@W5, N'matter', N'importar', N'/''maeter/', N'verb', N'It doesn''t matter.', N'Nao importa.'),
(@W6, N'peace', N'paz', N'/pis/', N'noun', N'World peace.', N'Paz mundial.'),
(@W7, N'misunderstanding', N'mal-entendido', N'/mis^nder''staending/', N'noun', N'A small misunderstanding.', N'Um pequeno mal-entendido.'),
(@W8, N'amazing', N'incrivel', N'/e''meizing/', N'adjective', N'That''s amazing!', N'Isso e incrivel!');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 40: Advanced & Mixed Conditionals  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 40, N'Advanced & Mixed Conditionals', N'Mixed Conditionals', N'(C1) Relacoes hipoteticas complexas entre tempos: condicionais mistos e variacoes (provided, supposing, but for).', 40);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Mixed Conditionals', N'intro', N'{"heading":"Advanced & Mixed Conditionals","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 40"}'),
(@L, 2, N'Mixed Conditional 1', N'examples', N'{"heading":"Past condition -> Present result","sections":[{"title":"Estrutura","formula":"If + past perfect, would + verb (now)","examples":["If I had studied medicine, I would be a doctor now","If she had saved money, she wouldn''t be broke today"]}]}'),
(@L, 3, N'Mixed Conditional 2', N'examples', N'{"heading":"Present condition -> Past result","sections":[{"title":"Estrutura","formula":"If + past simple, would have + participle","examples":["If I were richer, I would have bought that house","If he weren''t so shy, he would have spoken"]}]}'),
(@L, 4, N'Alternative Connectors', N'table', N'{"heading":"Beyond ''if''","headers":["Connector","Significado"],"rows":[["provided that","desde que"],["supposing","supondo que"],["but for","se nao fosse por"],["otherwise","caso contrario"]]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Make a mixed conditional about your life"},{"number":2,"text":"Use ''provided that'' in a sentence"},{"number":3,"text":"Analyze a past->present consequence"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'If I had studied law, I ___ a lawyer now.', N'would be', N'["would be","would have been","will be","am"]', N'Misto: condicao passada -> resultado presente: would + be.', 1),
(@L, N'multiple_choice', N'If she ___ more careful, she wouldn''t have crashed.', N'were', N'["is","were","had been","was being"]', N'Misto: condicao presente (were) -> resultado passado (wouldn''t have).', 2),
(@L, N'fill_blank', N'Complete: ___ that you pay, you can stay. (desde que)', N'Provided', NULL, N'provided (that) = desde que.', 3),
(@L, N'multiple_choice', N'''___ your help, I would have failed.'' (se nao fosse)', N'But for', N'["But for","Provided","Supposing","Otherwise"]', N'But for = se nao fosse por.', 4),
(@L, N'translation', N'Traduza: ''Se eu tivesse estudado, eu seria medico agora.''', N'If I had studied, I would be a doctor now.', NULL, N'Condicional misto: past perfect -> would + verbo (now).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'provided that', N'desde que', N'/pre''vaidid dhaet/', N'phrase', N'Provided that you agree.', N'Desde que voce concorde.'),
(@W2, N'supposing', N'supondo que', N'/se''pouzing/', N'conjunction', N'Supposing it rains.', N'Supondo que chova.'),
(@W3, N'but for', N'se nao fosse por', N'/b^t for/', N'phrase', N'But for you...', N'Se nao fosse por voce...'),
(@W4, N'otherwise', N'caso contrario', N'/''^dherwaiz/', N'adverb', N'Hurry, otherwise we''re late.', N'Depressa, caso contrario nos atrasamos.'),
(@W5, N'lawyer', N'advogado', N'/''loier/', N'noun', N'She''s a lawyer.', N'Ela e advogada.'),
(@W6, N'careful', N'cuidadoso', N'/''kerfel/', N'adjective', N'Be careful.', N'Tenha cuidado.'),
(@W7, N'consequence', N'consequencia', N'/''konsikwens/', N'noun', N'A serious consequence.', N'Uma consequencia seria.'),
(@W8, N'broke', N'sem dinheiro', N'/brouk/', N'adjective', N'I''m broke.', N'Estou sem dinheiro.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 41: Hedging & Academic Language  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 41, N'Hedging & Academic Language', N'Academic Language', N'(C1) Matizar afirmacoes e soar preciso e cauteloso: it appears that, tends to, is likely to, nominalizacao.', 41);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Hedging', N'intro', N'{"heading":"Hedging & Academic Language","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 41"}'),
(@L, 2, N'What is Hedging?', N'theory', N'{"heading":"Cautious Language","points":["Hedging = suavizar afirmacoes para soar cauteloso e academico.","Em vez de ''This is true'', diga ''This appears to be true''.","Evita generalizacoes absolutas e mostra rigor."]}'),
(@L, 3, N'Hedging Expressions', N'table', N'{"heading":"Softening Claims","headers":["Expression","Uso"],"rows":[["it appears/seems that","parece que"],["tends to","tende a"],["is likely to","provavelmente vai"],["to some extent","ate certo ponto"],["may/might suggest","pode sugerir"]]}'),
(@L, 4, N'Nominalization', N'examples', N'{"heading":"Academic Style","sections":[{"title":"Verbo -> Substantivo","formula":"decide -> decision; analyze -> analysis","examples":["The government decided -> The government''s decision","They failed -> The failure of..."]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Soften 3 categorical statements with hedging"},{"number":2,"text":"Rewrite a sentence using nominalization"},{"number":3,"text":"Write an academic paragraph with cautious language"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Academic hedge for ''This is the cause'':', N'This may be the cause', N'["This is definitely the cause","This may be the cause","This is the only cause","This is the cause for sure"]', N'''may'' suaviza a afirmacao (hedging).', 1),
(@L, N'multiple_choice', N'People ___ to prefer comfort. (tendencia)', N'tend', N'["tend","must","have","will"]', N'tend to = tende a (hedging).', 2),
(@L, N'fill_blank', N'Nominalize: ''They decided quickly.'' -> Their quick ___.', N'decision', NULL, N'decide -> decision (nominalizacao).', 3),
(@L, N'multiple_choice', N'Which is the most cautious (academic)?', N'The results appear to suggest a link.', N'["The results prove a link.","The results appear to suggest a link.","The results show the truth.","There is a link, period."]', N'''appear to suggest'' = linguagem cautelosa academica.', 4),
(@L, N'translation', N'Traduza: ''Os dados parecem indicar uma tendencia.''', N'The data seem to indicate a trend.', NULL, N'seem to indicate = hedging academico.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'appear', N'parecer', N'/e''pir/', N'verb', N'It appears so.', N'Parece que sim.'),
(@W2, N'tend to', N'tender a', N'/tend tu/', N'phrase', N'People tend to forget.', N'As pessoas tendem a esquecer.'),
(@W3, N'likely', N'provavel', N'/''laikli/', N'adjective', N'It''s likely to rain.', N'E provavel que chova.'),
(@W4, N'suggest', N'sugerir', N'/se''djest/', N'verb', N'The data suggest...', N'Os dados sugerem...'),
(@W5, N'analysis', N'analise', N'/e''naelisis/', N'noun', N'A careful analysis.', N'Uma analise cuidadosa.'),
(@W6, N'data', N'dados', N'/''deite/', N'noun', N'The data show...', N'Os dados mostram...'),
(@W7, N'trend', N'tendencia', N'/trend/', N'noun', N'A growing trend.', N'Uma tendencia crescente.'),
(@W8, N'extent', N'ponto/medida', N'/ik''stent/', N'noun', N'To some extent.', N'Ate certo ponto.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 42: Idiomatic & Native-like Expression  (C1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 42, N'Idiomatic & Native-like Expression', N'Native Expression', N'(C1) Usar a lingua de forma natural, com idioms avancados, reducoes e fala rapida (gonna, kinda, wanna).', 42);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Native-like Expression', N'intro', N'{"heading":"Idiomatic & Native-like English","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 42"}'),
(@L, 2, N'Spoken Reductions', N'table', N'{"heading":"Fast Speech","headers":["Written","Spoken"],"rows":[["going to","gonna"],["want to","wanna"],["got to","gotta"],["kind of","kinda"],["let me","lemme"]]}'),
(@L, 3, N'Advanced Idioms', N'table', N'{"heading":"Native Idioms","headers":["Idiom","Significado"],"rows":[["get the hang of it","pegar o jeito"],["a blessing in disguise","ha males que vem para bem"],["on the same page","em sintonia"],["call it a day","encerrar por hoje"]]}'),
(@L, 4, N'Binomials', N'examples', N'{"heading":"Fixed Word Pairs","sections":[{"title":"Pares fixos","formula":"X and Y (ordem fixa)","examples":["back and forth","sooner or later","more or less","now and then"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Rewrite a formal text with natural spoken English"},{"number":2,"text":"Use 4 reductions in speech (gonna, wanna...)"},{"number":3,"text":"Understand a clip and note the idioms used"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'''Gonna'' is the spoken form of:', N'going to', N'["got to","going to","gone to","want to"]', N'gonna = going to (fala informal).', 1),
(@L, N'multiple_choice', N'''I finally got the hang of it'' means I...', N'learned how to do it', N'["gave up","learned how to do it","broke it","lost it"]', N'get the hang of it = pegar o jeito.', 2),
(@L, N'fill_blank', N'Complete the binomial: back and ___.', N'forth', NULL, N'back and forth = de la para ca (par fixo).', 3),
(@L, N'multiple_choice', N'''Let''s call it a day'' means:', N'let''s stop for today', N'["let''s start","let''s stop for today","let''s name the day","let''s celebrate"]', N'call it a day = encerrar por hoje.', 4),
(@L, N'translation', N'Traduza o sentido: ''We''re on the same page.''', N'We agree / We understand each other.', NULL, N'on the same page = em sintonia, de acordo.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'gonna', N'vou (informal)', N'/''gone/', N'slang', N'I''m gonna go.', N'Eu vou indo.'),
(@W2, N'wanna', N'quero (informal)', N'/''wone/', N'slang', N'I wanna eat.', N'Eu quero comer.'),
(@W3, N'get the hang of', N'pegar o jeito', N'/get dhe haeng ev/', N'idiom', N'I got the hang of it.', N'Eu peguei o jeito.'),
(@W4, N'blessing in disguise', N'males que vem para bem', N'/''blesing in dis''gaiz/', N'idiom', N'It was a blessing in disguise.', N'Foi um mal que veio para bem.'),
(@W5, N'on the same page', N'em sintonia', N'/on dhe seim peidj/', N'idiom', N'We''re on the same page.', N'Estamos em sintonia.'),
(@W6, N'call it a day', N'encerrar por hoje', N'/kol it e dei/', N'idiom', N'Let''s call it a day.', N'Vamos encerrar por hoje.'),
(@W7, N'back and forth', N'de la para ca', N'/baek end forth/', N'binomial', N'Going back and forth.', N'Indo e voltando.'),
(@W8, N'now and then', N'de vez em quando', N'/nau end dhen/', N'binomial', N'Now and then.', N'De vez em quando.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 43: Phonology: Connected Speech, Stress & Intonation  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 43, N'Phonology: Connected Speech, Stress & Intonation', N'Phonology', N'(C2) Refinar a pronuncia para clareza e naturalidade: linking, elisao, sentence stress e entonacao.', 43);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Phonology', N'intro', N'{"heading":"Connected Speech & Intonation","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 43"}'),
(@L, 2, N'Connected Speech', N'table', N'{"heading":"How sounds blend","headers":["Fenomeno","Exemplo"],"rows":[["Linking","an apple -> /e''naepl/"],["Elision (som perdido)","next day -> /neks dei/"],["Assimilation","did you -> /''didju/"],["Weak forms","to /te/, of /ev/, and /en/"]]}'),
(@L, 3, N'Sentence Stress', N'theory', N'{"heading":"Rhythm of English","points":["Ingles e ''stress-timed'': palavras de conteudo (verbos, substantivos) sao acentuadas.","Palavras gramaticais (artigos, preposicoes) ficam fracas e rapidas.","Ex: I WANT to GO to the BEACH (so as maiusculas sao fortes)."]}'),
(@L, 4, N'Intonation', N'examples', N'{"heading":"Meaning through pitch","sections":[{"title":"Padroes","formula":"rising / falling intonation","examples":["Yes/no questions: rising -> Are you ready?","Statements & wh-questions: falling -> Where are you?","Contrastive stress: I said BLUE, not green"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Do shadowing of a native audio clip"},{"number":2,"text":"Mark the stressed words in 3 sentences"},{"number":3,"text":"Record yourself and compare with the original"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'In connected speech, ''did you'' often sounds like:', N'didja', N'["didja","did-you","didu","dija"]', N'Assimilacao: did you -> /''didju/ (''didja'').', 1),
(@L, N'multiple_choice', N'Which words are usually stressed?', N'content words (nouns, verbs)', N'["articles","prepositions","content words (nouns, verbs)","pronouns"]', N'Ingles acentua palavras de conteudo.', 2),
(@L, N'fill_blank', N'Yes/no questions usually have ___ intonation. (subida)', N'rising', NULL, N'Perguntas sim/nao -> entonacao ascendente (rising).', 3),
(@L, N'multiple_choice', N'The weak form of ''to'' is pronounced:', N'/te/', N'["/tu/","/te/","/toh/","/tow/"]', N'Weak form: to -> /te/ na fala rapida.', 4),
(@L, N'pronunciation', N'Practice linking: say ''turn it off'' as one unit.', N'tur-ni-toff', NULL, N'Linking une as palavras: turn-it-off -> /ter''nitof/.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'linking', N'ligacao (sons)', N'/''linking/', N'noun', N'Linking sounds.', N'Ligacao de sons.'),
(@W2, N'stress', N'acento tonico', N'/stres/', N'noun', N'Word stress.', N'Acento da palavra.'),
(@W3, N'intonation', N'entonacao', N'/inte''neishen/', N'noun', N'Rising intonation.', N'Entonacao ascendente.'),
(@W4, N'rhythm', N'ritmo', N'/''ridhem/', N'noun', N'The rhythm of English.', N'O ritmo do ingles.'),
(@W5, N'pitch', N'altura (tom)', N'/pitch/', N'noun', N'High pitch.', N'Tom alto.'),
(@W6, N'weak form', N'forma fraca', N'/wik form/', N'noun', N'Weak forms are fast.', N'Formas fracas sao rapidas.'),
(@W7, N'elision', N'elisao', N'/i''lijen/', N'noun', N'Elision drops sounds.', N'A elisao perde sons.'),
(@W8, N'fluent', N'fluente', N'/''fluent/', N'adjective', N'She is fluent.', N'Ela e fluente.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 44: Advanced Collocations & Lexical Chunks  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 44, N'Advanced Collocations & Lexical Chunks', N'Lexical Chunks', N'(C2) Falar em blocos pre-fabricados como um nativo, com collocations fortes por area tematica.', 44);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Lexical Chunks', N'intro', N'{"heading":"Advanced Collocations & Chunks","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 44"}'),
(@L, 2, N'What are Chunks?', N'theory', N'{"heading":"Thinking in Blocks","points":["Nativos armazenam e produzem linguagem em ''chunks'' (blocos prontos).","Ex: ''to be honest'', ''as far as I''m concerned'', ''at the end of the day''.","Aprender chunks acelera a fluencia e soa natural."]}'),
(@L, 3, N'Strong Collocations by Theme', N'table', N'{"heading":"By Area","headers":["Area","Collocation"],"rows":[["Business","launch a product, gain market share"],["Academic","conduct research, draw a conclusion"],["Emotions","burst into tears, have mixed feelings"],["Time","waste time, save time, kill time"]]}'),
(@L, 4, N'Discourse Chunks', N'examples', N'{"heading":"Useful Fixed Phrases","sections":[{"title":"Opiniao/transicao","formula":"ready-made phrases","examples":["As far as I''m concerned...","At the end of the day...","To be honest...","It goes without saying that..."]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Build a personal chunk bank (Anki)"},{"number":2,"text":"Paraphrase a text using precise collocations"},{"number":3,"text":"Use 3 discourse chunks in a short talk"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Which is a correct collocation?', N'conduct research', N'["do research strong","conduct research","make research","build research"]', N'conduct research = realizar pesquisa (academico).', 1),
(@L, N'multiple_choice', N'Complete: launch a ___ (negocios).', N'product', N'["product","money","time","tear"]', N'launch a product = lancar um produto.', 2),
(@L, N'fill_blank', N'Chunk: As far as I''m ___, this is wrong. (concerned)', N'concerned', NULL, N'As far as I''m concerned = no que me diz respeito.', 3),
(@L, N'multiple_choice', N'''Burst into tears'' means to suddenly:', N'start crying', N'["start laughing","start crying","stop talking","fall asleep"]', N'burst into tears = cair no choro.', 4),
(@L, N'translation', N'Traduza o chunk: ''At the end of the day, it''s your choice.''', N'No fim das contas, a escolha e sua.', NULL, N'at the end of the day = no fim das contas.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'chunk', N'bloco lexical', N'/tch^nk/', N'noun', N'Learn in chunks.', N'Aprenda em blocos.'),
(@W2, N'conduct research', N'realizar pesquisa', N'/ken''d^kt ri''sertch/', N'collocation', N'We conduct research.', N'Nos realizamos pesquisa.'),
(@W3, N'launch', N'lancar', N'/lontch/', N'verb', N'Launch a product.', N'Lancar um produto.'),
(@W4, N'burst into tears', N'cair no choro', N'/berst inte tirz/', N'collocation', N'She burst into tears.', N'Ela caiu no choro.'),
(@W5, N'to be honest', N'para ser sincero', N'/tu bi ''onist/', N'chunk', N'To be honest, I disagree.', N'Para ser sincero, discordo.'),
(@W6, N'at the end of the day', N'no fim das contas', N'/et dhi end/', N'chunk', N'At the end of the day...', N'No fim das contas...'),
(@W7, N'waste time', N'perder tempo', N'/weist taim/', N'collocation', N'Don''t waste time.', N'Nao perca tempo.'),
(@W8, N'conclusion', N'conclusao', N'/ken''klujen/', N'noun', N'Draw a conclusion.', N'Tirar uma conclusao.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 45: Persuasion, Debate & Argumentation  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 45, N'Persuasion, Debate & Argumentation', N'Argumentation', N'(C2) Defender pontos de vista e debater com tecnica: concordar, discordar, conceder e refutar.', 45);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Persuasion & Debate', N'intro', N'{"heading":"Persuasion, Debate & Argumentation","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 45"}'),
(@L, 2, N'Agreeing & Disagreeing', N'table', N'{"heading":"Debate Language","headers":["Funcao","Expressao"],"rows":[["Concordar","I couldn''t agree more / You have a point"],["Discordar (educado)","I see your point, but... / I''m afraid I disagree"],["Conceder","Admittedly / Granted, ..."],["Refutar","However, the evidence shows..."]]}'),
(@L, 3, N'Structuring an Argument', N'theory', N'{"heading":"Build Your Case","points":["Apresente sua tese com clareza.","Sustente com evidencias e exemplos.","Reconheca o outro lado (concessao) e depois refute."]}'),
(@L, 4, N'Persuasive Devices', N'examples', N'{"heading":"Rhetoric","sections":[{"title":"Tecnicas","formula":"rhetorical questions, repetition, tripling","examples":["Isn''t it time we acted?","We can, we must, and we will","The evidence is clear, compelling, and undeniable"]}]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Debate a controversial topic (for and against)"},{"number":2,"text":"Concede a point, then refute it"},{"number":3,"text":"Write a persuasive opening statement"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Polite way to disagree:', N'I see your point, but...', N'["You''re wrong.","I see your point, but...","That''s stupid.","No way."]', N'Discordancia educada reconhece o outro antes do ''but''.', 1),
(@L, N'multiple_choice', N'''Admittedly'' is used to:', N'concede a point', N'["concede a point","ask a question","greet someone","end a talk"]', N'Admittedly = e verdade que (concessao).', 2),
(@L, N'fill_blank', N'Strong agreement: I couldn''t agree ___.', N'more', NULL, N'I couldn''t agree more = concordo plenamente.', 3),
(@L, N'multiple_choice', N'A rhetorical question is asked to:', N'make a point, not to get an answer', N'["get real information","make a point, not to get an answer","change topic","end the debate"]', N'Pergunta retorica persuade, nao busca resposta.', 4),
(@L, N'translation', N'Traduza: ''Reconheco o seu argumento, mas as evidencias mostram o contrario.''', N'I acknowledge your argument, but the evidence shows otherwise.', NULL, N'Concessao + refutacao com evidencia.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'argue', N'argumentar', N'/''argju/', N'verb', N'She argues well.', N'Ela argumenta bem.'),
(@W2, N'concede', N'conceder/admitir', N'/ken''sid/', N'verb', N'I concede the point.', N'Eu admito o ponto.'),
(@W3, N'refute', N'refutar', N'/ri''fjut/', N'verb', N'Refute the claim.', N'Refute a alegacao.'),
(@W4, N'evidence', N'evidencia', N'/''evidens/', N'noun', N'Strong evidence.', N'Evidencia forte.'),
(@W5, N'admittedly', N'e verdade que', N'/ed''mitidli/', N'adverb', N'Admittedly, it''s hard.', N'E verdade que e dificil.'),
(@W6, N'persuade', N'persuadir', N'/per''sweid/', N'verb', N'Persuade them.', N'Persuada-os.'),
(@W7, N'claim', N'alegacao', N'/kleim/', N'noun', N'A bold claim.', N'Uma alegacao ousada.'),
(@W8, N'otherwise', N'o contrario', N'/''^dherwaiz/', N'adverb', N'Shows otherwise.', N'Mostra o contrario.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 46: Professional & Business English  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 46, N'Professional & Business English', N'Business English', N'(C2) Atuar com confianca em contextos de trabalho: reunioes, negociacao, apresentacoes e e-mails.', 46);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Business English', N'intro', N'{"heading":"Professional & Business English","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 46"}'),
(@L, 2, N'Meetings', N'table', N'{"heading":"Meeting Language","headers":["Funcao","Expressao"],"rows":[["Abrir","Let''s get started / Shall we begin?"],["Opiniao","From my perspective..."],["Interromper","Sorry to interrupt, but..."],["Concluir","To sum up / Let''s wrap up"]]}'),
(@L, 3, N'Negotiation', N'examples', N'{"heading":"Negotiating","sections":[{"title":"Frases-chave","formula":"proposing & bargaining","examples":["Would you be willing to...?","We could offer... in return for...","Let''s meet halfway"]}]}'),
(@L, 4, N'Professional Emails', N'theory', N'{"heading":"Email Etiquette","points":["Abertura: ''Dear Mr Silva,'' / ''I hope this email finds you well.''","Corpo claro e objetivo, um assunto por paragrafo.","Fechamento: ''Best regards,'' / ''Kind regards,''"]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Run a short meeting (open, discuss, close)"},{"number":2,"text":"Negotiate a deal with a partner"},{"number":3,"text":"Write a professional email (request or proposal)"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Formal email closing:', N'Best regards,', N'["See ya,","Best regards,","Bye,","Later,"]', N'''Best regards,'' e um fechamento profissional.', 1),
(@L, N'multiple_choice', N'To summarize at the end of a meeting:', N'To sum up,', N'["By the way,","To sum up,","Whatever,","Anyway, bye"]', N'''To sum up'' resume os pontos principais.', 2),
(@L, N'fill_blank', N'Negotiation: Would you be ___ to lower the price? (disposto)', N'willing', NULL, N'be willing to = estar disposto a.', 3),
(@L, N'multiple_choice', N'Polite way to interrupt in a meeting:', N'Sorry to interrupt, but...', N'["Shut up, but...","Sorry to interrupt, but...","Listen to me!","Stop talking."]', N'Interrupcao educada e profissional.', 4),
(@L, N'translation', N'Traduza: ''Vamos fazer um meio-termo.''', N'Let''s meet halfway.', NULL, N'meet halfway = fazer um meio-termo.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'meeting', N'reuniao', N'/''miting/', N'noun', N'A team meeting.', N'Uma reuniao de equipe.'),
(@W2, N'negotiate', N'negociar', N'/ni''goushieit/', N'verb', N'Negotiate a deal.', N'Negociar um acordo.'),
(@W3, N'deal', N'acordo/negocio', N'/dil/', N'noun', N'A good deal.', N'Um bom negocio.'),
(@W4, N'proposal', N'proposta', N'/pre''pouzel/', N'noun', N'Send a proposal.', N'Envie uma proposta.'),
(@W5, N'willing', N'disposto', N'/''wiling/', N'adjective', N'I''m willing to help.', N'Estou disposto a ajudar.'),
(@W6, N'regards', N'atenciosamente', N'/ri''gardz/', N'noun', N'Best regards.', N'Atenciosamente.'),
(@W7, N'client', N'cliente', N'/''klaient/', N'noun', N'A new client.', N'Um novo cliente.'),
(@W8, N'deadline', N'prazo', N'/''dedlain/', N'noun', N'A tight deadline.', N'Um prazo apertado.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 47: Academic Writing & Critical Reading  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 47, N'Academic Writing & Critical Reading', N'Academic Writing', N'(C2) Ler com profundidade e escrever textos estruturados: tese, desenvolvimento, conclusao, citacao e parafrase.', 47);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Academic Writing', N'intro', N'{"heading":"Academic Writing & Critical Reading","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 47"}'),
(@L, 2, N'Essay Structure', N'table', N'{"heading":"Building an Essay","headers":["Parte","Funcao"],"rows":[["Introduction","contexto + tese (thesis statement)"],["Body paragraphs","um argumento por paragrafo + evidencia"],["Conclusion","retomar a tese + sintese"]]}'),
(@L, 3, N'Citing & Paraphrasing', N'examples', N'{"heading":"Using Sources","sections":[{"title":"Tecnicas","formula":"quote / paraphrase / summarize","examples":["According to Smith (2020), ...","In other words, ...","The author argues that ..."]}]}'),
(@L, 4, N'Critical Reading', N'theory', N'{"heading":"Read Between the Lines","points":["Identifique a tese e os argumentos do autor.","Distinga fato de opiniao e avalie as evidencias.","Pergunte: qual o proposito, o publico e o vies do texto?"]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Summarize and critique an article"},{"number":2,"text":"Write a thesis statement for a topic"},{"number":3,"text":"Paraphrase a paragraph in your own words"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'The thesis statement appears in the:', N'introduction', N'["conclusion","introduction","body only","references"]', N'A tese vem na introducao.', 1),
(@L, N'multiple_choice', N'To restate an idea in your own words is to:', N'paraphrase', N'["quote","paraphrase","ignore","copy"]', N'paraphrase = parafrasear.', 2),
(@L, N'fill_blank', N'Citation: ___ to Smith (2020), the data are clear. (segundo)', N'According', NULL, N'According to = segundo/de acordo com.', 3),
(@L, N'multiple_choice', N'Critical reading means you:', N'evaluate the author''s claims and evidence', N'["read fast","evaluate the author''s claims and evidence","memorize words","skip the argument"]', N'Leitura critica avalia argumentos e evidencias.', 4),
(@L, N'translation', N'Traduza: ''O autor argumenta que a tecnologia mudou a sociedade.''', N'The author argues that technology has changed society.', NULL, N'The author argues that... = o autor argumenta que...', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'thesis', N'tese', N'/''thisis/', N'noun', N'A clear thesis.', N'Uma tese clara.'),
(@W2, N'paraphrase', N'parafrasear', N'/''paerefreiz/', N'verb', N'Paraphrase the text.', N'Parafraseie o texto.'),
(@W3, N'according to', N'segundo', N'/e''kording tu/', N'phrase', N'According to him...', N'Segundo ele...'),
(@W4, N'argue', N'argumentar', N'/''argju/', N'verb', N'The author argues...', N'O autor argumenta...'),
(@W5, N'evidence', N'evidencia', N'/''evidens/', N'noun', N'Support with evidence.', N'Apoie com evidencia.'),
(@W6, N'source', N'fonte', N'/sors/', N'noun', N'A reliable source.', N'Uma fonte confiavel.'),
(@W7, N'summarize', N'resumir', N'/''s^meraiz/', N'verb', N'Summarize the article.', N'Resuma o artigo.'),
(@W8, N'bias', N'vies', N'/''baies/', N'noun', N'Check for bias.', N'Verifique o vies.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 48: Mastery: Spontaneous & Cultural Fluency  (C2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 48, N'Mastery: Spontaneous & Cultural Fluency', N'Fluency Mastery', N'(C2) Comunicar-se sem esforco, com naturalidade e nuance cultural: humor, ironia, eufemismo e sotaques.', 48);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Mastery', N'intro', N'{"heading":"Spontaneous & Cultural Fluency","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 48"}'),
(@L, 2, N'Spontaneous Fluency', N'theory', N'{"heading":"Speaking without Effort","points":["No nivel de maestria, o foco esta na mensagem, nao na forma.","Voce se autocorrige naturalmente e reformula com facilidade.","A hesitacao e preenchida com fillers naturais: ''well'', ''you know'', ''I mean''."]}'),
(@L, 3, N'Humour, Irony & Understatement', N'table', N'{"heading":"Cultural Nuance","headers":["Recurso","Exemplo"],"rows":[["Irony","''Great weather!'' (na chuva)"],["Understatement","''It''s a bit cold'' (-10C)"],["Sarcasm","''Oh, brilliant.'' (algo deu errado)"],["Euphemism","''passed away'' (died)"]]}'),
(@L, 4, N'Accents & Varieties', N'theory', N'{"heading":"Many Englishes","points":["Existem variedades: British, American, Australian, Indian, etc.","Diferencas de vocabulario (lift/elevator), pronuncia e gramatica.","A fluencia inclui entender diferentes sotaques e registros."]}'),
(@L, 5, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Have a long free conversation on varied topics"},{"number":2,"text":"Watch native media without subtitles and discuss"},{"number":3,"text":"Use humour and understatement appropriately"}]}'),
(@L, 6, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'''It''s a bit cold'' at -10C is an example of:', N'understatement', N'["exaggeration","understatement","a lie","a question"]', N'Understatement = dizer menos do que e (recurso britanico).', 1),
(@L, N'multiple_choice', N'''Passed away'' is a euphemism for:', N'died', N'["traveled","died","slept","left"]', N'Eufemismo para ''died'' (morreu).', 2),
(@L, N'fill_blank', N'British word for ''elevator'': ___.', N'lift', NULL, N'British: lift; American: elevator.', 3),
(@L, N'multiple_choice', N'A natural filler when hesitating is:', N'you know', N'["you know","the end","goodbye","thank you"]', N'Fillers naturais: well, you know, I mean.', 4),
(@L, N'translation', N'Traduza o sentido (ironia): ''Oh, brilliant.'' (apos um erro).', N'Ah, otimo. (ironico - algo deu errado)', NULL, N'Ironia: dizer o oposto do que se quer expressar.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'irony', N'ironia', N'/''aireni/', N'noun', N'A touch of irony.', N'Um toque de ironia.'),
(@W2, N'understatement', N'atenuacao', N'/^nder''steitment/', N'noun', N'British understatement.', N'Atenuacao britanica.'),
(@W3, N'euphemism', N'eufemismo', N'/''jufemizem/', N'noun', N'A polite euphemism.', N'Um eufemismo educado.'),
(@W4, N'accent', N'sotaque', N'/''aeksent/', N'noun', N'A strong accent.', N'Um sotaque forte.'),
(@W5, N'filler', N'palavra de apoio', N'/''filer/', N'noun', N'Use a filler.', N'Use uma palavra de apoio.'),
(@W6, N'spontaneous', N'espontaneo', N'/spon''teinies/', N'adjective', N'Spontaneous speech.', N'Fala espontanea.'),
(@W7, N'nuance', N'nuance', N'/''njuans/', N'noun', N'Subtle nuance.', N'Nuance sutil.'),
(@W8, N'mastery', N'maestria', N'/''maesteri/', N'noun', N'Language mastery.', N'Maestria do idioma.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO
