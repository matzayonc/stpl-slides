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

## Font

Uses [Archivo](https://fonts.google.com/specimen/Archivo) via the `Archivo` LaTeX package (included in `texlive-fontsextra`).
