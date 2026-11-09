#!/usr/bin/env python

""" Compile one Haskell source into an executable, reproducing the Makefile's
`ghc -v0 -o <output> <input>`. Invoked by the generator as
ghc_build.py <input.hs> <output.elf>. The .hi/.o intermediates go to a
private temporary directory: they are not outputs, ghc names them after the
module (every demo is `Main`, so demos built in parallel would overwrite
each other's), and the build sandbox refuses undeclared files. """

import os
import subprocess
import sys
import tempfile


def main():
    """ main entry point """
    source, output = sys.argv[1], sys.argv[2]
    outdir = os.path.dirname(output)
    os.makedirs(outdir, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="ghc_build.") as scratch:
        sys.exit(subprocess.call(
            ["ghc", "-v0", "-outputdir", scratch, "-o", output, source]))


if __name__ == "__main__":
    main()
