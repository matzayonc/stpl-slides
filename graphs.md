# TikZ Graph Reference — Superteam Poland Slides

All graphs in this deck live inside `\begin{center}...\end{center}` blocks within Beamer frames.
Libraries loaded in `preamble.tex`: `calc`, `positioning`.
Global tikzset also in `preamble.tex` (see §Beamer caveats below).

---

## 1. Shared style vocabulary

```latex
every node/.style={font=\scriptsize\bfseries}   % box labels in flow diagrams
box/.style={
  draw=stplred, line width=1pt,
  fill=stplcard, text=stplwhite,
  rounded corners=2pt,
  minimum width=1.4cm, minimum height=0.55cm,
  align=center,
}
arr/.style={-latex, draw=stplred, line width=1pt}
lbl/.style={font=\tiny\itshape, text=stplmuted}  % axis / arrow labels
```

Axis label node (math graphs): `node[right, lbl] {$x$}`
Zone label inside bar: `font=\small\bfseries, text=stplwhite`

---

## 2. Flow diagrams (2_amm, 3_lending)

### Two-node pool (AMM style)

```latex
\node[box] (trader) {Trader};

\node[draw=stplred, line width=1pt, fill=stplcard,
      rounded corners=2pt,
      minimum width=2.4cm, minimum height=0.85cm,
      right=1.8cm of trader] (pool) {};
\node[font=\tiny\itshape, text=stplmuted] at ($(pool.north)+(0,5pt)$) {Pula};
\node[font=\tiny\bfseries, text=stplred]  at ($(pool.center)+(-0.55cm,0.08cm)$) {SOL};
\node[lbl]                                at ($(pool.center)+(-0.55cm,-0.18cm)$) {reserve};
\draw[draw=stplmuted, line width=0.5pt]
      ($(pool.north)+(0,-0.12cm)$) -- ($(pool.south)+(0,0.12cm)$);  % divider

\draw[arr] ([yshift= 3pt]trader.east) -- ([yshift= 3pt]pool.west)
      node[midway, above, lbl] {$+$SOL};
\draw[arr] ([yshift=-3pt]pool.west)   -- ([yshift=-3pt]trader.east)
      node[midway, below, lbl] {$+$USDC};
```

Key points:
- `right=X of Y` requires `\usetikzlibrary{positioning}`.
- `$(pool.center)+(dx,dy)$` requires `\usetikzlibrary{calc}`.
- Pool is a raw `\node[draw=..., minimum width=..., minimum height=...]{}` — no `box` style — because it needs a non-square size.
- Internal divider: draw from `pool.north` to `pool.south` offset inward.

### Three-node lending flow (Lender ↔ Pool ↔ Borrower)

Same pattern, two pairs of arrows.
Vertical ordering of arrows on the right side encodes prerequisite order:
- **Top arrow** (higher = earlier): Borrower → Pool (`+SOL zastaw`)
- **Bottom arrow**: Pool → Borrower (`+USDC`)

---

## 3. Mathematical curves (2_amm)

### Constant product hyperbola

```latex
\draw[draw=stplmuted, -latex, line width=1pt]
  (-0.3,0) -- (5.8,0) node[right, lbl] {$x$};
\draw[draw=stplmuted, -latex, line width=1pt]
  (0,-0.3) -- (0,5.8) node[above, lbl] {$y$};

\draw[domain=0.75:5.5, smooth, samples=100,
      draw=stplred, line width=2pt]
  plot (\x, {4/\x});

\node[font=\small\bfseries, text=stplred] at (4.4,1.3) {$x \cdot y = k$};
```

### Reference point + dashed coordinates

```latex
\draw[draw=stplmuted, dashed, line width=0.6pt] (2,0) -- (2,2) -- (0,2);
\node[lbl] at (2,-0.35) {$x_0$};
\node[lbl] at (-0.35,2)  {$y_0$};
\filldraw[fill=stplwhite, draw=stplred, line width=1.5pt] (2,2) circle (4pt);
```

### Δx / Δy annotations (bidirectional arrows)

Second point at $(x_1, y_1) = (3, k/3)$:

```latex
\draw[draw=stplmuted, dashed, line width=0.6pt] (3,0) -- (3,{4/3}) -- (0,{4/3});
\node[lbl] at (3,-0.35)  {$x_1$};
\node[lbl] at (-0.38,{4/3}) {$y_1$};

\draw[draw=stplred, latex-latex, line width=0.8pt] (2,-0.65) -- (3,-0.65)
  node[midway, below, font=\tiny\bfseries, text=stplred] {$\Delta x$};
\draw[draw=stplred, latex-latex, line width=0.8pt] (-0.72,{4/3}) -- (-0.72,2)
  node[midway, left,  font=\tiny\bfseries, text=stplred] {$\Delta y$};

\filldraw[fill=stplwhite, draw=stplred, line width=1.5pt] (3,{4/3}) circle (4pt);
```

`latex-latex` gives bidirectional arrowheads without extra libraries.

### Tangent line with slope label

```latex
\draw[draw=stplmuted, line width=0.8pt] (0.6,3.4) -- (3.8,0.2)
  node[midway, above right, font=\tiny\itshape, text=stplmuted] {nachylenie $= -p$};
```

---

## 4. Piecewise linear (kink model, 3_lending)

```latex
\draw[draw=stplred, line width=2pt] (0,0) -- (4,1) -- (5,5);

\draw[draw=stplmuted, dashed, line width=0.6pt] (4,0) -- (4,1) -- (0,1);

\node[lbl] at (4,-0.35) {$U_{\text{opt}}$};
\node[lbl] at (5,-0.35) {$100\%$};
\node[lbl] at (-0.5,1)  {$r_1$};

\node[font=\tiny\itshape, text=stplmuted] at (2,-0.7) {strefa normalna};
\node[font=\tiny\itshape, text=stplred]   at (4.6,-0.7) {kryzys};

\filldraw[fill=stplwhite, draw=stplred, line width=1.5pt] (4,1) circle (3pt);
```

Scale rationale: x 0–5 = U 0–100 %, kink at x=4 (80 %).
Slopes: 0.25 (gentle) vs 4 (steep) — 16× contrast is visually obvious.

---

## 5. Horizontal gradient bar (3_lending — Health Factor)

### Multi-stop gradient via chained \shade

Each segment's `right color` = next segment's `left color` → seamless blend:

```latex
\shade[left color=green!60!black,   right color=orange]           (0,0) rectangle  (8,1);
\shade[left color=orange,           right color=stplred]          (8,0) rectangle  (9,1);
\shade[left color=stplred,          right color=stplred!70!black] (9,0) rectangle (10,1);
\shade[left color=stplred!70!black, right color=stplred!40!black](10,0) rectangle (11,1);
```

### Rounded corners on a gradient bar

`\shade` ignores `rounded corners`. Workaround: clip first, then draw border separately:

```latex
\begin{scope}
  \clip[rounded corners=6pt] (0,0) rectangle (11,1);
  \shade[...] ...;   % all segments
\end{scope}
\draw[rounded corners=6pt, draw=stplmuted, line width=0.4pt] (0,0) rectangle (11,1);
```

Elements drawn **outside** the scope (e.g. a threshold line) are not clipped.

### Threshold line + staggered axis labels

```latex
\draw[draw=stplwhite, line width=1.5pt] (9,-0.5) -- (9,1.55);
\node[font=\small\bfseries, text=stplwhite, above] at (9,1.55) {likwidacja};

\node[lbl] at (0,-0.35)  {$0\%$};
\node[lbl] at (8,-0.35)  {$80\%$};
\node[lbl] at (9,-0.6)   {$90\%$};   % staggered down — avoids overlap with 80% and 100%
\node[lbl] at (10,-0.35) {$100\%$};
\node[lbl] at (11,-0.35) {$110\%$};
```

Bar label above: `\node[font=\small\itshape, text=stplmuted, above] at (5.5,1) {Health Factor};`

### Coordinate scale

`x=0.95cm` on the tikzpicture scales x-coordinates to 0.95 cm per unit,
fitting an 11-unit (110 % LTV) bar into the ~11.1 cm beamer text width.
Font sizes are **not** affected by coordinate scaling.

---

## 6. Staged reveals (Beamer overlays)

### The `visible on` pattern

Defined in **`preamble.tex`** (not inside any frame — see caveat below):

```latex
\tikzset{
  invisible/.style={opacity=0, text opacity=0},
  visible on/.style={alt={#1{}{invisible}}},
  alt/.code args={<#1>#2#3}{%
    \alt<#1>{\pgfkeysalso{#2}}{\pgfkeysalso{#3}}%
  },
}
```

Usage — wrap each stage in a scope:

```latex
% Stage 1: always visible (no style needed)
\node[box] (lender) {Lender};
...

% Stage 2: appears on overlay 2+
\begin{scope}[visible on=<2->]
  \node[box, right=1.8cm of pool] (borrower) {Borrower};
  \draw[arr] ...;
\end{scope}

% Stage 3: appears on overlay 3+
\begin{scope}[visible on=<3->]
  \draw[arr] ...;
\end{scope}
```

Why `\begin{scope}` instead of per-node style:
- `opacity=0` on a `\draw` path does **not** automatically hide `node[midway,...]` labels on that path.
- A scope propagates both `opacity` and `text opacity` to everything inside it, including path labels.

Why `opacity=0` instead of `\only`:
- `\only` removes the element entirely → bounding box shrinks → diagram shifts between overlays.
- `opacity=0` keeps the geometry; the element is invisible but still occupies space.

### Hybrid pattern — node style + scope

For a stage that adds **one node + one arrow with a midway label**, putting
`visible on=<N->` directly on the node is cleaner than wrapping a single node
in a scope. Keep the scope for the arrow because labels on paths need the
scope's text-opacity propagation:

```latex
% Stage 1: always visible
\node[box] (cli) {Klient};
\node[box, right=1.4cm of cli] (srv) {Serwer firmy};
% declared at stage 1 to lock the bounding box, but invisible until <2->
\node[dbbox, right=1.4cm of srv, visible on=<2->] (db) {Prywatna DB};
\draw[arr] (cli) -- node[lbl, above]{HTTPS} (srv);

% Stage 2: arrow with label needs the scope
\begin{scope}[visible on=<2->]
  \draw[arr] (srv) -- node[lbl, above]{zaufanie} (db);
\end{scope}
```

The early declaration of `db` (with `visible on`) reserves its geometry from
overlay 1, so the diagram doesn't reflow when stage 2 arrives. Worked example:
`1_paradigm.tex` slide "Web2 w jednym zdaniu".

### Sync stages to bullet reveals

With `\beamerdefaultoverlayspecification{<+->}` set in `preamble.tex`, each
`\item` consumes the next overlay automatically. Use **the same overlay numbers**
on your TikZ stages so graph elements appear in lockstep with the bullet that
introduces them — graph stages do **not** consume their own counter, they
overlay existing bullet overlays.

```
overlay 1 → bullet 1 + graph stage 1
overlay 2 → bullet 2 + graph stage 2 (visible on=<2->)
overlay 3 → bullet 3 + graph stage 3 (visible on=<3->)
overlay 4 → helper block
```

Pick stage numbers from the narrative role of each graph element, not the count.
Two-stage reveals are common: the "before" state on <1->, the "after" state on
<2-> (e.g. `1_paradigm.tex` summary slide pairs Web2 stack with Web3 stack).

The same lockstep idea applies to **code listings** synced to bullets, but the
mechanism differs (listings can't take a TikZ `visible on`): use the `codeblock`
card + `[style=reveal]` + `(*@\onslide<k->@*)` line tags. See `style.md` §8.2 and
`branding.md` → Code reveal card.

### Beamer catcode caveat

`alt/.code args={<#1>#2#3}` uses `<>` characters. Inside a Beamer `\begin{frame}`, Beamer changes the catcode of `<` and `>` for overlay parsing. Defining this tikzset inside a frame causes:

```
! Illegal parameter number in definition of \iterate.
```

**Fix**: define in `preamble.tex`, before `\begin{document}`.

---

## 7. Static diagram frames

Use `\begin{frame}<1>{Title}` for frames that contain only a diagram with no
incremental content. The `<1>` suppresses Beamer from generating multiple
overlay copies of the frame.

---

## 8. Quick reference — colors

| Token | Hex | Use |
|-------|-----|-----|
| `stplred` | `#DC143C` | brand accent, curve color, danger |
| `stplmuted` | `#8A9BA8` | axis lines, secondary labels |
| `stplwhite` | `#FFFFFF` | text on dark backgrounds |
| `stplcard` | `#161A1B` | box fill |
| `stpldark` | `#0B0E0F` | slide background |

Mixing idioms: `stplred!70!black` (30 % darker), `green!60!black`, `orange`.
