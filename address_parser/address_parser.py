import sys
from pyparsing import *
#import address_helpers

complicated_string='XyZzY'
original_state=''
def getStates():
  def makeState(s,arr):
    ret=[]
    for w in arr:
      x=CaselessLiteral(w).setParseAction(replaceWith(s))
      ret.append(x)
    return Or(ret)

  states={}
  with open("states.txt") as st:
    for line in st:
      line=line.strip()
      try:
        fips,fullname,usps,alt1,alt2=line.split("\t")
      except ValueError:
        continue
    
      states[usps]=makeState(usps,[fullname,usps,alt1,alt2] )

  #bogus=Literal(complicated_string).setParseAction(replaceWith(original_state))
#  st=Or(states.values())
  return Or(states.values()).setResultsName('state')

def test(p,s,expected):
  failed=False
  try:
      result = p.parseString(s)
  except ParseException, pe:
      print "Parsing failed:"
      print s
      print "%s^" % (' '*(pe.col-1))
      print pe.msg
  else:
    if {}.__class__ == expected.__class__:
      print "'%s' -> '%s'" % (s,expected)
      for k, v in expected.iteritems():
        if result.get(k) == v:
          print "   '%s' -> '%s' CORRECT" % (k,v)
        else:
          failed=True
          print "   '%s' -> '%s' ***WRONG***  expected '%s'" % (k,result.get(k),v)
      if failed:
        print "   TOKENS are %s" % result.asDict()
        #print result.asList
          
        #else:
          #print "***WRONG***, expected %s for %s" % (key,value)
    else:
      res = result[0]
      print "'%s' -> %s" % (s, res),
      if res == expected:
        print "CORRECT"
      else:
        print "***WRONG***, expected %s" % result.asList

  
# Zipcodes
zipsep = oneOf( "+ -").setParseAction( replaceWith('-') )
zip5 = Word(nums, exact=5).setResultsName('zip5')
zip4 = Combine(Optional(zipsep,'-') + Word(nums, exact=4))+LineEnd()
zip4.setResultsName('zip4')
#zip4.setDebug( True )
zipcode = Combine(zip5.setResultsName('zip') +Optional(zip4.setResultsName('zip4'))).setParseAction(lambda toks: "x".join(toks[0])).setResultsName('zipcode')
#zipcode = Regex('\d{5}[-+]{0,1}\d{4}').setResultsName('zipcode')

# States
state=getStates()

# Streets
addrSep=ZeroOrMore(White())+ZeroOrMore(Literal(','))+ZeroOrMore(White()).suppress()

#Places
place= Combine(OneOrMore(Word(alphas+'.')+Optional(White()))).setResultsName('place')
#place.setDebug(True)
# Whole Address
address= Optional(place) + Optional(addrSep) + Optional(state) + Optional(addrSep).suppress() + Optional(zipcode)


test(zipsep, '+', '-')
test(zip4, '-1234', '-1234')
test(zipcode,'97214', '97214')
test(zipcode,'97214-1234','97214-1234')
test(zipcode,'97214+123','97214')
test(zipcode,'97214+1234','97214-1234')
test(zipcode,'972141234', '97214-1234')
test(zipcode,'97214-','97214')
test(state,'Oregon', 'OR')
test(state,'Ore., 97212-1234','OR')
test(address,'Ore., 97212',{'state': 'OR', 'zipcode': '97212'})
test(address,'Ore., 97212-1234',{'state': 'OR', 'zipcode': '97212-1234'})
test(address, "Portland, Oregon", {'place': 'Portland', 'state': 'OR'})
test(address, "Portland, Ore. 97212-1234",{'place': 'Portland','state': 'OR', 'zipcode': '97212-1234'})
test(address, "Foo City, KS 12345-1234",{'place': 'Foo City','state': 'KS', 'zipcode': '12345-1234'})
test(address, "Foo City, 12345-1234",{'place': 'Foo City', 'zipcode': '12345-1234'})
#address.setDebug(True)
test(address, "Oregon City, KS 12345-1234", {'place': 'Oregon City','state': 'KS', 'zipcode': '12345-1234'})
test(address, "Oregon City, 12345-1234", {'place': 'Oregon City', 'zipcode': '12345-1234'})
test(address, "Oregon City, Oregon, 12345-1234", {'place': 'Oregon City', 'zipcode': '12345-1234'})
test(address, "Oregon, 12345-1234", {'state': 'OR', 'zipcode': '12345-1234'})
