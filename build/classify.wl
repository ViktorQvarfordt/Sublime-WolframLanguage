(* ::Package:: *)

<< (NotebookDirectory[] <> "wldata.mx");


toJSON[expression_, indent_: 2] := StringReplace[
	JSONTools`ToJSON[expression],
	StartOfLine ~~ whitespace: " ".. :> StringTake[whitespace, StringLength @ whitespace / 4 * indent]
];


resolveFileName[filename_] := FileNameJoin[{NotebookDirectory[], filename}]
readFile[filename_] := Import[resolveFileName[filename], "String"];
writeFile[filename_, content_] := Export[resolveFileName[filename], content, "String"];


writeFile["../completions.sublime-completions", toJSON[{
	"scope" -> "source.wolfram",
	"completions" -> Sort[StringReplace[StartOfString ~~ "$" -> ""] /@ wl`namespace]
}]];


classificationRules = <|
	"functions" -> (StringStartsQ["\!\(\*RowBox"]),
	"options" -> (StringContainsQ[RegularExpression["is an? (\\w+ )?option"]]),
	"constants" -> (True &)
|>;
classifiedNamespace = Last @ Reap[
	Function[rule, Sow[
		Keys[rule],
		Piecewise[KeyValueMap[
			{#1, #2[Values[rule]]}&,
			classificationRules
		]]
	]] /@ wl`usageDictionary,
	_,
	Rule
];
replacement[prefixes_, symbols_] := RuleDelayed[
	prefix: StringExpression @@ Riffle[prefixes, Whitespace, {2, -1, 2}] ~~ (WordCharacter | "$" | "|")..,
	prefix <> StringRiffle[StringReplace["$" -> "\\$"] /@ symbols, "|"]
]


writeFile["../WolframLanguage.sublime-syntax", StringReplace[
	readFile["../WolframLanguage.sublime-syntax"],
	{
		Sequence @@ (replacement[
			{"built_in_" ~~ # ~~ ": |-", "(?x)", "\\b(?:"},
			# /. classifiedNamespace
		]& /@ Keys @ classificationRules),
		replacement[{"named_characters:"}, wl`namedCharacters]
	}
]];


Export[resolveFileName["usages.json"], wl`usageDictionary];
