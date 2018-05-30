(* SYNTAX TEST "WolframLanguage.sublime-syntax" *)

(*
  For information on how this file is used, see
  https://www.sublimetext.com/docs/3/syntax.html#testing
  Run tests by pressing `ctrl+shift+b` (or `cmd+b` on macOS), i.e. run the `build` command
*)

(* NUMBERS *)

   11
(* ^^ constant.numeric *)
   .11
(* ^^^ constant.numeric *)
   11.
(* ^^^ constant.numeric *)
   11.11
(* ^^^^^ constant.numeric *)
   11.11`
(* ^^^^^^ constant.numeric *)
   11.11`11.11
(* ^^^^^^^^^^^ constant.numeric *)

(* NUMERIC CONSTANTS *)

   Catalan
(* ^ constant.numeric *)
   Pi
(* ^ constant.numeric *)

(* LANGUAGE CONSTANTS *)

   True
(* ^^^^ constant.language *)
   Left
(* ^^^^ constant.language *)

(* OPERATORS *)

  +
(*^ keyword.operator.arithmetic*)
  -
(*^ keyword.operator.arithmetic*)
  /
(*^ keyword.operator.arithmetic*)
  *
(*^ keyword.operator.arithmetic*)

  !
(*^ keyword.operator.logical*)
  &&
(*^^ keyword.operator.logical*)
  ||
(*^^ keyword.operator.logical*)

  >
(*^ keyword.operator.comparison*)
  <
(*^ keyword.operator.comparison*)
  ==
(*^^ keyword.operator.comparison*)
  >=
(*^^ keyword.operator.comparison*)
  <=
(*^^ keyword.operator.comparison*)
  ===
(*^^^ keyword.operator.comparison*)
  =!=
(*^^^ keyword.operator.comparison*)

   /;
(* ^^ keyword.operator *)
   //
(* ^^ keyword.operator *)
   /:
(* ^^ keyword.operator *)
   =
(* ^ keyword.operator *)
   :=
(* ^^ keyword.operator *)
   :>
(* ^^ keyword.operator *)
   ->
(* ^^ keyword.operator *)
   <->
(* ^^^ keyword.operator *)

(* VARIABLES *)

  f[x]
(*^ variable.function*)
  foo$bar12
(*^^^^^^^^^ variable.other *)
  $foo
(*^^^^ variable.other *)
  my`context12`$foo
(*^^^^ variable.other *)

  f[x];
(*^ variable.function *)
(*. ^ variable.other *)

  Image[Red, Interleaving -> True]
(*^^^^^ variable.function *)
(*      ^ variable.function *)
(*           ^ variable.function *)
(*                        ^^ keyword.operator *)


(* FUNCTIONS *)

  f[x_, y_] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)
(*      ^ variable.parameter*)
(*          ^^ keyword.operator*)

  f[x_, OptionsPattern[]] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)
(*      ^^^^^^^^^^^^^^ variable.function*)
(*                        ^^ keyword.operator*)

  f[x_?TrueQ, y_ /; Negative[y]] := 2x /; y > 0
(*^ entity.name.function*)
(*  ^ variable.parameter*)
(*    ^ keyword.operator*)
(*               ^^ keyword.operator*)


  f[x: _] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)

(* <<< the scoping from above is breaking this one *)
  f[x_] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)


(* STRINGS *)

  "This is a `string` (* this is not \a comment*)"
(* ^ string.quoted.wolfram *)
(*            ^ constant.other.placeholder *)
(*                       ^ string.quoted.wolfram *)
(*                                    ^ constant.character.escape *)

(* ASSERTION FREE *)

  foo[[1]]

  StringMatchQ[IgnoreCase -> Automatic, foo -> bar]

  foo["bar",  baz_] :=


