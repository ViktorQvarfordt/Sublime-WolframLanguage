(* ::Package:: *)

<< (NotebookDirectory[] <> "utilities.wl");


Begin["wl`"];


namespace = Select[Names["System`*"], PrintableASCIIQ];

Function[usages,
	usageDictionary = Select[usages, Head["Definition" /. Values[#]] === String &];
	usagePresentSymbols = Keys @ usageDictionary;
	usageAbsentSymbols = Complement[namespace, usagePresentSymbols];
] @ util`ruleMap[Block[{symbol = Symbol[#]},
	Join[SyntaxInformation[symbol], {
		"Definition" -> MessageName[Evaluate[symbol], "usage"],
		"Attributes" -> Attributes[Evaluate[symbol]]
	}]
] &, namespace];


documentedLists = Keys[#] -> Values[#] /@ util`getGuideText[util`toCamel[Keys[#]]] & /@ {
	"listing_of_named_characters" -> (StringTake[#, {3, -2}]&) @* util`getAtomic[{1, 1, -1, 1}],
	"listing_of_supported_external_services" -> util`getAtomic[{1, 1, 1, 1, 1, 1, 1, 1, 1}],
	"listing_of_all_formats" -> util`getAtomic[{1, 1, 1, 1, 1, 1, 1, 1, 1}]
};


DumpSave[NotebookDirectory[] <> "wldata.mx", "wl`"];


Export[util`resolveFileName["usages.json"], wl`usageDictionary];


util`writeFile["../completions.sublime-completions", util`toJSON[{
	"scope" -> "source.wolfram",
	"completions" -> Sort[StringReplace[StartOfString ~~ "$" -> ""] /@ wl`namespace]
}]];


End[];
