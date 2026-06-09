# Ticket: Interactive article series (Learning Elixir)

## Goal

Publish a structured, self-promoting tutorial series (first: *Learning Elixir*)
where each article showcases a program **and** embeds an in-browser
JavaScript reimplementation readers can run and play with.

## Design (agreed)

### Content model — every article is a `Post`; only the body source varies
- `Post` owns all metadata: `title`, `perex`, `published_at`, plus new
  `series_id` + `position`.
- New nullable `content_path` column is the **discriminator**:
  - **blank** → DB article: `body` is Markdown → rendered with
    **commonmarker + Rouge**, **HTML sanitized** (no `<script>`).
  - **set** → file article: a logical template name (e.g.
    `"post_content/pattern_matching"`) under `app/views/post_content/`,
    rendered with full view context (helpers, components, inline `<script>`).
- Both render into the existing `ArticleLayoutComponent` (template = body only).
- `content_path` is only ever set from a trusted `Post` row, never public input.

### Interactivity
- File articles are `.html.erb`, so widgets are plain HTML + inline `<script>`.
- A thin **`PlaygroundComponent`** supplies the consistent shell (card, title,
  run button, output pane, dark-mode); bespoke inputs + script go in its block.
- JS is a hand-written port of the article's Elixir program.

### Syntax highlighting
- **Rouge**, server-side. Shared by the commonmarker renderer (DB path) and an
  ERB `CodeBlockComponent` / helper (file path). No client JS.

### Series
- First-class `Series` (`has_many :posts`, `position` ordering).
- **Prev/next footer** on articles now; series landing page deferred.

### Authoring & preview
- Manual two-step: write the `.html.erb` template, then create the `Post` row in
  admin (form gains a `series` selector + `content_path` field; `body` relabeled
  "Markdown — used only when no template is set").
- Preview is local for now (give the dev row a past `published_at`).

### Testing
- Unit/render-path only: source selection (body vs template), Markdown+Rouge
  output, **DB Markdown strips `<script>` (sanitization)**, Series ordering +
  prev/next. No per-widget system tests.

## Out of scope / known trade-offs
- **CSP**: inline `<script>` in file articles means a strict Content-Security-
  Policy later would need per-block nonces/rework. Accepted for now.
- **JS↔Elixir drift**: the JS port is hand-maintained; nothing enforces fidelity.
- **Slugs**: separate follow-up ticket; routes stay `id`-based.
