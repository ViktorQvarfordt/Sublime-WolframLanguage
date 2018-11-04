(* ::Package:: *)

Begin["wl`"];


namespace = Select[Names["System`*"], PrintableASCIIQ];
namespaceSize = Length[namespace];


Monitor[Quiet[
	usages = Table[
		namespace[[i]] -> ToExpression[namespace[[i]] <> "::usage"],
		{i, namespaceSize}
	], Message::name],
	ProgressIndicator[i / namespaceSize]
];


usageDictionary = Select[usages, Head[Values[#]] === String &];
usageAbsentSymbols = Keys @ Select[usages, Head[Values[#]] =!= String &];


DumpSave[NotebookDirectory[] <> "wldata.mx", "wl`"];


End[];
