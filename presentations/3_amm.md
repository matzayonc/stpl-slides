---
title: AMM na Solanie
subtitle: "Automated Market Maker --- Solana Bootcamp"
institute: Superteam Poland
toc: true
---

# Czym jest DeFi?

## Czym jest DeFi?

- **DeFi** (Decentralized Finance) --- usługi finansowe bez pośredników
- Inteligentne kontrakty zamiast banków i brokerów
- Permissionless --- każdy może korzystać, bez KYC
- Composable --- protokoły łączą się jak klocki
- Dwa filary: **wymiana tokenów** (AMM) i **pożyczki** (Lending)

# AMM --- Automated Market Maker

## Tradycyjny order book vs AMM

::: columns
::: block
### Order Book (CEX)
- Kupujący i sprzedający składają zlecenia
- Cena wynika z dopasowania zleceń
- Wymaga animatorów rynku (market makers)
- Przykład: Binance, Openbook
:::

---

::: block
### AMM (DEX)
- Brak zleceń --- cena z formuły matematycznej
- Płynność dostarcza każdy (LP)
- Swap zawsze możliwy, 24/7
- Przykład: Orca, Raydium
:::
:::

## Constant Product AMM --- formuła

::: block
### Niezmiennik
$$x \cdot y = k$$

$x$ --- rezerwa tokenu A \quad $y$ --- rezerwa tokenu B \quad $k$ --- stała
:::

- Po każdej operacji iloczyn rezerw musi pozostać równy $k$
- Im więcej kupujesz jednego tokenu, tym wyższa cena jednostkowa
- Cena chwilowa: $p = y / x$

## Jak działa swap?

::: example
### Przykład: wymiana SOL $\to$ USDC
Pula: $x = 1\,000$ SOL, $y = 100\,000$ USDC \quad $k = 10^8$

Chcemy kupić $\Delta y = 10\,000$ USDC.
$$x' = \frac{k}{y - \Delta y} = \frac{10^8}{90\,000} \approx 1\,111{,}1 \text{ SOL}$$

Płacimy $\approx 111{,}1$ SOL zamiast spodziewanych $100$ SOL (cena startowa $100\,\text{USDC/SOL}$).
:::

::: alert
### Price Impact
Duże swapy relatywnie do puli powodują znaczący poślizg cenowy (slippage).
:::

## Dostarczanie płynności (LP)

- LP wpłaca oba tokeny w *proporcji odpowiadającej aktualnej cenie*
- Otrzymuje **LP tokeny** --- potwierdzenie udziału w puli
- Zarabia na **opłatach transakcyjnych** (np. 0.25% per swap)
- Może wycofać płynność w dowolnym momencie

::: example
### Przykład
Pula SOL/USDC, cena 100 USDC/SOL.

Wpłacasz: 10 SOL + 1\,000 USDC $\Rightarrow$ otrzymujesz LP tokeny proporcjonalnie.
:::

## Impermanent Loss

::: alert
### Impermanent Loss (IL)
Gdy cena tokenów zmienia się względem chwili wpłaty, wartość pozycji LP jest *mniejsza* niż gdybyś po prostu trzymał tokeny (HODL).
:::

- IL jest tym większy, im bardziej cena odchyla się od ceny wejścia
- Przy powrocie ceny do poziomu wejścia --- IL znika (stąd *impermanent*)
- LP profituje gdy: **opłaty > IL**
- Strategia: pule stabilnych par (np. USDC/USDT) mają minimalne IL

## Concentrated Liquidity

::: block
### Ulepszenie: CLMM (Concentrated Liquidity Market Maker)
- LP wybiera **przedział cenowy** $[p_a,\, p_b]$, w którym działa
- Kapitał jest efektywniejszy --- więcej płynności tam, gdzie handel
- Wyższe opłaty przy trafnym wyborze zakresu
- Wyższe ryzyko IL przy wyjściu ceny z zakresu
:::

::: example
### Na Solanie
**Orca Whirlpools**, **Raydium CLMM** --- wiodące implementacje CLMM
:::

# Ryzyka i podsumowanie

## Ryzyka w AMM

::: alert
### Ryzyka, o których warto pamiętać
- **Impermanent Loss** --- przy zmiennych cenach względem wejścia
- **Price impact** --- duże swapy względem puli kosztują więcej
- **Smart contract risk** --- błąd w kodzie = utrata środków
- **Oracle manipulation** --- fałszywe ceny zaburzają wycenę
- **Rug pull** --- złośliwy projekt drainuje płynność
:::

## Podsumowanie

::: block
### AMM
- Formuła $x \cdot y = k$ --- cena wynika z proporcji rezerw
- LP dostarcza płynność, zarabia opłaty transakcyjne
- Price impact i Impermanent Loss to główne ryzyka
- CLMM zwiększa efektywność kapitału w wybranym przedziale
:::

::: example
### Na Solanie
**Orca** (Whirlpools CLMM) $\cdot$ **Raydium** (CLMM + Standard AMM)
:::
