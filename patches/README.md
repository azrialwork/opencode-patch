# patches

Patch files (`*.patch`) in this directory are applied to the upstream
OpenCode checkout, in filename order, before building. See the main
README for how to create one.

Current series:

- `0001-remove-builtin-providers.patch` — removes all built-in providers
  and models except `opencode` (Zen); custom providers still work. See
  the main README's *Patches* section for exactly what is deleted.

This file is not a patch and is ignored by `scripts/apply-patches.sh`,
which only reads `*.patch`.
