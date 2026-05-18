# dynaprez

LaTeX beamer presentation setup.

## Dependencies

- `texlive-meta` (or any TeX Live distribution with `beamer` and `texlive-fontsextra`)
- `latexmk`

On Manjaro/Arch:

```bash
sudo pacman -S texlive-meta latexmk
```

## Usage

```bash
make        # build and open PDF
make clean  # remove build artifacts
```

Output: `build/presentation.pdf`

## Font

Uses [Archivo](https://fonts.google.com/specimen/Archivo) via the `Archivo` LaTeX package (included in `texlive-fontsextra`).
