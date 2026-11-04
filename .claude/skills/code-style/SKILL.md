---
name: code-style
description: Use before writing or editing any code, from any repo. The user's code style: derivation order, one equation per def, jax/numpyro conventions, h-unit docstrings, file naming and outputs.
---

# Code
Write as a scientist deriving, not as an engineer maintaining.
Flat, in the order a person derives it: equation, limit check inline, wrapper that attaches units.
Physics visible: no helper hides an equation, no class holds state, knobs are args with defaults.
Checks are the only error handling: assert in numpy glue, eqx.error_if inside jax (jit safe). No try/except, no raise, no input validation, no None defaulting.
One equation, one def, the equation in its docstring as ASCII, even for a one-liner.
Tag a source only when known, as an arXiv html link to the equation; never guessed.
Composites call equation defs in derivation order, one named intermediate per line.
A general formula is its own def; specific profiles feed it, never restate it.
Units: galutil hunits=True, h powers in every docstring (M [h^-1 Msun], M* [h^-2 Msun], R [h^-1 Mpc]); a source or catalog in another h convention is converted once at entry, its constants times the powers of h they carry.
jax by default; a numpy leg only where jax cannot do it.
Arrays in jax: equation defs take scalars (R may be a vector); maps are jax.vmap(lambda x: f(..., x, ...))(xs), never in_axes, [:, None] or einsum; every integral or weighted sum is its own def, map then reduce: for the reader, as fast under jit.
Names and parametrisation follow the cited source, its symbols and pivots: no reparametrising.
Distributions with a closed form are numpyro.distributions (log_prob, cdf, sample) in models and mocks alike; integrals of our own integrands are jnp.trapezoid on a grid; a tabulated density is drawn by its trapezoid CDF and np.interp: reads as the definition, as fast under jit.
Readable by a physicist with the paper beside it: when a shortcut and a plain loop compute the same thing at the same speed, write the loop.
Bins and slices are written as their edges, (x >= lo) & (x < hi), never index arithmetic (np.digitize, np.searchsorted, offsets like - 1): the bin is visible.
Parameter dicts are built once, key by key; never unpacked with **: every value is visible where it is used.
Priors are numpyro distributions in one top block, a source tag per line; variants' prior dicts merge with |, p is sampled in a loop over them.
No silent fallbacks: missing data is NaN or an assert, never a filler value such as zeros for an empty bin.
Vectorise only a timed hot path: everything else stays in the readable form.
At the end of a build, show the stage map (stage, lines), the glue budget (physics / total lines) and every construct outside the stages, then ask about any construct you are unsure they read: the code is theirs to maintain.
One path through a function. Branch only where the physics is piecewise, as a mask.
Inference files are `# %%` cells in derivation order: knobs, priors, data, model, likelihood, sampler, diagnostics, save, plot.
Variants of one model are picked once at top, dict(name=fn)[SETUP], fns of one signature; one variant is the n = 1 case of this, so a new variant only adds lines at the top.
Glue (plots, prompts, sampler calls) is flat and repeated, never abstracted; data loading shared by sibling scripts is the one exception (# Files).
Comments are one line, physics or provenance only, never mechanics.
No README bullet or comment spans two lines: if it needs a paragraph it is a docstring equation or it is deleted.
Write the vanilla first, always, and test the fast one against it: a pasted equation in jax is already the vanilla.
Prefer fewer, meaningful tests: against a library, a vanilla implementation, or an analytic limit.
Equations and glue as one-liners.

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
