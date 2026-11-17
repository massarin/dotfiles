---
name: code-style
description: Use before writing or editing any code, from any repo. The user's code style: who reads the code, comments, naming, variants, file naming and outputs.
---

# Code
The reader is a physicist who verifies every line you write, against a source (a paper, a catalogue) or against what they have in mind (a plot, an algorithm, a model). Their time to verify is the only cost.
Write what the output needs, nothing they did not ask for.
No docstrings: the code reads as the equation, in the symbols of the source or of the user.
A comment only for what the code cannot show: a unit conversion, a power of little h, a non-obvious why.
A section marker is a label of one or two words.
Names follow one contract within a file: the name says what is returned, and things of one kind have names of one shape (mean_<q>, <q>_dist).
What varies between runs is written as its difference only and chosen once at the top. Functions or classes is the user's call per task: ask.
Split a line that needs two readings.
What you left out goes in your reply, one line each.

# Files
Files cluster by name prefix, so siblings sort together: `<prefix>_<what>.py`.
A sibling `<script>_check_<what>.py` is a plot plus one assert, `<script>_plot_<what>.py` a plot or sweep with none.
What sibling scripts share (data loading) is `<prefix>_util.py`, one def per dataset: one source, next to its users.
Every file a script writes starts with that script's name: s4_fit_plot_shmr.py -> s4_fit_plot_shmr_<what>.png, so an output points back to its source.
Outputs are overwritten on rerun, never versioned by name: the script is the version.
Stale outputs (.parquet, .png, .npz) are proposed for deletion as soon as their script changes or goes, git indexed or not.

# Content
One source of truth per concept, point to it rather than restating it.
Rationale as a trailing ": reason" fragment, never a paragraph.
Warn against content that will go stale and propose the generated alternative.
