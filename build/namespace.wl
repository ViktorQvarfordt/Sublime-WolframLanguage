(* ::Package:: *)

namespace = Select[Names["*"], PrintableASCIIQ];


Monitor[
	Quiet[
		usages = Table[
			namespace[[i]] -> (ToExpression[namespace[[i]] <> "::usage"]),
		{i, Length @ namespace}],
	Message::name],
	ProgressIndicator[i / Length@namespace]
];


Export[NotebookDirectory[] <> "usage-dict.json",
	Select[usages, Head[Values[#]] === String &]
];


Export[NotebookDirectory[] <> "usage-absent.json", Keys[
	Select[usages, Head[Values[#]] =!= String &]
]];
