# JuliaForScientists

An interactive, introductory course to the Julia language for
scientists. Material for the PhD course at [IFIC
(CSIC/UV)](https://indico.ific.uv.es/event/6550/)

## Prerequisites

The course is though for students that have some experience in
scientific/numerical computing, but no prior experience with the Julia
language. Students should have coded previously in other languages
(python, C, Fortran, ...).

We expect you to know:
- What a data type is: `float`, `int`, `strings`, `bool`/`logical`,
  etc... The basic concept of custom/derived types
- The basics of programming: iterations (loops), and conditionals
  (if-then-else). 
- The basic concept of function/subroutine. Modularity of a code.

On the other hand we do not expect you to have experience in OO
languages, or previous experience in Julia.

### Requirements

In short: **before** the first lecture you **should** install:
- Julia v1.7
- A text editor (i.e VScode)
- The course repository [JuliaForScientists](https://github.com/andLaing/JuliaForScientists.git). 

Now the longer explanation:

All students should come to the course with a working environment of
Julia v1.7. Installing Julia is quite easy, and consists basically of
using the [correct file for your operating
system](https://julialang.org/downloads/). Julia can be used with your
favorite text editor, although in the course we will try to use
VScode. Some basic detailed instructions can be found in many on-line
tutorials, [for example, this
one](https://techytok.com/julia-vscode/). To fully profit from the
course, the student **should** make an effort to consult this material
before the first class.

We also recommend that you download the course repository from
github (https://github.com/andLaing/JuliaForScientists.git) and check
that it works properly by activating its environment and running the
tests:
__from the commandline__
```console
<your terminal> julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.1 (2021-12-22)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>]
(@v1.7) pkg> activate .
  Activating project at `~/julia_course/test/JuliaForScientists`

(JuliaForScientists) pkg> instantiate
...
(JuliaForScientists) pkg> test
```


We will use [Pluto](https://github.com/fonsp/Pluto.jl) notebooks in
class. This will be covered in the first session, but if you get some
experience with it, that would of course be great. This short
[video](https://www.youtube.com/watch?v=OOjKEgbt8AI) is nice, and
there are many more on-line tools available.