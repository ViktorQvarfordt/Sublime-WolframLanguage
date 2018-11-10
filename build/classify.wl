(* ::Package:: *)

<< (NotebookDirectory[] <> "wldata.mx");
<< (NotebookDirectory[] <> "utilities.wl");


(* ::Subsubsection::Closed:: *)
(*Usages*)


Export[util`resolveFileName["usages.json"], wl`usageDictionary];


(* ::Subsubsection::Closed:: *)
(*Completions*)


util`writeFile["../completions.sublime-completions", util`toJSON[{
	"scope" -> "source.wolfram",
	"completions" -> Sort[StringReplace[StartOfString ~~ "$" -> ""] /@ wl`namespace]
}]];


(* ::Subsubsection:: *)
(*Syntaxes*)


classify[usages_, rules_] := Last @ Reap[
	Function[usage, Sow[
		Keys[usage],
		Piecewise[KeyValueMap[
			{#1, #2[Values[usage]]}&,
			rules
		]]
	]] /@ usages,
	_String,
	Rule
] // (AssociateTo[$dataset, #]; #)&;


$dataset = <|"named_characters" -> wl`namedCharacters|>;


classifiedNamespace = classify[wl`usageDictionary, <|
	"built_in_functions" -> StringStartsQ["\!\(\*RowBox[{"],
	"built_in_options" -> StringContainsQ[RegularExpression["is an? (\\w+ )?option"]],
	"built_in_constants" -> (True &)
|>];


getLines[name_] := Select[StringStartsQ[
	"\!\(\*RowBox[{" ~~ Repeated["\"", {0, 1}] ~~ name
]] @ StringCases[RegularExpression["(\!\(\*([^\)]+)\)|.)+"]] @ (name /. wl`usageDictionary);

getArguments[usage_] := usage //
	StringCases[#, RegularExpression["\!\(\*([^\)]+)\)"] -> "$1", 1]&
	First //
	ToExpression //
	util`getAtomic[{1}] //
	If[Length @ # <= 3, {}, getAtomic[#, {3, 1}]]& //
	If[Head @ # === List, getAtomic[{1}] /@ Take[#, {1, -1, 2}], {#}]&;

functionArguments = util`ruleMap[getArguments /@ getLines[#]&, "built_in_functions" /. classifiedNamespace];


testAll[crit_, sel_: Identity] := Length[#] > 0 && AllTrue[#, Length[#] > 0 && crit[sel[#]] &] &;


isFunctional[arg_] := arg === "f" || arg === "crit";

classify[functionArguments, <|
	"functional_rest_param" -> testAll[testAll[isFunctional], Rest], (* not found? *)
	"functional_first_param" -> testAll[isFunctional, First],
	"functional_last_param" -> testAll[isFunctional, Last]
|>];


isParametic[list_] := With[{sym = list[[1]][[1]]},
	StringLength[sym] === 1 &&
	MatchQ[Take[list, {3, -1, 2}], {
		SubscriptBox[StyleBox[sym, "TI"], StyleBox["min", "TI"]],
		SubscriptBox[StyleBox[sym, "TI"], StyleBox["max", "TI"]]
	}]
];

classify[functionArguments, <|
	"parametic_rest_param" -> (testAll[testAll[isParametic]] @ Cases[
		Cases[#, args_?(Length[#] > 0 &) :> Last[args]],
		args: {{"{", RowBox[{StyleBox[_String, "TI"], __}], "}"}..} :> (#[[2]][[1]] & /@ args)
	] &),
	"parametic_last_param" -> (testAll[isParametic] @ Cases[
		Cases[#, args_?(Length[#] > 0 &) :> Last[args]],
		{"{", RowBox[list: {StyleBox[_String, "TI"], __}], "}"} :> list
	] &)
|>];


util`replaceFile["../WolframLanguage.sublime-syntax", KeyValueMap[RuleDelayed[
	prefix: (#1 <> ":" ~~ Whitespace) ~~ (WordCharacter | "$" | "|")..,
	prefix <> StringRiffle[StringReplace["$" -> "\\$"] /@ #2, "|"]
]&, $dataset]];
