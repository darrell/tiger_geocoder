import sys
from pyparsing import *
#import address_helpers

complicated_string='XyZzY'
original_state=''
def flatten(l, ltypes=(list, tuple)):
    ltype = type(l)
    l = list(l)
    i = 0
    while i < len(l):
        while isinstance(l[i], ltypes):
            if not l[i]:
                l.pop(i)
                i -= 1
                break
            else:
                l[i:i + 1] = l[i]
        i += 1
    return ltype(l)
  
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

def getPlaces():
  places=[]
  with open("places.txt") as pl:
    for line in pl:
      places.append(CaselessLiteral(line.strip()))
  return Or(places).setResultsName('place')


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
        print "TOKENS are:" #"%s" % result.asDict()
        print result.dump()
          
        #else:
          #print "***WRONG***, expected %s for %s" % (key,value)
    else:
      res = result[0]
      print "'%s' -> %s" % (s, res),
      if res == expected:
        print "CORRECT"
      else:
        print "***WRONG***, expected %s" % result.asList
    if expected=={}:
      print result.dump()
  print "-----------"

  
# Zipcodes
zipsep = oneOf( "+ -").setParseAction( replaceWith('-') )
zip5 = Word(nums, exact=5).setResultsName('zip5')
zip4 = Combine(Optional(zipsep,'-') + Word(nums, exact=4))+LineEnd()
zip4.setResultsName('zip4')
#zip4.setDebug( True )
zipcode = Combine(zip5.setResultsName('zip') +Optional(zip4.setResultsName('zip4'))).setParseAction(lambda toks: "".join(toks[0])).setResultsName('zipcode')
#zipcode = Regex('\d{5}[-+]{0,1}\d{4}').setResultsName('zipcode')

# States
state=getStates()


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
test(location,'Ore., 97212',{'state': 'OR', 'zipcode': '97212'})
test(location,'Ore., 97212-1234',{'state': 'OR', 'zipcode': '97212-1234'})
test(location, "Portland, Oregon", {'place': 'Portland', 'state': 'OR'})
test(location, "Portland, Ore. 97212-1234",{'place': 'Portland','state': 'OR', 'zipcode': '97212-1234'})
test(location, "Oregon City, KS 12345-1234",{'place': 'Oregon City','state': 'KS', 'zipcode': '12345-1234'})
test(location, "Oregon City, 12345-1234",{'place': 'Oregon City', 'zipcode': '12345-1234'})
#address.setDebug(True)
test(location, "Oregon City, KS 12345-1234", {'place': 'Oregon City','state': 'KS', 'zipcode': '12345-1234'})
test(location, "Oregon City, 12345-1234", {'place': 'Oregon City', 'zipcode': '12345-1234'})
test(location, "Oregon City, Oregon, 12345-1234", {'place': 'Oregon City', 'zipcode': '12345-1234'})
test(location, "Oregon, 12345-1234", {'state': 'OR', 'zipcode': '12345-1234'})
test(address, "123 Main St.", {'housenumber': '123', 'streetname':'Main', 'suftype': 'St'})
test(street, "21St St.", {'suftype': 'St','streetname': '21st'})
test(street, "Pale Horse Ave",{'streetname': 'Pale Horse', 'suftype': 'Ave'})
test(street, "SE Pale Horse Ave",{'streetname': 'Pale Horse', 'suftype': 'Ave', 'predir': 'SE'})
test(street, "SE 21St Ave.", {'predir': 'SE','suftype': 'Ave','streetname': '21st'})
test(street, "SE 21St St.", {'predir': 'SE','suftype': 'St','streetname': '21st'})
test(intersection, "NE Foo Rd and 21ST Ave", {'intersectionA': 'NE Foo Rd', 'intersectionB': '21st Ave'})
test(address, "123 SE 21St St.", {'housenumber': '123', 'predir': 'SE','streetname': '21st', 'suftype': 'St'})
test(location, "123 Main St, Portland, Oregon, 97212",{'place': 'Portland', 'state': 'OR', 'zipcode': '12345-1234'})
