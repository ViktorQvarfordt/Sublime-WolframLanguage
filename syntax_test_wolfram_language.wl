(* SYNTAX TEST "WolframLanguage.sublime-syntax" *)

(*
  For information on how this file is used, see
  https://www.sublimetext.com/docs/3/syntax.html#testing
  Run tests by pressing `ctrl+shift+b` (or `cmd+b` on macOS), i.e. run the `build` command
*)


(* NUMBERS *)

  11
(*^^ constant.numeric *)
  .11
(*^^^ constant.numeric *)
  11.
(*^^^ constant.numeric *)
  11.11
(*^^^^^ constant.numeric *)
  11.11`
(*^^^^^^ constant.numeric *)
  11.11`11.11
(* ^^^^^^^^^^^ constant.numeric *)


(* NUMERIC CONSTANTS *)

  Catalan
(*^ constant.numeric *)
  Pi
(*^ constant.numeric *)


(*LANGUAGE CONSTANTS *)

  True
(*^^^^ constant.language *)
  Left
(*^^^^ constant.language *)


(* OPERATORS *)

  +
(*^ keyword.operator.arithmetic *)
  -
(*^ keyword.operator.arithmetic *)
  /
(*^ keyword.operator.arithmetic *)
  *
(*^ keyword.operator.arithmetic *)

  !
(*^ keyword.operator.logical *)
  &&
(*^^ keyword.operator.logical *)
  ||
(*^^ keyword.operator.logical *)
  >
(*^ keyword.operator.comparison *)
  <
(*^ keyword.operator.comparison *)
  ==
(*^^ keyword.operator.comparison *)
  >=
(*^^ keyword.operator.comparison *)
  <=
(*^^ keyword.operator.comparison *)
  ===
(*^^^ keyword.operator.comparison *)
  =!=
(*^^^ keyword.operator.comparison *)

  @
(*^ keyword.operator *)
  @@
(*^^ keyword.operator *)
  @@@
(*^^^ keyword.operator *)
  @*
(*^^ keyword.operator *)
  /*
(*^^ keyword.operator *)
  /@
(*^^ keyword.operator *)
  /;
(*^^ keyword.operator *)
  //
(*^^ keyword.operator *)
  /:
(*^^ keyword.operator *)
  =
(*^ keyword.operator *)
  :=
(*^^ keyword.operator *)
  :>
(*^^ keyword.operator *)
  ->
(*^^ keyword.operator *)
  <->
(*^^^ keyword.operator *)

(* VARIABLES *)

  f[x]
(*^ variable.function *)
  foo$bar12
(*^^^^^^^^^ variable.other *)
  $foo
(*^^^^ variable.other *)
  my`context12`$foo
(*^^^^^^^^^^^^^^^^^ variable.other *)

  Plus
(*^ variable.function *)
  System`Plus
(*^^^^^^^^^^^ variable.function *)

  Image[Red, Interleaving -> True]
(*^^^^^ variable.function *)
(*     ^ punctuation.section.brackets.begin.wolfram *)
(*           ^^^^^^^^^^^^ variable.function.wolfram *)
(*                        ^^ keyword.operator *)


(* PATTERNS *)

  var_head: foo
(*^^^^^^^^ meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*        ^ meta.pattern.blank.wolfram keyword.operator.Optional.wolfram *)
(*          ^^^ variable.other *)

  var_head ? EvenQ
(*^^^^^^^^ meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*         ^ meta.pattern.blank.wolfram keyword.operator.PatternTest.wolfram *)
(*           ^^^^^ variable.function *)

  var: patt ? EvenQ : foo
(*^^^ variable.parameter.wolfram *)
(*   ^ keyword.operator.Pattern.wolfram *)
(*     ^^^ meta.pattern.wolfram variable.other *)
(*          ^ meta.pattern.wolfram keyword.operator.PatternTest.wolfram *)
(*            ^^^^^ meta.pattern.wolfram variable.function *)
(*                  ^ keyword.operator.Optional.wolfram *)
(*                    ^^^ variable.other *)


(* FUNCTIONS *)

  f[x_, y_] := 2x
(*^ entity.name.function *)
(* ^ meta.arguments.wolfram punctuation.section.brackets.begin.wolfram *)
(*  ^^ meta.arguments.wolfram meta.pattern.blank.wolfram variable.parameter.wolfram *)
(*    ^^ meta.arguments.wolfram punctuation.separator.sequence.wolfram *)
(*      ^ variable.parameter *)
(*        ^ meta.arguments.wolfram punctuation.section.brackets.end.wolfram *)
(*          ^^ keyword.operator *)

  f[x_, OptionsPattern[]] := 2x
(* ^ entity.name.function *)
(*  ^ variable.parameter *)
(*      ^^^^^^^^^^^^^^ variable.function *)
(*                        ^^ keyword.operator *)

  f[x_?TrueQ, y_ /; Negative[y]] := 2x /; y > 0
(* ^ entity.name.function *)
(*  ^ variable.parameter *)
(*    ^ keyword.operator *)
(*               ^^ keyword.operator *)

  f[x_, s_] := 2x
(* ^ entity.name.function *)
(*  ^ variable.parameter *)

  f[x_] := 2x
(* ^ entity.name.function *)
(*  ^ variable.parameter *)

  f[x_] /; x > 0 := x
(* ^ entity.name.function  *)

  f[[]]


(* STRINGS *)

  "This is\n\a string. (* not a comment *)"
(*^ punctualation.defination.string.begin *)
(*        ^^ constant.character.escape *)
(*          ^^ string.quoted *)

  foo::bar = "message"
(*   ^^ keyword.operator.MessageName *)
(*     ^^^ string.unquoted *)
(*           ^^^^^^^^^ string.quoted *)

  StringTemplate["Value `a`: <* Range[#n] *>."][<|"a" -> 1234, "n" -> 3|>]
(*                      ^^^ variable.parameter *)
(*                           ^^ keyword.operator.template-expression *)

  "box 1: \!\(x\^2\); box 2: \(y\^3\) "
(*        ^ keyword.operator.string-box *)
(*             ^^ keyword.operator.x-scriptBox *)


(* COMMENTS *)

  (* comment (* another comment *) *)
(*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ comment.block.wolfram *)
(*           ^^^^^^^^^^^^^^^^^^^^^ comment.block.wolfram comment.block.wolfram *)


(* BRACKETS *)

  <| |>
(*^^ punctuation.section.association.begin.wolfram  *)
(*^^^^^ meta.association.wolfram  *)
(*   ^^ punctuation.section.association.end.wolfram *)

  [ ]
(*^ punctuation.section.brackets.begin.wolfram *)
(*^^^ meta.brackets.wolfram *)
(*  ^ punctuation.section.brackets.end.wolfram *)

  { }
(*^ punctuation.section.braces.begin.wolfram *)
(*^^^ meta.braces.wolfram *)
(*  ^ punctuation.section.braces.end.wolfram *)

  ( )
(*^ punctuation.section.parens.begin.wolfram *)
(*^^^ meta.parens.wolfram *)
(*  ^ punctuation.section.parens.end.wolfram *)

  \( \)
(*^^ punctuation.section.box.begin.wolfram *)
(*^^^^^ meta.box.wolfram *)
(*   ^^ punctuation.section.box.end.wolfram *)

  [[ ]]
(*^^ punctuation.section.parts.begin.wolfram *)
(*^^^^^ meta.parts.wolfram *)
(*   ^^ punctuation.section.parts.end.wolfram *)


(* SCOPING *)

  Module[
(*^^^^^^ variable.function.scoping.wolfram *)
(*      ^ punctuation.section.brackets.begin.wolfram *)
    { foo, bar = 1},
(*   ^ meta.block.local.wolfram *)
(*    ^^^ meta.block.local.wolfram variable.parameter.wolfram *)
(*                 ^ meta.block.wolfram *)
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
(*                                  ^^^^ meta.block.local.wolfram variable.other *)
  },

  code
(* ^^^^ meta.block.wolfram variable.other *)

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
