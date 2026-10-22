# patches

Patch files (`*.patch`) in this directory are applied to the upstream
OpenCode checkout, in filename order, before building. See the main
README for how to create one.

The series is currently empty on purpose: patching is on hold, and the
pipeline releases unmodified upstream rebuilds until a patch is added.
This file is not a patch and is ignored by `scripts/apply-patches.sh`,
which only reads `*.patch`.
