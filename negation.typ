

== Negation

- in contrast to the `Bool` values `true` and `false` there are
  _types_

  `True : Prop` and `False : Prop`.

  The type `True` is a "trivially provable" proposition. In Lean,
  its proof term (certificate) is called

  `True.intro : True`

  The type `False` has no terms.

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
