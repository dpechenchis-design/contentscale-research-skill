# ContentSCALE Research skill

Скіл для Claude Code, який робить content research: збирає пости акаунта клієнта й конкурентів в Instagram і TikTok, відбирає ті, що реально залетіли (перегляди ≥ 2× підписники), робить транскрипти й визначає тип відео за кадрами, і складає все в одну research-таблицю (.xlsx, за бажанням у Google Sheets).

## Що отримаєш

- `clients/<клієнт>/research/<Client> research (IG+Tik Tok).xlsx`: вкладки `Best performing content IG / Tik Tok`, `Competitors (IG) / (Tik Tok)`, `Carousels`, `Why selected`. Біля кожного відео `Type` і `Transcript`.
- `reference_records.json`: повні записи з транскриптами, типом і джерелом кожної цифри.
- `research_log.md`: акаунти, підписники з джерелом і датою, статистика правила 2×.

Правила, які скіл не порушує: цифри тільки з експорту, немає числа → порожньо; конкурентів, яких знайшов AI, показує тобі на погодження; «Approved?» ставить людина; немає транскрипту → так і пише.

## Встановлення

Найпростіше: відкрий Claude Code і напиши:

> Встанови скіл з https://github.com/dpechenchis-design/contentscale-research-skill: склонуй репо в ~/Downloads і запусти install.sh

Або вручну в терміналі:

```bash
git clone https://github.com/dpechenchis-design/contentscale-research-skill ~/Downloads/contentscale-research-skill
sh ~/Downloads/contentscale-research-skill/install.sh
```

Або як плагін у Claude Code:

```
/plugin marketplace add dpechenchis-design/contentscale-research-skill
/plugin install contentscale-research@contentscale-research
```

`install.sh` копіює скіл у `~/.claude/skills/cs-content-research` і створює Python-середовище `~/.contentscale-venv` (openpyxl, faster-whisper). Після встановлення перезапусти Claude Code.

## Що потрібно один раз

- macOS з `python3` і відео-інструменти: `brew install yt-dlp ffmpeg`.
- Для Instagram: розширення [Sort Feed](https://sortfeed.com) у Chrome (Pro), вхід в Instagram у цьому Chrome, і конектор SortFeed у Claude (`+` → Connectors). Під час research Chrome має бути відкритий. Без SortFeed скіл працює повільнішим запасним способом через браузер.
- TikTok збирається сам, без розширень.
- Щоб таблиця лягла в Google Sheets: конектор Google Drive у Claude.

## Як запустити

У Claude Code, у папці, де лежатимуть клієнти, напиши, наприклад:

> Зроби research для клієнта Acme Studio. Акаунт: Instagram @acme.studio, TikTok @acmestudio. Конкуренти: Instagram @rival_one, @rival_two. Період 12 місяців. Таблицю завантаж у Google Sheets і дай посилання.

Скіл спитає те, чого бракує (ніша, формати, винятки з правила 2×), і зупиниться, якщо треба погодити конкурентів, знайдених AI.

## Що всередині

| Шлях | Що це |
|---|---|
| `skills/cs-content-research/SKILL.md` | Процес по кроках: бриф, акаунти, збір, правило 2×, шортлист і Type, таблиця, QA |
| `skills/cs-content-research/scripts/` | Збір TikTok, розбір експортів SortFeed, кадри й транскрипти, запис таблиці, `setup.sh` |
| `skills/cs-content-research/references/` | Шаблон брифу, правила Type, налаштування SortFeed, запасні способи збору |
| `skills/cs-content-research/brain/` | Рішення команди й планка якості, за якими скіл перевіряє результат |
| `skills/cs-content-research/assets/research_template.xlsx` | Шаблон таблиці |

Частина ContentSCALE OS. Імена клієнтів і конкурентів у прикладах замінено нейтральними.
