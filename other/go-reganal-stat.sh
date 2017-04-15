#!/bin/bash -xe
files='gvn_hoist_reganal
base_reganal'

for f in $files; do
  grep 'regalloc.*spills inserted' `find . -name $f` -a > $f.spills;
  grep 'inline.*Number of functions inlined' `find . -name $f` -a > $f.inlinecost;
  grep 'inline.*functions deleted because all callers found' `find . -name $f` -a > $f.f_deleted.inlinecost;
  grep 'licm.*Number of instructions hoisted out of loop' `find . -name $f` -a > $f.hoist.licm;
  grep 'licm.*Number of instructions sunk out of loop' `find . -name $f` -a > $f.sunk.licm;
done

grep 'gvn.hoist.*instructions hoisted' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.hoist.insn
grep 'gvn.hoist.*instructions removed' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.remov.insn
grep 'gvn.hoist.*loads hoisted' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.hoist.loads
grep 'gvn.hoist.*loads removed' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.remov.loads
grep 'gvn.hoist.*calls hoisted' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.hoist.calls
grep 'gvn.hoist.*instructions sunk' `find . -name gvn_hoist_reganal` -a > gvn_hoist_reganal.sink.insn
