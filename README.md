# dynaprez

LaTeX beamer presentation setup.

## Dependencies

- `texlive-meta` (or any TeX Live distribution with `beamer` and `texlive-fontsextra`)
- `latexmk`
- `libreoffice` (optional, for PPTX export)

On Manjaro/Arch:

```bash
sudo pacman -S texlive-meta latexmk libreoffice-fresh
```

## Usage

```bash
make            # build all presentations → dist/*.pdf
make open       # open default presentation (first alphabetically)
make clean      # remove build artifacts
```

### Filter by name

Any token that is not a named target is treated as a filename filter — all presentations whose filename contains that string are built:

```bash
make 2          # build all files matching *2* → dist/2_defi.pdf, …
make pptx-2     # build + convert to PPTX for files matching *2*
make open-2     # build + open files matching *2*
```

### Single presentation

Override the default with `PRES=`:

```bash
make open PRES=1_intro
make pptx PRES=2_defi
```

Output PDFs go to `dist/`, PPTX files alongside them.

## Google Slides export

Convert a PDF to `.pptx` via LibreOffice, then upload to Google Drive or use **File → Import slides** in Google Slides:

```bash
make pptx           # default presentation
make pptx-2         # all presentations matching *2*
make pptx PRES=name # specific presentation
```

## Adding presentations

Create a new `.tex` file in `presentations/` using `\input{preamble}`. It will be picked up automatically by `make all` and the filter targets.

### Naming convention

Files must follow the pattern `<index>_<slug>.tex`:

- `<index>` — zero-padded number that controls ordering (e.g. `01`, `02`, … `99`)
- `<slug>` — short lowercase name with no spaces (use `_` within the slug if needed)

Examples: `1_intro.tex`, `2_defi.tex`, `99_example.tex`.

Use `99_` for templates or scratch files that should sort last and not appear in a regular run.

### Content style

- Slide titles: max 2 words
- Bullet points: short enough to fit on a single line
- Language: formal Polish (avoid colloquial words)

### gn slide policy

Every presentation **must** end with a closing `gn` slide immediately before `\end{document}`:

```latex
% ================================================================
\begin{frame}[plain]
  \begin{center}
    \vfill
    {\Huge\bfseries\color{stplwhite} gn}
    \vfill
  \end{center}
\end{frame}
```

This is the standard sign-off slide. Do not add section headings or any content after it.

## Font

Uses [Archivo](https://fonts.google.com/specimen/Archivo) via the `Archivo` LaTeX package (included in `texlive-fontsextra`).
