import glob

d = {}
def parse(files):
  for f in files:
    with open(f, 'r') as fs:
        for l in fs:
          #print l
          p = l.split(":")
          n = p[0]
          val = p[1].strip()
          valname = val.split("-")
          #print n, val
          #print valname[0].strip().split()[0]
          key = n + '_' + '_'.join(valname[1].strip().split())
          #print key
          d[key] = 0 # to initialize each key to zero
          #return
  for f in files:
    with open(f, 'r') as fs:
        for l in fs:
          p = l.split(":")
          n = p[0]
          val = p[1].strip()
          valname = val.split("-")
          #print n, val
          ins_val = valname[0].strip().split()[0]
          key = n + '_' + '_'.join(valname[1].strip().split())
          #print n, val[0]
          d[key] += int(ins_val)

          

# pass the list of insts.csv files to be parsed.
files = glob.glob("gvn_hoist*")
parse(files)
print d
files = glob.glob("base_reganal*")
parse(files)
print d
