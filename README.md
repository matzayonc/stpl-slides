# dynaprez

LaTeX beamer presentation setup.

## Dependencies

- `texlive-meta` (or any TeX Live distribution with `beamer` and `texlive-fontsextra`)
- `latexmk`
- `libreoffice` (optional, for PPTX/Google Slides export)
- `poppler` (optional, for per-slide PNG export)

On Manjaro/Arch:

```bash
sudo pacman -S texlive-meta latexmk libreoffice-fresh poppler
```

## Usage

```bash
make        # build and open PDF
make clean  # remove build artifacts
```

Output: `build/presentation.pdf`

## Google Slides export

Google Slides does not reliably import Beamer-generated PDFs. Two options are provided:

**PPTX (recommended)** — converts the PDF to a `.pptx` file via LibreOffice, which Google Slides imports natively:

```bash
make pptx
```

Output: `build/presentation.pptx` — upload to Google Drive or use **File → Import slides** in Google Slides.

**PNG slides** — exports each slide as a PNG image (150 dpi) via `pdftocairo`:

```bash
make slides
```

Output: `build/slides/slide-01.png`, `slide-02.png`, … — import via **File → Import slides → Upload** in Google Slides.

## Font

Uses [Archivo](https://fonts.google.com/specimen/Archivo) via the `Archivo` LaTeX package (included in `texlive-fontsextra`).
