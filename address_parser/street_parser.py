# from http://pyparsing.wikispaces.com/file/view/streetAddressParser.py
from pyparsing import *

# number can be any of the forms 123, 21B, or 23 1/2
number = ( Combine(Word(nums) + 
                   Optional(oneOf(list(alphas))+FollowedBy(White()))) + \
            Optional(Optional("-") + "1/2")
         ).setParseAction(keepOriginalText, lambda t:t[0].strip())
numberSuffix = oneOf("st th nd")

# just a basic word of alpha characters, Maple, Main, etc.
name = ~numberSuffix + Word(alphas)

# types of streets - extend as desired
type_ = Combine( oneOf("Street St Boulevard Blvd Lane Ln Road Rd Avenue Ave "
                        "Circle Cir Cove Cv Drive Dr Parkway Pkwy Court Ct",
                        caseless=True) + Optional(".").suppress())

# street name 
streetName = (Combine( Optional(oneOf("N S E W")) + number + 
                        Optional("1/2") + 
                        Optional(numberSuffix), joinString=" ", adjacent=False ) 
                | Combine(OneOrMore(~type_ + name), joinString=" ",adjacent=False) )

# basic street address
streetReference = streetName.setResultsName("name") + Optional(type_).setResultsName("type")
direct = number.setResultsName("number") + streetReference
intersection = ( streetReference.setResultsName("crossStreet") + 
                 Keyword("and",caseless=True) +
                 streetReference.setResultsName("street") )
streetAddress = ( direct.setResultsName("street") | 
                  intersection |
                  streetReference.setResultsName("street") )

tests = """\
    100 South Street
    123 Main
    221B Baker Street
    10 Downing St
    1600 Pennsylvania Ave
    33 1/2 W 42nd St.
    454 N 38 1/2
    21A Deer Run Drive
    256K Memory Lane
    12-1/2 Lincoln
    23N W Loop South
    23 N W Loop South
    25 Main St
    2500 14th St
    12 Bennet Pkwy
    Pearl St
    Bennet Rd and Main St
    19th St
    """.split("\n")
from operator import attrgetter
for t in map(str.strip,tests):
    if t:
        addr = streetAddress.parseString(t)
        print t
        print addr.dump()
        print "Street is", addr.street.name, addr.street.type
        print
