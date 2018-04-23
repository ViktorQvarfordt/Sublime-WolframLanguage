const fs = require('fs');
const dict = require('./usage-dict.json');

// f7c1 = \!
// f7c9 = \(
// f7c8 = \*
// f7c0 = \)

const funcDict = [];
const optDict = [];
const constDict = [];

for (name in dict) {
	if (dict[name].includes('RowBox')) {
		funcDict.push(name.replace('$', '\\$'));
	} else if (dict[name].includes('option')) {
		optDict.push(name.replace('$', '\\$'));
	} else {
		constDict.push(name.replace('$', '\\$'));
	}
}

fs.writeFileSync(__dirname + '/name-function.txt', funcDict.join('|'), {encoding: 'utf8'});
fs.writeFileSync(__dirname + '/name-option.txt', optDict.join('|'), {encoding: 'utf8'});
fs.writeFileSync(__dirname + '/name-constant.txt', constDict.join('|'), {encoding: 'utf8'});
