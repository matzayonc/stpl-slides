# Bootcamp Lesson Plan — Part 2 (Recorded Filter)

Slide-by-slide outline for the seven recorded lessons (Lekcje 0–6) of the
"Od Zera do Blockchain Developera" bootcamp. Pairs with [`style.md`](style.md)
(narrative rules), [`branding.md`](branding.md) (visual chrome), and
[`README.md`](README.md) (build & filenames).

Scope here is **Part 2 only** — the recorded filter on Kajabi, watched
self-paced 20–26 lipca 2026. Part 3 (Live 1–5) is outside this plan; its
theory blocks reuse the vocabulary established below.

If anything in this file conflicts with `style.md`, `style.md` wins.

---

## 1. Conventions used in this plan

- **Slide shape** — every concept slide line is written as
  `N. Title — intent (helper-block role)`. `helper-block role` is `def`
  (block), `risk` (alertblock), `effect`/`example` (exampleblock), or `—`
  if the slide is exempt per `style.md` §4.3 (transition, A-vs-B, summary,
  `gn`).
- **Term debut** — every new technical word follows §6: problem in plain
  Polish → mechanism → bolded name, with acronym in parentheses on first
  use. The plan flags the slide where each term debuts.
- **Reveal** — `\beamerdefaultoverlayspecification{<+->}` stays on unless
  the slide is a single visual or a static table.
- **Closer** — every deck ends with the `gn` slide per `style.md` §5.4.
- **Kickoff-only slides** — only Lekcja 0 carries "O mnie" and "Plan
  kursu" before the toc. Lekcje 1–6 jump straight to `\tableofcontents`.

---

## 2. File map and rename plan

| Lekcja | New filename | Status | Source today |
|---|---|---|---|
| 0 | `presentations/0_why.tex` | keep as-is | `0_why.tex` (reference recording) |
| 1 | `presentations/1_defi.tex` | **rename** | `2_defi.tex` |
| 2 | `presentations/2_paradigm.tex` | **new** | — |
| 3 | `presentations/3_rust.tex` | **rename + trim** | `6_rust.tex` |
| 4 | `presentations/4_accounts.tex` | keep, light touch-up | `4_accounts.tex` |
| 5 | `presentations/5_anchor.tex` | **new** | — |
| 6 | `presentations/6_wallet.tex` | **new** | — |

Files moved aside (not part of bootcamp sequence):

| File | Action | Why |
|---|---|---|
| `presentations/1_intro.tex` | deleted | superseded; the two reusable slides (dApp comparison, klucze/portfel) were integrated into `2_paradigm.tex` slides 2/3/7; the rest is covered better in L0/L3/L4/L5 |
| `presentations/5_shared_core.tex` | rename to `presentations/archive_shared_core.tex` | unrelated Rust Meetup talk; keep available, out of bootcamp number range |
| `presentations/99_example.tex` | keep | template reference |

After the renames, `presentations/` reads top-to-bottom in lesson order
with no collisions, and `make N` (where N matches a filename token) builds
exactly one bootcamp deck.

---

## 3. Pro Ed gap-handling (judgment calls)

The Polish curriculum doc omits three topics the legacy Solana Foundation
Pro Ed deck made explicit. My proposal:

- **Crypto primitives** (Pro Ed L1: symmetric/asymmetric/signing) — fold
  into **Lekcja 6 Wallet**, two slides before Phantom install. The
  student is about to handle a private key for the first time; that is
  the natural moment to debut `klucz publiczny / prywatny / podpis` from
  the problem ("jak mam podpisać, skoro nie ma hasła?"). No new lesson.

- **Transactions** (Pro Ed L3: instructions, signers, fees, atomicity) —
  fold into **Lekcja 5 Anchor** as a 3-slide sub-section "Transakcja"
  before `#[program]`. Instructions belong with the framework that
  invokes them, and Anchor's `Context<T>` only makes sense once the
  transaction envelope is named. No new lesson.

- **Tokeny / SPL** (Pro Ed L4–L5) — leave for Live 2 (hands-on), but
  add one slide in **Lekcja 1 DeFi** explicitly naming `Mint` and
  `Token Account` so the student carries the vocab into the live
  session. No new content depth in Part 2.

Net effect: 7 lessons stay 7 lessons, ~7 extra slides distributed across
L1/L5/L6. Override any of these by changing the relevant lesson outline
below.

---

## 4. Lekcja 0 — Dlaczego blockchain i Solana

- File: `presentations/0_why.tex` (already recorded; reference lecture)
- Format: nagranie wideo · ~11 min · 13 frames
- Rola: motywacja, intuicja blockchainu, debut Solany

Slide structure (existing, do not change):

1. O mnie — kickoff (—)
2. Plan kursu — kickoff (—)
3. Plan — toc (—)
4. Prywatne serwery — problem (example: PayPal, FTX, AWS)
5. Problem zaufania — A-vs-B opposition (—)
6. Wspólna sieć — mechanism, BFT debut (effect)
7. Rejestr BFT — mechanism, podpis kluczem (A-vs-B)
8. Smart kontrakty — benefit, term debut (example: pożyczka, wymiana)
9. Obecne ograniczenia — problem (risk: BFT bez skali)
10. Solana — benefit, kluczowe liczby (def: 50k TPS, <$0.001, 400 ms)
11. Podsumowanie — recap (—)
12. `gn` — closer (—)

Po lekcji student umie wyjaśnić: czemu prywatny serwer to ryzyko · co
gwarantuje BFT · czym smart kontrakt zastępuje bank/giełdę/notariusza ·
dlaczego Solana, a nie Bitcoin/Ethereum.

Audit notes: deck is the canonical example of the style. No changes
needed for this plan.

---

## 5. Lekcja 1 — DeFi: co właściwie budujemy

- File: `presentations/1_defi.tex` (rename from `2_defi.tex`)
- Format: nagranie wideo · ~10 min · ~13 frames
- Rola: wizja, "co konkretnie powstanie z tych klocków"

Po lekcji student umie:

- wyjaśnić różnicę między bankiem/giełdą a DeFi (otwarty kod zamiast
  pośrednika);
- opisać AMM na intuicji (pula płynności, cena z proporcji);
- wytłumaczyć lending z nadzabezpieczeniem i likwidacją;
- nazwać `Mint` i `Token Account` jako prymitywy SPL.

Slide structure:

1. Wracamy do obietnicy — problem hook (risk: "jak bez pośrednika?")
2. Token programowalny — term debut "token" (example: żeton w kasynie)
3. Tokenomika — three questions: podaż, użytek, zachęty (def)
4. **Mint i Token Account** — *gap-fold*; term debut SPL prymitywów
   (def: `Mint` = definicja waluty, `Token Account` = saldo per
   właściciel) — added for Live 2 vocab
5. Order book vs AMM — A-vs-B opposition (—) *(currently in file as
   "Order book vs AMM" — keep)*
6. Constant Product — formula debut `x·y=k` (def)
7. Jak działa swap? — mechanism, slippage debut (example: SOL→USDC)
8. Dostarczanie płynności — LP role (example: 10 SOL + 1000 USDC)
9. Impermanent Loss — risk debut (alertblock)
10. Concentrated Liquidity — CLMM mention (example: Orca/Raydium)
11. Lending: pożyczki — overcollateralized (example: Kamino/Solend)
12. Mechanika pożyczki — A-vs-B Lender/Borrower (—)
13. LTV i Health Factor — formula debut (def)
14. Utilization Rate — formula (def)
15. Ryzyka — risk (alertblock: oracle, smart contract, rug pull)
16. Money legos — kompozytowość, CPI tease (example: Kamino)
17. Podsumowanie — recap dwie sekcje AMM/Lending (—)
18. `gn` — closer (—)

Audit notes vs current `2_defi.tex`:

- Current deck already has 13 frames; close to the target. Add slide 4
  (Mint/Token Account vocab) and slide 16 (money legos / CPI tease) per
  curriculum doc.
- Constant Product slide currently runs `\[ x · y = k \]` inside a
  block — correct per `style.md` §8.1, keep.
- Ryzyka slide is one alertblock with five bullets; that's the slide,
  per §4.3. Keep.

Analogies inventory: bank/notariusz/broker (recurring) · żeton w
kasynie · dwie połączone beczki z wodą · lombard sprzedający zastaw ·
LEGO ("money legos").

Mini-test (4 questions for ABCD): DeFi vs bank · jak AMM ustala cenę ·
po co nadzabezpieczenie · który projekt to cegiełka DEX-a.

---

## 6. Lekcja 2 — Paradygmat Web3 dla dewelopera Web2

- File: `presentations/2_paradigm.tex` (new)
- Format: nagranie wideo · ~9 min · ~11 frames
- Rola: most z Bloku A do Bloku B — przełącza "co budujemy" w "jak
  pracujemy"

Po lekcji student umie:

- narysować przepływ "frontend → RPC → klaster → program → konto";
- wskazać, co znika z Web2 (serwer aplikacyjny, baza, sesje, hasło);
- odróżnić read (gratis, dowolny node) od write (transakcja, podpis,
  opłata);
- wyjaśnić, dlaczego nie ma "zapomniałem hasła".

Slide structure:

1. Z wizji do warsztatu — transition (—)
2. Web2 w jednym zdaniu — problem hook (risk: "jeden właściciel
   prawdy")
3. Web3 w jednym zdaniu — mechanism (effect: "backend staje się
   programem")
4. RPC node — term debut (example: bankomat dowolnej sieci) (def)
5. Read vs Write — A-vs-B opposition (—)
6. Bezserwerowa architektura — benefit (risk: "kod publiczny i
   niezmienny, błąd też publiczny")
7. Portfel jako tożsamość — debut `klucz publiczny/prywatny` w skrócie
   (deep dive in L6) (example: podpis odręczny nie do podrobienia)
8. Konsekwencje UX — benefit + risk (alertblock: utrata klucza =
   utrata dostępu)
9. Mapa stacku Web3 — TikZ diagram: Frontend · Wallet Adapter · RPC ·
   Klaster · Program · Konta (—) *single visual; pause `<+->` for this
   slide*
10. Podsumowanie — recap czterech różnic (—)
11. `gn` — closer (—)

Analogies inventory: bankomat dowolnej sieci (RPC) · Google Docs
współdzielony (stan publiczny) · podpis odręczny bez resetu (klucz
prywatny).

Mini-test: które elementy Web2 znikają · czym jest RPC i czemu jest
wymienny · read vs write — co podpisuje user · co zastępuje login.

Notes for author:

- This is the first lesson that names `Solana RPC`, but full account
  model is L4. Keep RPC at "okno na łańcuch" level here.
- Klucze are debuted softly (one slide, no deep dive); L6 does the
  asymmetric crypto explanation.

---

## 7. Lekcja 3 — Szybki Rust (tyle, ile trzeba do Anchora)

- File: `presentations/3_rust.tex` (rename + trim from `6_rust.tex`)
- Format: nagranie wideo · ~10 min · ~12 frames
- Rola: narzędzie (język) — odblokować czytanie `lib.rs`, nic więcej

Po lekcji student umie:

- przeczytać sygnaturę funkcji i `struct` w Anchor bez paniki;
- odróżnić `mut` od domyślnej niemutowalności i wyjaśnić, czemu;
- rozpoznać `Option<T>`, `Result<T, E>` i operator `?`;
- rozpoznać makro (`#[...]`, `coś!(...)`) jako "kod, który pisze kod".

Slide structure:

1. Nie uczymy Rusta — scope set (alertblock: "to nie kurs RUST")
2. Po co Rust on-chain — problem (effect: "cała klasa bugów
   niemożliwa")
3. Jak wygląda — składnia, snake_case, `->` (def)
4. Niemutowalność domyślna — `let` vs `let mut` (def)
5. Brak klas — `struct` + `impl` zamiast `class` (def) *(new vs
   current file — small slide to set Anchor expectations)*
6. Typy w Anchorze — `u64`, `i64`, `Pubkey`, `Vec<T>`, `bool` (def)
   *(new — currently absent)*
7. Match wyczerpujący — analogy: lista kontrolna pilota (alertblock)
8. Option — bez null (example: paczka kurierska)
9. Result — bez wyjątków, `?` (alertblock)
10. Makra — `#[...]` i `coś!(...)` (example: formularz z polami)
11. Czytamy razem — full snippet, name every element (—)
12. Podsumowanie — pięć zaskoczeń + "co NIE jest dziś" (—)
13. `gn` — closer (—)

Audit notes vs current `6_rust.tex`:

- File currently has 3 Anchor-specific frames at the end (Cztery makra
  / Kontekst instrukcji / Czytamy razem). **Trim** — Anchor anatomy
  is L5. Keep only "Czytamy razem" with a small Anchor snippet as the
  final read-along; move "cztery makra" and "kontekst instrukcji" out
  of this deck.
- Current deck is missing the `struct + impl` (no classes) and "typy
  w Anchorze" frames — both add value with low cost. Add per curriculum
  doc.
- Borrow / pożyczanie frame in current file is on the edge — keep, but
  mark `&` as "intuicja, nie teoria" per `[RUST]` tag in curriculum
  doc.

Analogies inventory: pasy bezpieczeństwa wymuszane przez kompilator ·
arkusz z ochroną komórek (mut) · lista kontrolna pilota (match) ·
paczka kurierska (Option) · early return (`?`) · formularz z polami
(makro).

Mini-test: co robi `mut` · czym Result różni się od wyjątku · co
zastępuje klasę · co oznacza `#[...]`.

---

## 8. Lekcja 4 — Model Kont na Solanie

- File: `presentations/4_accounts.tex` (keep, light touch-up)
- Format: nagranie wideo · ~10 min · ~11 frames
- Rola: fundament (dane) — wprowadza "wszystko jest kontem"

Po lekcji student umie:

- wyjaśnić zdanie "wszystko jest kontem" i wymienić 3 typy
  (dane/program/system);
- wskazać różnicę kod+stan razem (Ethereum) vs kod osobno od stanu
  (Solana);
- powiedzieć, kto może zmienić dane konta i jak user to autoryzuje;
- wyjaśnić, czemu trzymanie danych on-chain kosztuje (rent-exempt).

Slide structure (current file is already close):

1. Jeden pomysł — hook (risk: "jak odróżnić kod od danych?")
2. Anatomia konta — code listing of `Account` struct (example: konto
   to plik)
3. Typy kont — A-vs-B dane/program (—)
4. Vs Ethereum — A-vs-B opposition (example: program = funkcja
   przyjmująca konta)
5. Właściciel — owner debut (risk: "kto zmienia dane?")
6. Owner vs Signer — A-vs-B (example: przelew tokena)
7. Adres — PDA zajawka, deep dive Live 1 (alertblock)
8. Rent — depozyt rent-exempt (example: "to nie abonament")
9. Rozmiar — `space` w Anchor (—) *code slide; no helper block
   needed per §4.3 if it's a teaching code listing — re-classify if
   author disagrees*
10. Explorer demo — Solana Explorer pointer (example)
11. Podsumowanie — 4 takeaways (example)
12. PDA cliffhanger — transition to L1 live (—)
13. `gn` — closer (—)

Audit notes vs current `4_accounts.tex`:

- Deck is well-formed and largely matches the curriculum doc. No
  structural change.
- Consider adding a one-line callback to Lekcja 2's "RPC = okno na
  łańcuch" before slide 10 (Explorer demo) so the student knows
  Explorer is just a polished RPC view.

Analogies inventory: konto = plik · program = aplikacja z prawem
zapisu do pliku · funkcja czysta + argumenty (program bezstanowy +
konta danych).

Mini-test: wymień pola konta · różnica dane/wykonywalne · kto może
zmienić dane · czym jest rent-exempt.

---

## 9. Lekcja 5 — Anatomia Frameworku Anchor

- File: `presentations/5_anchor.tex` (new)
- Format: nagranie wideo · ~11 min · ~13 frames *(includes 3-slide
  "Transakcja" gap-fold sub-section)*
- Rola: fundament (framework) — z czego się składa program Anchor

Po lekcji student umie:

- wyjaśnić, co Anchor robi za niego (walidacja kont, serializacja,
  IDL);
- wskazać `#[program]`, `#[derive(Accounts)]`, `#[account]` w
  `lib.rs`;
- powiedzieć, czym jest IDL i kto go używa;
- zdefiniować transakcję (envelope z instrukcji, podpisem, opłatą).

Slide structure:

Sekcja 1 — Transakcja (*gap-fold from Pro Ed L3*):

1. Co user wysyła do sieci — problem hook (risk: "kto autoryzuje?")
2. Transakcja — debut: envelope z instrukcji, signers, opłaty (def)
3. Atomowość — wszystkie instrukcje albo żadna (example: swap +
   transfer w jednej tx)

Sekcja 2 — Anchor:

4. Surowa Solana — problem (risk: "łatwo o lukę")
5. Czym jest Anchor — analogy (example: Rails dla Solany)
6. Trzy bloki — `#[program]` / `#[derive(Accounts)]` / `#[account]`
   (def)
7. `#[program]` — instrukcje, `Context<T>` (def)
8. `#[derive(Accounts)]` — deklaratywne bezpieczeństwo (effect:
   "luka łapana w deklaracji, nie w `if`")
9. Constraints — `init`, `mut`, `signer`, `seeds`, `has_one` (def)
10. Serializacja — Borsh za ciebie (example: nie liczysz bajtów)
11. Dyskryminator — 8 bajtów, "Content-Type konta" (def)
12. IDL — kontrakt API programu (example: Swagger dla on-chain)
13. Mini-program — pełny licznik, 25 linii (—) *code slide*
14. Podsumowanie — co Anchor robi za ciebie (—)
15. `gn` — closer (—)

Analogies inventory: Rails/NestJS (framework backendowy) ·
middleware walidujący request (constraints) · Swagger/OpenAPI (IDL) ·
nagłówek Content-Type (dyskryminator).

Mini-test: za co odpowiadają trzy `#[...]` bloki · co robią
constraints `init`/`mut`/`signer` · czym jest dyskryminator · co to
IDL i kto go używa.

Notes for author:

- Transakcja sub-section uses callbacks to Lekcja 2 (read/write,
  user podpisuje) and Lekcja 4 (signer vs owner). No new vocab
  beyond `instrukcja`, `opłata`, `atomowość`.
- Mini-program slide is the single best test of `style.md` §8.2 —
  keep snippet under 10 lines, run the squint test before shipping.

---

## 10. Lekcja 6 — Twój pierwszy wallet

- File: `presentations/6_wallet.tex` (new)
- Format: nagranie wideo · ~7 min · ~9 frames *(includes 2-slide
  crypto-primitives gap-fold before Phantom install)*
- Rola: wejście w zadanie blokujące — student ma działający Phantom
  na devnecie

Po lekcji student umie:

- wyjaśnić parę klucz publiczny / prywatny i podpis kryptograficzny;
- zainstalować Phantom, zabezpieczyć seed phrase;
- przełączyć portfel na devnet i zrobić airdrop;
- znaleźć transakcję w Solana Explorer.

Slide structure:

Sekcja 1 — Klucze (*gap-fold from Pro Ed L1*):

1. Portfel — twój login — hook back to Lekcja 2 (—)
2. Para kluczy — asymmetric crypto debut (example: skrytka
   bankowa: każdy może wrzucić, tylko ty otwierasz)
3. Podpis — `klucz prywatny` szyfruje, `klucz publiczny`
   weryfikuje (def) *single concept slide, helper block names the
   property*

Sekcja 2 — Phantom:

4. Instalacja Phantom — screen-grab demo (—)
5. Seed phrase — jedna zasada bezpieczeństwa (alertblock: "kto ma
   seed, ma środki")
6. Devnet vs Mainnet — A-vs-B opposition (—)
7. Airdrop — devnet faucet demo (example)
8. Pierwsza transakcja + Explorer — demo, podpis/status/opłata
   (example)
9. Checklist — gotowe do zadania blokującego (—)
10. `gn` — closer (—)

Analogies inventory: skrytka bankowa z dwoma kluczami (klucz pub/priv) ·
podpis odręczny nie do podrobienia (back to L2) · klucz do mieszkania,
którego nie da się dorobić (seed phrase).

Mini-test: devnet vs mainnet · czym jest seed phrase · gdzie znajdziesz
podpis i status transakcji · co robi klucz prywatny w podpisie.

Notes for author:

- The crypto-primitives gap-fold is intentionally light — 2 slides,
  not a full lesson. Pro Ed L1 spent 13 slides on this; for our
  audience, the practical "you have a key, here's why it works" is
  enough. If a student wants deeper crypto, that's a separate skill.
- All four demos (slide 4, 7, 8, 9-checklist) are screen-grab moments
  in the recording. No bullet-only frames in the demo section — show
  the UI.

---

## 11. Cross-lesson dependencies (term-debut ledger)

A new term debuts in the lesson where it first appears with bolded
`\textbf{}`; later lessons may use it freely.

| Term | Debuts in | Re-used in |
|---|---|---|
| smart kontrakt, BFT, PoH, Sealevel | L0 | L2, L4, L5 |
| permissionless, composable, AMM, LTV, Health Factor | L1 | L5 (CPI tease) |
| Mint, Token Account | L1 (gap-fold) | L6 quickly; full in Live 2 |
| RPC node, read/write, klaster | L2 | L4, L5, L6 |
| portfel, signer (intuitively) | L2 | full in L4 (owner vs signer), L6 (cryptography) |
| `mut`, `Option`, `Result`, `?`, makra, `struct` | L3 | L4 (code), L5 (Anchor) |
| konto, owner, lamports, executable, rent-exempt, PDA | L4 | L5, L6 (rent in airdrop) |
| transakcja, instrukcja, atomowość, opłata | L5 (gap-fold sec. 1) | L6 demo |
| `#[program]`, `#[derive(Accounts)]`, `#[account]`, IDL, dyskryminator | L5 | (Live sessions) |
| klucz publiczny / prywatny, podpis kryptograficzny, seed phrase | L6 (gap-fold sec. 1) | — |

If a later lesson uses a term that has not yet debuted, treat it as new
and hook from problem per `style.md` §6.

---

## 12. Filter-task mapping

The blocking task (quiz ABCD + wallet setup + deploy + Explorer link)
maps 1:1 onto the lessons:

| Task element | Backed by |
|---|---|
| ABCD: po co to wszystko (DeFi, kontekst) | L1 |
| ABCD: Rust syntax | L3 |
| ABCD: architektura kont | L4 + L5 |
| Wallet setup (Phantom, devnet, airdrop) | L6 |
| Deploy programu w Playground | L5 + L6 |
| Link do transakcji w Explorer | L2 (read/write) + L6 (Explorer demo) |

A student who passes every mini-test passes the blocking task.

---

## 13. Outstanding decisions for review

1. **`5_shared_core.tex` archive rename** — the earlier round said
   "keep" but later said "archive intro". I extended the same archive
   treatment to `shared_core` to free up the `5_` slot for Anchor. If
   you want `shared_core` to keep its current name and Anchor to use a
   different slot (e.g. `5b_anchor.tex` or `7_anchor.tex`), flag it
   and I'll re-shuffle the map in §2.
2. **L5 length** — 15 frames is at the top of the curriculum doc's
   recommended range. If you prefer a tighter L5, drop the
   "Atomowość" slide and merge "Trzy bloki" with "`#[program]`".
   Alternatively split the Transakcja sub-section into its own short
   L4.5 lesson — that would make the bootcamp 8 lessons.
3. **L6 demo recording** — slides 4/7/8/9 are screen-grab moments. If
   you'd rather author static screenshot slides than live-record demos,
   the lesson grows by 2–3 frames. Confirm before authoring.
4. **TikZ stack diagram in L2 slide 9** — proposed as a single visual.
   If you'd rather use a real screenshot (Solana Explorer + Phantom +
   Next.js page side-by-side), call it out.

Once §13 is settled, draft `.tex` files in this order: rename batch
first (§2), then new files L2 → L5 → L6 → trim L3.
