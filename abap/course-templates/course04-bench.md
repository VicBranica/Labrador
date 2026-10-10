# Bench {{N}} — {{Domain}}

[← Course 04 index](index.md) · [← Bench {{N-1}}](0{{N-1}}-bench-{{previous}}.md) · [Bench {{N+1}} →](0{{N+1}}-bench-{{next}}.md)

*[Bench 1's previous link is [← Starter kit](00-starter-kit.md); bench 8's next link is [Course 04 index →](index.md).]*

*[Open question: Labrador's benches are physical kits costed as a BOM. An abap bench is likely a hands-on lab on an SAP trial or ABAP environment — system, packages, sample data and tools rather than parts; keep the BOM sections until the format is decided.]*

**Course:** [course01 Module {{N}}](../course01/index.md#module-{{n}}--{{domain}}-domain) · **Theory:** [course03/{{NN}}-{{domain}}](../course03/{{NN}}-{{domain}}/README.md) · **Shared tools:** [Universal Starter Kit](00-starter-kit.md)

## What's on it

{{Two sentences: what's on the bench and what it teaches.}}

## BOM structure

```
{{N}}  Bench {{N}} — {{Domain}}  (${{bench total}})
├── {{N}}.1  {{Category}}  (${{category total}})
│   ├── {{N}}.1.1  {{Item description}}
│   └── {{N}}.1.2  {{Item description}}
├── {{N}}.2  {{Category}}  (${{category total}})
│   └── {{N}}.2.1  {{Item description}}
└── {{N}}.{{last}}  Teardown targets (free)  ($0)
    └── {{N}}.{{last}}.1  {{Free object}}
```

## Multilevel BOM

*[Level 0 and level 1 costs are the sums of the level 2 items below them. Keep the tree, this table and the total line in agreement.]*

| Level | Item | Description | Qty | Cost (USD) | Notes |
|---|---|---|---|---|---|
| **0** | **{{N}}** | **Bench {{N}} — {{Domain}}** | 1 | **{{bench total}}** | |
| **1** | **{{N}}.1** | **{{Category}}** | — | **{{category total}}** | |
| 2 | {{N}}.1.1 | {{Item description}} | {{qty}} | {{cost}} | {{Why it's here; material or grade if it matters}} |
| 2 | {{N}}.1.2 | {{Item description}} | {{qty}} | {{cost}} |  |
| **1** | **{{N}}.2** | **{{Category}}** | — | **{{category total}}** | |
| 2 | {{N}}.2.1 | {{Item description}} | {{qty}} | {{cost}} |  |
| **1** | **{{N}}.{{last}}** | **Teardown targets (free)** | — | **0** | |
| 2 | {{N}}.{{last}}.1 | {{Free object}} | 1 | 0 | → {{what you'll find inside}}. |

**Bench {{N}} — {{Domain}} total: ${{bench total}}** for components (reuse the starter tools) — the course states ~${{stated}}.

## Four builds

### Build 1 — {{Title}}

{{One to three sentences: what you build and what you measure.}}

| Uses | |
|---|---|
| This bench | `{{N}}.1.1` {{Short name}} · `{{N}}.1.2` {{Short name}} |
| Other benches | `{{code}}` [{{Short name}}]({{NN}}-bench-{{domain}}.md) |
| Starter kit | `S.{{x.y}}` [{{Short name}}](00-starter-kit.md) |
| Not in any BOM | {{Household items}} *[For abap: anything outside the lab system.]* |

### Build 2 — {{Title}}

{{…}}

| Uses | |
|---|---|
| This bench | `{{code}}` {{Short name}} |

### Build 3 — {{Title}}

{{…}}

| Uses | |
|---|---|
| This bench | `{{code}}` {{Short name}} |

### Build 4 — {{Title}}

{{…}}

| Uses | |
|---|---|
| This bench | `{{code}}` {{Short name}} |

*[Leave out any "Uses" row that has nothing in it.]*

## Measurement wins

- {{What the learner can now do or estimate.}}
