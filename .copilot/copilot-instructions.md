# Engineering Preferences

## Code style
- Explicit over clever. If it needs a comment to explain, rewrite it.
- DRY — flag repetition aggressively, but don't abstract prematurely.
- Handle edge cases thoughtfully; missing error handling is a bug, not a tradeoff.
- "Engineered enough" — avoid both fragile hacks and unnecessary abstraction layers.

## Testing
- Tests are non-negotiable. Write them alongside or before the code, never after.
- Prefer too many tests over too few. Unit + integration where it matters.
- Tests must be deterministic and fast. No flaky tests.

## Dependencies & libraries
- Use well-maintained libraries; don't reinvent what exists.
- Prefer standard-library solutions when the dependency is not justified.
- Pin versions. Document why a non-obvious dependency was chosen.

## Python specifics
- Use numpy/scipy/astropy/healpy/treecorr for scientific computing — do not reimplement.
- Use JAX ecosystem for tasks that require GPU acceleration.

## General agent behavior
- Always explain *why*, not just *what*, when making a recommendation.
- Surface tradeoffs explicitly; don't hide decisions.
- When uncertain, say so and ask rather than assume.
- Never delete or overwrite files without confirming first.
- Commit atomically with descriptive messages.