-- ============================================================
-- LearnEnglish - Migration V4
-- Modulo 2 - Intermediario (B1) - Licoes 13-24
-- Teacher Katrine Riccaldoni  |  Curriculo CEFR
-- ContentType: intro | theory | table | examples | practice | closing
-- ExerciseType: multiple_choice | fill_blank | identify_past | translation | pronunciation
-- ============================================================
USE learnenglish;
GO

-- ==========================================================
-- LESSON 13: Simple Past  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 13, N'Simple Past', N'Simple Past', N'(B1) O Simple Past indica acoes concluidas no passado. Verbos regulares e irregulares.', 13);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Simple Past', N'intro', N'{"heading":"Simple Past","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 13"}'),
(@L, 2, N'What is Simple Past?', N'theory', N'{"heading":"What is Simple Past?","points":["O simple past e equivalente ao passado simples do portugues.","O simple past e usado para indicar acoes ja concluidas, ou seja, para falar de fatos que ja aconteceram (comecaram e terminaram no passado)."]}'),
(@L, 3, N'Expressoes Temporais', N'theory', N'{"heading":"Expressoes Temporais","description":"Para reforcar o uso do simple past, muitas expressoes temporais sao utilizadas nas frases.","words":[{"en":"yesterday","pt":"ontem"},{"en":"the day before yesterday","pt":"anteontem"},{"en":"last night","pt":"ontem a noite"},{"en":"last year","pt":"ano passado"},{"en":"last month","pt":"mes passado"},{"en":"last week","pt":"semana passada"},{"en":"ago","pt":"atras"}],"example":"We did not work yesterday"}'),
(@L, 4, N'The Structure - Affirmative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + d/ed/ied + complement","example":"I liked cookies","note":"Verbos irregulares nao possuem um padrao de formacao. Eles possuem uma forma propria."}]}'),
(@L, 5, N'Verbos Regulares - Parte 1', N'theory', N'{"heading":"Verbos Regulares","rules":[{"number":1,"rule":"Terminados em -e: acrescenta-se -d no final","examples":["to love > loved","to lie > lied"]},{"number":2,"rule":"Terminados em consoante + vogal + consoante: duplica-se a ultima consoante e acrescenta-se -ed","examples":["to stop > stopped","to control > controlled"]}]}'),
(@L, 6, N'Verbos Regulares - Parte 2', N'theory', N'{"heading":"Verbos Regulares","rules":[{"number":3,"rule":"Terminados em -y precedido de consoante: retira-se o -y e acrescenta-se -ied no final","examples":["to study > studied","to try > tried"]},{"number":4,"rule":"Terminados em -y precedido de vogal: acrescenta-se o -ed no final","examples":["to enjoy > enjoyed","to play > played"]}]}'),
(@L, 7, N'Verbos Irregulares - Parte 1', N'table', N'{"heading":"Verbos Irregulares","pairs":[["to be","was"],["to become","became"],["to begin","began"],["to break","broke"],["to bring","brought"],["to build","built"],["to buy","bought"],["to choose","chose"],["to come","came"],["to do","did"],["to drink","drank"],["to drive","drove"],["to eat","ate"],["to feed","fed"],["to feel","felt"],["to find","found"],["to forbid","forbade"],["to forget","forgot"],["to get","got"],["to give","gave"],["to go","went"],["to have","had"],["to hear","heard"],["to hide","hid"],["to keep","kept"],["to know","knew"],["to lead","led"]]}'),
(@L, 8, N'Verbos Irregulares - Parte 2', N'table', N'{"heading":"Verbos Irregulares","pairs":[["to lose","lost"],["to make","made"],["to mean","meant"],["to meet","met"],["to pay","paid"],["to put","put"],["to read","read"],["to ride","rode"],["to run","ran"],["to say","said"],["to see","saw"],["to sell","sold"],["to send","sent"],["to sleep","slept"],["to speak","spoke"],["to take","took"],["to tell","told"],["to think","thought"],["to wake","woke"],["to win","won"],["to write","wrote"]]}'),
(@L, 9, N'The Structure - Negative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Negative form","formula":"Subject + did + not + main verb + complement","example":"She did not like the restaurant","note":"Atencao! O verbo auxiliar faz o trabalho pelo verbo principal: o auxiliar no passado e o principal na forma infinitiva (sem o to)."}]}'),
(@L, 10, N'The Structure - Interrogative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Did + subject + main verb + complement","example":"Did she like the restaurant?"}]}'),
(@L, 11, N'Contractions', N'examples', N'{"heading":"Contractions","contractions":[{"full":"Did + not","short":"didn''t","example":"She didn''t like the restaurant"}]}'),
(@L, 12, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Identify the past of some words"},{"number":2,"text":"Talk about what you did yesterday"},{"number":3,"text":"Try to have a quick conversation"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'identify_past', N'What is the Simple Past of "go"?', N'went', N'["goed","went","gone","going"]', N'"go" e irregular: go > went. Nao siga a regra do -ed!', 1),
(@L, N'identify_past', N'What is the Simple Past of "study"?', N'studied', N'["studyed","studied","studid","studed"]', N'study termina em -y precedido de consoante: remove -y, adiciona -ied.', 2),
(@L, N'multiple_choice', N'She ___ not work yesterday.', N'did', N'["was","did","does","had"]', N'Na forma negativa do Simple Past, usamos "did not" + verbo na forma base.', 3),
(@L, N'multiple_choice', N'___ you eat sushi last night?', N'Did', N'["Were","Did","Do","Have"]', N'Na interrogativa do Simple Past, "Did" vai para o inicio.', 4),
(@L, N'identify_past', N'What is the Simple Past of "stop"?', N'stopped', N'["stoped","stopped","stopd","stoping"]', N'Consoante + vogal + consoante -> dobra a ultima consoante + -ed: stop > stopped.', 5),
(@L, N'identify_past', N'What is the Simple Past of "buy"?', N'bought', N'["buyed","boughted","bought","buied"]', N'"buy" e irregular: buy > bought.', 6),
(@L, N'translation', N'Traduza para o ingles: "Ela viu um filme ontem."', N'She saw a movie yesterday.', NULL, N'saw = Simple Past de "see". Lembre da expressao temporal: yesterday.', 7);

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
(@W1, N'was/were', N'era/estava', N'/woz/ /wer/', N'verb', N'She was happy yesterday.', N'Ela estava feliz ontem.'),
(@W2, N'became', N'tornou-se', N'/bi''keim/', N'verb', N'He became a doctor.', N'Ele se tornou medico.'),
(@W3, N'began', N'comecou', N'/bi''gaen/', N'verb', N'She began to study.', N'Ela comecou a estudar.'),
(@W4, N'broke', N'quebrou', N'/brouk/', N'verb', N'He broke the glass.', N'Ele quebrou o copo.'),
(@W5, N'brought', N'trouxe', N'/brot/', N'verb', N'She brought flowers.', N'Ela trouxe flores.'),
(@W6, N'built', N'construiu', N'/bilt/', N'verb', N'They built a house.', N'Eles construiram uma casa.'),
(@W7, N'bought', N'comprou', N'/bot/', N'verb', N'I bought a new car.', N'Eu comprei um carro novo.'),
(@W8, N'went', N'foi', N'/went/', N'verb', N'We went to the beach.', N'Fomos a praia.'),
(@W9, N'saw', N'viu', N'/so/', N'verb', N'She saw a movie yesterday.', N'Ela viu um filme ontem.'),
(@W10, N'said', N'disse', N'/sed/', N'verb', N'He said goodbye.', N'Ele disse tchau.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8), (@L, @W9), (@L, @W10);
GO

-- ==========================================================
-- LESSON 14: Past Continuous  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 14, N'Past Continuous', N'Past Continuous', N'(B1) O Past Continuous descreve acoes continuas que ocorreram no passado. Combine com o Simple Past usando while e when.', 14);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Past Continuous', N'intro', N'{"heading":"Past Continuous","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 14"}'),
(@L, 2, N'What is Past Continuous?', N'theory', N'{"heading":"What is Past Continuous?","points":["Past Continuous e usado para indicar acoes continuas que ocorreram no passado.","Quando expressamos duas ou mais acoes simultaneas no passado, e muito comum utilizarmos while (enquanto).","Example: I was reading a book while she was watching TV"]}'),
(@L, 3, N'Estrutura - Affirmative', N'examples', N'{"heading":"Estrutura do Past Continuous","sections":[{"title":"Affirmative form","formula":"Subject + was/were + main verb with -ing + complement","examples":["She was going to my house","I was doing the laundry","We were eating together"]}]}'),
(@L, 4, N'Estrutura - Negative', N'examples', N'{"heading":"Estrutura do Past Continuous","sections":[{"title":"Negative form","formula":"Subject + was/were + not + main verb with -ing + complement","examples":["She was not (wasn''t) going to my house","I was not (wasn''t) doing the laundry","We were not (weren''t) eating together"]}]}'),
(@L, 5, N'Estrutura - Interrogative', N'examples', N'{"heading":"Estrutura do Past Continuous","sections":[{"title":"Interrogative form","formula":"Was/Were + subject + main verb with -ing + complement","examples":["Was she going to my house?","Was I doing the laundry?","Were we eating together?"]}]}'),
(@L, 6, N'Pontos Importantes - When', N'theory', N'{"heading":"Pontos Importantes","points":["Quando expressamos uma acao que aconteceu pontualmente enquanto outra estava em andamento no passado, colocamos a acao pontual no Simple Past."],"examples":["I was watching Brazil''s game when she arrived","We were talking when the teacher came","She was studying when the phone rang"]}'),
(@L, 7, N'Pontos Importantes - Adverbios', N'theory', N'{"heading":"Pontos Importantes","description":"Quando expressamos uma acao continua habitual que ocorria no passado, e comum usarmos adverbios de frequencia.","words":[{"en":"often","pt":"frequentemente"},{"en":"rarely","pt":"raramente"},{"en":"occasionally","pt":"ocasionalmente"},{"en":"weekly","pt":"semanalmente"},{"en":"daily","pt":"diariamente"},{"en":"monthly","pt":"mensalmente"}]}'),
(@L, 8, N'Pontos Importantes - Expressoes de Tempo', N'theory', N'{"heading":"Pontos Importantes","description":"Para estabelecer relacao temporal entre acao continua no passado e o presente, usamos expressoes de tempo.","words":[{"en":"by this time","pt":"nessa epoca"},{"en":"yesterday","pt":"ontem"},{"en":"last night","pt":"noite passada"},{"en":"last year","pt":"ano passado"},{"en":"last month","pt":"mes passado"},{"en":"last week","pt":"semana passada"}]}'),
(@L, 9, N'Regras do -ing (Parte 1)', N'theory', N'{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -e precedido de consoante: retira-se o -e e acrescenta-se -ing","examples":["to dance > dancing","to take > taking","to make > making"]},{"note":"Atencao! Nao e comum usar verbos de estado no Continuous: agree, need, believe, know, like..."}]}'),
(@L, 10, N'Regras do -ing (Parte 2)', N'theory', N'{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -ie: troca-se -ie por -y e acrescenta-se -ing","examples":["to die > dying","to lie > lying"]},{"rule":"Quando o verbo e mono ou dissilabo CVC: duplica-se a ultima consoante + -ing","examples":["to travel > travelling","to cut > cutting","to run > running"]}]}'),
(@L, 11, N'Regras do -ing - Excecoes', N'theory', N'{"heading":"Regras do -ing - Excecoes","rules":[{"rule":"Quando a ultima consoante e w ou x: nao se dobra","examples":["to snow > snowing","to fix > fixing"]},{"rule":"Se a silaba tonica for a 1a: nao se dobra a ultima consoante","examples":["to open > opening","to happen > happening"]}]}'),
(@L, 12, N'Simple Past X Past Continuous', N'table', N'{"heading":"Simple Past X Past Continuous","headers":["","Simple Past","Past Continuous"],"rows":[["Uso","Fato pontual","Acao em progresso"],["Verbo auxiliar","did","to be (was/were)"],["Afirmativa","He went to school","He was going to school"],["Negativa","He didn''t go to school","He wasn''t going to school"],["Interrogativa","Did he go to school?","Was he going to school?"]]}'),
(@L, 13, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Create sentences in the Past Continuous tense"},{"number":2,"text":"Transform sentences from Simple Past to Past Continuous"},{"number":3,"text":"Try to have a quick conversation"}]}'),
(@L, 14, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'She ___ TV when I called her.', N'was watching', N'["watched","was watching","is watching","were watching"]', N'She = singular -> was. Acao em progresso no passado -> -ing.', 1),
(@L, N'multiple_choice', N'Choose the correct sentence:', N'We were eating when she arrived.', N'["We was eating when she arrived.","We were eat when she arrived.","We were eating when she arrived.","We were eating when she was arrived."]', N'We -> were. Acao pontual (arrived) -> Simple Past.', 2),
(@L, N'fill_blank', N'Complete: They ___ (not sleep) when the alarm rang.', N'were not sleeping', NULL, N'They -> were. Negativa: were not + -ing.', 3),
(@L, N'multiple_choice', N'What is the interrogative form of "I was working"?', N'Was I working?', N'["I was working?","Was I working?","Did I working?","Were I working?"]', N'Interrogativa Past Continuous: Was/Were + subject + -ing.', 4),
(@L, N'multiple_choice', N'I was watching Brazil''s game ___ she arrived.', N'when', N'["while","when","during","because"]', N'"When" e usado para acao pontual (Simple Past) interrompendo acao continua (Past Continuous).', 5),
(@L, N'translation', N'Traduza: "Eles estavam dormindo enquanto eu estudava."', N'They were sleeping while I was studying.', NULL, N'Duas acoes simultaneas no passado -> Past Continuous + while + Past Continuous.', 6);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'while', N'enquanto', N'/wail/', N'conjunction', N'I read while she slept.', N'Eu li enquanto ela dormia.'),
(@W2, N'when', N'quando', N'/wen/', N'conjunction', N'She arrived when I called.', N'Ela chegou quando eu liguei.'),
(@W3, N'arrive', N'chegar', N'/e''raiv/', N'verb', N'She arrived late.', N'Ela chegou tarde.'),
(@W4, N'laundry', N'lavanderia/roupa', N'/''londri/', N'noun', N'I was doing the laundry.', N'Eu estava lavando roupa.'),
(@W5, N'often', N'frequentemente', N'/''ofen/', N'adverb', N'I often read at night.', N'Eu frequentemente leio a noite.'),
(@W6, N'rarely', N'raramente', N'/''rerli/', N'adverb', N'He rarely calls.', N'Ele raramente liga.'),
(@W7, N'ring', N'tocar (telefone)', N'/ring/', N'verb', N'The phone rang.', N'O telefone tocou.'),
(@W8, N'sleep', N'dormir', N'/slip/', N'verb', N'They were sleeping.', N'Eles estavam dormindo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 15: Comparatives & Superlatives  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 15, N'Comparatives & Superlatives', N'Comparatives', N'(B1) Comparar e classificar coisas, lugares e pessoas com -er/more e the -est/the most.', 15);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Comparatives & Superlatives', N'intro', N'{"heading":"Comparatives & Superlatives","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 15"}'),
(@L, 2, N'Comparatives', N'table', N'{"heading":"Comparative Form","headers":["Tipo","Regra","Exemplo"],"rows":[["Curtos (1 silaba)","+ -er + than","tall > taller than"],["Terminados em -y","-y > -ier than","happy > happier than"],["Longos (2+ silabas)","more + adj + than","more expensive than"]]}'),
(@L, 3, N'Superlatives', N'table', N'{"heading":"Superlative Form","headers":["Tipo","Regra","Exemplo"],"rows":[["Curtos","the + -est","the tallest"],["Terminados em -y","the + -iest","the happiest"],["Longos","the most + adj","the most expensive"]]}'),
(@L, 4, N'Irregular Adjectives', N'table', N'{"heading":"Irregulares","headers":["Adjective","Comparative","Superlative"],"rows":[["good","better","the best"],["bad","worse","the worst"],["far","farther","the farthest"]]}'),
(@L, 5, N'as ... as', N'examples', N'{"heading":"Equality: as...as","sections":[{"title":"Igualdade","formula":"as + adjective + as","examples":["She is as tall as her brother","This car is not as fast as that one"]}]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Compare two cities you know"},{"number":2,"text":"Say the best and worst thing about your week"},{"number":3,"text":"Use as...as to compare two friends"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'My brother is ___ than me.', N'taller', N'["tall","taller","tallest","more tall"]', N'Adjetivo curto: + -er + than -> taller than.', 1),
(@L, N'multiple_choice', N'This is ___ movie I have ever seen.', N'the best', N'["the better","the best","the goodest","the most good"]', N'good e irregular: superlativo = the best.', 2),
(@L, N'fill_blank', N'Complete: This phone is ___ (expensive) than that one.', N'more expensive', NULL, N'Adjetivo longo: more + adjetivo + than.', 3),
(@L, N'multiple_choice', N'She is as tall ___ her sister.', N'as', N'["than","as","that","to"]', N'Igualdade: as + adjetivo + as.', 4),
(@L, N'multiple_choice', N'What is the superlative of ''happy''?', N'the happiest', N'["the happyest","the happiest","the most happy","the happier"]', N'-y -> the + -iest: the happiest.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'tall', N'alto', N'/tol/', N'adjective', N'He is tall.', N'Ele e alto.'),
(@W2, N'expensive', N'caro', N'/ik''spensiv/', N'adjective', N'This is expensive.', N'Isto e caro.'),
(@W3, N'cheap', N'barato', N'/tchip/', N'adjective', N'That phone is cheap.', N'Aquele telefone e barato.'),
(@W4, N'better', N'melhor', N'/''beter/', N'adjective', N'This is better.', N'Isto e melhor.'),
(@W5, N'worse', N'pior', N'/wers/', N'adjective', N'Today is worse.', N'Hoje esta pior.'),
(@W6, N'big', N'grande', N'/big/', N'adjective', N'A big house.', N'Uma casa grande.'),
(@W7, N'fast', N'rapido', N'/faest/', N'adjective', N'A fast car.', N'Um carro rapido.'),
(@W8, N'than', N'do que', N'/dhaen/', N'conjunction', N'Bigger than this.', N'Maior do que isto.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 16: Simple Future (Will / Going to)  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 16, N'Simple Future (Will / Going to)', N'Simple Future', N'(B1) O Simple Future expressa acoes futuras. Estude will, going to e shall, e saiba quando usar cada um.', 16);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Simple Future', N'intro', N'{"heading":"Simple Future","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 16"}'),
(@L, 2, N'What is Simple Future?', N'theory', N'{"heading":"What is Simple Future?","points":["O Simple Future e usado para expressar acoes que irao acontecer no futuro.","Existem tres formas de expressar o futuro em ingles: will, going to e shall.","Cada forma tem usos e contextos especificos que aprenderemos nesta licao."]}'),
(@L, 3, N'Expressoes Temporais', N'theory', N'{"heading":"Expressoes Temporais","description":"Expressoes de tempo que reforcam o uso do Simple Future.","words":[{"en":"tomorrow","pt":"amanha"},{"en":"soon","pt":"em breve"},{"en":"next week","pt":"semana que vem"},{"en":"next month","pt":"proximo mes"},{"en":"next year","pt":"ano que vem"},{"en":"in the future","pt":"no futuro"},{"en":"later","pt":"mais tarde"}],"example":"I will call you tomorrow"}'),
(@L, 4, N'Will - Affirmative', N'examples', N'{"heading":"Will - Affirmative","sections":[{"title":"Uso: decisoes espontaneas, promessas, previsoes","formula":"Subject + will + main verb (infinitive) + complement","examples":["I will call you later","She will travel next week","They will help us"]}]}'),
(@L, 5, N'Will - Negative and Interrogative', N'examples', N'{"heading":"Will - Negative and Interrogative","sections":[{"title":"Negative form","formula":"Subject + will + not + main verb + complement","examples":["I will not (won''t) call you","She will not come tomorrow"]},{"title":"Interrogative form","formula":"Will + subject + main verb + complement","examples":["Will you call me?","Will she travel?","Will they help us?"]}]}'),
(@L, 6, N'Going to - Affirmative', N'examples', N'{"heading":"Going to - Affirmative","sections":[{"title":"Uso: planos e intencoes, previsoes com evidencia","formula":"Subject + am/is/are + going to + main verb + complement","examples":["I am going to study tonight","She is going to visit her parents","They are going to buy a new car"]}]}'),
(@L, 7, N'Going to - Negative', N'examples', N'{"heading":"Going to - Negative","sections":[{"title":"Negative form","formula":"Subject + am/is/are + not + going to + main verb + complement","examples":["I am not going to study tonight","She is not (isn''t) going to visit her parents","They are not (aren''t) going to buy a new car"]}]}'),
(@L, 8, N'Going to - Interrogative', N'examples', N'{"heading":"Going to - Interrogative","sections":[{"title":"Interrogative form","formula":"Am/Is/Are + subject + going to + main verb + complement","examples":["Are you going to study tonight?","Is she going to visit her parents?","Are they going to buy a new car?"]}]}'),
(@L, 9, N'Shall - Affirmative', N'examples', N'{"heading":"Shall - Affirmative","sections":[{"title":"Uso: sugestoes, ofertas (formal/britanico), I e We","formula":"Subject (I/We) + shall + main verb + complement","examples":["I shall help you","Shall we go to the cinema?","We shall overcome"]}]}'),
(@L, 10, N'Shall - Negative and Interrogative', N'examples', N'{"heading":"Shall - Negative and Interrogative","sections":[{"title":"Negative form","formula":"Subject + shall + not (shan''t) + main verb","examples":["I shall not (shan''t) be late","We shall not give up"]},{"title":"Interrogative form","formula":"Shall + I/We + main verb + complement?","examples":["Shall I open the window?","Shall we start the meeting?"]}]}'),
(@L, 11, N'Will X Shall X Going to', N'table', N'{"heading":"Will X Shall X Going to","headers":["Forma","Uso principal","Exemplo"],"rows":[["Will","Decisao espontanea, promessa, previsao geral","I will help you (decisao agora)"],["Going to","Plano ja decidido, intencao, evidencia concreta","I am going to study (ja planejado)"],["Shall","Sugestao/oferta formal, usado com I/We","Shall I help you?"]]}'),
(@L, 12, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Talk about your plans for the weekend using going to"},{"number":2,"text":"Ask about the other person''s plans"},{"number":3,"text":"Try to have a quick conversation about the future"}]}'),
(@L, 13, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I ___ call you later. (decisao espontanea)', N'will', N'["am going to","will","shall","am"]', N'"Will" expressa decisao espontanea tomada no momento da fala.', 1),
(@L, N'multiple_choice', N'She ___ visit her parents next weekend. (plano ja decidido)', N'is going to', N'["will","is going to","shall","does"]', N'"Going to" expressa plano ou intencao ja decidida com antecedencia.', 2),
(@L, N'fill_blank', N'Complete: ___ I open the window? (oferta formal)', N'Shall', NULL, N'"Shall" e usado para ofertas e sugestoes formais com I e We.', 3),
(@L, N'multiple_choice', N'What is the negative form of "They will travel tomorrow"?', N'They will not travel tomorrow.', N'["They not will travel tomorrow.","They will not travel tomorrow.","They won''t to travel tomorrow.","They are not going travel tomorrow."]', N'Negativa com will: Subject + will + not + verbo na forma base.', 4),
(@L, N'multiple_choice', N'Look at the dark clouds! It ___ rain.', N'is going to', N'["will","shall","is going to","does"]', N'Evidencia concreta (nuvens escuras) -> "going to" para previsao com evidencia.', 5),
(@L, N'fill_blank', N'Make the interrogative: "You will study tonight."', N'Will you study tonight?', NULL, N'Interrogativa com will: Will + subject + verbo base + complemento?', 6),
(@L, N'translation', N'Traduza: "Ela vai viajar para Londres no proximo mes."', N'She is going to travel to London next month.', NULL, N'Plano definido -> going to. London sem "the". next month = proximo mes.', 7);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'will', N'vai/ira', N'/wil/', N'modal', N'I will help you.', N'Eu vou ajudar voce.'),
(@W2, N'going to', N'vai (plano)', N'/''gouing tu/', N'phrase', N'I am going to travel.', N'Eu vou viajar.'),
(@W3, N'tomorrow', N'amanha', N'/te''morou/', N'adverb', N'See you tomorrow.', N'Ate amanha.'),
(@W4, N'soon', N'em breve', N'/sun/', N'adverb', N'I will call soon.', N'Vou ligar em breve.'),
(@W5, N'travel', N'viajar', N'/''traevl/', N'verb', N'We will travel next year.', N'Vamos viajar ano que vem.'),
(@W6, N'visit', N'visitar', N'/''vizit/', N'verb', N'She is going to visit us.', N'Ela vai nos visitar.'),
(@W7, N'later', N'mais tarde', N'/''leiter/', N'adverb', N'I''ll call you later.', N'Te ligo mais tarde.'),
(@W8, N'plan', N'plano/planejar', N'/plaen/', N'noun', N'What''s your plan?', N'Qual e o seu plano?');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 17: Present Perfect  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 17, N'Present Perfect', N'Present Perfect', N'(B1) Falar de experiencias e acoes que tem ligacao com o presente, com have/has + participio.', 17);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Present Perfect', N'intro', N'{"heading":"Present Perfect","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 17"}'),
(@L, 2, N'What is Present Perfect?', N'theory', N'{"heading":"What is Present Perfect?","points":["Usado para experiencias de vida (sem dizer quando) e acoes que comecaram no passado e continuam.","Formado por have/has + past participle (3a coluna dos verbos).","Conecta o passado com o presente."],"example":"I have visited London"}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative","formula":"Subject + have/has + past participle","examples":["I have finished","She has eaten"]},{"title":"Negative","formula":"Subject + have/has + not + past participle","examples":["I haven''t finished","She hasn''t eaten"]},{"title":"Question","formula":"Have/Has + subject + past participle?","examples":["Have you finished?","Has she eaten?"]}]}'),
(@L, 4, N'Key Words', N'table', N'{"heading":"Palavras-chave","headers":["Word","Uso"],"rows":[["ever","ja alguma vez (perguntas)"],["never","nunca"],["just","acabou de"],["already","ja (afirmativa)"],["yet","ainda (negativa/pergunta)"]]}'),
(@L, 5, N'For / Since', N'examples', N'{"heading":"For x Since","sections":[{"title":"for + periodo","formula":"for + duration","examples":["I have lived here for 5 years"]},{"title":"since + ponto no tempo","formula":"since + start point","examples":["I have lived here since 2020"]}]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Have you ever...? Ask about experiences"},{"number":2,"text":"Say what you have just done today"},{"number":3,"text":"Talk about how long with for/since"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I have ___ this movie before.', N'seen', N'["see","saw","seen","seeing"]', N'Present Perfect usa o past participle: see > seen.', 1),
(@L, N'multiple_choice', N'___ you ever been to Paris?', N'Have', N'["Did","Have","Has","Are"]', N'Pergunta com you: Have + subject + participio.', 2),
(@L, N'fill_blank', N'Complete: She ___ (just/finish) her homework.', N'has just finished', NULL, N'has + just + finished (acabou de terminar).', 3),
(@L, N'multiple_choice', N'Choose: I have lived here ___ 2020.', N'since', N'["for","since","ago","from"]', N'Ponto no tempo (2020) -> since.', 4),
(@L, N'multiple_choice', N'Negative: He ___ eaten yet.', N'hasn''t', N'["haven''t","hasn''t","didn''t","isn''t"]', N'He -> has; negativa = hasn''t; ''yet'' = ainda.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'ever', N'ja (alguma vez)', N'/''ever/', N'adverb', N'Have you ever tried?', N'Voce ja tentou?'),
(@W2, N'never', N'nunca', N'/''never/', N'adverb', N'I have never been there.', N'Eu nunca estive la.'),
(@W3, N'just', N'acabou de', N'/dj^st/', N'adverb', N'I have just arrived.', N'Acabei de chegar.'),
(@W4, N'already', N'ja', N'/ol''redi/', N'adverb', N'She has already left.', N'Ela ja saiu.'),
(@W5, N'yet', N'ainda', N'/jet/', N'adverb', N'Not yet.', N'Ainda nao.'),
(@W6, N'since', N'desde', N'/sins/', N'preposition', N'Since Monday.', N'Desde segunda.'),
(@W7, N'for', N'por/durante', N'/for/', N'preposition', N'For two years.', N'Por dois anos.'),
(@W8, N'experience', N'experiencia', N'/ik''spiriens/', N'noun', N'A new experience.', N'Uma nova experiencia.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 18: Modal Verbs (should / must / have to)  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 18, N'Modal Verbs (should / must / have to)', N'Modal Verbs', N'(B1) Dar conselhos, falar de obrigacoes e proibicoes com should, must e have to.', 18);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Modal Verbs', N'intro', N'{"heading":"Modal Verbs","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 18"}'),
(@L, 2, N'Advice: should', N'examples', N'{"heading":"should / shouldn''t","sections":[{"title":"Conselho","formula":"Subject + should (not) + verb","examples":["You should drink water","You shouldn''t smoke"]}]}'),
(@L, 3, N'Obligation: must / have to', N'table', N'{"heading":"Obligation","headers":["Modal","Uso","Exemplo"],"rows":[["must","obrigacao forte / regra","You must wear a seatbelt"],["have to","obrigacao externa","I have to work tomorrow"],["mustn''t","proibicao","You mustn''t smoke here"],["don''t have to","nao e necessario","You don''t have to come"]]}'),
(@L, 4, N'must x mustn''t x don''t have to', N'theory', N'{"heading":"Cuidado!","points":["mustn''t = proibido (You mustn''t park here).","don''t have to = nao precisa, mas pode (You don''t have to pay).","Sao bem diferentes - nao confunda!"]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Give advice for 3 common problems"},{"number":2,"text":"List rules of a place (must / mustn''t)"},{"number":3,"text":"Say 3 things you have to do this week"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'You look tired. You ___ rest.', N'should', N'["should","must","shouldn''t","have to"]', N'Conselho -> should.', 1),
(@L, N'multiple_choice', N'You ___ smoke in the hospital. (proibido)', N'mustn''t', N'["mustn''t","don''t have to","should","have to"]', N'Proibicao -> mustn''t.', 2),
(@L, N'fill_blank', N'Complete: I ___ to work tomorrow. (obrigacao)', N'have', NULL, N'Obrigacao externa: have to.', 3),
(@L, N'multiple_choice', N'It''s free. You ___ pay.', N'don''t have to', N'["mustn''t","don''t have to","should","must"]', N'Nao e necessario -> don''t have to.', 4),
(@L, N'translation', N'Traduza: ''Voce deveria estudar mais.''', N'You should study more.', NULL, N'Conselho com should + verbo base.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'should', N'deveria', N'/shud/', N'modal', N'You should rest.', N'Voce deveria descansar.'),
(@W2, N'must', N'deve (obrigacao)', N'/m^st/', N'modal', N'You must stop.', N'Voce deve parar.'),
(@W3, N'have to', N'ter que', N'/haev tu/', N'phrase', N'I have to go.', N'Eu tenho que ir.'),
(@W4, N'advice', N'conselho', N'/ed''vais/', N'noun', N'Good advice.', N'Bom conselho.'),
(@W5, N'rule', N'regra', N'/rul/', N'noun', N'Follow the rules.', N'Siga as regras.'),
(@W6, N'rest', N'descansar', N'/rest/', N'verb', N'You need to rest.', N'Voce precisa descansar.'),
(@W7, N'smoke', N'fumar', N'/smouk/', N'verb', N'Don''t smoke here.', N'Nao fume aqui.'),
(@W8, N'seatbelt', N'cinto de seguranca', N'/''sitbelt/', N'noun', N'Wear your seatbelt.', N'Use o cinto.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 19: Countable & Uncountable / Quantifiers  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 19, N'Countable & Uncountable / Quantifiers', N'Quantifiers', N'(B1) Falar de quantidades com much, many, a lot of, a few, a little, some e any.', 19);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Countable & Uncountable', N'intro', N'{"heading":"Countable & Uncountable","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 19"}'),
(@L, 2, N'Countable x Uncountable', N'table', N'{"heading":"Two Types of Nouns","headers":["Countable","Uncountable"],"rows":[["apple, book, car","water, rice, money"],["plural: apples","no plural: waters (X)"],["a/an + singular","no a/an"]]}'),
(@L, 3, N'Much / Many / A lot of', N'table', N'{"heading":"Quantifiers","headers":["Quantifier","Uso","Exemplo"],"rows":[["many","contaveis","many books"],["much","incontaveis (neg/perg)","much money?"],["a lot of","ambos (afirmativa)","a lot of friends"]]}'),
(@L, 4, N'A few / A little', N'examples', N'{"heading":"Small Quantities","sections":[{"title":"a few + contavel","formula":"a few + plural noun","examples":["a few apples","a few people"]},{"title":"a little + incontavel","formula":"a little + uncountable","examples":["a little water","a little time"]}]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Classify 10 nouns: countable or uncountable"},{"number":2,"text":"Make a shopping list with quantifiers"},{"number":3,"text":"Ask: How much/How many...?"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'How ___ money do you have?', N'much', N'["many","much","few","a lot"]', N'money e incontavel -> much (em pergunta).', 1),
(@L, N'multiple_choice', N'There are ___ apples on the table.', N'many', N'["much","many","a little","any"]', N'apples e contavel plural -> many.', 2),
(@L, N'fill_blank', N'Complete: I have a ___ water left (pouca).', N'little', NULL, N'a little + incontavel (water).', 3),
(@L, N'multiple_choice', N'Is ''rice'' countable or uncountable?', N'uncountable', N'["countable","uncountable","both","neither"]', N'rice (arroz) e incontavel.', 4),
(@L, N'multiple_choice', N'I have a ___ friends in London (alguns).', N'few', N'["little","few","much","any"]', N'a few + contavel plural (friends).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'water', N'agua', N'/''woter/', N'noun', N'I drink water.', N'Eu bebo agua.'),
(@W2, N'money', N'dinheiro', N'/''m^ni/', N'noun', N'How much money?', N'Quanto dinheiro?'),
(@W3, N'rice', N'arroz', N'/rais/', N'noun', N'I like rice.', N'Eu gosto de arroz.'),
(@W4, N'much', N'muito (incont.)', N'/m^tch/', N'quantifier', N'Too much sugar.', N'Acucar demais.'),
(@W5, N'many', N'muitos (cont.)', N'/''meni/', N'quantifier', N'Many people.', N'Muitas pessoas.'),
(@W6, N'a few', N'alguns', N'/e fju/', N'quantifier', N'A few minutes.', N'Alguns minutos.'),
(@W7, N'a little', N'um pouco', N'/e ''litl/', N'quantifier', N'A little milk.', N'Um pouco de leite.'),
(@W8, N'sugar', N'acucar', N'/''shuger/', N'noun', N'No sugar, please.', N'Sem acucar, por favor.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 20: First Conditional  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 20, N'First Conditional', N'First Conditional', N'(B1) Falar de condicoes reais e provaveis e suas consequencias com If + presente, will + verbo.', 20);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'First Conditional', N'intro', N'{"heading":"First Conditional","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 20"}'),
(@L, 2, N'What is the First Conditional?', N'theory', N'{"heading":"Real & Possible Conditions","points":["Usamos para situacoes reais e provaveis no futuro.","Estrutura: If + Simple Present, will + verbo base.","A ordem pode inverter (com virgula apenas quando ''if'' vem primeiro)."],"example":"If it rains, I will stay home"}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Condicao + resultado","formula":"If + present, ... will + verb","examples":["If you study, you will pass","I will call you if I have time"]}]}'),
(@L, 4, N'when / unless / as soon as', N'table', N'{"heading":"Other Connectors","headers":["Connector","Significado"],"rows":[["when","quando (certeza)"],["unless","a menos que (= if not)"],["as soon as","assim que"]]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Make 3 sentences: If..., I will..."},{"number":2,"text":"Use ''unless'' in a sentence"},{"number":3,"text":"Build a chain: If A, then B; if B, then C"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'If it ___ tomorrow, we will cancel the trip.', N'rains', N'["rain","rains","will rain","rained"]', N'Apos ''if'' usa-se o Simple Present: rains.', 1),
(@L, N'multiple_choice', N'If you study hard, you ___ pass the exam.', N'will', N'["will","would","are","do"]', N'Resultado do 1o condicional: will + verbo.', 2),
(@L, N'fill_blank', N'Complete: I won''t go ___ you come with me. (a menos que)', N'unless', NULL, N'unless = a menos que (= if not).', 3),
(@L, N'multiple_choice', N'Choose the correct order with comma:', N'If I see her, I will tell her.', N'["I will tell her if, I see her.","If I see her, I will tell her.","If I will see her, I tell her.","I will tell her, if I see her."]', N'If primeiro -> virgula entre as oracoes; ''if'' + presente.', 4),
(@L, N'translation', N'Traduza: ''Se voce me ajudar, eu te ajudarei.''', N'If you help me, I will help you.', NULL, N'If + presente, will + verbo.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'if', N'se', N'/if/', N'conjunction', N'If it rains...', N'Se chover...'),
(@W2, N'unless', N'a menos que', N'/^n''les/', N'conjunction', N'Unless you hurry.', N'A menos que se apresse.'),
(@W3, N'rain', N'chuva/chover', N'/rein/', N'verb', N'It will rain.', N'Vai chover.'),
(@W4, N'pass', N'passar', N'/paes/', N'verb', N'I will pass the exam.', N'Vou passar na prova.'),
(@W5, N'exam', N'prova/exame', N'/ig''zaem/', N'noun', N'A hard exam.', N'Uma prova dificil.'),
(@W6, N'trip', N'viagem', N'/trip/', N'noun', N'A short trip.', N'Uma viagem curta.'),
(@W7, N'as soon as', N'assim que', N'/ez sun ez/', N'phrase', N'Call me as soon as you arrive.', N'Me ligue assim que chegar.'),
(@W8, N'hurry', N'apressar-se', N'/''h^ri/', N'verb', N'Hurry up!', N'Depressa!');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 21: Relative Clauses  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 21, N'Relative Clauses', N'Relative Clauses', N'(B1) Dar mais informacao sobre pessoas e coisas em uma so frase com who, which, that, where e whose.', 21);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Relative Clauses', N'intro', N'{"heading":"Relative Clauses","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 21"}'),
(@L, 2, N'Relative Pronouns', N'table', N'{"heading":"Which pronoun?","headers":["Pronoun","Uso"],"rows":[["who","pessoas"],["which","coisas/animais"],["that","pessoas ou coisas (informal)"],["where","lugares"],["whose","posse"]]}'),
(@L, 3, N'Examples', N'examples', N'{"heading":"Joining Sentences","sections":[{"title":"Pessoas (who)","formula":"noun + who + verb","examples":["The man who called is my uncle"]},{"title":"Coisas (which/that)","formula":"noun + which/that + verb","examples":["The book which I read was great"]},{"title":"Lugares (where)","formula":"place + where","examples":["The city where I was born"]}]}'),
(@L, 4, N'Defining x Non-defining', N'theory', N'{"heading":"Com ou sem virgula?","points":["Defining (sem virgula): informacao essencial. The woman who lives here is a doctor.","Non-defining (com virgula): informacao extra. My mother, who is 60, still works.","''that'' so e usado em oracoes defining."]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Define 3 jobs: A teacher is someone who..."},{"number":2,"text":"Join two sentences with who/which"},{"number":3,"text":"Describe a place using ''where''"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'The man ___ called you is my uncle.', N'who', N'["who","which","where","whose"]', N'Pessoas -> who.', 1),
(@L, N'multiple_choice', N'This is the book ___ I told you about.', N'which', N'["who","which","where","whose"]', N'Coisas -> which (ou that).', 2),
(@L, N'fill_blank', N'Complete: That''s the house ___ I grew up. (lugar)', N'where', NULL, N'Lugares -> where.', 3),
(@L, N'multiple_choice', N'She''s the woman ___ car was stolen.', N'whose', N'["who","which","whose","where"]', N'Posse -> whose.', 4),
(@L, N'translation', N'Traduza: ''Um medico e alguem que ajuda pessoas.''', N'A doctor is someone who helps people.', NULL, N'someone who + verbo (pessoas).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'who', N'que/quem', N'/hu/', N'pronoun', N'The man who came.', N'O homem que veio.'),
(@W2, N'which', N'que/qual', N'/witch/', N'pronoun', N'The car which I bought.', N'O carro que comprei.'),
(@W3, N'where', N'onde', N'/wer/', N'pronoun', N'The place where we met.', N'O lugar onde nos conhecemos.'),
(@W4, N'whose', N'cujo', N'/huz/', N'pronoun', N'The boy whose dog ran away.', N'O menino cujo cachorro fugiu.'),
(@W5, N'uncle', N'tio', N'/''^nkl/', N'noun', N'My uncle is funny.', N'Meu tio e engracado.'),
(@W6, N'born', N'nascido', N'/born/', N'adjective', N'I was born in Brazil.', N'Eu nasci no Brasil.'),
(@W7, N'someone', N'alguem', N'/''s^mw^n/', N'pronoun', N'Someone called.', N'Alguem ligou.'),
(@W8, N'stolen', N'roubado', N'/''stoulen/', N'adjective', N'My bike was stolen.', N'Minha bici foi roubada.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 22: Phrasal Verbs (Essentials)  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 22, N'Phrasal Verbs (Essentials)', N'Phrasal Verbs', N'(B1) Compreender e usar verbos frasais frequentes: get up, turn on/off, look for, give up, find out.', 22);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Phrasal Verbs', N'intro', N'{"heading":"Phrasal Verbs","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 22"}'),
(@L, 2, N'What are Phrasal Verbs?', N'theory', N'{"heading":"Verb + Particle","points":["Phrasal verb = verbo + particula (preposicao/adverbio), com sentido proprio.","Ex: ''look'' (olhar) + ''for'' = look for (procurar).","O sentido muitas vezes nao e literal - precisa memorizar."]}'),
(@L, 3, N'Common Phrasal Verbs', N'table', N'{"heading":"Top Phrasal Verbs","headers":["Phrasal Verb","Portugues"],"rows":[["get up","levantar"],["turn on/off","ligar/desligar"],["look for","procurar"],["give up","desistir"],["find out","descobrir"],["take off","decolar/tirar"]]}'),
(@L, 4, N'Separable x Inseparable', N'examples', N'{"heading":"Position of the Object","sections":[{"title":"Separaveis","formula":"turn the TV on / turn it on","examples":["Turn off the light","Turn it off"]},{"title":"Inseparaveis","formula":"look for it (nao ''look it for'')","examples":["I''m looking for my keys"]}]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Replace formal verbs with phrasal verbs"},{"number":2,"text":"Make 5 sentences with phrasal verbs"},{"number":3,"text":"Mini-dialogue using turn on/off and look for"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I ___ at 6 a.m. every day.', N'get up', N'["get up","get on","get off","get in"]', N'get up = levantar da cama.', 1),
(@L, N'multiple_choice', N'Please ___ the lights when you leave.', N'turn off', N'["turn off","turn up","look for","give up"]', N'turn off = desligar.', 2),
(@L, N'fill_blank', N'Complete: I''m looking ___ my keys. (procurando)', N'for', NULL, N'look for = procurar (inseparavel).', 3),
(@L, N'multiple_choice', N'Don''t ___! Keep trying.', N'give up', N'["give up","find out","take off","turn on"]', N'give up = desistir.', 4),
(@L, N'translation', N'Traduza: ''Eu descobri a verdade.''', N'I found out the truth.', NULL, N'find out (passado: found out) = descobrir.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'get up', N'levantar', N'/get ^p/', N'phrasal verb', N'I get up early.', N'Eu levanto cedo.'),
(@W2, N'turn on', N'ligar', N'/tern on/', N'phrasal verb', N'Turn on the TV.', N'Ligue a TV.'),
(@W3, N'turn off', N'desligar', N'/tern of/', N'phrasal verb', N'Turn off the light.', N'Desligue a luz.'),
(@W4, N'look for', N'procurar', N'/luk for/', N'phrasal verb', N'I look for my phone.', N'Eu procuro meu celular.'),
(@W5, N'give up', N'desistir', N'/giv ^p/', N'phrasal verb', N'Never give up.', N'Nunca desista.'),
(@W6, N'find out', N'descobrir', N'/faind aut/', N'phrasal verb', N'I found out the truth.', N'Eu descobri a verdade.'),
(@W7, N'take off', N'decolar/tirar', N'/teik of/', N'phrasal verb', N'The plane takes off.', N'O aviao decola.'),
(@W8, N'truth', N'verdade', N'/truth/', N'noun', N'Tell the truth.', N'Diga a verdade.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 23: Gerunds & Infinitives  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 23, N'Gerunds & Infinitives', N'Gerunds & Infinitives', N'(B1) Escolher entre -ing e to + verbo apos outro verbo (enjoy doing x want to do).', 23);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Gerunds & Infinitives', N'intro', N'{"heading":"Gerunds & Infinitives","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 23"}'),
(@L, 2, N'Verb + -ing (Gerund)', N'table', N'{"heading":"Verbs + Gerund","headers":["Verb","Exemplo"],"rows":[["enjoy","I enjoy reading"],["avoid","She avoids eating sugar"],["finish","I finished working"],["keep","Keep trying"]]}'),
(@L, 3, N'Verb + to (Infinitive)', N'table', N'{"heading":"Verbs + Infinitive","headers":["Verb","Exemplo"],"rows":[["want","I want to learn"],["decide","She decided to leave"],["need","I need to sleep"],["hope","We hope to win"]]}'),
(@L, 4, N'like / love / hate', N'theory', N'{"heading":"Preferences","points":["like/love/hate + -ing (geral): I like cooking.","Tambem aceitam to + verbo com sentido parecido: I like to cook.","would like + to: I would like to go (pedido educado)."]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Say 3 things you enjoy doing"},{"number":2,"text":"Say 3 things you want to do this year"},{"number":3,"text":"Complete sentences choosing -ing or to"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I enjoy ___ books.', N'reading', N'["read","to read","reading","reads"]', N'enjoy + gerundio (-ing).', 1),
(@L, N'multiple_choice', N'She wants ___ English.', N'to learn', N'["learning","to learn","learn","learns"]', N'want + to + verbo.', 2),
(@L, N'fill_blank', N'Complete: I need ___ (sleep) now.', N'to sleep', NULL, N'need + to + verbo.', 3),
(@L, N'multiple_choice', N'He avoided ___ to her.', N'talking', N'["talk","to talk","talking","talks"]', N'avoid + gerundio (-ing).', 4),
(@L, N'translation', N'Traduza: ''Eu decidi viajar.''', N'I decided to travel.', NULL, N'decide + to + verbo.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'enjoy', N'apreciar/curtir', N'/in''djoi/', N'verb', N'I enjoy music.', N'Eu curto musica.'),
(@W2, N'avoid', N'evitar', N'/e''void/', N'verb', N'Avoid junk food.', N'Evite comida ruim.'),
(@W3, N'decide', N'decidir', N'/di''said/', N'verb', N'I decided to go.', N'Eu decidi ir.'),
(@W4, N'need', N'precisar', N'/nid/', N'verb', N'I need to rest.', N'Eu preciso descansar.'),
(@W5, N'hope', N'esperar/torcer', N'/houp/', N'verb', N'I hope to win.', N'Espero vencer.'),
(@W6, N'finish', N'terminar', N'/''finish/', N'verb', N'I finished working.', N'Terminei de trabalhar.'),
(@W7, N'keep', N'continuar/manter', N'/kip/', N'verb', N'Keep going.', N'Continue.'),
(@W8, N'learn', N'aprender', N'/lern/', N'verb', N'I want to learn.', N'Eu quero aprender.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 24: Connectors & Paragraph Writing  (B1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 24, N'Connectors & Paragraph Writing', N'Connectors', N'(B1) Organizar ideias em textos curtos coerentes com and, but, so, because, although e sequenciadores.', 24);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Connectors & Writing', N'intro', N'{"heading":"Connectors & Writing","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 24"}'),
(@L, 2, N'Linking Words', N'table', N'{"heading":"Basic Connectors","headers":["Connector","Funcao"],"rows":[["and","adicao"],["but","contraste"],["so","consequencia"],["because","causa"],["although","concessao"]]}'),
(@L, 3, N'Sequencers', N'examples', N'{"heading":"Ordering Ideas","sections":[{"title":"Sequencia","formula":"First, ... Then, ... After that, ... Finally, ...","examples":["First, I woke up.","Then, I had coffee.","Finally, I went to work."]}]}'),
(@L, 4, N'Building a Paragraph', N'theory', N'{"heading":"Paragraph Structure","points":["Comece com uma frase principal (topic sentence).","Desenvolva com 2-3 frases de apoio usando conectores.","Feche com uma conclusao curta."]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Join sentences with and, but, so, because"},{"number":2,"text":"Write a short paragraph about your weekend (5 sentences)"},{"number":3,"text":"Use sequencers to describe a process"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'I was tired, ___ I went to bed early.', N'so', N'["but","so","because","although"]', N'Consequencia -> so.', 1),
(@L, N'multiple_choice', N'She studied a lot, ___ she failed.', N'but', N'["so","and","but","because"]', N'Contraste -> but.', 2),
(@L, N'fill_blank', N'Complete: I stayed home ___ it was raining. (causa)', N'because', NULL, N'Causa -> because.', 3),
(@L, N'multiple_choice', N'Which word shows contrast at the start of a clause?', N'although', N'["so","and","because","although"]', N'although = embora (concessao/contraste).', 4),
(@L, N'translation', N'Traduza: ''Eu gosto de cha, mas prefiro cafe.''', N'I like tea, but I prefer coffee.', NULL, N'Contraste com but.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'and', N'e', N'/aend/', N'conjunction', N'Tea and coffee.', N'Cha e cafe.'),
(@W2, N'but', N'mas', N'/b^t/', N'conjunction', N'Cheap but good.', N'Barato mas bom.'),
(@W3, N'so', N'entao/portanto', N'/sou/', N'conjunction', N'I was late, so I ran.', N'Eu estava atrasado, entao corri.'),
(@W4, N'because', N'porque', N'/bi''koz/', N'conjunction', N'I left because I was tired.', N'Eu sai porque estava cansado.'),
(@W5, N'although', N'embora', N'/ol''dhou/', N'conjunction', N'Although it was hard.', N'Embora fosse dificil.'),
(@W6, N'then', N'entao/depois', N'/dhen/', N'adverb', N'Then I left.', N'Entao eu sai.'),
(@W7, N'prefer', N'preferir', N'/pri''fer/', N'verb', N'I prefer coffee.', N'Eu prefiro cafe.'),
(@W8, N'paragraph', N'paragrafo', N'/''paeregraef/', N'noun', N'Write a paragraph.', N'Escreva um paragrafo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO
