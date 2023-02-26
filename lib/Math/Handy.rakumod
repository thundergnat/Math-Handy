unit module Math::Handy;

# Factorial related

sub factorial (Int(Cool) $n) is export { (constant f = 1, |[\*] 1..*)[$n] }

sub postfix:<!> (Int(Cool) $n) is export { factorial $n }

sub gamma (Real \z where * > 0) is export {
    constant g = 9;
    z < .5 ?? π/ sin(π * z) / Γ(1 - z) !!
    sqrt(τ) *
    (z + g - 1/2)**(z - 1/2) *
    exp(-(z + g - 1/2)) *
    [+] <
        1.000000000000000174663
     5716.400188274341379136
   -14815.30426768413909044
    14291.49277657478554025
    -6348.160217641458813289
     1301.608286058321874105
     -108.1767053514369634679
        2.605696505611755827729
       -0.7423452510201416151527e-2
        0.5384136432509564062961e-7
       -0.4023533141268236372067e-8
    > Z* 1, |map 1/(z + *), 0..*
}

our &Γ is export = &gamma;

sub binomial (Int $n, Int $p) is export { Π ($n … 0) Z/ 1 .. $p }


# Arithematic operators

sub product (*@p) is export { [*] @p }

our &Π is export = &product;

our &Σ is export = &sum;

sub divmod (Real $n, Real $m) is export { my $div = ($n / $m).Int, $n % $m }

sub infix:</%> (Real $n, Real $m) is export { divmod $n, $m }


# Digital roots

sub digital-root ($r, :$base = 10) is export {
    my $root = $r.base($base);
    my $persistence = 0;
    while $root.chars > 1 {
        $root = $root.comb.map({:36($_)}).&Σ.base($base);
        $persistence++;
    }
    $root.Int, $persistence;
}

our &adr is export = &digital-root;

sub multiplicative-digital-root ($r, :$base = 10) is export {
    my $root = $r.base($base);
    my $persistence = 0;
    while $root.chars > 1 {
        $root = $root.comb.map({:36($_)}).&Π.base($base);
        $persistence++;
    }
    $root.Int, $persistence;
}

our &mdr is export = &multiplicative-digital-root;


# Radian conversions

sub postfix:<°> (\d) is export { d × τ / 360 }

sub postfix:<ᵍ> (\g) is export { g × τ / 400 }

=begin pod

=head1 NAME

Math::Handy - Handy math routines and operators that aren't in CORE Raku.

=head1 SYNOPSIS

=begin code :lang<raku>

use Math::Handy;

say 25!;  # 15511210043330985984000000

say Γ 1/2; # 1.7724538509055163

say Σ (^1e2).grep: &is-prime; # 1060

say Π (^1e2).grep: &is-prime; # 2305567963945518424753102147331756070

say 33 /% 5;  # (6 3)

say adr 16781; # (5 2)

say mdr 16781; # (0 4)

say 180°; # 3.141592653589793

say 200ᵍ; # 3.141592653589793

=end code

=head1 DESCRIPTION

Math::Handy provides several handy functions and operators.

=head3 Factorial operators

C<factorial (Int)> - the product of the integers from zero to $n. Also
available as C<postfix:<!> (Int)>.

Factorial is a discrete operation, only valid at integer values. For a continuous
function, you need C<gamma (Real $n)>.

C<gamma (Real)> is a continuous factorial function. C<Γ($n) =~=  ($n - 1)!>.
Also available as C<Γ (Real $n)> (Greek uppercase gamma). Calculated using
Lanczos approximation. (Only valid for positive arguments at this point.)

Also related to C<factorial()> is C<binomial()>.

C<binomial(Int $n, Int $p)> very commonly appears in combinatorics. Is equivalently
expressed as: C< n! / (p! × (n - p)!) >.


=head3 Arithematic operators

Raku has the very convenient C<sum> function. Tradional mathematics spells it
C<Σ>. This module provides a C<Σ (*@list)> operator to remedy that.


Another common mathematical operator that Raku neglected is C<product()>. It has
the C<[*]> meta reduce operator, but that is difficult to chain with other
operations. This module provides both a C<product (*@list)> routine, and the more
traditionally spelled: C<Π (*@list)> (Greek uppercase pi)


Raku has C<div>, Raku has C<mod>, Raku has C<polymod()>, but sometimes you may
want a plain old C<divmod()>.
C<divmod (Real, Real)> returns the whole divisions and the remainder. Also
available as an binop C<infix:</%> (Real, Real)>: C<Real %/ Real>



=head3 Digital roots

The C<additive digital root> of an Integer in a particular base, is the recursive sum
of the digits until only a single digit remains. The C<persistance> is the number
of times the function needs to recurse to reach a single digit.

Provides C<digital-root (Int $n, :$base = 10)>. Calculates and returns the
additive digital root and the persistance. Also available as the abbreviated
C<adr (Int $n, :$base = 10)>

Similar to the additive C<digital-root()> is the
C<multiplicative-digital-root()>. The C<multiplicative-digital-root (Int $n, :$base = 10)>
is the recursive product  of the digits until only one digit remains. Returns
the multiplicative digital root and the persistance. Also available as the
abbreviated  C<mdr (Int $n, :$base = 10)>



=head3 Radian conversions

Raku provides a multitude of trigonometric functions, but they all work with
radian angle measurements by default. To make it easy to work with degrees (360°
in 2π radians), or gradians (400ᵍ in 2π radians), provides two postfix conversion
routines.

C<postfix:<°> (Real $degrees)> converts degree measurments to radians.

C<postfix:<ᵍ> (Real $gradians)> converts gradian measurments to radians.


=head1 AUTHOR

Most of these were code snippets I or someone else wrote as helper functions
for solving RosettaCode tasks.

Stephen Schulze (aka thundergnat <thundergnat@comcast.net>)

=head1 COPYRIGHT AND LICENSE

Copyright 2023 thundergnat

This library is free software; you can redistribute it and/or modify it under
the Artistic License 2.0.

=end pod
