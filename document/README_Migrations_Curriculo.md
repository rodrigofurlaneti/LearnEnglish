# LearnEnglish — Migrations do Currículo Completo (48 lições)

Estas migrations populam o banco `learnenglish` com o curso inteiro, alinhado ao
currículo CEFR de 4 módulos (do zero à fluência), seguindo o mesmo padrão da
professora Katrine Riccaldoni (tabelas `Lessons`, `Slides`, `Exercises`,
`Words`, `LessonWords`).

## Ordem de execução (importante)

Rode **nesta ordem**, após o schema base já existir:

1. `V3_Modulo1_Basico_A1-A2.sql` — Lições 1–12 (A1–A2)
2. `V4_Modulo2_Intermediario_B1.sql` — Lições 13–24 (B1)
3. `V5_Modulo3_Avancado_B2.sql` — Lições 25–36 (B2)
4. `V6_Modulo4_Fluente_C1-C2.sql` — Lições 37–48 (C1–C2)

> **Atenção:** o `V3` começa limpando o conteúdo de curso existente
> (`Lessons`, `Slides`, `Exercises`, `Words`, `LessonWords`) e as tabelas de
> progresso (`UserProgress`, `ExerciseAttempts`, `WordInteractions`, por causa
> das FKs), e repovoa tudo do zero com a numeração nova (1–48). Isso foi
> necessário porque as lições existentes (Verb to Be, Simple Present, etc.)
> mudaram de posição para se alinhar ao currículo. O conteúdo rico que já existia
> foi **reaproveitado** nas posições corretas (lições 3, 7, 12, 13, 14, 16).

## Conteúdo gerado

| Módulo | Nível | Lições | Slides | Exercícios | Palavras |
|--------|-------|--------|--------|------------|----------|
| 1 — Básico | A1–A2 | 1–12 | 81 | 61 | 96 |
| 2 — Intermediário | B1 | 13–24 | 86 | 65 | 98 |
| 3 — Avançado | B2 | 25–36 | 72 | 60 | 96 |
| 4 — Fluente | C1–C2 | 37–48 | 72 | 60 | 96 |
| **Total** | | **48** | **311** | **246** | **386** |

Cada lição traz: slides (intro, theory, table, examples, practice, closing),
exercícios (multiple_choice, fill_blank, identify_past, translation,
pronunciation) e 8 palavras bilíngues (EN/PT) com fonética e frase de exemplo,
ligadas via `LessonWords`.

## Ajuste no C# (DeriveLevel)

O schema não tem coluna de nível/módulo — o nível é derivado de `LessonNumber`.
Como agora há 48 lições em 4 faixas, atualize o `DeriveLevel` para o novo
mapeamento CEFR:

```csharp
static string DeriveLevel(int lessonNumber) => lessonNumber switch
{
    <= 12 => "Beginner",      // Módulo 1 (A1–A2)
    <= 24 => "Intermediate",  // Módulo 2 (B1)
    <= 36 => "Advanced",      // Módulo 3 (B2)
    _     => "Fluent"         // Módulo 4 (C1–C2)
};
```

O nível CEFR de cada lição também está no início do campo `Description`
(ex.: `(A1) ...`, `(B2) ...`), caso queira exibi-lo na interface.

## Observação sobre fonética

As transcrições fonéticas usam aproximações em ASCII (ex.: `/ae/`, `/dh/`, `/^/`)
para evitar problemas de codificação no SQL. Se quiser IPA completo (ɪ, ʌ, ð, æ),
dá para trocar numa migration futura — os campos `Phonetic` e `AudioUrl` já
suportam isso.
