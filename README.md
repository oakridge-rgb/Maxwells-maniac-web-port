# Maxwell's Maniac — Web Port

A clean-room browser reconstruction of **Maxwell's Maniac**, the 1992 puzzle game
from **Microsoft Entertainment Pack 4** for Windows 3.x, originally programmed by
**Dima Pavlovsky** and developed by **Marjacq Micro**, published by Microsoft.

Play it by opening `index.html` — one self-contained file, no dependencies, no
build step, no network requests. Everything (physics, rendering, sound, UI) is
inline.

> This project ships **no original Microsoft code or assets**. It is an
> independent reimplementation of documented game mechanics. See
> [Source availability & preservation](#source-availability--preservation).

## How to play

| Input | Action |
| --- | --- |
| Drag on the board (mouse/touch) or **↑ / ↓** (`W` / `S`) | Slide the door along the divider wall |
| `Enter` | Continue / restart |
| `Esc` | Back to menu |

The chamber is divided by a wall with a single gap. The gray door slides along
that wall to seal the gap or open a lane — and it slides at a fixed speed, so
you have to think like the demon: anticipate which molecule arrives next, open
the lane for it, and shut the door before anything wrong slips through.

A molecule only "counts" while it **stays** on its correct side. Sort every
molecule simultaneously to clear the level. Levels add molecules and speed;
the timer shrinks. When time runs out, the experiment ends.

### The three modes

All three modes are named in period documentation of the original game.

- **Move** — red molecules only; they all start on the wrong side. Get every
  red molecule into the red chamber.
- **Swap** — adds blue molecules. Red starts in the blue chamber and blue
  starts in the red chamber: the classic Maxwell's-demon separation problem.
- **Paint** — same board as Swap, but a molecule turns **gray** while it is on
  its correct side and reverts to its color if it crosses back. The level
  clears when the whole board is gray at once.

### Scoring (reconstructed values)

- **+100** when a molecule reaches its matching chamber for the first time.
- **+10 × seconds remaining** bonus when a level clears.
- Two skill settings: **Novice** and **Maniac** (faster molecules, less time).

## Historical background

Maxwell's Maniac shipped in **Microsoft Entertainment Pack 4 (1992)**, the last
of the four "Entertainment Pack" collections Microsoft sold to show off Windows
3.x as a gaming platform. The packs were deliberately not copy-protected and
their authors were famously paid in shares of Microsoft stock. The game is
"loosely based on the concept of the Maxwell's demon thought experiment" —
James Clerk Maxwell's 1867 thought experiment in which a being guards a tiny
gate between two chambers of gas, sorting fast and slow molecules and
apparently violating the second law of thermodynamics. In the game, you are the
demon, and the molecules are red and blue.

## Source availability & preservation

- **The original source code has never been released.** It is closed-source
  Microsoft/Marjacq Micro work from 1992.
- The original is a **16-bit Windows (Win16) executable** (`MAXWELL.EXE`). It
  runs on 16- and 32-bit Windows only — 64-bit Windows cannot execute it, which
  is the main reason the game became unplayable on modern machines.
- Microsoft ended support for all Entertainment Packs on **January 31, 2003**,
  and the packs have long been out of print.
- The binaries survive in several preservation collections (Internet Archive
  disk images of Entertainment Pack 4, WinWorld, My Abandonware's Windows 3.x
  section), and Microsoft's own KnowledgeBase article for the game
  ("Q99158: Description of Maxwell's Maniac") is preserved in community KB
  mirrors. A GOG Dreamlist entry shows continued community interest in a
  commercial re-release.
- This port exists because the preserved binaries need an emulator, while this
  repository runs anywhere a browser runs — including phones.

### Research sources

Consulted while building this port (retrieved November 2026):

- Wikipedia — *Microsoft Entertainment Pack* (pack contents, licensing and
  support history): https://en.wikipedia.org/wiki/Microsoft_Entertainment_Pack
- Codex Gamicus / Fandom — *Maxwell's Maniac* (author, developer, and the
  Move/Swap/Paint mode descriptions; fragments of the article were retrieved
  via web-search excerpts as the wiki is behind a bot wall):
  https://gamicus.fandom.com/wiki/Maxwell%27s_Maniac
- IGDB — *Maxwell's Maniac* (core premise blurb, mirrored across Kotaku, VGL,
  GameScriptions and other IGDB clients):
  https://www.igdb.com/games/maxwells-maniac
- KnowledgeBase Archive — Microsoft Home Games index listing
  "Q99158: Description of Maxwell's Maniac":
  https://www.infania.net/misc/kbarchive/id/homegame/index.html
- GOG Dreamlist — *Maxwell's Maniac (1992)*:
  https://www.gog.com/dreamlist/game/maxwell-s-maniac-1992

### Documented vs. reconstructed mechanics

| Mechanic | Status |
| --- | --- |
| Sorting red/blue molecules into color-coded chambers | Documented |
| Sliding door in the divider wall | Documented |
| Three modes: Move, Swap, Paint | Documented |
| Paint mode grays correct-side molecules, reverts on crossing back | Documented |
| Move mode: red only; Swap adds blue | Documented |
| Maxwell's demon framing, JezzBall-like layout | Documented |
| Door sliding speed, molecule counts/speeds per level | Reconstruction |
| Timer, +100/+10×time scoring, Novice/Maniac skill levels | Reconstruction |
| Molecule-molecule elastic collisions | Reconstruction |

## Implementation notes

- Single `index.html` (~28 KB): HTML5 canvas, vanilla JS, inline CSS.
- Fixed-timestep physics (120 Hz) with constant-molecule-speed drift
  correction and equal-mass elastic collisions.
- Win3.1-flavored UI drawn in CSS (bevels, navy title bar, modal dialogs) and
  canvas (status strip, timer bar).
- Sounds are generated with the Web Audio API as PC-speaker-style square
  waves; no audio files. Toggle via `MM.sound` in the console or mute your tab.
- The game object is exposed as `window.MM` for debugging and testing.

## License

Code in this repository: **MIT**. "Maxwell's Maniac" and Microsoft
Entertainment Pack are trademarks of Microsoft; the original game remains the
property of its rights holders. This reconstruction contains no Microsoft code
or art and is presented for historical and educational interest.
