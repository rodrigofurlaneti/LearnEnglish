-- ============================================================
-- LearnEnglish - Migration V3
-- Modulo 1 - Basico (A1-A2) - Licoes 1-12
-- Teacher Katrine Riccaldoni  |  Curriculo CEFR
-- ContentType: intro | theory | table | examples | practice | closing
-- ExerciseType: multiple_choice | fill_blank | identify_past | translation | pronunciation
-- ============================================================
USE learnenglish;
GO

-- ------------------------------------------------------------
-- ATENCAO: realinhamento ao curriculo de 4 modulos (LessonNumber 1-48).
-- Como a numeracao das licoes existentes (L1-L7) muda, este script
-- limpa o conteudo de curso e o repovoa do zero, na nova ordem.
-- (Tabelas de progresso de usuario sao limpas por causa das FKs.)
-- ------------------------------------------------------------
DELETE FROM ExerciseAttempts;
DELETE FROM WordInteractions;
DELETE FROM UserProgress;
DELETE FROM LessonWords;
DELETE FROM Slides;
DELETE FROM Exercises;
DELETE FROM Words;
DELETE FROM Lessons;
GO

-- ==========================================================
-- LESSON 1: The Alphabet & Sounds (Phonics)  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 1, N'The Alphabet & Sounds (Phonics)', N'Phonics', N'(A1) Alfabetizacao em ingles: as 26 letras e os sons que elas representam. Base para ler e pronunciar palavras novas.', 1);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'The Alphabet & Sounds', N'intro', N'{"heading":"The Alphabet & Sounds","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 1"}'),
(@L, 2, N'Letras x Sons', N'theory', N'{"heading":"Letras x Sons (Phonics)","points":["O ingles tem 26 letras, mas cerca de 44 sons (fonemas). Uma mesma letra pode ter sons diferentes.","Aprender phonics e relacionar cada letra/combinacao ao seu som - isso destrava leitura, escuta e pronuncia.","Comece pelos sons curtos das vogais e pelas consoantes mais comuns."]}'),
(@L, 3, N'As 5 vogais', N'table', N'{"heading":"Short Vowel Sounds","headers":["Vogal","Som","Exemplo"],"rows":[["a","/ae/","cat"],["e","/e/","bed"],["i","/i/","sit"],["o","/o/","dog"],["u","/^/","sun"]]}'),
(@L, 4, N'Digrafos importantes', N'table', N'{"heading":"Common Digraphs","headers":["Letras","Som","Exemplo"],"rows":[["sh","/sh/","ship"],["ch","/tch/","chair"],["th","/th/ (surdo)","think"],["th","/dh/ (sonoro)","this"],["ph","/f/","phone"],["wh","/w/","what"]]}'),
(@L, 5, N'Sons que nao existem no portugues', N'theory', N'{"heading":"Sons novos para brasileiros","points":["O TH de ''think'' e ''this'' - lingua entre os dentes.","O /ae/ de ''cat'' - entre o A e o E.","O H aspirado de ''hello'', ''house'' - sopro de ar (nao mudo como em portugues)."]}'),
(@L, 6, N'Soletrando (Spelling)', N'examples', N'{"heading":"Let''s Spell!","sections":[{"title":"Soletrar o nome","formula":"How do you spell your name?","examples":["A-N-A","J-O-H-N","M-A-R-I-A"]}]}'),
(@L, 7, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Spell your full name out loud"},{"number":2,"text":"Read 10 simple CVC words: cat, dog, sun, bed, big"},{"number":3,"text":"Find 3 words with the TH sound"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Which word has the /sh/ sound?', N'ship', N'["ship","cat","dog","sun"]', N'''sh'' em ''ship'' produz o som /sh/.', 1),
(@L, N'multiple_choice', N'How many letters does the English alphabet have?', N'26', N'["24","26","27","28"]', N'O alfabeto ingles tem 26 letras.', 2),
(@L, N'multiple_choice', N'Which word starts with the TH sound (as in ''this'')?', N'the', N'["the","sun","fan","pen"]', N'''the'' comeca com o TH sonoro /dh/.', 3),
(@L, N'fill_blank', N'Complete the word: _at (a small animal that says ''meow'').', N'cat', NULL, N'c + at = cat (gato).', 4),
(@L, N'multiple_choice', N'The letter ''a'' in ''cat'' has which sound?', N'/ae/', N'["/ae/","/o/","/e/","/u/"]', N'Em ''cat'' o ''a'' tem o som curto /ae/.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'cat', N'gato', N'/kaet/', N'noun', N'The cat is black.', N'O gato e preto.'),
(@W2, N'dog', N'cachorro', N'/dog/', N'noun', N'The dog is big.', N'O cachorro e grande.'),
(@W3, N'sun', N'sol', N'/s^n/', N'noun', N'The sun is hot.', N'O sol e quente.'),
(@W4, N'bed', N'cama', N'/bed/', N'noun', N'My bed is soft.', N'Minha cama e macia.'),
(@W5, N'ship', N'navio', N'/ship/', N'noun', N'The ship is big.', N'O navio e grande.'),
(@W6, N'think', N'pensar', N'/think/', N'verb', N'I think in English.', N'Eu penso em ingles.'),
(@W7, N'phone', N'telefone', N'/foun/', N'noun', N'This is my phone.', N'Este e o meu telefone.'),
(@W8, N'house', N'casa', N'/haus/', N'noun', N'I live in a house.', N'Eu moro em uma casa.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 2: Greetings & Introductions  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 2, N'Greetings & Introductions', N'Greetings', N'(A1) Cumprimentar, se apresentar e dar informacoes pessoais basicas em ingles.', 2);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Greetings & Introductions', N'intro', N'{"heading":"Greetings & Introductions","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 2"}'),
(@L, 2, N'Saying Hello', N'theory', N'{"heading":"Saying Hello","points":["Saudacoes informais: Hi / Hello / Hey.","Saudacoes pelo periodo: Good morning / Good afternoon / Good evening.","Ao se despedir: Goodbye / Bye / See you / Good night."]}'),
(@L, 3, N'Introducing Yourself', N'examples', N'{"heading":"Introducing Yourself","sections":[{"title":"Nome","formula":"What''s your name? - My name is... / I''m...","examples":["What''s your name?","My name is Rodrigo","I''m Rodrigo"]},{"title":"Origem","formula":"Where are you from? - I''m from...","examples":["Where are you from?","I''m from Brazil"]}]}'),
(@L, 4, N'Polite Expressions', N'table', N'{"heading":"Magic Words","headers":["English","Portugues"],"rows":[["Please","Por favor"],["Thank you","Obrigado(a)"],["You''re welcome","De nada"],["Sorry / Excuse me","Desculpe / Com licenca"],["Nice to meet you","Prazer em conhecer"]]}'),
(@L, 5, N'Countries & Nationalities', N'table', N'{"heading":"Countries & Nationalities","headers":["Country","Nationality"],"rows":[["Brazil","Brazilian"],["The USA","American"],["England","English"],["Spain","Spanish"],["Italy","Italian"]]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Introduce yourself (name, country)"},{"number":2,"text":"Greet a partner using the correct time of day"},{"number":3,"text":"Use ''please'' and ''thank you'' in a short dialogue"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'How do you ask someone''s name?', N'What''s your name?', N'["What''s your name?","How old you?","Where you go?","Who am I?"]', N'''What''s your name?'' = Qual e o seu nome?', 1),
(@L, N'multiple_choice', N'You meet someone at 9 a.m. You say:', N'Good morning', N'["Good morning","Good night","Good evening","Goodbye"]', N'De manha usamos ''Good morning''.', 2),
(@L, N'fill_blank', N'Complete: I''m ___ Brazil.', N'from', NULL, N'''I''m from Brazil'' = Eu sou do Brasil.', 3),
(@L, N'multiple_choice', N'Someone says ''Thank you''. You answer:', N'You''re welcome', N'["You''re welcome","Please","Sorry","Hello"]', N'''You''re welcome'' = De nada.', 4),
(@L, N'translation', N'Traduza: ''Prazer em conhecer voce.''', N'Nice to meet you.', NULL, N'Expressao fixa de cortesia ao conhecer alguem.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'hello', N'ola', N'/he''lou/', N'interjection', N'Hello! How are you?', N'Ola! Como vai?'),
(@W2, N'goodbye', N'tchau', N'/gud''bai/', N'interjection', N'Goodbye! See you later.', N'Tchau! Ate mais.'),
(@W3, N'name', N'nome', N'/neim/', N'noun', N'My name is Ana.', N'Meu nome e Ana.'),
(@W4, N'please', N'por favor', N'/pliz/', N'adverb', N'Coffee, please.', N'Cafe, por favor.'),
(@W5, N'thank you', N'obrigado(a)', N'/thaenk ju/', N'phrase', N'Thank you very much.', N'Muito obrigado.'),
(@W6, N'sorry', N'desculpe', N'/''sori/', N'adjective', N'Sorry, I''m late.', N'Desculpe, estou atrasado.'),
(@W7, N'country', N'pais', N'/''k^ntri/', N'noun', N'Brazil is a big country.', N'O Brasil e um pais grande.'),
(@W8, N'Brazilian', N'brasileiro(a)', N'/bre''zilien/', N'adjective', N'I am Brazilian.', N'Eu sou brasileiro.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 3: Verb to Be  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 3, N'Verb to Be', N'Verb to Be', N'(A1) Aprenda o verbo mais fundamental do ingles: to be (ser/estar). Conjugacoes no presente, passado e futuro.', 3);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Verb to Be', N'intro', N'{"heading":"Verb to Be","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 3"}'),
(@L, 2, N'O que e o Verb to Be?', N'theory', N'{"heading":"O que e o Verb to Be?","points":["Para entender o sentido do verbo to be na frase, e necessario entender o contexto da mensagem como um todo.","O verbo to be e classificado como um verbo irregular, ja que nao segue as regras de formacao do simple past e do past participle.","O verbo to be pode ser utilizado como verbo principal, mas tambem como verbo auxiliar de alguns tempos verbais."]}'),
(@L, 3, N'Conjugacao: Simple Present', N'table', N'{"heading":"Conjugacao: Simple Present","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","am","am not"],["You","are","are not"],["He/She/It","is","is not"],["We","are","are not"],["You","are","are not"],["They","are","are not"]]}'),
(@L, 4, N'Conjugacao: Simple Past', N'table', N'{"heading":"Conjugacao: Simple Past","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","was","was not"],["You","were","were not"],["He/She/It","was","was not"],["We","were","were not"],["You","were","were not"],["They","were","were not"]]}'),
(@L, 5, N'Conjugacao: Simple Future', N'table', N'{"heading":"Conjugacao: Simple Future","headers":["Subject","Afirmativa","Negativa"],"rows":[["I","will be","will not be"],["You","will be","will not be"],["He/She/It","will be","will not be"],["We","will be","will not be"],["You","will be","will not be"],["They","will be","will not be"]]}'),
(@L, 6, N'Estrutura', N'examples', N'{"heading":"Estrutura","subheading":"Affirmative form","formula":"Subject + verb to be + complement","examples":["He is a mechanical engineer","He was a mechanical engineer","He will be a mechanical engineer"]}'),
(@L, 7, N'Formas Negativa e Interrogativa', N'examples', N'{"heading":"Formas Negativa e Interrogativa","sections":[{"title":"Negative form","formula":"Subject + verb to be + not + complement","examples":["He is not a mechanical engineer","He was not a mechanical engineer","He will not be a mechanical engineer"]},{"title":"Interrogative form","formula":"Verb to be + subject + complement","examples":["Is he a mechanical engineer?","Was he a mechanical engineer?","Will he be a mechanical engineer?"]}]}'),
(@L, 8, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Make an affirmative sentence about you"},{"number":2,"text":"Ask a question"},{"number":3,"text":"Make a negative sentence about someone"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Complete the sentence: I ___ a student.', N'am', N'["am","is","are","were"]', N'Para o sujeito "I" no Simple Present, usamos "am". Ex: I am happy.', 1),
(@L, N'multiple_choice', N'Choose the correct sentence:', N'She is a teacher.', N'["She am a teacher.","She is a teacher.","She are a teacher.","She be a teacher."]', N'He/She/It usa "is" no Simple Present.', 2),
(@L, N'fill_blank', N'Complete: They ___ students.', N'are', NULL, N'Para "They" (e We, You), usamos "are" no Simple Present.', 3),
(@L, N'multiple_choice', N'What is the past form of "is"?', N'was', N'["was","were","be","been"]', N'I/He/She/It -> was no Simple Past. We/You/They -> were.', 4);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'to be', N'ser/estar', N'/tu bi/', N'verb', N'I want to be a doctor.', N'Eu quero ser medico.'),
(@W2, N'engineer', N'engenheiro(a)', N'/endji''nir/', N'noun', N'He is an engineer.', N'Ele e engenheiro.'),
(@W3, N'teacher', N'professor(a)', N'/''titcher/', N'noun', N'She is a teacher.', N'Ela e professora.'),
(@W4, N'student', N'estudante', N'/''stiudent/', N'noun', N'I am a student.', N'Eu sou estudante.'),
(@W5, N'happy', N'feliz', N'/''haepi/', N'adjective', N'We are happy.', N'Nos estamos felizes.'),
(@W6, N'tired', N'cansado(a)', N'/''taierd/', N'adjective', N'I am tired.', N'Eu estou cansado.'),
(@W7, N'doctor', N'medico(a)', N'/''doktor/', N'noun', N'She is a doctor.', N'Ela e medica.'),
(@W8, N'friend', N'amigo(a)', N'/frend/', N'noun', N'You are my friend.', N'Voce e meu amigo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 4: Numbers, Dates & Time  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 4, N'Numbers, Dates & Time', N'Numbers & Time', N'(A1) Dizer e entender numeros, precos, horarios e datas em ingles.', 4);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Numbers, Dates & Time', N'intro', N'{"heading":"Numbers, Dates & Time","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 4"}'),
(@L, 2, N'Cardinal Numbers', N'table', N'{"heading":"Cardinal Numbers","headers":["Number","Word"],"rows":[["1-5","one, two, three, four, five"],["6-10","six, seven, eight, nine, ten"],["20 / 30","twenty / thirty"],["100 / 1000","one hundred / one thousand"]]}'),
(@L, 3, N'13 x 30 (cuidado!)', N'theory', N'{"heading":"Pronuncia: 13 x 30","points":["thirteen /thir''tin/ - acento na ULTIMA silaba (13).","thirty /''thirti/ - acento na PRIMEIRA silaba (30).","Isso vale para 14/40, 15/50, 16/60..."],"example":"I''m thirteen, not thirty!"}'),
(@L, 4, N'Telling the Time', N'examples', N'{"heading":"What time is it?","sections":[{"title":"Horas","formula":"It''s + hora + o''clock","examples":["It''s seven o''clock","It''s ten o''clock"]},{"title":"Minutos","formula":"half past / quarter past / quarter to","examples":["It''s half past six (6:30)","It''s quarter to nine (8:45)"]}]}'),
(@L, 5, N'Days, Months & Dates', N'table', N'{"heading":"Dates","headers":["Tipo","Exemplos"],"rows":[["Days","Monday, Tuesday, Wednesday..."],["Months","January, February, March..."],["Ordinals","first (1st), second (2nd), third (3rd)"],["Date","May 5th, 2026"]]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Say your phone number, one digit at a time"},{"number":2,"text":"Tell the current time"},{"number":3,"text":"Say your birthday (month + ordinal day)"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'How do you write 30?', N'thirty', N'["thirteen","thirty","thirteen","three"]', N'30 = thirty /''thirti/ (acento na 1a silaba).', 1),
(@L, N'multiple_choice', N'What time is 6:30?', N'half past six', N'["half past six","half past seven","quarter to six","six o''clock"]', N'6:30 = half past six (meia hora depois das 6).', 2),
(@L, N'fill_blank', N'Complete the ordinal: the 3rd = the ___.', N'third', NULL, N'3rd = third (terceiro).', 3),
(@L, N'multiple_choice', N'Which is a month?', N'August', N'["Monday","August","Tuesday","Friday"]', N'August (agosto) e um mes; os outros sao dias.', 4),
(@L, N'translation', N'Traduza: ''Sao nove horas.''', N'It''s nine o''clock.', NULL, N'It''s + hora + o''clock para horas exatas.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'number', N'numero', N'/''n^mber/', N'noun', N'What''s your number?', N'Qual e o seu numero?'),
(@W2, N'time', N'tempo/hora', N'/taim/', N'noun', N'What time is it?', N'Que horas sao?'),
(@W3, N'hour', N'hora', N'/aur/', N'noun', N'One hour, please.', N'Uma hora, por favor.'),
(@W4, N'day', N'dia', N'/dei/', N'noun', N'Have a nice day!', N'Tenha um bom dia!'),
(@W5, N'week', N'semana', N'/wik/', N'noun', N'See you next week.', N'Ate a proxima semana.'),
(@W6, N'month', N'mes', N'/m^nth/', N'noun', N'This month is May.', N'Este mes e maio.'),
(@W7, N'today', N'hoje', N'/te''dei/', N'adverb', N'Today is Monday.', N'Hoje e segunda.'),
(@W8, N'birthday', N'aniversario', N'/''berthdei/', N'noun', N'My birthday is in June.', N'Meu aniversario e em junho.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 5: Articles & Plural Nouns  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 5, N'Articles & Plural Nouns', N'Articles & Plurals', N'(A1) Usar a / an / the corretamente e formar o plural dos substantivos.', 5);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Articles & Plural Nouns', N'intro', N'{"heading":"Articles & Plural Nouns","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 5"}'),
(@L, 2, N'Indefinite Articles: a / an', N'examples', N'{"heading":"a / an","sections":[{"title":"a + som de consoante","formula":"a + word","examples":["a car","a book","a university"]},{"title":"an + som de vogal","formula":"an + word","examples":["an apple","an hour","an egg"]}]}'),
(@L, 3, N'Definite Article: the', N'theory', N'{"heading":"the","points":["Usamos ''the'' para algo especifico ou ja conhecido.","a/an = primeira mencao; the = algo ja mencionado ou unico.","Exemplo: I have a dog. The dog is brown."]}'),
(@L, 4, N'Regular Plurals', N'table', N'{"heading":"Plural Regular","headers":["Regra","Exemplo"],"rows":[["+ s (geral)","book > books"],["+ es (s, ss, sh, ch, x)","box > boxes"],["-y por consoante > ies","city > cities"],["-y por vogal > + s","boy > boys"]]}'),
(@L, 5, N'Irregular Plurals', N'table', N'{"heading":"Plural Irregular","headers":["Singular","Plural"],"rows":[["man","men"],["woman","women"],["child","children"],["foot","feet"],["tooth","teeth"],["person","people"]]}'),
(@L, 6, N'Os 3 sons do -s', N'theory', N'{"heading":"Pronuncia do plural -s","points":["/s/ apos sons surdos: cats, books.","/z/ apos sons sonoros e vogais: dogs, pens.","/iz/ apos s, ss, sh, ch, x: boxes, watches."]}'),
(@L, 7, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Classify 10 nouns into a / an"},{"number":2,"text":"Make the plural of: city, box, child, foot"},{"number":3,"text":"Describe objects around you using a/an/the"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Choose: I have ___ apple.', N'an', N'["a","an","the","-"]', N'''apple'' comeca com som de vogal -> ''an''.', 1),
(@L, N'multiple_choice', N'What is the plural of ''city''?', N'cities', N'["citys","cities","cityes","city"]', N'-y precedido de consoante: remove -y, adiciona -ies.', 2),
(@L, N'fill_blank', N'Complete the plural: one child, two ___.', N'children', NULL, N'child e irregular: child > children.', 3),
(@L, N'multiple_choice', N'Choose the correct article: ___ sun is hot.', N'The', N'["A","An","The","-"]', N'O sol e unico -> usamos ''the''.', 4),
(@L, N'multiple_choice', N'What is the plural of ''box''?', N'boxes', N'["boxs","boxes","boxies","box"]', N'Terminado em -x: adiciona -es -> boxes.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'apple', N'maca', N'/''aepl/', N'noun', N'I eat an apple.', N'Eu como uma maca.'),
(@W2, N'book', N'livro', N'/buk/', N'noun', N'This is a book.', N'Isto e um livro.'),
(@W3, N'city', N'cidade', N'/''siti/', N'noun', N'Sao Paulo is a big city.', N'Sao Paulo e uma cidade grande.'),
(@W4, N'child', N'crianca', N'/tchaild/', N'noun', N'The child is happy.', N'A crianca esta feliz.'),
(@W5, N'man', N'homem', N'/maen/', N'noun', N'The man is tall.', N'O homem e alto.'),
(@W6, N'woman', N'mulher', N'/''wumen/', N'noun', N'The woman is a doctor.', N'A mulher e medica.'),
(@W7, N'box', N'caixa', N'/boks/', N'noun', N'Open the box.', N'Abra a caixa.'),
(@W8, N'people', N'pessoas', N'/''pipl/', N'noun', N'Many people are here.', N'Muitas pessoas estao aqui.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 6: Pronouns & Possessives  (A1)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 6, N'Pronouns & Possessives', N'Pronouns', N'(A1) Pronomes pessoais, adjetivos possessivos e o genitivo ''s para indicar posse.', 6);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Pronouns & Possessives', N'intro', N'{"heading":"Pronouns & Possessives","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 6"}'),
(@L, 2, N'Personal Pronouns', N'table', N'{"heading":"Subject Pronouns","headers":["Ingles","Portugues"],"rows":[["I","eu"],["you","voce"],["he / she / it","ele / ela / isso"],["we","nos"],["you","voces"],["they","eles/elas"]]}'),
(@L, 3, N'Possessive Adjectives', N'table', N'{"heading":"Possessive Adjectives","headers":["Pronome","Possessivo"],"rows":[["I","my"],["you","your"],["he","his"],["she","her"],["it","its"],["we","our"],["they","their"]]}'),
(@L, 4, N'Genitive ''s', N'examples', N'{"heading":"Saxon Genitive (''s)","sections":[{"title":"Posse","formula":"Owner + ''s + thing","examples":["Maria''s car (o carro da Maria)","John''s book (o livro do John)","the dog''s tail"]}]}'),
(@L, 5, N'This / That / These / Those', N'table', N'{"heading":"Demonstratives","headers":["Perto","Longe"],"rows":[["this (singular)","that (singular)"],["these (plural)","those (plural)"]]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Describe your family using possessives (my, his, her)"},{"number":2,"text":"Point to objects: this / that / these / those"},{"number":3,"text":"Use ''s to show who owns what"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Complete: ___ name is Ana. (she)', N'Her', N'["His","Her","Your","My"]', N'she -> her (possessivo).', 1),
(@L, N'multiple_choice', N'Choose the subject pronoun for ''Maria and I'':', N'We', N'["They","We","You","He"]', N'Maria and I = we (nos).', 2),
(@L, N'fill_blank', N'Complete with ''s: This is ___ car. (John)', N'John''s', NULL, N'Genitivo saxao: John + ''s = John''s.', 3),
(@L, N'multiple_choice', N'Choose: ___ books are on the table (longe, plural).', N'Those', N'["This","That","These","Those"]', N'Longe + plural = those.', 4),
(@L, N'multiple_choice', N'Complete: The dog wags ___ tail.', N'its', N'["it''s","its","his","her"]', N'Posse de ''it'' = its (sem apostrofo).', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'my', N'meu/minha', N'/mai/', N'possessive', N'This is my house.', N'Esta e a minha casa.'),
(@W2, N'your', N'seu/sua', N'/jor/', N'possessive', N'Is this your bag?', N'Esta e a sua bolsa?'),
(@W3, N'his', N'dele', N'/hiz/', N'possessive', N'His car is new.', N'O carro dele e novo.'),
(@W4, N'her', N'dela', N'/her/', N'possessive', N'Her name is Ana.', N'O nome dela e Ana.'),
(@W5, N'family', N'familia', N'/''faemili/', N'noun', N'I love my family.', N'Eu amo minha familia.'),
(@W6, N'mother', N'mae', N'/''m^dher/', N'noun', N'My mother is kind.', N'Minha mae e gentil.'),
(@W7, N'father', N'pai', N'/''fadher/', N'noun', N'His father is a doctor.', N'O pai dele e medico.'),
(@W8, N'this', N'este/isto', N'/dhis/', N'demonstrative', N'This is my pen.', N'Esta e a minha caneta.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 7: Simple Present  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 7, N'Simple Present', N'Simple Present', N'(A2) O Simple Present e usado para habitos, rotinas, sentimentos e verdades universais.', 7);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Simple Present', N'intro', N'{"heading":"Simple Present","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 7"}'),
(@L, 2, N'What is Simple Present?', N'theory', N'{"heading":"What is Simple Present?","points":["The Simple Present is a verb tense used to talk about habits and routines.","We also use it to express feelings, opinions, and universal truths."],"example":"I like to play videogames"}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + main verb + complement","example":"I like cookies"},{"title":"Negative Form","formula":"Subject + auxiliary verb + not + main verb + complement","example":"I do not like chocolate"}]}'),
(@L, 4, N'The Structure - Interrogative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Interrogative form","formula":"Auxiliary verb + subject + main verb + complement","example":"Do we have class today?"},{"title":"Affirmative answer","formula":"Yes + subject + auxiliary verb","example":"Yes, we do"},{"title":"Negative answer","formula":"No + subject + auxiliary verb + not","example":"No, we do not"}]}'),
(@L, 5, N'Conjugacao - He/She/It', N'table', N'{"heading":"Important","subheading":"The verb form changes according to the subject","headers":["Subject","Verb form","Examples"],"rows":[["I","infinitive form","work"],["You","infinitive form","work"],["He/She/It","infinitive form + s/es/ies","works"],["We","infinitive form","work"],["You","infinitive form","work"],["They","infinitive form","work"]]}'),
(@L, 6, N'Verbs - Regras de conjugacao', N'theory', N'{"heading":"Verbs","rules":[{"rule":"Ending in -o, -z, -ss, -ch, -sh, -x: add -es","examples":["to teach > teaches","to kiss > kisses","to go > goes"]},{"rule":"Ending in -y after a consonant: remove -y and add -ies","examples":["to fly > flies","to study > studies","to worry > worries"]},{"rule":"Ending in -y after a vowel: add -s","examples":["to say > says","to play > plays"]}]}'),
(@L, 7, N'Contractions', N'examples', N'{"heading":"Contractions","contractions":[{"full":"Do + not","short":"Don''t","example":"I don''t go to the gym"},{"full":"Does + not","short":"Doesn''t","example":"He doesn''t eat sushi"}]}'),
(@L, 8, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Talk about your interests"},{"number":2,"text":"Ask about the other person"},{"number":3,"text":"Identify similarities between your interests and talk about that"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'She ___ to school every day.', N'goes', N'["go","goes","going","gone"]', N'Com He/She/It, verbos terminados em -o recebem -es: go > goes.', 1),
(@L, N'multiple_choice', N'Which is the correct NEGATIVE form?', N'He does not like coffee.', N'["He not like coffee.","He does not like coffee.","He do not likes coffee.","He doesn''t likes coffee."]', N'Na forma negativa com He/She/It: does + not + verbo na forma base.', 2),
(@L, N'fill_blank', N'Complete: She ___ (study) English every morning.', N'studies', NULL, N'study > estudar. Com She, remova o -y e adicione -ies: studies.', 3),
(@L, N'multiple_choice', N'I ___ like chocolate.', N'do not', N'["not","does not","do not","am not"]', N'Com I/You/We/They, a forma negativa e: do + not.', 4),
(@L, N'multiple_choice', N'___ he work on weekends?', N'Does', N'["Do","Does","Is","Has"]', N'Na forma interrogativa com He/She/It, usamos "Does" no inicio.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'work', N'trabalhar', N'/werk/', N'verb', N'I work every day.', N'Eu trabalho todo dia.'),
(@W2, N'study', N'estudar', N'/''st^di/', N'verb', N'She studies English.', N'Ela estuda ingles.'),
(@W3, N'like', N'gostar', N'/laik/', N'verb', N'I like cookies.', N'Eu gosto de biscoitos.'),
(@W4, N'eat', N'comer', N'/it/', N'verb', N'We eat at noon.', N'Nos comemos ao meio-dia.'),
(@W5, N'play', N'jogar/brincar', N'/plei/', N'verb', N'They play soccer.', N'Eles jogam futebol.'),
(@W6, N'go', N'ir', N'/gou/', N'verb', N'I go to the gym.', N'Eu vou a academia.'),
(@W7, N'every day', N'todo dia', N'/''evri dei/', N'phrase', N'He runs every day.', N'Ele corre todo dia.'),
(@W8, N'always', N'sempre', N'/''olweiz/', N'adverb', N'I always drink water.', N'Eu sempre bebo agua.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 8: Common Verbs & Daily Activities  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 8, N'Common Verbs & Daily Activities', N'Daily Routine', N'(A2) Ampliar o repertorio de verbos e collocations para falar da rotina diaria.', 8);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Common Verbs & Daily Activities', N'intro', N'{"heading":"Daily Activities","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 8"}'),
(@L, 2, N'Daily Routine Verbs', N'table', N'{"heading":"My Day","headers":["English","Portugues"],"rows":[["wake up","acordar"],["get up","levantar"],["take a shower","tomar banho"],["have breakfast","tomar cafe da manha"],["go to work","ir ao trabalho"],["go to bed","ir dormir"]]}'),
(@L, 3, N'Collocations: make / do / have', N'table', N'{"heading":"Important Collocations","headers":["make","do","have"],"rows":[["make a call","do homework","have lunch"],["make a decision","do the dishes","have a shower"],["make breakfast","do exercise","have a good time"]]}'),
(@L, 4, N'Sequencing the Day', N'examples', N'{"heading":"Telling Your Routine","sections":[{"title":"Connectors","formula":"first, then, after that, finally","examples":["First, I wake up.","Then, I have breakfast.","After that, I go to work.","Finally, I go to bed."]}]}'),
(@L, 5, N'Linking sounds', N'theory', N'{"heading":"Connected Speech","points":["Na fala natural, ligamos as palavras: ''get up'' soa como /ge''t^p/.","''wake up'' soa como /wei''k^p/.","Pratique falando as frases sem pausas entre as palavras."]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Describe your typical day in order"},{"number":2,"text":"Use 5 collocations with make/do/have"},{"number":3,"text":"Ask a partner about their routine"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Choose the correct collocation:', N'do homework', N'["make homework","do homework","have homework","take homework"]', N'Em ingles dizemos ''do homework''.', 1),
(@L, N'multiple_choice', N'I ___ a shower every morning.', N'take', N'["make","take","do","go"]', N'''take a shower'' = tomar banho.', 2),
(@L, N'fill_blank', N'Complete the sequence: First, then, after that, ___.', N'finally', NULL, N'''finally'' = finalmente, fecha a sequencia.', 3),
(@L, N'multiple_choice', N'Which collocation uses ''make''?', N'make a decision', N'["make a decision","make homework","make a shower","make the dishes"]', N'''make a decision'' = tomar uma decisao.', 4),
(@L, N'translation', N'Traduza: ''Eu acordo as sete horas.''', N'I wake up at seven o''clock.', NULL, N'wake up = acordar; at + hora.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'wake up', N'acordar', N'/weik ^p/', N'phrasal verb', N'I wake up early.', N'Eu acordo cedo.'),
(@W2, N'breakfast', N'cafe da manha', N'/''brekfest/', N'noun', N'I have breakfast at 7.', N'Eu tomo cafe as 7.'),
(@W3, N'shower', N'banho/chuveiro', N'/''shauer/', N'noun', N'I take a shower.', N'Eu tomo banho.'),
(@W4, N'homework', N'licao de casa', N'/''houmwerk/', N'noun', N'I do my homework.', N'Eu faco minha licao.'),
(@W5, N'lunch', N'almoco', N'/l^ntch/', N'noun', N'Let''s have lunch.', N'Vamos almocar.'),
(@W6, N'dinner', N'jantar', N'/''diner/', N'noun', N'Dinner is ready.', N'O jantar esta pronto.'),
(@W7, N'first', N'primeiro', N'/ferst/', N'adverb', N'First, I wake up.', N'Primeiro, eu acordo.'),
(@W8, N'finally', N'finalmente', N'/''faineli/', N'adverb', N'Finally, I sleep.', N'Finalmente, eu durmo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 9: There is / There are  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 9, N'There is / There are', N'There is/are', N'(A2) Descrever lugares e dizer o que existe neles com there is / there are e some/any.', 9);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'There is / There are', N'intro', N'{"heading":"There is / There are","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 9"}'),
(@L, 2, N'The Structure', N'examples', N'{"heading":"There is / There are","sections":[{"title":"Singular","formula":"There is + a/an + singular noun","examples":["There is a book on the table","There is a cat in the room"]},{"title":"Plural","formula":"There are + plural noun","examples":["There are two books","There are many people"]}]}'),
(@L, 3, N'Negative & Interrogative', N'examples', N'{"heading":"Negative & Question","sections":[{"title":"Negative","formula":"There is not / There are not","examples":["There isn''t a problem","There aren''t any chairs"]},{"title":"Question","formula":"Is there...? / Are there...?","examples":["Is there a bank near here?","Are there any apples?"]}]}'),
(@L, 4, N'Some / Any', N'theory', N'{"heading":"Some & Any","points":["some: em frases afirmativas (There are some books).","any: em negativas e perguntas (There aren''t any books / Are there any books?).","some tambem em ofertas/pedidos: Would you like some coffee?"]}'),
(@L, 5, N'Rooms & Furniture', N'table', N'{"heading":"Vocabulary","headers":["Room","Furniture"],"rows":[["bedroom","bed, wardrobe"],["kitchen","fridge, stove"],["living room","sofa, TV"],["bathroom","sink, shower"]]}'),
(@L, 6, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Describe your bedroom (There is/are...)"},{"number":2,"text":"Ask about a place using Is there/Are there"},{"number":3,"text":"Use some and any correctly"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'___ a book on the table.', N'There is', N'["There is","There are","There be","There am"]', N'Singular (a book) -> There is.', 1),
(@L, N'multiple_choice', N'___ many people at the party.', N'There are', N'["There is","There are","There has","There be"]', N'Plural (many people) -> There are.', 2),
(@L, N'fill_blank', N'Complete (negativa): There ___ any milk.', N'isn''t', NULL, N'milk e incontavel (singular): There isn''t + any.', 3),
(@L, N'multiple_choice', N'Choose: There are ___ apples in the basket.', N'some', N'["some","any","a","an"]', N'Afirmativa -> some.', 4),
(@L, N'multiple_choice', N'Make a question: ___ a bank near here?', N'Is there', N'["There is","Is there","Are there","Have there"]', N'Pergunta no singular: Is there...?', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'room', N'quarto/sala', N'/rum/', N'noun', N'There is a TV in the room.', N'Ha uma TV na sala.'),
(@W2, N'table', N'mesa', N'/''teibl/', N'noun', N'The book is on the table.', N'O livro esta na mesa.'),
(@W3, N'chair', N'cadeira', N'/tcher/', N'noun', N'There are four chairs.', N'Ha quatro cadeiras.'),
(@W4, N'bed', N'cama', N'/bed/', N'noun', N'There is a bed here.', N'Ha uma cama aqui.'),
(@W5, N'kitchen', N'cozinha', N'/''kitchen/', N'noun', N'The kitchen is big.', N'A cozinha e grande.'),
(@W6, N'some', N'alguns/um pouco', N'/s^m/', N'determiner', N'There are some books.', N'Ha alguns livros.'),
(@W7, N'any', N'algum/nenhum', N'/''eni/', N'determiner', N'Are there any apples?', N'Ha alguma maca?'),
(@W8, N'near', N'perto', N'/nir/', N'preposition', N'Is there a bank near here?', N'Ha um banco perto daqui?');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 10: Prepositions of Place & Time  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 10, N'Prepositions of Place & Time', N'Prepositions', N'(A2) Localizar objetos no espaco e situar eventos no tempo com in, on, at e outras preposicoes.', 10);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Prepositions of Place & Time', N'intro', N'{"heading":"Prepositions","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 10"}'),
(@L, 2, N'Prepositions of Place', N'table', N'{"heading":"Where is it?","headers":["Preposition","Portugues"],"rows":[["in","dentro de"],["on","sobre/em cima"],["under","embaixo"],["next to","ao lado de"],["between","entre"],["behind","atras"],["in front of","na frente de"]]}'),
(@L, 3, N'Prepositions of Time: in / on / at', N'table', N'{"heading":"When?","headers":["Preposition","Uso","Exemplo"],"rows":[["in","meses, anos, estacoes","in July, in 2026"],["on","dias e datas","on Monday, on May 5th"],["at","horas e momentos","at 7 o''clock, at night"]]}'),
(@L, 4, N'Examples', N'examples', N'{"heading":"Place & Time Together","sections":[{"title":"Place","formula":"Subject + be + preposition + place","examples":["The cat is under the table","The keys are next to the phone"]},{"title":"Time","formula":"event + in/on/at + time","examples":["I work in the morning","We meet on Friday","The class starts at 8"]}]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Describe where 5 objects are in the room"},{"number":2,"text":"Complete sentences with in/on/at (time)"},{"number":3,"text":"Say where and when you have your classes"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'The book is ___ the table.', N'on', N'["in","on","under","at"]', N'Em cima de uma superficie -> on.', 1),
(@L, N'multiple_choice', N'My birthday is ___ June.', N'in', N'["in","on","at","to"]', N'Meses -> in.', 2),
(@L, N'fill_blank', N'Complete: The class starts ___ 8 o''clock.', N'at', NULL, N'Horas -> at.', 3),
(@L, N'multiple_choice', N'We have a meeting ___ Monday.', N'on', N'["in","on","at","of"]', N'Dias da semana -> on.', 4),
(@L, N'multiple_choice', N'The cat is ___ the chairs (no meio).', N'between', N'["between","under","on","behind"]', N'No meio de dois -> between.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'in', N'em/dentro', N'/in/', N'preposition', N'in the box', N'dentro da caixa'),
(@W2, N'on', N'sobre/em', N'/on/', N'preposition', N'on the wall', N'na parede'),
(@W3, N'under', N'embaixo', N'/''^nder/', N'preposition', N'under the bed', N'embaixo da cama'),
(@W4, N'next to', N'ao lado de', N'/nekst tu/', N'preposition', N'next to the door', N'ao lado da porta'),
(@W5, N'between', N'entre', N'/bi''twin/', N'preposition', N'between the cars', N'entre os carros'),
(@W6, N'behind', N'atras', N'/bi''haind/', N'preposition', N'behind the house', N'atras da casa'),
(@W7, N'morning', N'manha', N'/''morning/', N'noun', N'in the morning', N'de manha'),
(@W8, N'night', N'noite', N'/nait/', N'noun', N'at night', N'a noite');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 11: Can / Can't (Ability)  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 11, N'Can / Can''t (Ability)', N'Modal Can', N'(A2) Falar sobre habilidades e permissoes com o verbo modal can / can''t.', 11);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Can / Can''t', N'intro', N'{"heading":"Can / Can''t","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 11"}'),
(@L, 2, N'Using Can', N'theory', N'{"heading":"What does ''can'' mean?","points":["Usamos ''can'' para habilidade (I can swim).","Tambem para permissao e pedidos (Can I go? Can you help me?).","''can'' e seguido do verbo na forma base, sem ''to''."]}'),
(@L, 3, N'The Structure', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative","formula":"Subject + can + verb","examples":["I can swim","She can drive"]},{"title":"Negative","formula":"Subject + can''t (cannot) + verb","examples":["I can''t cook","He can''t dance"]},{"title":"Question","formula":"Can + subject + verb?","examples":["Can you swim?","Can she drive?"]}]}'),
(@L, 4, N'Can x Can''t pronunciation', N'theory', N'{"heading":"Pronuncia: can x can''t","points":["can (afirmativo) e fraco: /ken/.","can''t (negativo) e forte e longo: /kaent/.","A diferenca esta no som e na duracao - ouca com atencao!"]}'),
(@L, 5, N'Let''s Practice!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"List 3 things you can do and 3 you can''t"},{"number":2,"text":"Ask a partner: Can you...?"},{"number":3,"text":"Make a polite request with ''Can you...?''"}]}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'Complete: I ___ swim very well.', N'can', N'["can","can to","cans","am can"]', N'''can'' + verbo base, sem ''to'' e sem -s.', 1),
(@L, N'multiple_choice', N'Choose the negative: ''He can dance.''', N'He can''t dance.', N'["He cannot to dance.","He can''t dance.","He don''t can dance.","He not can dance."]', N'Negativa: can''t (cannot) + verbo base.', 2),
(@L, N'fill_blank', N'Make a question: ___ you help me?', N'Can', NULL, N'Pergunta com can: Can + subject + verbo.', 3),
(@L, N'multiple_choice', N'Which sentence asks for permission?', N'Can I open the window?', N'["I can open the window.","Can I open the window?","I can''t open the window.","I opening the window."]', N'''Can I...?'' pede permissao.', 4),
(@L, N'translation', N'Traduza: ''Ela nao sabe dirigir.''', N'She can''t drive.', NULL, N'saber fazer algo = can; negativa = can''t.', 5);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'can', N'poder/saber', N'/ken/', N'modal', N'I can swim.', N'Eu sei nadar.'),
(@W2, N'swim', N'nadar', N'/swim/', N'verb', N'Can you swim?', N'Voce sabe nadar?'),
(@W3, N'drive', N'dirigir', N'/draiv/', N'verb', N'She can drive.', N'Ela sabe dirigir.'),
(@W4, N'cook', N'cozinhar', N'/kuk/', N'verb', N'I can''t cook.', N'Eu nao sei cozinhar.'),
(@W5, N'dance', N'dancar', N'/daens/', N'verb', N'He can dance.', N'Ele sabe dancar.'),
(@W6, N'help', N'ajudar', N'/help/', N'verb', N'Can you help me?', N'Voce pode me ajudar?'),
(@W7, N'sing', N'cantar', N'/sing/', N'verb', N'She can sing well.', N'Ela canta bem.'),
(@W8, N'well', N'bem', N'/wel/', N'adverb', N'I can swim well.', N'Eu nado bem.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO

-- ==========================================================
-- LESSON 12: Present Continuous  (A2)
-- ==========================================================
DECLARE @L UNIQUEIDENTIFIER = NEWID();
INSERT INTO Lessons (LessonId, LessonNumber, Title, Topic, Description, OrderIndex) VALUES
(@L, 12, N'Present Continuous', N'Present Continuous', N'(A2) O Present Continuous descreve acoes que estao acontecendo agora. Regras do -ing e diferenca para o Simple Present.', 12);

INSERT INTO Slides (LessonId, OrderIndex, SlideTitle, ContentType, Content) VALUES
(@L, 1, N'Present Continuous', N'intro', N'{"heading":"Present Continuous","subtitle":"Teacher Katrine Riccaldoni","lesson":"Lesson 12"}'),
(@L, 2, N'What is Present Continuous?', N'theory', N'{"heading":"What is Present Continuous?","points":["O Present Continuous e usado para descrever acoes que estao acontecendo no momento da fala.","Tambem e utilizado para falar de acoes temporarias que ocorrem ao redor do presente.","E formado pelo verbo to be (am/is/are) + verbo principal com -ing."]}'),
(@L, 3, N'Expressoes Temporais', N'theory', N'{"heading":"Expressoes Temporais","description":"Para reforcar o uso do Present Continuous, expressoes temporais sao comumente usadas.","words":[{"en":"now","pt":"agora"},{"en":"at the moment","pt":"no momento"},{"en":"at present","pt":"no presente"},{"en":"right now","pt":"agora mesmo"},{"en":"currently","pt":"atualmente"},{"en":"today","pt":"hoje"}],"example":"She is studying English right now"}'),
(@L, 4, N'The Structure - Affirmative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Affirmative form","formula":"Subject + am/is/are + verb with -ing + complement","examples":["I am studying English","She is watching TV","They are running in the park"]}]}'),
(@L, 5, N'The Structure - Negative and Interrogative', N'examples', N'{"heading":"The Structure","sections":[{"title":"Negative form","formula":"Subject + am/is/are + not + verb with -ing + complement","examples":["I am not studying","She is not watching TV"]},{"title":"Interrogative form","formula":"Am/Is/Are + subject + verb with -ing + complement","examples":["Are you studying English?","Is she watching TV?"]}]}'),
(@L, 6, N'Regras do -ing (Parte 1)', N'theory', N'{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -e precedido de consoante: retira-se o -e e acrescenta-se -ing","examples":["to dance > dancing","to take > taking","to make > making"]},{"note":"Atencao! Nao e comum usar verbos de estado (stative verbs) no Continuous, como: agree, need, believe, know, like, love, hate, want, prefer..."}]}'),
(@L, 7, N'Regras do -ing (Parte 2)', N'theory', N'{"heading":"Regras do -ing","rules":[{"rule":"Quando o verbo termina em -ie: troca-se -ie por -y e acrescenta-se -ing","examples":["to die > dying","to lie > lying"]},{"rule":"Quando o verbo e monossilabo ou dissilabo e segue o padrao consoante + vogal + consoante: duplica-se a ultima consoante e acrescenta-se -ing","examples":["to run > running","to sit > sitting","to travel > travelling","to cut > cutting"]}]}'),
(@L, 8, N'Regras do -ing - Excecoes', N'theory', N'{"heading":"Regras do -ing - Excecoes","rules":[{"rule":"Quando a ultima consoante e w ou x, ela nao e dobrada","examples":["to snow > snowing","to fix > fixing"]},{"rule":"Se a silaba tonica for a 1a silaba, nao se dobra a ultima consoante","examples":["to open > opening","to happen > happening","to listen > listening"]}]}'),
(@L, 9, N'Simple Present X Present Continuous', N'table', N'{"heading":"Simple Present X Present Continuous","headers":["","Simple Present","Present Continuous"],"rows":[["Uso","Habitos e rotinas","Acao em progresso agora"],["Verbo auxiliar","do/does","am/is/are"],["Estrutura aff.","I work","I am working"],["Estrutura neg.","I do not work","I am not working"],["Estrutura int.","Do I work?","Am I working?"]]}'),
(@L, 10, N'Vamos Praticar!', N'practice', N'{"heading":"Let''s Practice!","activities":[{"number":1,"text":"Create sentences in the Present Continuous tense"},{"number":2,"text":"Transform sentences from Simple Present to Present Continuous"},{"number":3,"text":"Try to have a quick conversation about what you are doing right now"}]}'),
(@L, 11, N'Thank You!', N'closing', N'{"heading":"Thank you!","subtitle":"See you next class!"}');

INSERT INTO Exercises (LessonId, ExerciseType, Question, CorrectAnswer, Options, Explanation, OrderIndex) VALUES
(@L, N'multiple_choice', N'She ___ (watch) TV right now.', N'is watching', N'["watches","is watching","are watching","was watching"]', N'She = He/She/It -> usa "is". Acao acontecendo agora -> -ing.', 1),
(@L, N'multiple_choice', N'Which sentence is in the Present Continuous?', N'They are playing football.', N'["They play football.","They played football.","They are playing football.","They will play football."]', N'Present Continuous: am/is/are + verbo-ing.', 2),
(@L, N'fill_blank', N'Complete: I ___ (not study) right now, I am sleeping.', N'am not studying', NULL, N'Negativa com I: am + not + verbo-ing.', 3),
(@L, N'multiple_choice', N'What is the -ing form of "run"?', N'running', N'["runing","running","runeing","runned"]', N'Consoante + vogal + consoante -> duplica-se a ultima consoante: run > running.', 4),
(@L, N'multiple_choice', N'Which verb CANNOT normally be used in the Present Continuous?', N'know', N'["go","study","know","talk"]', N'"Know" e um stative verb (verbo de estado) e nao e usado no Continuous.', 5),
(@L, N'fill_blank', N'Transform to Present Continuous: "He works every day."', N'He is working right now.', NULL, N'Simple Present -> Present Continuous: He works > He is working.', 6),
(@L, N'translation', N'Traduza: "Elas estao cantando uma musica bonita."', N'They are singing a beautiful song.', NULL, N'They + are + singing (cantar>singing). Uma musica = a song.', 7);

DECLARE @W1 UNIQUEIDENTIFIER = NEWID();
DECLARE @W2 UNIQUEIDENTIFIER = NEWID();
DECLARE @W3 UNIQUEIDENTIFIER = NEWID();
DECLARE @W4 UNIQUEIDENTIFIER = NEWID();
DECLARE @W5 UNIQUEIDENTIFIER = NEWID();
DECLARE @W6 UNIQUEIDENTIFIER = NEWID();
DECLARE @W7 UNIQUEIDENTIFIER = NEWID();
DECLARE @W8 UNIQUEIDENTIFIER = NEWID();
INSERT INTO Words (WordId, WordEn, WordPt, Phonetic, WordType, ExampleSentence, ExampleTranslation) VALUES
(@W1, N'now', N'agora', N'/nau/', N'adverb', N'I am working now.', N'Eu estou trabalhando agora.'),
(@W2, N'watch', N'assistir', N'/wotch/', N'verb', N'She is watching TV.', N'Ela esta assistindo TV.'),
(@W3, N'run', N'correr', N'/r^n/', N'verb', N'They are running.', N'Eles estao correndo.'),
(@W4, N'sing', N'cantar', N'/sing/', N'verb', N'He is singing.', N'Ele esta cantando.'),
(@W5, N'study', N'estudar', N'/''st^di/', N'verb', N'I am studying English.', N'Eu estou estudando ingles.'),
(@W6, N'right now', N'agora mesmo', N'/rait nau/', N'phrase', N'I am busy right now.', N'Estou ocupado agora mesmo.'),
(@W7, N'song', N'musica/cancao', N'/song/', N'noun', N'A beautiful song.', N'Uma musica bonita.'),
(@W8, N'currently', N'atualmente', N'/''k^rentli/', N'adverb', N'I am currently learning.', N'Atualmente estou aprendendo.');
INSERT INTO LessonWords (LessonId, WordId) VALUES
(@L, @W1), (@L, @W2), (@L, @W3), (@L, @W4), (@L, @W5), (@L, @W6), (@L, @W7), (@L, @W8);
GO
