# Claude Code — Repo Guide

This repository builds LaTeX/Beamer slide decks for the Superteam Poland Solana
Bootcamp. Read the files below before editing slides — they are the source of
truth, this file only points to them.

## Read first

- [`style.md`](style.md) — **content & narrative rules**: audience model,
  problem → mechanism → benefit arc, slide skeleton (title 2–4 words, 3–5
  bullets, mandatory helper block), term-introduction pattern, analogies,
  anglicisms, math/code conventions, voice. Open this before writing any
  new slide.
- [`branding.md`](branding.md) — **visual chrome**: colors, block types,
  bullets, footline, section dividers, title slide. Open this when changing
  anything visual.
- [`README.md`](README.md) — **build & file conventions**: `make` targets,
  filename pattern `<index>_<slug>.tex`, mandatory closing `gn` slide.
- [`preamble.tex`](preamble.tex) — the actual implementation of brand
  chrome (colors, beamer templates, `\maketitleframe`, section dividers,
  block environments). Edit only when the brand definition itself needs to
  change; otherwise treat as fixed and author against it.

## Existing slides

`presentations/` holds the deck source. Files follow `<index>_<slug>.tex`
(see `README.md`). The recorded reference lecture for narrative rhythm is
`0_why.tex` — when an answer about *style* is unclear, that file is the
working example of what `style.md` describes.

## Technical reference (Solana / Anchor)

`reference/skill/` holds reference docs the AI uses for technical
correctness when writing slide content. Consult it before claiming
anything specific about Anchor, IDL codegen, accounts, payments,
testing, security, or common errors:

- `anchor/`, `programs/`, `kit/`, `surfpool/` — framework-specific notes
- `common-errors.md`, `compatibility-matrix.md` — pitfalls and version
  alignment
- `confidential-transfers.md`, `payments.md`, `security.md`,
  `testing.md`, `idl-codegen.md`, `kit-web3-interop.md`,
  `frontend-framework-kit.md`, `resources.md` — topic deep-dives

Treat these as authoritative for facts; treat `style.md` as authoritative
for how those facts get presented.

## Common tasks

- **New deck**: create `presentations/<index>_<slug>.tex`, start with
  `\input{preamble}`, follow the skeleton in `style.md` §5, end with the
  mandatory `gn` slide from `README.md`.
- **Build**: `make` builds everything to `dist/`. `make N` (where N is a
  filename token) builds only matching decks. `make open-N` builds + opens.
- **Editing visuals**: change `preamble.tex`, then update `branding.md` so
  it stays the source of truth.
- **Editing narrative rules**: change `style.md`. Do not duplicate rules
  here.

## Conventions worth repeating

- Polish, impersonal third person. No emojis on slides.
- Concept slides end in exactly one helper block (`block`, `alertblock`,
  or `exampleblock`) — picked by semantic role per `style.md` §4.3.
- Incremental reveal (`<+->`) is on by default; do not turn it off
  globally.
- Every deck ends with the `gn` slide. No exceptions.
