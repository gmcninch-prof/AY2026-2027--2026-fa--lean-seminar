# Formalization Seminar — plan for early sessions

Weekly, Tuesdays 3:30–4:20, JCC 302.

Since we can't assume outside reading gets done, the core logic/tactic
vocabulary needs to be built into room time over the first several
sessions, rather than assigned as prep. Mathematics in Lean sections
are used as *reference material* participants can revisit, not as
required homework driving the pace.

## Week 1 — Kickoff (done)

Framing, live demo (`append_length`), tease of the analysis target
(`seq_limit` / squeeze theorem), logistics.

## Week 2 — `apply`/`rw` and order reasoning

- Corresponds to Mathematics in Lean §2.3 ("Using Theorems and Lemmas")
- Introduce `apply`, `exact`, `rw` through live-coded examples rather
  than lecture
- Order/inequality reasoning: `le_trans`, `min`/`max`, `abs_add`
  (triangle inequality) — this is the toolkit that later shows up
  directly in convergence proofs
- Possibly pair people up for hands-on time; the Lean-competent grad
  student floats to help

## Week 3 — Quantifiers

- Corresponds to Mathematics in Lean Ch. 3, roughly through §3.3
  (Implication and the Universal Quantifier; the Existential
  Quantifier; Negation)
- The conceptually hardest jump for people used to informal math —
  worth its own session rather than folding it into something else
- Live-code some `∀`/`∃` statements and proofs together; unpack what
  `∀ ε > 0, ∃ N, ...` is actually asking for, piece by piece

## Week 4 — Finishing logic, landing at Sequences and Convergence

- Corresponds to Mathematics in Lean §3.4–§3.6 (Conjunction/Iff,
  Disjunction, Sequences and Convergence)
- By the end of this session, the `seq_limit` definition and squeeze
  theorem statement from the kickoff demo should be something
  participants can actually start attempting, not just admire

## Week 5 — Sets and functions, transition to the analysis project

- Corresponds to Mathematics in Lean Ch. 4 (Sets, Functions,
  Schröder–Bernstein)
- Pivot toward the actual undergraduate-analysis formalization project

## Notes

- Some of the intro material is probably best delivered via live
  coding rather than pure lecture or independent exercises — echoing
  the kickoff demo format.
- Reading list (Mathematics in Lean sections above, plus the Natural
  Number Game as an optional no-install warm-up) stays posted on the
  seminar page as reference, not as a prerequisite for keeping up in
  the room.
