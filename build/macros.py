from YAMLMacros.lib.syntax import rule

def builtin(str):
	return r'(?:System`)?({{%s}})(?![$`])\b' % str

def meta(end, scope, type):
	return [
		rule(meta_scope = 'meta.%s.wolfram' % scope),
		rule(
			match = end,
			scope = 'punctuation.section.%s.end.wolfram' % type,
			pop = True,
		),
		rule(include = 'expressions'),
	]

def nested(start, end, type):
	return rule(
		match = start,
		scope = 'punctuation.section.%s.begin.wolfram' % type,
		push = meta(type, end, type)
	)
	