#may not need this,  but put here for reference
def parse(grammar,s,substr=''):
  print "input s: %s, substr: %s" % (s,substr)
  x=[]
  str=''
  state=''
  # look for multiple state matches so we only use the last one   state.scanString("")
  if substr != '':
    g=grammar.copy().setParseAction( replaceWith(complicated_string)) + SkipTo(LineEnd()).setResultsName('rest')
    g.setParseAction(lambda toks: "".join(toks))
    g.setDebug(True)
    res=g.parseString(s)
    print "res is %s" % res
    str=' '.join(res)
    print "rest is %s" % res.rest
  else:
    for tokens,start,end in grammar.scanString(s):
      x.append([tokens, start, end])
      #print "x is %s" % x
    if len(x) > 1:
      print "s is %s" % s
      tok,start,end=x.pop()
      state = parse(grammar,s[start:end])
      #str=s[0:start]+parse(grammar,s[start:end])+s[end:]
      str=s[0:start]+complicated_string+s[end:]
    else:
      str=" ".join(x.pop()[0])
  print "returning: [%s,%s]" % (str,state)
  return str

#print "got %s" % parse(state, "Kansas City, Kan. 12345-1234")
#print "got %s" % parse(state, "Kansas City, Kan.")
#print "got %s" % parse(state, "Kansas City, 12345")
