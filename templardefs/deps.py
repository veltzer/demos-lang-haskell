'''
dependencies for this project
'''

def populate(d):
    d.packs=[
        'ghc',
    ]

def getdeps():
    return [
        __file__, # myself
    ]
