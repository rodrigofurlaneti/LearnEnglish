-- ============================================================
-- LearnEnglish - Migration V2
-- Popula L2 (Verb to Be - Prática) + Adiciona L5-L7
-- Sem alterações de schema: Level e DurationMinutes são
-- computados no C# (DeriveLevel + slides*2)
-- ============================================================
-- ContentType (lowercase): intro | theory | table | examples | practice | closing
-- ExerciseType (snake_case): multiple_choice | fill_blank | identify_past | translation | pronunciation
-- ============================================================
USE learnenglish;
GO

-- ============================================================
-- L2: VERB TO BE - PRÁTICA  (preencher slides faltantes)
-- ============================================================
DECLARE @L2 UNIQUEIDENTIFIER;
SELECT @L2 = LessonId FROM Lessons WHERE LessonNumber = 2;

-- Limpar slides existentes (segurança)
DELETE FROM Slides WHERE LessonId = @L2;

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L2, 1, 'Verb to Be', 'intro',
 '{"heading":"Verb to Be","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 2"}'),

(@L2, 2, 'O que é o Verb to Be?', 'theory',
 '{"heading":"O que é o Verb to Be?","points":["Para entender o sentido do verbo to be na frase, é necessário entender o contexto da mensagem como um todo.","O verbo to be é classificado como um verbo irregular, já que não segue as regras de formação do simple past e do past participle.","O verbo to be pode ser utilizado como verbo principal, mas também como verbo auxiliar de alguns tempos verbais."]}'),

(@L2, 3, 'Conjugação: Simple Present', 'table',
 '{"heading":"Conjugação: Simple Present","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","am","am not"],["You","are","are not"],["He/She/It","is","is not"],["We","are","are not"],["You","are","are not"],["They","are","are not"]]}'),

(@L2, 4, 'Conjugação: Simple Past', 'table',
 '{"heading":"Conjugação: Simple Past","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","was","was not"],["You","were","were not"],["He/She/It","was","was not"],["We","were","were not"],["You","were","were not"],["They","were","were not"]]}'),

(@L2, 5, 'Conjugação: Simple Future', 'table',
 '{"heading":"Conjugação: Simple Future","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","will be","will not be"],["You","will be","will not be"],["He/She/It","will be","will not be"],["We","will be","will not be"],["You","will be","will not be"],["They","will be","will not be"]]}'),

(@L2, 6, 'Estrutura - Afirmativa', 'examples',
 '{"heading":"Estrutura","sections":[{"title":"Affirmative form","formula":"Subject + verb to be + complement","examples":["He is a mechanical engineer","He was a mechanical engineer","He will be a mechanical engineer"]}]}'),

(@L2, 7, 'Formas Negativa e Interrogativa', 'examples',
 '{"heading":"Formas Negativa e Interrogativa","sections":[{"title":"Negative form","formula":"Subject + verb to be + not + complement","examples":["He is not a mechanical engineer","He was not a mechanical engineer","He will not be a mechanical engineer"]},{"title":"Interrogative form","formula":"Verb to be + subject + complement","examples":["Is he a mechanical engineer?","Was he a mechanical engineer?","Will he be a mechanical engineer?"]}]}'),

(@L2, 8, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Make an affirmative sentence about you"},{"number":2,"text":"Ask a question"},{"number":3,"text":"Make a negative sentence about someone"}]}');

-- Exercícios L2
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L2, 'multiple_choice',
 'Complete: She ___ a teacher.',
 'is',
 '["am","is","are","be"]',
 'Com He/She/It no Simple Present, usamos "is".',
 1),

(@L2, 'multiple_choice',
 'Choose the correct negative form: "They are students."',
 'They are not students.',
 '["They not are students.","They are not students.","They is not students.","They aren''t students not."]',
 'Negativa: Subject + verb to be + not + complement.',
 2),

(@L2, 'fill_blank',
 'Complete com a forma correta: I ___ at home yesterday.',
 'was',
 NULL,
 'I/He/She/It + was no Simple Past.',
 3),

(@L2, 'multiple_choice',
 'What is the interrogative form of "He is a doctor"?',
 'Is he a doctor?',
 '["He is a doctor?","Is he a doctor?","Does he a doctor?","He is doctor?"]',
 'Interrogativa: Verb to be + subject + complement.',
 4),

(@L2, 'fill_blank',
 'Complete: We ___ (not be) at school tomorrow.',
 'will not be',
 NULL,
 'Simple Future negativo: will not be. Contração: won''t be.',
 5),

(@L2, 'multiple_choice',
 'Translate to English: "Eles estavam cansados."',
 'They were tired.',
 '["They was tired.","They are tired.","They were tired.","They will be tired."]',
 '"Were" é o Simple Past para We/You/They.',
 6);

GO

-- ============================================================
-- L5: PRESENT CONTINUOUS
-- ============================================================
DECLARE @L5 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L5, 5, 'Present Continuous', 'Present Continuous',
 'O Present Continuous descreve ações que estão acontecendo agora ou ao redor do momento presente. Aprenda as regras do -ing e como diferenciá-lo do Simple Present.',
 5);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L5, 1, 'Present Continuous', 'intro',
 '{"heading":"Present Continuous","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 5"}'),

(@L5, 2, 'What is Present Continuous?', 'theory',
 '{"heading":"What is Present Continuous?","points":["O Present Continuous é usado para descrever ações que estão acontecendo no momento da fala.","Também é utilizado para falar de ações temporárias que ocorrem ao redor do presente.","É formado pelo verbo to be (am/is/are) + verbo principal com -ing."]}'),

(@L5, 3, 'Expressões Temporais', 'theory',
 '{"heading":"Expressões Temporais","description":"Para reforçar o uso do Present Continuous, expressões temporais são comumente usadas.","words":[{"en":"now","pt":"agora"},{"en":"at the moment","pt":"no momento"},{"en":"at present","pt":"no presente"},{"en":"right now","pt":"agora mesmo"},{"en":"currently","pt":"atualmente"},{"en":"today","pt":"hoje"}],"example":"She is studying English right now"}'),

(@L5, 4, 'The Structure - Affirmative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + am/is/are + verb with -ing + complement","examples":["I am studying English","She is watching TV","They are running in the park"]}]}'),

(@L5, 5, 'The Structure - Negative and Interrogative', 'examples',
 '{"heading":"The Structure","sections":[{"title":"Negative form","formula":"Subject + am/is/are + not + verb with -ing + complement","examples":["I am not studying","She is not watching TV"]},{"title":"Interrogative form","formula":"Am/Is/Are + subject + verb with -ing + complement","examples":["Are you studying English?","Is she watching TV?"]}]}'),

(@L5, 6, 'Regras do -ing (Parte 1)', 'theory',
 '{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -e precedido de consoante: retira-se o -e e acrescenta-se -ing","examples":["to dance > dancing","to take > taking","to make > making"]},{"note":"Atenção! Não é comum usar verbos de estado (stative verbs) no Continuous, como: agree, need, believe, know, like, love, hate, want, prefer..."}]}'),

(@L5, 7, 'Regras do -ing (Parte 2)', 'theory',
 '{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -ie: troca-se -ie por -y e acrescenta-se -ing","examples":["to die > dying","to lie > lying"]},{"rule":"Quando o verbo é monossílabo ou dissílabo e segue o padrão consoante + vogal + consoante: duplica-se a última consoante e acrescenta-se -ing","examples":["to run > running","to sit > sitting","to travel > travelling","to cut > cutting"]}]}'),

(@L5, 8, 'Regras do -ing - Exceções', 'theory',
 '{"heading":"Regras do -ing - Exceções","rules":[{"rule":"Quando a última consoante é w ou x, ela não é dobrada","examples":["to snow > snowing","to fix > fixing"]},{"rule":"Se a sílaba tônica for a 1ª sílaba, não se dobra a última consoante","examples":["to open > opening","to happen > happening","to listen > listening"]}]}'),

(@L5, 9, 'Simple Present X Present Continuous', 'table',
 '{"heading":"Simple Present X Present Continuous","headers":["","Simple Present","Present Continuous"],"rows":[["Uso","Hábitos e rotinas","Ação em progresso agora"],["Verbo auxiliar","do/does","am/is/are"],["Estrutura aff.","I work","I am working"],["Estrutura neg.","I do not work","I am not working"],["Estrutura int.","Do I work?","Am I working?"]]}'),

(@L5, 10, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Create sentences in the Present Continuous tense"},{"number":2,"text":"Transform sentences from Simple Present to Present Continuous"},{"number":3,"text":"Try to have a quick conversation about what you are doing right now"}]}'),

(@L5, 11, 'Thank You!', 'closing',
 '{"heading":"Thank you!","subtitle":"See you next class!"}');

-- Exercícios L5
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L5, 'multiple_choice',
 'She ___ (watch) TV right now.',
 'is watching',
 '["watches","is watching","are watching","was watching"]',
 'She = He/She/It → usa "is". Ação acontecendo agora → -ing.',
 1),

(@L5, 'multiple_choice',
 'Which sentence is in the Present Continuous?',
 'They are playing football.',
 '["They play football.","They played football.","They are playing football.","They will play football."]',
 'Present Continuous: am/is/are + verbo-ing.',
 2),

(@L5, 'fill_blank',
 'Complete: I ___ (not study) right now, I am sleeping.',
 'am not studying',
 NULL,
 'Negativa com I: am + not + verbo-ing.',
 3),

(@L5, 'multiple_choice',
 'What is the -ing form of "run"?',
 'running',
 '["runing","running","runeing","runned"]',
 'Consoante + vogal + consoante → duplica-se a última consoante: run → running.',
 4),

(@L5, 'multiple_choice',
 'Which verb CANNOT normally be used in the Present Continuous?',
 'know',
 '["go","study","know","talk"]',
 '"Know" é um stative verb (verbo de estado) e não é usado no Continuous.',
 5),

(@L5, 'fill_blank',
 'Transform to Present Continuous: "He works every day."',
 'He is working right now.',
 NULL,
 'Simple Present → Present Continuous: He works → He is working.',
 6),

(@L5, 'translation',
 'Traduza: "Elas estão cantando uma música bonita."',
 'They are singing a beautiful song.',
 NULL,
 'They + are + singing (cantar→singing). Uma música = a song.',
 7);

GO

-- ============================================================
-- L6: PAST CONTINUOUS
-- ============================================================
DECLARE @L6 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L6, 6, 'Past Continuous', 'Past Continuous',
 'O Past Continuous descreve ações contínuas que ocorreram no passado. Aprenda a combiná-lo com o Simple Past usando while e when.',
 6);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L6, 1, 'Past Continuous', 'intro',
 '{"heading":"Past Continuous","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 6"}'),

(@L6, 2, 'What is Past Continuous?', 'theory',
 '{"heading":"What is Past Continuous?","points":["Past Continuous é usado para indicar ações contínuas que ocorreram no passado.","Quando expressamos duas ou mais ações simultâneas no passado, é muito comum utilizarmos while (enquanto).","Example: I was reading a book while she was watching TV"]}'),

(@L6, 3, 'Estrutura - Affirmative', 'examples',
 '{"heading":"Estrutura do Past Continuous","sections":[{"title":"Affirmative form","formula":"Subject + was/were + main verb with -ing + complement","examples":["She was going to my house","I was doing the laundry","We were eating together"]}]}'),

(@L6, 4, 'Estrutura - Negative', 'examples',
 '{"heading":"Estrutura do Past Continuous","sections":[{"title":"Negative form","formula":"Subject + was/were + not + main verb with -ing + complement","examples":["She was not (wasn''t) going to my house","I was not (wasn''t) doing the laundry","We were not (weren''t) eating together"]}]}'),

(@L6, 5, 'Estrutura - Interrogative', 'examples',
 '{"heading":"Estrutura do Past Continuous","sections":[{"title":"Interrogative form","formula":"Was/Were + subject + main verb with -ing + complement","examples":["Was she going to my house?","Was I doing the laundry?","Were we eating together?"]}]}'),

(@L6, 6, 'Pontos Importantes - When', 'theory',
 '{"heading":"Pontos Importantes","points":["Quando expressamos uma ação que aconteceu pontualmente enquanto outra estava em andamento no passado, colocamos a ação pontual no Simple Past."],"examples":["I was watching Brazil''s game when she arrived","We were talking when the teacher came","She was studying when the phone rang"]}'),

(@L6, 7, 'Pontos Importantes - Advérbios', 'theory',
 '{"heading":"Pontos Importantes","description":"Quando expressamos uma ação contínua habitual que ocorria no passado, é comum usarmos advérbios de frequência.","words":[{"en":"often","pt":"frequentemente"},{"en":"rarely","pt":"raramente"},{"en":"occasionally","pt":"ocasionalmente"},{"en":"weekly","pt":"semanalmente"},{"en":"daily","pt":"diariamente"},{"en":"monthly","pt":"mensalmente"}]}'),

(@L6, 8, 'Pontos Importantes - Expressões de Tempo', 'theory',
 '{"heading":"Pontos Importantes","description":"Para estabelecer relação temporal entre ação contínua no passado e o presente, usamos expressões de tempo.","words":[{"en":"by this time","pt":"nessa época"},{"en":"yesterday","pt":"ontem"},{"en":"last night","pt":"noite passada"},{"en":"last year","pt":"ano passado"},{"en":"last month","pt":"mês passado"},{"en":"last week","pt":"semana passada"}]}'),

(@L6, 9, 'Regras do -ing (Parte 1)', 'theory',
 '{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -e precedido de consoante: retira-se o -e e acrescenta-se -ing","examples":["to dance > dancing","to take > taking","to make > making"]},{"note":"Atenção! Não é comum usar verbos de estado no Continuous: agree, need, believe, know, like..."}]}'),

(@L6, 10, 'Regras do -ing (Parte 2)', 'theory',
 '{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -ie: troca-se -ie por -y e acrescenta-se -ing","examples":["to die > dying","to lie > lying"]},{"rule":"Quando o verbo é mono ou dissílabo CVC: duplica-se a última consoante + -ing","examples":["to travel > travelling","to cut > cutting","to run > running"]}]}'),

(@L6, 11, 'Regras do -ing - Exceções', 'theory',
 '{"heading":"Regras do -ing - Exceções","rules":[{"rule":"Quando a última consoante é w ou x: não se dobra","examples":["to snow > snowing","to fix > fixing"]},{"rule":"Se a sílaba tônica for a 1ª: não se dobra a última consoante","examples":["to open > opening","to happen > happening"]}]}'),

(@L6, 12, 'Simple Past X Past Continuous', 'table',
 '{"heading":"Simple Past X Past Continuous","headers":["","Simple Past","Past Continuous"],"rows":[["Uso","Fato pontual","Ação em progresso"],["Verbo auxiliar","did","to be (was/were)"],["Afirmativa","He went to school","He was going to school"],["Negativa","He didn''t go to school","He wasn''t going to school"],["Interrogativa","Did he go to school?","Was he going to school?"]]}'),

(@L6, 13, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Create sentences in the Past Continuous tense"},{"number":2,"text":"Transform sentences from Simple Past to Past Continuous"},{"number":3,"text":"Try to have a quick conversation"}]}'),

(@L6, 14, 'Thank You!', 'closing',
 '{"heading":"Thank you!","subtitle":"See you next class!"}');

-- Exercícios L6
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L6, 'multiple_choice',
 'She ___ TV when I called her.',
 'was watching',
 '["watched","was watching","is watching","were watching"]',
 'She = singular → was. Ação em progresso no passado → -ing.',
 1),

(@L6, 'multiple_choice',
 'Choose the correct sentence:',
 'We were eating when she arrived.',
 '["We was eating when she arrived.","We were eat when she arrived.","We were eating when she arrived.","We were eating when she was arrived."]',
 'We → were. Ação pontual (arrived) → Simple Past.',
 2),

(@L6, 'fill_blank',
 'Complete: They ___ (not sleep) when the alarm rang.',
 'were not sleeping',
 NULL,
 'They → were. Negativa: were not + -ing.',
 3),

(@L6, 'multiple_choice',
 'What is the interrogative form of "I was working"?',
 'Was I working?',
 '["I was working?","Was I working?","Did I working?","Were I working?"]',
 'Interrogativa Past Continuous: Was/Were + subject + -ing.',
 4),

(@L6, 'multiple_choice',
 'I was watching Brazil''s game ___ she arrived.',
 'when',
 '["while","when","during","because"]',
 '"When" é usado para ação pontual (Simple Past) interrompendo ação contínua (Past Continuous).',
 5),

(@L6, 'translation',
 'Traduza: "Eles estavam dormindo enquanto eu estudava."',
 'They were sleeping while I was studying.',
 NULL,
 'Duas ações simultâneas no passado → Past Continuous + while + Past Continuous.',
 6);

GO

-- ============================================================
-- L7: SIMPLE FUTURE
-- ============================================================
DECLARE @L7 UNIQUEIDENTIFIER = NEWID();

INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L7, 7, 'Simple Future', 'Simple Future',
 'O Simple Future expressa ações que acontecerão no futuro. Estude as três formas: will, going to e shall, e saiba quando usar cada uma.',
 7);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L7, 1, 'Simple Future', 'intro',
 '{"heading":"Simple Future","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 7"}'),

(@L7, 2, 'What is Simple Future?', 'theory',
 '{"heading":"What is Simple Future?","points":["O Simple Future é usado para expressar ações que irão acontecer no futuro.","Existem três formas de expressar o futuro em inglês: will, going to e shall.","Cada forma tem usos e contextos específicos que aprenderemos nesta lição."]}'),

(@L7, 3, 'Expressões Temporais', 'theory',
 '{"heading":"Expressões Temporais","description":"Expressões de tempo que reforçam o uso do Simple Future.","words":[{"en":"tomorrow","pt":"amanhã"},{"en":"soon","pt":"em breve"},{"en":"next week","pt":"semana que vem"},{"en":"next month","pt":"próximo mês"},{"en":"next year","pt":"ano que vem"},{"en":"in the future","pt":"no futuro"},{"en":"later","pt":"mais tarde"}],"example":"I will call you tomorrow"}'),

(@L7, 4, 'Will - Affirmative', 'examples',
 '{"heading":"Will - Affirmative","sections":[{"title":"Uso: decisões espontâneas, promessas, previsões","formula":"Subject + will + main verb (infinitive) + complement","examples":["I will call you later","She will travel next week","They will help us"]}]}'),

(@L7, 5, 'Will - Negative and Interrogative', 'examples',
 '{"heading":"Will - Negative and Interrogative","sections":[{"title":"Negative form","formula":"Subject + will + not + main verb + complement","examples":["I will not (won''t) call you","She will not come tomorrow"]},{"title":"Interrogative form","formula":"Will + subject + main verb + complement","examples":["Will you call me?","Will she travel?","Will they help us?"]}]}'),

(@L7, 6, 'Going to - Affirmative', 'examples',
 '{"heading":"Going to - Affirmative","sections":[{"title":"Uso: planos e intenções, previsões com evidência","formula":"Subject + am/is/are + going to + main verb + complement","examples":["I am going to study tonight","She is going to visit her parents","They are going to buy a new car"]}]}'),

(@L7, 7, 'Going to - Negative', 'examples',
 '{"heading":"Going to - Negative","sections":[{"title":"Negative form","formula":"Subject + am/is/are + not + going to + main verb + complement","examples":["I am not going to study tonight","She is not (isn''t) going to visit her parents","They are not (aren''t) going to buy a new car"]}]}'),

(@L7, 8, 'Going to - Interrogative', 'examples',
 '{"heading":"Going to - Interrogative","sections":[{"title":"Interrogative form","formula":"Am/Is/Are + subject + going to + main verb + complement","examples":["Are you going to study tonight?","Is she going to visit her parents?","Are they going to buy a new car?"]}]}'),

(@L7, 9, 'Shall - Affirmative', 'examples',
 '{"heading":"Shall - Affirmative","sections":[{"title":"Uso: sugestões, ofertas (formal/britânico), I e We","formula":"Subject (I/We) + shall + main verb + complement","examples":["I shall help you","Shall we go to the cinema?","We shall overcome"]}]}'),

(@L7, 10, 'Shall - Negative and Interrogative', 'examples',
 '{"heading":"Shall - Negative and Interrogative","sections":[{"title":"Negative form","formula":"Subject + shall + not (shan''t) + main verb","examples":["I shall not (shan''t) be late","We shall not give up"]},{"title":"Interrogative form","formula":"Shall + I/We + main verb + complement?","examples":["Shall I open the window?","Shall we start the meeting?"]}]}'),

(@L7, 11, 'Will X Shall X Going to', 'table',
 '{"heading":"Will X Shall X Going to","headers":["Forma","Uso principal","Exemplo"],"rows":[["Will","Decisão espontânea, promessa, previsão geral","I will help you (decisão agora)"],["Going to","Plano já decidido, intenção, evidência concreta","I am going to study (já planejado)"],["Shall","Sugestão/oferta formal, usado com I/We","Shall I help you?"]]}'),

(@L7, 12, 'Vamos Praticar!', 'practice',
 '{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Talk about your plans for the weekend using going to"},{"number":2,"text":"Ask about the other person''s plans"},{"number":3,"text":"Try to have a quick conversation about the future"}]}'),

(@L7, 13, 'Thank You!', 'closing',
 '{"heading":"Thank you!","subtitle":"See you next class!"}');

-- Exercícios L7
INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L7, 'multiple_choice',
 'I ___ call you later. (decisão espontânea)',
 'will',
 '["am going to","will","shall","am"]',
 '"Will" expressa decisão espontânea tomada no momento da fala.',
 1),

(@L7, 'multiple_choice',
 'She ___ visit her parents next weekend. (plano já decidido)',
 'is going to',
 '["will","is going to","shall","does"]',
 '"Going to" expressa plano ou intenção já decidida com antecedência.',
 2),

(@L7, 'fill_blank',
 'Complete: ___ I open the window? (oferta formal)',
 'Shall',
 NULL,
 '"Shall" é usado para ofertas e sugestões formais com I e We.',
 3),

(@L7, 'multiple_choice',
 'What is the negative form of "They will travel tomorrow"?',
 'They will not travel tomorrow.',
 '["They not will travel tomorrow.","They will not travel tomorrow.","They won''t to travel tomorrow.","They are not going travel tomorrow."]',
 'Negativa com will: Subject + will + not + verbo na forma base.',
 4),

(@L7, 'multiple_choice',
 'Look at the dark clouds! It ___ rain.',
 'is going to',
 '["will","shall","is going to","does"]',
 'Evidência concreta (nuvens escuras) → "going to" para previsão com evidência.',
 5),

(@L7, 'fill_blank',
 'Make the interrogative: "You will study tonight."',
 'Will you study tonight?',
 NULL,
 'Interrogativa com will: Will + subject + verbo base + complemento?',
 6),

(@L7, 'translation',
 'Traduza: "Ela vai viajar para Londres no próximo mês."',
 'She is going to travel to London next month.',
 NULL,
 'Plano definido → going to. London sem "the". next month = próximo mês.',
 7);

GO

-- ============================================================
-- RESUMO DA MIGRAÇÃO
-- ============================================================
-- L2: 8 slides + 6 exercícios  → Beginner  (2 min/slide = 16 min)
-- L5: 11 slides + 7 exercícios → Advanced  (22 min)
-- L6: 14 slides + 6 exercícios → Advanced  (28 min)
-- L7: 13 slides + 7 exercícios → Advanced  (26 min)
--
-- LEVEL (calculado por DeriveLevel no C#):
--   LessonNumber 1-2  → Beginner
--   LessonNumber 3-4  → Intermediate
--   LessonNumber 5+   → Advanced
--
-- GAPS NÃO-CRÍTICOS (para roadmap futuro):
--   - AudioUrl / ImageUrl nas slides (DTO já suporta NULL)
--   - Exercícios tipo Pronunciation (enum já existe, pronto para uso)
--   - Words bilíngues para L5-L7 (tabela Words + LessonWords já modelada)
-- ============================================================
