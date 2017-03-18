(* SYNTAX TEST "Packages/Mathematica/Mathematica.sublime-syntax" *)

(*
  For information on how this file is used, see
  https://www.sublimetext.com/docs/3/syntax.html#testing
  Run tests by pressing `ctrl+shift+b`, i.e. run the `build` command
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
