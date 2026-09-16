// seminar-kickoff.typ
//
// Formalization Seminar -- kickoff meeting, fall term.
// Built on the shared slide theme at @local/george:0.1.0.
// No theorem-box machinery needed this time (framing/logistics talk,
// not a math-content talk) -- just the `slides` module.

#import "@preview/touying:0.6.1": *
#import "@local/george:0.1.0": slides

#show: slides.university-theme.with(
    config-common(handout: false),
    config-info(
        title: [Formalization Seminar: Kickoff],
        author: [George McNinch],
        date: datetime(year: 2026, month: 9, day: 15),
        institution: [Tufts University],
    ),
)

#slides.title-slide()
#show link: it => text(fill: blue, underline(it))


= Welcome

== Plan for today

#pause
- proof assistant and _Lean_?
- a short live demo -- watch Lean check a proof
- where I'd like to head: formalizing some undergraduate analysis
- logistics

= Proof assistants and Lean

== What is a proof assistant?

#pause
- It is a piece of software for:
  - *defining* mathematical objects,
  - *specifying* properties of those objects,
  - *proving* that the specifications hold
#pause

- the system ("proof assistant") checks that the proof is correct. This
  check feels a bit like a _compilation step_. #pause

- contrast with automated theorem proving: there, the *computer* searches
  for the argument. Here, *you* construct it and the proof assistant checks it.
#pause

- there are many different examples of proof assistants: Lean, Coq,
  Isabelle/HOL, Agda, Mizar, ...

  The differences mostly come down to the choice of underlying logic.

== Why Lean, specifically?

#pause
- Lean's foundations -- *dependent type theory* (Calculus of Constructions
  with inductive types) -- is expressive enough to state and prove
  essentially any theorem you'd meet in ordinary mathematics
#pause

- There is
  a large, actively maintained, community library of formalized
  mathematics known as  #highlight[mathlib] -- see #link("https://github.com/leanprover-community/mathlib4")

#pause

- Mainly, this seminar will take a pragmatic view on this
  subject. Rather than describing type-theoretic foundations for their
  own sake -- we'll just focus on how to use Lean to formalize
  mathematics.

== A taste of what Lean looks like

```lean
-- a definition
def append {α : Type} (xs ys : List α) : List α :=
  match xs with
  | []      => ys
  | z :: zs => z :: append zs ys

-- a theorem, and its proof
theorem append_length {α : Type} (xs ys : List α) :
    (append xs ys).length = xs.length + ys.length := by
  induction xs with
  | nil => simp [append]
  | cons z zs ih =>
      simp only [append, List.length_cons]
      rw [ih]
      ring
```

#pause

= Live demo

== Let's watch Lean check a proof

#pause
- let's switch to the editor now

- we'll prove `append_length` from scratch, live

- watch for what happens if a step is *wrong*?

// (Live coding happens outside the slide deck. Return here afterward.)

= Where this is headed

== The target: formalizing undergraduate analysis

- the plan for this seminar: work, together, toward formalizing pieces
  of the undergraduate analysis course

#pause
- here's the kind of statement we mean -- convergence of a sequence:
```lean
-- "u tends to ℓ"
def seq_limit (u : ℕ → ℝ) (ℓ : ℝ) :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - ℓ| ≤ ε
```

#pause
- and a real theorem about it -- the squeeze theorem:
  ```lean
  theorem squeeze (hu : seq_limit u ℓ) (hw : seq_limit w ℓ)
      (h : ∀ n, u n ≤ v n) (h' : ∀ n, v n ≤ w n) :
      seq_limit v ℓ := by
    sorry
  ```


== Suggested reading

#pause
- a gentle, no-install warm-up: the
  #link("https://adam.math.hhu.de/")[Natural Number Game] -- builds tactic
  and induction intuition in the browser
#pause
- when you're ready to install: Lean + mathlib (link already sent --
  VS Code, then the Lean extension, then mathlib)
#pause
- from #emph[Mathematics in Lean]: §2.3 ("Using Theorems and Lemmas") is
  the most useful part of Ch. 2 for where we're headed -- the rest of
  Ch. 2 you can skim or skip. Then Ch. 3 (Logic), through §3.6
  ("Sequences and Convergence"). Then Ch. 4 (Sets and Functions).
#pause
- try some of the exercises as you go -- no need to do all of them
#pause
- happy to help outside of meeting time too

= Logistics

- weekly, Tuesdays 3:30 -- 4:20, JCC 302

- see the seminar page:
  #link("gmcninch.math.tufts.edu/pages/2026-Fall---lean-seminar.html")

- some write-ups and materials will be posted to Proof Sketches
  #link("gmcninch.math.tufts.edu/proof-sketches/") as we go

