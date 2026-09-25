---
name: mybib-read
description: Answer from Nicolo's own library at ~/cosmo/mybib - what his papers and code libraries contain, as claims with equations, arXiv anchors and the symbol that implements them. Use when asked what his sources say on a topic, for the equation or citation behind a relation, or for the reference to cite while writing code. Read only, works from any repo.
---

# mybib-read

The library is at `~/cosmo/mybib`. Schema: its `SPEC.md`. Never restate that here.

Read only. Writing, ingesting and tagging are the project-scoped `mybib-ingest`
skill, and are not available from another repo.

## Query

Three shapes, all ripgrep, all against absolute paths.

    rg -l "^kind: shmr$" ~/cosmo/mybib/assets/                    # inventory by kind
    rg -A20 "^kind: concentration_relation$" ~/cosmo/mybib/assets/  # the maths and the anchors
    rg -l "\[\[halo_structure\]\]" ~/cosmo/mybib/sources/         # papers in a topic

An asset is self-contained: `kind`, `source`, `anchor`, `symbol`, and the
equation in `$$`. Answer from the asset, not from the cache and not from memory.

`symbol` and `symbol_url` are the function that implements the equation, which is
what makes an asset usable mid-code. Give both the equation and the symbol.

## Cite

From `~/cosmo/mybib/bib/library.bib`, by the source's `citekey`. Never invent a
citekey: if the paper is not in `sources/`, say it is not in the library.

## Scope

- A source still reading `TODO summary from full text` is at the mapped tier: its
  title, year and keywords are real, its contents are not yet in the graph. Say so
  rather than reading `cache/` to improvise a summary.
- A source with an empty `arxiv` field has no fulltext here, ever, by design.
- Never edit anything under `~/cosmo/mybib` from another repo.
