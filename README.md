# Understanding value categories in C++

## Abstract

In C++ today, do you know what an xvalue is?
Or a prvalue?
Why would you want to know?
Because it matters!
In C++, each expression is characterized by a value category.
These value categories are used to describe parts of the C++ standard, and are often used in books and articles.
You might have heard of terms like 'lvalue' or 'rvalue', which are the most commonly known ones.
Over the years, changes to the C++ language changed the meaning of value categories.
This means a lot of information about value categories is outdated or just plain wrong.
In this talk, I will explain what expression value categories are in today's C++ standard.
It turns out that knowledge about value categories can really be beneficial.
Not only will it enrich your understanding of C++ in general, it will deepen your understanding of mechanisms like move semantics.
Also, it can help you to make better choices about code.
These choices can then leverage language rules to enable compilers to generate efficient code without redundant copies.
Other, related topics that will be covered: copy elision, return value optimization, temporary materialization.

## Speaker bio

Ever since the first time Kris got in touch with his dad's 1983 ZX Spectrum, he was captivated by the wonderful world of computer programming.
In 1995, he learned to program 'Pacman' in x86 assembly, which was soon followed by learning C and then C++, which came to be his bread and butter.
He is very serious about code quality and is interested in 'modern' C++, Linux, JavaScript, Rust, software architecture and performance optimization.
He currently works as lead developer / team lead at ViNotion in Eindhoven.
If he is not working or doing dad-/husband-related things, he is probably playing the guitar or running (often long distances) out in the woods.
Kris studied mechatronics at FH Niederrhein, Krefeld, and electrical engineering at the TU/e.
He can be contacted at krisvanrens@gmail.com

## Tags

`software design`
`c++`
`expressions`
`value categories`
`copy elision`
`return value optimization`
`rvo`
`unnamed return value optimization`
`urvo`
`named return value optimization`
`nrvo`
`temporary materialization`
`implicit conversions`
`implicit move`
`return slot`
`calling conventions`
`ABI`
