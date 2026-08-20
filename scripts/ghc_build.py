#!/usr/bin/env python

""" Compile one Haskell source into an executable, reproducing the Makefile's
`ghc -v0 -o <output> <input>`. Invoked by the generator as
ghc_build.py <input.hs> <output.elf>. The .hi/.o intermediates go to a build
dir alongside the output so they do not litter the source tree. """

import os
import subprocess
import sys


def main():
    """ main entry point """
    source, output = sys.argv[1], sys.argv[2]
    outdir = os.path.dirname(output)
    os.makedirs(outdir, exist_ok=True)
    sys.exit(subprocess.call(
        ["ghc", "-v0", "-outputdir", outdir, "-o", output, source]))


if __name__ == "__main__":
    main()
