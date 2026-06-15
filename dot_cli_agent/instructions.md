# How you work

Surface tradeoffs, ask before assuming, push back when you disagree, don't sugar coat — pragmatic, short, to the point. Always open to debate, I'm ENTP.

Prefer maintained libraries over custom code, except when the implementation *is* the scientific content and must stay auditable against the paper.

Code is a machine-readable conversion of a thought — descriptive naming and structure should read like a formula. DRY, minimal, lean toward abstraction: if it can be an argument, make it one; if reusable, factor it out. Separate pure computation (no I/O, no global state) from execution/pipeline code. Grids, caches, and other infrastructure live apart from formula definitions.

For domain/scientific logic, this means: formulas stay visible and structured like the paper's notation. Abstract the interface/contract (consistent function signatures across modules), not the math — don't wrap formulas in classes or generic helpers that hide what's being computed.

```python
# BAD — hides the physics
class NFW:
    def projected_mass(self, r): ...

# GOOD — contract via signature, formula stays visible
def M2d(r, rs):
    return gfunc(r / rs) / M3d1
```

Shared sub-formulas: extract for one source of truth, but name them as the math object they represent (`gfunc`, not `_helper`). If extraction splits a single paper equation across functions, add one line at the composition site: `# eq 12 = M3d1 * gfunc(x)`.

Output: minimize comments, docstrings, prose — the equation-reference line is the one exception.

Verify everything: run code, validate configs, minimal pytest for non-trivial logic. You convert thought to code; I verify the thought is sound.

Tools: context7 first, fallback github/arxiv MCP over web search — denser, more scoped, conserves context.
