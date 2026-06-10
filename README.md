# LearnEnglish — Plataforma Interativa de Inglês
**Teacher Katrine Riccaldoni**

---

## Visão Geral

Plataforma de trilha contínua de ensino de inglês com:
- **Lições interativas** com slides (Verb to Be, Simple Present, Simple Past)
- **Clique em qualquer palavra** → ouve a pronúncia (Text-to-Speech)
- **Tooltip de tradução** ao passar o mouse sobre palavras-chave
- **Painel de pronúncia** com microfone (Web Speech API) e pontuação de similaridade
- **Exercícios** de múltipla escolha e preenchimento com feedback imediato
- **Trilha de progresso** persistida no localStorage (frontend) / banco de dados (API)

---

## Estrutura do Projeto

```
LearnEnglish/
├── database/
│   └── schema.sql           # Schema T-SQL + seed data completo
├── api/
│   └── LearnEnglish.API/
│       ├── Models/
│       │   └── Entities.cs  # Entidades EF Core
│       ├── Data/
│       │   └── AppDbContext.cs
│       ├── Controllers/
│       │   └── LessonsController.cs  # Lessons, Words, Progress, Exercises
│       ├── Program.cs
│       └── appsettings.json
└── frontend/
    └── index.html           # App completo (funciona standalone)
```

---

## Diagrama do Banco de Dados

```
Users ──────────┬── UserProgress ──── Lessons ──── Slides
                │                         │
                ├── ExerciseAttempts ─ Exercises
                │
                └── WordInteractions ─ Words ──── LessonWords ─ Lessons
```

### Tabelas principais

| Tabela | Descrição |
|--------|-----------|
| `Lessons` | Lições da trilha (Verb to Be, Simple Present, Simple Past) |
| `Slides` | Slides de cada lição com conteúdo em JSON |
| `Words` | Vocabulário com tradução PT, fonética IPA e exemplos |
| `LessonWords` | Relação muitos-para-muitos Lição ↔ Palavra |
| `Exercises` | Exercícios por lição (multiple_choice, fill_blank, translation) |
| `Users` | Usuários da plataforma |
| `UserProgress` | Status do progresso por usuário/lição + pontuação |
| `ExerciseAttempts` | Histórico de tentativas de exercícios |
| `WordInteractions` | Log de cliques, TTS e verificações de pronúncia |

---

## Como Rodar

### Frontend (standalone — sem backend)
1. Abra `frontend/index.html` diretamente no **Google Chrome**
2. Navegue pelas lições, clique nas palavras, faça os exercícios
3. O progresso é salvo no `localStorage` do navegador

> **Pronúncia via microfone** requer Chrome (Web Speech API) e HTTPS ou localhost.

---

### API .NET + SQL Server

#### Pré-requisitos
- .NET 8 SDK
- SQL Server (local ou Docker)

#### 1. Criar banco e seed data
```sql
-- Execute no SQL Server Management Studio ou sqlcmd
sqlcmd -S localhost -i database/schema.sql
```

#### 2. Configurar connection string
Edite `api/LearnEnglish.API/appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=SEU_SERVIDOR;Database=LearnEnglishDB;Trusted_Connection=True;TrustServerCertificate=True;"
  }
}
```

#### 3. Rodar a API
```bash
cd api/LearnEnglish.API
dotnet run
```

A API estará em `https://localhost:5001` com Swagger em `/swagger`.

---

## Endpoints da API

| Método | Rota | Descrição |
|--------|------|-----------|
| GET | `/api/lessons` | Lista todas as lições com contagem de slides/exercícios |
| GET | `/api/lessons/{id}` | Detalhes de uma lição com slides e palavras |
| GET | `/api/lessons/{id}/exercises` | Exercícios de uma lição |
| GET | `/api/words?lessonId={id}` | Vocabulário (filtrado por lição) |
| POST | `/api/words/{id}/interaction` | Registra clique/TTS/pronúncia |
| GET | `/api/progress/{userId}` | Progresso do usuário em todas as lições |
| POST | `/api/progress` | Cria ou atualiza progresso |
| POST | `/api/exercises/{id}/submit` | Submete resposta de exercício |

---

## Funcionalidades Interativas

### Text-to-Speech (TTS)
- **Verbos irregulares**: clique em qualquer par (to go → went) para ouvir
- **Expressões temporais**: clique nos chips para ouvir
- **Palavras destacadas**: clique em qualquer `palavra sublinhada` no conteúdo

### Verificação de Pronúncia
1. Clique em uma palavra
2. O painel de pronúncia abre
3. Clique **🔊 Ouvir** para ouvir a pronúncia correta
4. Clique **🎤 Pronunciar** e fale a palavra
5. Receba uma pontuação de 0–100% de similaridade

### Tooltip de Tradução
- Passe o mouse sobre qualquer **palavra azul sublinhada**
- Veja tradução PT e fonética IPA instantaneamente

---

## Próximos Passos

- [ ] Autenticação de usuários (JWT)
- [ ] Mais lições (Present Continuous, Future Tenses, etc.)
- [ ] Sistema de repetição espaçada (flashcards)
- [ ] Gamificação: XP, badges, streak diário
- [ ] App mobile (MAUI ou React Native)
- [ ] Integração com Azure Speech para pontuação de pronúncia profissional
