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


getAtomic[expr_, orders_List] := If[Length @ orders == 0,
	expr,
	getAtomic[Level[expr, 1][[orders[[1]]]], Rest @ orders]
];


namedCharacters = StringTake[getAtomic[#, {1, 1, -1, 1}], {3, -2}]& /@ Import[FileNameJoin[{
	$InstallationDirectory,
	"Documentation",
	$Language,
	"System/Guides/ListingOfNamedCharacters.nb"
}], {"Cells", "GuideText"}];


DumpSave[NotebookDirectory[] <> "wldata.mx", "wl`"];


End[];
