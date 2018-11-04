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


classifiedNamespace = Last @ Reap[
	Sow[Keys[#], Switch[Values[#],
		_?(StringStartsQ["\!\(\*RowBox"]), "functions",
		_?(StringContainsQ[RegularExpression["is an? (\\w+ )?option"]]), "options",
		_, "constants"
	]]& /@ wl`usageDictionary,
	_,
	Rule
];


writeFile["../WolframLanguage.sublime-syntax", StringReplace[
	readFile["../WolframLanguage.sublime-syntax"],
	RuleDelayed[
		prefix: StringExpression[
			"built_in_" ~~ # ~~ ": |-" ~~ Whitespace,
			"(?x)" ~~ Whitespace,
			"\\b(?:" ~~ Whitespace
		] ~~ (WordCharacter | "$" | "|")..,
		prefix <> StringRiffle[StringReplace["$" -> "\\$"] /@ (# /. classifiedNamespace), "|"]
	]& /@ {"functions", "options", "constants"}
]];
