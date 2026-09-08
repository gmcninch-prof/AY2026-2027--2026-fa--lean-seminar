import csv, os, re
from collections import defaultdict

path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Untitled form (Responses) - Form Responses 1.csv")

# Atomic (1-hour) slots, in display order
atomic_slots = [
    "Tuesdays 1:30-2:30 pm",
    "Tuesdays 2:30-3:30 pm",
    "Tuesdays 3:30-4:30 pm",
    "Wednesdays 2:30-3:30 pm",
    "Thursdays 1:30-2:30 pm",
    "Thursdays 4:30-5:30 pm",
]

# Map each raw option string (as appears in the CSV) to the atomic slot(s) it covers.
option_to_atomic = {
    "Tuesdays 1:30-3:30 pm": ["Tuesdays 1:30-2:30 pm", "Tuesdays 2:30-3:30 pm"],
    "Tuesdays 2:30-3:30 pm": ["Tuesdays 2:30-3:30 pm"],
    "Tuesdays 3:30-4:30 pm": ["Tuesdays 3:30-4:30 pm"],
    "Wednesdays 2:30-3:30 pm": ["Wednesdays 2:30-3:30 pm"],
    "Thursdays 1:30-2:30 pm": ["Thursdays 1:30-2:30 pm"],
    "Thursdays 4:30-5:30 pm": ["Thursdays 4:30-5:30 pm"],
}

weight_map = {
    "Very likely": 1.0,
    "Maybe - depends on how busy the term seems.": 0.5,
}

raw_counts = defaultdict(int)          # simple headcount per atomic slot
weighted_counts = defaultdict(float)   # weighted by likelihood
voters = defaultdict(list)             # names per atomic slot
very_likely_counts = defaultdict(int)  # count of "Very likely" respondents per slot

names = []
likelihoods = []

with open(path, newline='', encoding='utf-8') as f:
    reader = csv.DictReader(f)
    fieldnames = reader.fieldnames
    time_field = [fn for fn in fieldnames if fn.startswith("Which of the following")][0]
    for row in reader:
        name = row["Your name:"].strip()
        likelihood = row["How likely are you to attend/participate in the lean seminar?"].strip()
        names.append(name)
        likelihoods.append(likelihood)
        w = weight_map.get(likelihood, 0.5)
        options = [o.strip() for o in row[time_field].split(",")]
        # normalize possible whitespace variations
        atomic_hit = set()
        for opt in options:
            opt_norm = re.sub(r'\s+', ' ', opt).strip()
            mapped = option_to_atomic.get(opt_norm)
            if mapped is None:
                print(f"WARNING: unrecognized option: {opt_norm!r}")
                continue
            for a in mapped:
                atomic_hit.add(a)
        for a in atomic_hit:
            raw_counts[a] += 1
            weighted_counts[a] += w
            voters[a].append(name)
            if likelihood == "Very likely":
                very_likely_counts[a] += 1

total = len(names)
print(f"Total respondents: {total}")
print(f"Likelihood breakdown: {dict((l, likelihoods.count(l)) for l in set(likelihoods))}\n")

print(f"{'Slot':<28} {'Raw count':>10} {'Very likely':>12} {'Weighted':>10}")
for slot in atomic_slots:
    print(f"{slot:<28} {raw_counts[slot]:>10} {very_likely_counts[slot]:>12} {weighted_counts[slot]:>10.1f}")

print("\nVoters per slot:")
for slot in atomic_slots:
    print(f"  {slot}: {', '.join(voters[slot])}")
