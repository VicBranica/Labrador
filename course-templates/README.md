# Course templates

[← Project map](../index.md)

> Start every new course file from one of these, so it matches the files already in the courses: same header, same sections, same anchors.

## How to use a template

1. Copy the template to its destination and rename it (see the table).
2. Replace every `{{PLACEHOLDER}}`. Delete the guidance lines in *italics in brackets*.
3. Make the follow-up edits listed for that file type.
4. Check that every relative link and `#anchor` resolves before committing.

Links inside the templates are written as they will be at the destination, so they only resolve after you copy the file into place.

## Templates

| Template | Makes | Copy to | Name |
|---|---|---|---|
| [lesson.md](lesson.md) | A course01 lesson in nine steps | `version/course01/` | `Lesson{{N}}.md` |
| [course02-resource.md](course02-resource.md) | A course02 reading-list entry | `version/course02/{{NN}}-{{author}}-{{short-title}}/` | `README.md` |
| [course03-domain.md](course03-domain.md) | A course03 domain file (A–C, layers 1–6, D–G) | `version/course03/{{NN}}-{{domain}}/` | `README.md` |
| [course04-bench.md](course04-bench.md) | A course04 bench with a three-level BOM and builds | `version/course04/` | `{{NN}}-bench-{{domain}}.md` |
| [course05-company.md](course05-company.md) | A course05 company file | `version/course05/{{NN}}-{{category}}/` | `{{company}}.md` |
| [course-index.md](course-index.md) | The `index.md` header for a new course | `version/course{{NN}}/` | `index.md` |

## Follow-up edits

| New file | Also update |
|---|---|
| Lesson | The lessons table in `version/course01/index.md`; the prev/next links of the neighbouring lessons; the project map's domain cross-reference and Contents; the `**Lesson:**` line of the matching course03 file. |
| course02 resource | The table in `version/course02/index.md`; the project map's tree count, course02 table and domain cross-reference; section 9 of the lesson and section F of the course03 domain that cite it. |
| course03 domain | The tables in `version/course03/index.md`; the prev/next links of the neighbouring domain files; the project map. |
| course04 bench | The files table and BOM sums in `version/course04/index.md`; the starter kit's "Where used" table; the project map. Level 0 and level 1 costs are the sums of the level 2 items. |
| course05 company | The category `index.md`, the products table and company list in `version/course05/index.md`. |
| Any text that names a company | That company's "Cited in the courses" table in course05. |

## Conventions

- Domain numbers are the same everywhere: `01` electrical · `02` magnetic · `03` mechanical · `04` fluidic · `05` thermal · `06` chemical · `07` radiant.
- BOM codes are `bench.category.item` (`3.1.3`); the starter kit uses `S`. The teardown category is always last, at cost 0.
- In build tables, cite an item as `` `code` short name `` — the description without its parenthesis.
- Unknown facts in a company file are "—", never guessed.
