(* ::Package:: *)

<< (NotebookDirectory[] <> "utilities.wl");


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


namedCharacters = StringTake[getAtomic[#, {1, 1, -1, 1}], {3, -2}]& /@ Import[FileNameJoin[{
	$InstallationDirectory,
	"Documentation",
	$Language,
	"System/Guides/ListingOfNamedCharacters.nb"
}], {"Cells", "GuideText"}];


DumpSave[NotebookDirectory[] <> "wldata.mx", "wl`"];


End[];
