#import "../../../template.typ": *
#import "@preview/lovelace:0.3.0": *

#show: project.with(
  theme: "project",
  course: "Fundamentals of Data Structures",
  title: "Projects 1: ???",
  date: "2024/03/14",
  author: "memset0",
  semester: "2023-2024 Spring & Summer",
)

= *Chapter 1*: Introduction

Problem description and (if any) background of the algorithms.

= *Chapter 2*: Algorithm Specification

Description (pseudo-code preferred) of all the algorithms involved for solving the problem, including specifications of main data structures.

== Step One

#lorem(20)

== Step Two

#lorem(30)

== Step Three // Auto-numbering is supported

#lorem(50)

= *Chapter 3*: Testing Results

Table of test cases. Each test case usually consists of a brief description of the purpose of this case, the expected result, the actual behavior of your program, the possible cause of a bug if your program does not function as expected, and the current status ("pass", or
"corrected", or "pending").

#table(
  columns: (1fr, 1fr),
  align: top,
  inset: 10pt,
  [Sample Input], [Sample Output],
  [
    #raw(read("../code/sample.in"), block: true)
  ],
  [
    #raw(read("../code/sample.out"), block: true)
  ],
)

= *Chapter 4*: Analysis and Comments

Analysis of the time and space complexities of the algorithms. Comments on further possible improvements.

// pseudocode demo, require `lovelace` package
#pseudocode-list[
  + do something
  + *while* still something to do
    + do even more
    + *if* not done yet *then*
      + wait a bit
      + resume working
    + *else*
      + go home
    + *end*
  + *end*
]

= *Appendix*: Source Code (in C)

At least 30% of the lines must be commented. Otherwise the code will NOT be evaluated.

#codex(read("../code/sol.c"), filename: [*File*: sol.c], lang: "c")
// use `importCode` function to read code from a file

= *Declaration*

I hereby declare that all the work done in this project titled "XXX" is of my independent effort.

Please keep in mind that these are the "minimum" requirements. Other requirements will be specified according to each project assignment.
