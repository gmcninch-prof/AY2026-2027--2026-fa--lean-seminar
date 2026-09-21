// seminar-week2-logic-sets.typ
//
// Formalization Seminar -- session 2: logic and sets, fall term.
// Built on the shared slide theme at @local/george:0.1.0.

#import "@preview/touying:0.6.1": *
#import "@local/george:0.1.0": slides

#show: slides.university-theme.with(
    config-common(handout: false),
    config-info(
        title: [Formalization Seminar: Logic and Sets],
        author: [George McNinch],
        date: datetime(year: 2026, month: 9, day: 22), // TODO: confirm actual date
        institution: [Tufts University],
    ),
)

#show link: set text(fill: blue)

#slides.title-slide()

= Welcome back

== Plan for today

#pause
- a quick word on `Bool` vs `Prop`
#pause
- negation: what `¬P` actually *is*
#pause
- automating negation: `push_neg`
#pause
- punchline, live: De Morgan for sets

= `Bool` vs `Prop`

== Why do we need this at all?

#pause
- last time: Lean *checked* a proof, and it felt like a compilation
  step
#pause
- but what, exactly, is it checking?
#pause
- some statements a computer really can just settle by calculation --
  `2 + 2 = 5` is a finite check
#pause
- most of what we actually care about can't be settled that way:
  "there are infinitely many primes," "this sequence converges,"
  "these two groups are isomorphic" -- there's no brute-force
  computation that decides these
#pause
- Lean's answer: represent a statement as a *type* (`Prop`), and "this
  is true" means *producing a term of that type* -- a genuine
  certificate, not a computed bit
#pause
- this is the same idea behind last time's demo: `append_length`
  wasn't checked by running anything -- it was checked by verifying
  the *proof term* has the right type

== Two different kinds of things

#pause
```lean
#eval (2 + 2 == 5)        -- Bool: computes, gives `false`
#check (2 + 2 = 5 : Prop)  -- Prop: a statement
```
#pause
- `Bool` is ordinary *data* -- two constructors, `true` and `false`.
  You *compute* a `Bool`.
#pause
- `Prop` is the type of *statements*. To settle one you give a
  *proof*, not a value out of a two-element type.
#pause
```lean
example : ¬ (2 + 2 = 5) := by decide
```
#pause
- `decide` can settle statements like this automatically, because
  they're the kind of statement a computer can just check by
  calculation. (More on how, later in the semester.)

= Negation

== What is `¬P`, really?

#pause
- `¬P` is *notation* for `P → False`
#pause
- so "prove `¬P`" means: construct a function taking a hypothetical
  proof of `P` and producing a proof of `False`
#pause
```lean
example : ¬ (1 = 0) := by
  intro h        -- h : 1 = 0, goal is now False
  exact absurd h (by norm_num)
```
#pause
- `intro h` is the moment to linger on: it's the *same* `intro` you'd
  use on any implication -- nothing special about negation as a
  connective, it's just an implication whose target happens to be
  `False`
#pause
- this is exactly proof-by-contradiction, stated precisely: "assume
  `P`, derive an absurdity" *is* "give a term of type `P → False`"

== Why is `False` absurd?

#pause
- `False` is the type with *no constructors*
#pause
- so having a term of type `False` is absurd by construction: from
  one, you can derive anything (`h.elim`, `absurd`, `contradiction`)
#pause
- that's what closes the loop -- it's *why* `P → False` genuinely
  captures "`P` cannot hold"

== A note on names

#pause
- `Prop` has its own `True` and `False` -- these are *types*, not the
  `Bool` values from earlier
#pause
- `False` : no constructors (as before -- absurd)
#pause
- `True` : one trivial constructor, `True.intro` -- proving it needs
  no information at all
#pause
- the capitalization is the tell: `True`/`False` (Prop) vs
  `true`/`false` (Bool) -- you'll see both in Mathlib source, so it's
  worth having the distinction ready

= Automating negation

== `push_neg`: De Morgan for propositions

#pause
- pushing a negation through by hand (`intro`, `cases`, ...) works,
  but gets tedious once quantifiers and connectives stack up
#pause
```lean
example (P Q : Prop) : ¬ (P ∨ Q) ↔ ¬P ∧ ¬Q := by
  push_neg
  -- goal is closed, or reduced to something trivial
```
#pause
- `push_neg` mechanically pushes negation through `∀`, `∃`, `∧`, `∨`
  -- this *is* De Morgan, just at the level of propositions
#pause
- (we're working classically throughout, so `¬¬P → P` is fair game --
  `push_neg`, `by_contra`, etc. rely on this)

= Punchline, live

== De Morgan for sets

#pause
- same shape of statement, now for sets:
```lean
example (s t : Set α) : (s ∪ t)ᶜ = sᶜ ∩ tᶜ := by
  ext x
  simp [Set.mem_union, Set.mem_compl_iff]
  push_neg
  tauto
```
#pause
- switching to the editor now -- let's build this up piece by piece
#pause
- watch for: `ext x` turns a *set equality* into an *iff of
  memberships* -- this is where "sets" quietly becomes "logic" again

// (Live coding happens outside the slide deck. Return here afterward.)

= Wrap

== Questions?

#pause
- where did the connection between logic and sets feel surprising?
