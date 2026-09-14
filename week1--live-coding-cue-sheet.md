# Live-coding cue sheet — kickoff demo

Editor: Emacs (lean4-mode). Pre-warm the build cache before the room
fills up — open the file once ahead of time so elaboration isn't cold.

## 1. Ground it with a computation

```lean
#eval append [1, 2, 3] [4, 5]
```

Say: "before we prove anything, let's see it run" — let them watch it
evaluate. Ten seconds, not more.

## 2. The bridge line (say this out loud, no slide needed)

"This looks like a programming exercise, but structural induction on
lists and induction on ℕ are the same principle — this is the same
machinery we'll use on sequences later this semester."

## 3. State the theorem, empty proof

```lean
theorem append_length {α : Type} (xs ys : List α) :
    (append xs ys).length = xs.length + ys.length := by
  sorry
```

Let `sorry` sit for a second — point at it: "Lean will accept this
file, but it knows this isn't actually proved. That's the difference
between checking syntax and checking a proof."

## 4. Start the induction

```lean
  induction xs with
  | nil => sorry
  | cons z zs ih => sorry
```

Narrate: two cases, because a list is either empty or a head plus a
tail. This *is* the definition of `List` — nothing hidden.

## 5. Close the `nil` case

```lean
  | nil => simp [append]
```

Narrate briefly what `simp [append]` is doing: unfolding `append` on
the empty case and closing a now-trivial equality.

## 6. Close the `cons` case — the real content

```lean
  | cons z zs ih =>
      simp only [append, List.length_cons]
      rw [ih]
      ring
```

Narrate each line separately — this is the payoff, don't rush it:
- `simp only [append, List.length_cons]` — just unfolding definitions,
  bookkeeping, nothing deep yet
- `rw [ih]` — point at this explicitly: "here `ih` is the induction
  hypothesis — Lean is handing us, for free, the fact that the theorem
  already holds for the shorter list `zs`. This line is the whole
  proof."
- `ring` — just cleaning up the order of addition; not every line
  carries mathematical weight, and that's fine too

## 7. Watch it fail (deliberate)

Change something small and wrong — e.g. drop the `ih` from the
`simp` call, or flip `xs.length + ys.length` to `ys.length +
xs.length` in the statement — and let the error surface.

Narrate: "this is the whole point — Lean isn't taking my word for it."
Then fix it back.

## 8. Land the close

Once accepted: pause, let the room see the goal state clear
("No goals" / checkmark), don't rush past it. This is the moment the
first-meeting pitch is actually about.

## Optional, if time allows: `append_assoc`

Only if the room still has time and appetite after questions — not a
required step. Same skeleton, different property, reinforces the
pattern rather than diluting it:

```lean
theorem append_assoc {α : Type} (xs ys zs : List α) :
    append (append xs ys) zs = append xs (append ys zs) := by
  induction xs with
  | nil => simp [append]
  | cons x xs ih => simp [append, ih]
```

Frame it live as "let's see the same idea used again," not as a
planned second act.

A further optional beat if things are going well: try the `cons` case
with `rw` alone instead of `simp` — it gets genuinely awkward (several
occurrences to unfold, in a particular order, plus needing to splice
in `ih` by hand), and watching it struggle is a good motivator for
"here's why `simp` exists" before switching back to `simp only [ih,
append]` and watching it just close. Good if there's room; skip
without regret if not.

## If something goes wrong live

Don't debug syntax errors in real time hunting for a typo — if
something breaks in a way that isn't the deliberate step 7 failure,
say so plainly ("that's not the failure I meant to show you") and
either fix it fast from memory or move on to the next planned step;
don't let troubleshooting eat the room's attention.
