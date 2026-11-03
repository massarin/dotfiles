---
name: mybib-read
description: Use whenever a paper is to be read, searched, quoted or cited, or an equation looked up in one, from any repo. For this we have a local paper library at ~/cosmo/mybib.  It contains tools to check the library and its cached fulltext; given an arXiv id, returns the local text, ingesting the paper first if missing. This is part of a local system/contract for handling literature.
---

# mybib-read

The library is at `~/cosmo/mybib`.

## Search
Explore library's metadata and papers fulltext:
```
rg -il "<terms>" ~/cosmo/mybib/sources/   # title, authors, keywords, abstract
rg -il "<terms>" ~/cosmo/mybib/cache/txt/ ~/cosmo/mybib/fulltext/ # fulltext of every paper
```
A `cache/txt/<id>.txt` maps to its source by `rg -l "^arxiv: <id>$" ~/cosmo/mybib/sources/`; `fulltext/<citekey>_marker.md` by its citekey.

## Read
Fetch a paper:
```
python3 ~/cosmo/mybib/bin/get.py <arxiv id | arxiv url | citekey | zotero key>
```
`fulltext: marker` means machine conversion of a PDF with no arXiv text: `[#p12]` is printed page 12, cite Author Year p. 12, and check symbols against the PDF before quoting, bold vectors can be lost.
If paper is in the library it prints the citekey, then the file to Read.
Otherwise it is ingested -> (Zotero, `sources/`, cache, commit, push) first.
No arXiv id yet: find it in `sources/` first, else ask, else `python3 ~/cosmo/mybib/bin/zfind.py "<title|doi>"` (read only).

## Cite

Use arxiv's html paper version to cite and link to equation/section/figure.
Quote equations as `[S3.E31](https://arxiv.org/html/<pinned id>#S3.E31)`, same goes for figures and subsections, notation is: `#Ch0.F9.fig1`=Figure 9, chapter 0
`#S3.F1`=Figure 1 in section 3
`#S3.T1`=Table 1 in section 3
`#S4.SS4`=Subsection 4 in section 4.
Sometimes the arxiv html conversion is not perfect but link always resolves to the paper so it doesn't matter.
Grep the file for the anchor before quoting it.
