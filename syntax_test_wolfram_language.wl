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

   @
(* ^ keyword.operator *)
   @@
(* ^^ keyword.operator *)
   @@@
(* ^^^ keyword.operator *)
   @*
(* ^^ keyword.operator *)
   /*
(* ^^ keyword.operator *)
   /@
(* ^^ keyword.operator *)
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

  Plus
(* ^ variable.function *)
  System`Plus
(*     ^^^ variable.function *)

  Image[Red, Interleaving -> True]
(*^^^^^ variable.function *)
(*      ^ constant.language *) (* seems wrong to me *)
(*           ^^^^^^^^^^^^ variable.function.wolfram *)
(*                        ^^ keyword.operator *)

(* PATTERNS *)

  var_head  foo
(*^^^^^^^^ meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*          ^ variable.other *)

  var_head:foo
(*^^^^^^^^ meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*        ^ meta.pattern.blank.wolfram keyword.operator.Optional.wolfram *)
(*         ^^^ variable.other *)

  var_head ? EvenQ
(*^^^^^^^^ meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*         ^ meta.pattern.blank.wolfram keyword.operator.PatternTest.wolfram *)
(*           ^^^^^ variable.function *)

  var: patt ? EvenQ : foo
(*^^^ variable.parameter.wolfram *)
(*   ^ keyword.operator.Pattern.wolfram *)
(*      ^^^ meta.pattern.wolfram variable.other *)
(*          ^ meta.pattern.wolfram keyword.operator.PatternTest.wolfram *)
(*            ^^^^^ meta.pattern.wolfram variable.function *)
(*                  ^ keyword.operator.Optional.wolfram *)
(*                    ^^^ variable.other *)


(* FUNCTIONS *)

  f[x_, y_] := 2x
(*^ entity.name.function*)
(* ^ meta.arguments.wolfram punctuation.section.brackets.begin.wolfram *)
(*  ^^ meta.arguments.wolfram meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*    ^^ meta.arguments.wolfram punctuation.separator.sequence.wolfram *)
(*      ^ variable.parameter*)
(*        ^ meta.arguments.wolfram punctuation.section.brackets.end.wolfram *)
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


  f[x_, s_] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)

  f[x_] := 2x
(*^ entity.name.function*)
(*  ^ variable.parameter*)

  f[x_] /; x > 0 := x
(*^ entity.name.function  *)

  f[[]]


(* STRINGS *)

  "This is a `string` (* this is not \a comment*)"
(* ^ string.quoted *)
(*            ^ constant.other.placeholder *)
(*                       ^ string.quoted *)
(*                                    ^ constant.character.escape *)

  foo::bar = "message"
(*   ^^ keyword.operator.MessageName *)
(*     ^^^ string.unquoted *)
(*             ^^ string.quoted *)

  "this`is`a`context"
(*^ punctuation.definition.string.begin *)
(* ^^^^^^^^^^^^^^^^^ string.quoted.wolfram*)


(* COMMENTS *)

(* simple comment *)
(* ^ comment.block *)

(* comment (*in a comment*) *)
(* ^^^^^^^^ comment.block.wolfram *)
(*         ^^^^^^^^^^^^^^^^ comment.block.wolfram comment.block.wolfram *)


(* BRACKETS *)

  <|   |>  foo
(*^^ meta.association.wolfram punctuation.section.association.begin.wolfram  *)
(*   ^ meta.association.wolfram  *)
(*     ^^ meta.association.wolfram punctuation.section.association.end.wolfram *)
(*         ^^^ source.wolfram variable.other *)

  [ ]
(*^ meta.brackets.wolfram punctuation.section.brackets.begin.wolfram *)
(* ^ meta.brackets.wolfram *)
(*  ^ meta.brackets.wolfram punctuation.section.brackets.end.wolfram *)

  { }
(*^ meta.braces.wolfram punctuation.section.braces.begin.wolfram *)
(* ^ meta.braces.wolfram *)
(*  ^ meta.braces.wolfram punctuation.section.braces.end.wolfram *)

  ( )
(*^ meta.parens.wolfram punctuation.section.parens.begin.wolfram *)
(* ^ meta.parens.wolfram *)
(*  ^ meta.parens.wolfram punctuation.section.parens.end.wolfram *)

  [ [ ]]
(*^^^ meta.parts.wolfram punctuation.section.parts.begin.wolfram *)
(*   ^ meta.parts.wolfram *)
(*    ^^ meta.parts.wolfram punctuation.section.parts.end.wolfram *)


(* SCOPING *)

Module[
(*^^^^ variable.function.scoping.wolfram *)
(*    ^ punctuation.section.brackets.begin.wolfram *)
    { foo, bar = 1},
(*   ^ meta.block.local.wolfram *)
(*    ^^^ meta.block.local.wolfram variable.parameter.wolfram *)
(*                  ^ meta.block.wolfram *)
    foo
(*  ^^^ meta.block.wolfram variable.other *)
]

Block[
  {
    var1, (*comment*) var2 , var3 = var4
(*  ^^^^ meta.block.local.wolfram variable.parameter.wolfram *)
(*        ^^^^^^^^^^^ meta.block.local.wolfram comment.block.wolfram *)
(*                    ^^^^ meta.block.local.wolfram variable.parameter.wolfram *)
(*                           ^^^^ meta.block.local.wolfram variable.parameter.wolfram *)
(*                                  ^^^^ meta.block.local.wolfram variable.other*)
  },

  code
(*^^^^ meta.block.wolfram variable.other *)

]


(* ASSERTION FREE *)

  System`foo[[1]]
  a//a
  StringMatchQ[IgnoreCase -> Automatic, foo -> bar]

  foo["bar",  baz_Lisght] :=


(* multiline (* also a comment *)
  comment 
  asd
*)

(* ::s:: *)
