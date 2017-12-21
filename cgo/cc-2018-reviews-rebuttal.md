
Dear Aditya Kumar,

Thank you again for your submission to CC 2018. You are now
given an opportunity to respond to the comments made to your submission.
The author response period is 20 -- 21 December, 2017 (midnight, AOE).

During this time, you will have access to the reviews for your paper.

Please note that every paper received at least three reviews and
these reviews are completed by its assigned PC members, without any
coordination between them. Thus, there may be inconsistencies.
Reviews and scores are likely going to be updated, to take into account
the discussion among the reviewers and your rebuttal. So please do not
assume that a paper with all positive reviews will necessarily get accepted
or a paper with all negative reviews will necessarily get rejected.

You have 800 words for your rebuttal. The author response is not
compulsory. However, if you feel that your paper may get accepted,
I strongly encourage you to use this opportunity to answer the reviewers'
questions.  You may also use the space to focus on any factual errors
in the reviews. Please try to be as concise and to the point as possible
and please do not provide new research results or reformulate the
presentation.

Please also try to be polite and constructive. Please be very careful not
to reveal your identity in your response. If your response breaks the
double-blind reviewing policy, then your paper may be rejected outright.

The program committee will read your response carefully and take this
information into account during the PC discussions.

The reviews on your paper are attached to this email.

Best wishes,


       Title: A fast algorithm for global code motion of congruent
              instructions
  Paper site: https://cc18.hotcrp.com/paper/66

Use the link below to sign in to the site.

https://cc18.hotcrp.com/?email=hiraditya%40gmail.com

--- Jingling
Program Chair for CC 2018

Review #66A
===========================================================================

Overall merit
-------------
3. Weak accept

Paper summary
-------------
This work describes the design and implementation of a global code-motion optimization pass in LLVM. It provides a detailed overview of the algorithm, analyses it relies on, data-structures used, and cost-model considerations. Evaluation of several different metrics are presented on the Spec2006 benchmark suite, and clear reduction in number of spills is shown, with some other effects on inlining and LICM, while incurring no increase in compilation time.

Strengths:
        - Provides a practical report on an actual implementation in an industry-strength compiler. The work is also (in the process of being) contributed to open-source.

        - The paper is well written. In particular I thought the motivation (benefits of GCM) is set up very clearly and convincingly, prior-art is discussed in detail, the data-structures are presented clearly, and the overall algorithm is easy to follow with the pseudo-code provided.

        - Experimental results on the entire SPEC2006 benchmark suite are presented, and several metrics are examined (code size, compile time, runtime) including an account of individual effects on number of spills, number of instructions hoisted/sunk, and effects on LICM and inlining.


Weaknesses:
        - Overall the experimental results are not entirely conclusive. There is a clear 2% improvement in number of spills (Table 3), but otherwise the bottom line picture is not very clear (e.g. as reflected in Tables 1,2).

        - Performance is shown only with inliner and loop-unroller disabled. It's ok that results are shown in a setup that leaves out some effects that make it difficult to isolate the "pure" impact of GCM, but results on a more realistic setup are still also relevant to get an idea about.
(I understand though the difficulty to draw conclusions and make an informed analysis with various compilation passes being affected in various ways, and I appreciate the effort to compensate for that with the different metrics that Section 5 explores.)

        - I would have liked to see more analysis of the experimental results, and more discussion of the tradeoffs of various decisions in the implementation at hand (some examples below).

Comments for author
-------------------
- I would have liked to see more analysis of the experimental results:
        ○ Regarding Table 1: Can anything be said about the benchmarks with the larger impact? Were the effects scattered all over these benchmarks or occurred in a few hotspots? Can you say something on what was the primary factor for the performance effect (e.g. from the benefits mentioned in the introduction: reduced register pressure / increased ILP / reduced branch mis-peculation penalty? Were there any effects on vectorization?). Also, how significant are the absolute code-size effects?
        ○ Regarding Table2: can you say anything about the situations where GCM resulted in less inlining/less instructions deleted? About the LICM effects: were the LICM improvements indeed due to conditional code simplified by GCM?
        ○ Regarding Table 3: Can anything be said about the cases that exhibited significant register-spill increase? Can anything be done to further reduce it? How would the picture look like if the more aggressive GCM was used (that is, with the compiler flag that makes it not  consider register pressure)?
        ○ Regarding Figure 4: Can you tell how many of these hoists would have happened anyhow, without GCM in the picture?
        ○ Regarding Table 4: How does the compile-time increase look like in terms of actual compilation time?

- Other comments on the experimental section:
        ○ What was the effect on the memory footprint of the compiler? (how much extra storage was required)?
        ○ Is it possible to show the impact on other platforms? (what would be the benefit on a platform that is less sensitive to register pressure?)
        ○ Is it possible to compare some of the metrics to GCC's GCM implementation? Can anything be learned from that on the tradeoffs between the heuristics the two implementations use?
        ○ No overall (average) impact is indicated over all the benchmarks (except for Table 3).

- Were any other heuristics considered along the way? For example, how about giving hoisting preference to higher-latency instructions?

- You mention that scheduling GCM so early in the compilation pass had significant implications. Did you consider scheduling the pass at a different (later) place in the compiler?



Typos:

Page4: trackig -> tracking
Page5: PHIc1, c2) -> PHI(c1, c2)
Page6: explains how GCM of can reduce -> remove 'of'?
Page6: allocation of calls expressions -> call expressions
Page6: for each x-nodes in the CFG -> node


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Review #66B
===========================================================================

Overall merit
-------------
3. Weak accept

Paper summary
-------------
The paper "A fast algorithm for global code motion of congruent instructions"
extends global code motion with a register-aware cost model.
The primary trick seems to be to consider the life times of values (virtual registers)
as a surrogate for (hardware) register pressure.
The heuristic is to hoist or sink instructions
if more life times are shortened than extended by a motion.
The approach was implemented into LLVM and evaluated with SPEC 2006.

The work is well motivated from practical and theoretic angles
due to bug reports and related work.
The idea is nicely presented and the steps of the algorithm are described in sufficient detail.
Related work and the evaluation can be improved.

Comments for author
-------------------
The novelty of the core idea is not clear to me.
For example, "A lifetime optimal algorithm for speculative PRE"
by Jingling Xue and Qiong Cai seem to have a similar idea,
although for the related optimization PRE.
Also, Knoop and Steffen have multiple publications on code motion,
but none is discussed or even cited.

The evaluation could be improved with more rigorous setup and statistics.
The hardware should be described in more detail than "x86_64-linux machine".
At least the CPU should be described like "Intel i7-3770".
For execution time statistics at least deviations should be considered.
If deviations are practically zero that fact should be mentioned and all is well.
If they are closer to the performance changes
that must be honestly reported as well.
One step further,
testing the significance of the changes might be worthwhile (e.g. Student's T-test).
An improvement like libquantum's 8% is probably significant,
and povray's 0.05% is probably just noise,
but what about hmmer's 0.93%?
Unfortunately, this requires more extensive benchmarking than "run three times".

Overall, the paper is a nice contribution and publication worthy.
While related work and evaluation can be improved,
I believe the algorithm to be new
and the evalation demonstrating real improvements.


Insignificant nitpicking:

Line 575 mentions "reduced performance regressions with this cost model",
but I cannot find which regressions this refers to?

Line 733 seems to have a superfluous "ref".

The code examples are missing ":" at a few loops

Figure 4 should not use a line as the elements on the x-axis are independent.
A table might be sufficient?


* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Review #66C
===========================================================================

Overall merit
-------------
1. Reject

Paper summary
-------------
This manuscript intent is to describe the author's implementation of
global code motion (GCM) in LLVM with what they claim to be a new
technique to take register pressure into consideration.

Comments for author
-------------------

While this manuscript is ok as an experience report in LLVM, the style
in which it is written makes it a very poor contribution to the
literature of code optimization. The contribution is described as a
mashing up of important existing techniques but with no concern to
explaining them at any level or even to provide definitions for the
most important concepts in the paper. Here are some specific examples:

- the concepts of "congruent values" or "congruent expressions" or
  "congruent instructions" are never defined.
- The concept of a Barrier is never precisely defined. What does it
  mean for an instruction to "not guarantee progress"? (section 3.2)
 - What does it mean for a value to have "multiple occurrences in a
  function"? (end of section 3.1). Is it multiple uses? multiple
  definitions? Does an use inside a loop counts as multiple uses?
 - What is a "landing pad" (section 3.3)?
- Precision: "no use of the instruction" (section 3.3). Instructions
  are not used. The value computed by an instruction is used.
 - "Anticipable" (last parag. of Section 3.3) is not defined.
 - The key insight in the whole manuscript appears split between the
  last lines of page 5 and first lines of page 6 --- it is the idea of
  examining opearnd that are killed by the instructions that will be
  hoisted. This insight should be more prominent in the manuscript.
  - there is an inconsistency between the text before and after the
  code on the left column of page 6: "as long as there is one operant
  killed at most" and "when the use opearnds are not kills"?
  - how is the ranking of a code hoisting opportunity defined? (end of
  page 6)
  - I do not now what is a "dependency of a hoistable candidate" is it
  an instruction that generates a value that is used by the hoistable
  candidate? Or is it an instruction that uses a value that is defined
  by the hoistable candidate? This type of imprecision in the text
  makes it very difficult for other to understand or try to reproduce
  the technique described int the manuscript.

Experimental Evaluation:

- In the experimental evaluation, what is the rational to report the
  best result of three runs? What was the methodology used to execute
  the experiments? Was the order of execution of the experiments
  randomized or were they executed in some fix order?

- The machine used for the experiments is described as "an
  x86_64-linux" machine? The experimental machine must be described in
  more detail. Does this processor has CPU frequency scaling
  (https://wiki.archlinux.org/index.php/CPU_frequency_scaling and
  https://www.kernel.org/doc/html/v4.13/admin-guide/pm/cpufreq.html)?
  If it does and this feature was not turned off, all the reported
  results may have been severely influenced by this feature.

- It does not seem to make sense to report the result only with loop
  unrolling and inlining disabled in Table 1. If these code transformations
  interfere with the GCM optimization, there is even more reason to
  report the performance results with and without these code
  transformations.

- The loop unrolling algorithm was disabled in both versions of LLVM
   (with new GMC optimization and without) because the results "vary
   wildly with GCM optimization". If the implementation is producing
   unpredictable results when a common optimization is applied to the
   code, then these results should be investigated carefully to
   determine what is causing these variations. Moreover, it would be
   valuable to compare with the performance of the unmodifed LLVM
   compiler.

- The manuscript claims that there is an increase in code size of the
   447.dealII benchmark and attribute this increase to "it becoming
   cheaper to do some optimizations like inlining, loop unrolling,
   copy...." but earlier it was stated that loop unrolling is disabled.
   It is not clear if the code was compiled with loop
   unrolling enabled to evaluate the code size variations.

- It is very strange that the impact on compilation in Table 4 is
  reported as changes in number of instructions executed during
  compilation. Anyone using the LLVM compiler will be most interested
  in the compilation time measured in seconds.

- Figure 4 does not make much sense. Why is this a line graph? A line
  graph should be use when there is an order between the points in the
  horizontal axis. In this case there is no order. Also, the vertical
  axis of the plot have no label or unit. Also, how is the
  "GrandTotal" computed for each of the metrics shown in that plot?


Editorial issues:

Large algorithms without labels in sections 3.1, 3.2, 3.3, 3.4.1,
4. Ideally algorithms should be typeset as figures with captions so
that the text can refer to them (LaTeX provides several packages for
typesetting algorithms). Also, most of the algorithms do not provide
a clear description of what input each algorithm expects and what
output it generates.

Line 314: following with the names within parenthesis is an unusual
sentence construction in English.

Line 531: "post-dominaing \phi to use"...

Line 554: "how GCM of can reduce"

Line 587: "Due to this" This what?

Line 604: "structuers"

Line 702: "is linear in (the) number"

Line 723: Cpu -> CPU (also many other places)

Line 732: "compile time (as shown in) Table 4."

Rebuttal questions
------------------






Thank you for the rigorous review of the paper. 
General response:
- The CPU used was Intel(R) Xeon(R) CPU E5-2660 v2 with frequency scaling disabled and the benchmark was run with the standard reportable configuratino where 'test runs' were followed by 'ref runs'.
- Some benchmarks regressed w.r.t. code size even if loop unrolling and inlining was disabled because other optimizations became cheaper like versioning of code, vectorization, copy-propagation, if-conversion etc. Some scheduling and register allocation decisions in the compiler backend could also change because of GCM.
- Because many optimizations in LLVM are still not mature for example: constant propagation may increase register pressure, but instead of computing the affect on register pressure, the optimization algorithm may use a heuristic to propagate values only so far (say next basic block only). Similarly for if-conversion, loop unrolling, inliner etc. have approaches based on separate cost-models. That would limit some useful gains which our algorithm could have shown.
- The compilation time was reported in terms of valgrind instructions because it was deterministic. We could report the number with other benchmarks but because we were sticking to SPEC we did not want to explore the details of its build configuration.
- Figure 4 is mostly to show the relative comparison of different kinds of instructions scheduled.

Following are the responses to specific questions:

@Reviewer1:
- Theoretically GCM would improve vectorization but we haven't explored a case in those benchmarks. For example, consider a loop:

for (int i = 0; i < N; i++) {
  if (p) a = b+c;
  else e = b+c;
  //...
}

The conditional within a loop may prevent vectorization. PRE may not remove this because there is no partial redundancy.  Loop Invariant Motion cannot remove this because none of the computations of 'b+c' dominate the overall execution of the loop.
GCM would hoist 'b+c' and then the if-else can be converted to a csel (conditional select) thus enabling vectorization. In some cases the conditional can be completely removed because of GCM.

- The GCM does not have access to profile information so the scheduling is oblivious to hotspots. We have not investigated which code-motion caused a specific benchmark to improve.

- GCC's GCM is implemented in the backend (RTL) level so any such comparison will be imprecise. The algorithms used there is quite different because of level of abstractions both are dealing with. Our cost-model is geared towards reducing code-size and reducing register pressure while GCC's cost-model is classical, improving ILP with minimal impact to register pressure.

-Table2:
Because inliner (in LLVM) relies on instruction counts, some functions can get chance to be inlined thereby preventing subsequent inlining. e.g. consider a callgraph with inlinecost for each A(100)->B(20)->[C(125), D(90)] and if the inliner inlines functions with a maximum cost of 120. Without GCM, D will get inlined in B, and then B will still get inlined in A. With GCM, if C reduced in code size and its cost became, say 110, only C will get inlined in B preventing the inlining of B.

@Reviewer2:
The algorithm relies on SSA so early references to code-motion in dataflow model cannot exploit the kind of abstraction we have explained in the paper. There are plenty of papers related to GCM but none in SSA and realizing that code-hoisting or code-sinking can be performed with an algorithm similar to PHI-insertion. Also, the cost model to compute the difference in liveness (before and after GCM) is novel. The paper by Jingling Xue et al. is based on bit-vectors and is computationally an order of magnitude worse in terms of time and no better than us in space.

@Reviewer3:
- We should have defined those terms, I apologize.
- Multiple occurrence in a function referred to multiple expressions with same value number.
- Congruency is with respect to global values as mentioned in [Briggs 1997].
- When an instruction does not guarantee progress, that means that instruction may cause an exception and subsequent instructions are not guaranteed to execute. With limited information available statically, call instructions which may not return, some memory operations etc. are assumed to not guarantee progress.
- The place where an invocation continues after exception (https://llvm.org/docs/ExceptionHandling.html) is called landing pad. In simple terms, it is a basic block which is the target of an indirect branch.
- There is no inconsistency, the first argument discusses when there is at least one use which is a kill, then sinking will not increase the register pressure. The second argument says, if none of the use operands are kills then register pressure may reduce (for example: a<def> = b+c, and b, c are not killed here then sinking this will reduce the live-range of a).
- Ranking is defined in page 2 second column.
- Dependency of hoistable candidate: instructions defining the operands used by a hoistable instruction.
