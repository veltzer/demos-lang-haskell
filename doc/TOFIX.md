# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `scripts/ghc_build.py:16-19` - `-outputdir` is set to the output's own directory, so every demo's intermediates land in the shared `out/` as `out/Main.hi` / `out/Main.o` (confirmed in the current `out/`). Every standalone demo is module `Main`, so as soon as a second `.hs` exists, parallel generator runs overwrite each other's `Main.o`/`Main.hi` and can link the wrong object. The docstring (`:6`) promises "a build dir alongside the output". Use a per-source dir, e.g. `outdir = output + ".build"` for `-outputdir`, keeping `-o output`.
- `rsconstruct.toml:10,14` - `[processor.ruff]` and `[processor.mypy]` list `src_dirs = ["src", "scripts"]`, but `src/` holds only Haskell (`src/hello.hs`); the only Python is `scripts/ghc_build.py`. Make both `src_dirs = ["scripts"]` per the precise-src_dirs rule.
- `pyproject.toml:10` - `pytest` is declared in the dev group, but there is no `tests/` dir and no `[processor.pytest]`; drop it (or add a real test, e.g. one that runs `out/hello.elf` and checks its output).

## Low

- `README.md:1-4` - says nothing beyond the title: no build/run instructions (`rsconstruct build`, then `out/hello.elf`), no note that `ghc` must be installed (`rsconstruct.toml:31-34`).
- `doc/links.txt:1-2` - both links use `http://`; `learnyouahaskell.com` and `www.yesodweb.com` serve HTTPS - switch to `https://`.
- `config/project.lua` - not linted: no `[processor.luacheck]` with `src_dirs = ["config"]` and no fleet `.luacheckrc`, unlike the 109 fleet repos that have both.
