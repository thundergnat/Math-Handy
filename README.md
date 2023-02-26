[![Actions Status](https://github.com/thundergnat/Math-Handy/actions/workflows/test.yml/badge.svg)](https://github.com/thundergnat/Math-Handy/actions)

NAME
====

Math::Handy - Handy math routines and operators that aren't in CORE Raku.

SYNOPSIS
========

```raku
use Math::Handy;

say 25!;  # 15511210043330985984000000

say Γ 1/2; # 1.7724538509055163

say binomial(9, 5); # 126

say Σ (^1e2).grep: &is-prime; # 1060

say Π (^1e2).grep: &is-prime; # 2305567963945518424753102147331756070

say 33 /% 5;  # (6 3)

say adr 16781; # (5 2)

say mdr 16781; # (0 4)

say 180°; # 3.141592653589793

say 200ᵍ; # 3.141592653589793
```

DESCRIPTION
===========

Math::Handy provides several handy functions and operators.

### Factorial operators

`factorial (Int)` - the product of the integers from one to $n. Also available as `postfix:<!> (Int)`.

Factorial is a discrete operation, only valid at integer values. For a continuous function, you want `gamma (Real $n)`.

`gamma (Real)` is a continuous factorial function. `Γ($n) =~= ($n - 1)!`. Also available as `Γ (Real $n)` (Greek uppercase gamma). Calculated using Lanczos approximation. (Only valid for positive arguments at this point.)

Also related to `factorial()` is `binomial()`.

`binomial(Int $n, Int $p)`, very commonly appears in combinatorics. Is equivalently expressed as: `n! / (p! × (n - p)!)`.

### Arithematic operators

Raku has the very convenient `sum` function. Traditional mathematics spells it `Σ`. This module provides a `Σ (*@list)` operator to remedy that.

Another common mathematical operator that Raku left out is `product()`. Raku has the `[*]` meta reduce operator, but that is difficult to chain with other operations. This module provides both a `product (*@list)` routine, and the more traditionally spelled: `Π (*@list)` (Greek uppercase pi)

Raku has `div`, Raku has `mod`, Raku has `polymod()`, but sometimes you may want a plain old `divmod()`. `divmod (Real, Real)` returns the whole divisions and the remainder. Also available as an binop `infix:</%> (Real, Real)`: `Real %/ Real`

### Digital roots

The `additive digital root` of an Integer in a particular base, is the recursive sum of the digits until only a single digit remains. The `persistance` is the number of times the function needs to recurse to reach a single digit.

Provides `digital-root (Int $n, :$base = 10)`. Calculates and returns the additive digital root and the persistance, by default in base 10. Pass in a named base (2 = 36) if a different base is desired. Also available as the abbreviated `adr (Int $n, :$base = 10)`

Similar to the additive `digital-root()` is the `multiplicative-digital-root()`. The `multiplicative-digital-root (Int $n, :$base = 10)` is the recursive product of the digits until only one digit remains. Returns the multiplicative digital root and the persistance. Also available as the abbreviated `mdr (Int $n, :$base = 10)`

### Radian conversions

Raku provides a multitude of trigonometric functions, but they all work with radian angle measurements by default. To make it easy to work with degrees (360° in 2π radians), or gradians (400ᵍ in 2π radians), provides two postfix conversion routines.

`postfix:<°> (Real $degrees)` converts degree measurments to radians.

`postfix:<ᵍ> (Real $gradians)` converts gradian measurments to radians.

AUTHOR
======

Most of these were code snippets I or someone else wrote as helper functions for solving RosettaCode tasks.

If there is a routine you think should be added, or if I bungled one of the existing, please let me know.

Stephen Schulze (aka thundergnat <thundergnat@comcast.net>)

COPYRIGHT AND LICENSE
=====================

Copyright 2023 thundergnat

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

