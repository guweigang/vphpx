module compiler

import compiler.repr

fn test_exported_enum_rejects_invalid_and_duplicate_case_names() {
	for name, expected in {
		'Class':     'invalid case name'
		'bad-name':  'invalid case name'
		'Duplicate': 'duplicate declaration'
	} {
		mut enum_ := repr.new_enum_repr()
		enum_.php_name = 'Probe'
		enum_.cases = [
			repr.PhpEnumCaseRepr{ v_name: 'first', php_name: 'Duplicate' },
			repr.PhpEnumCaseRepr{ v_name: 'second', php_name: name },
		]
		validate_attribute_arguments([repr.PhpRepr(enum_)]) or {
			assert err.msg() == 'PHP enum case Probe::${name}: ${expected}'
			continue
		}
		assert false, 'accepted invalid enum case declaration'
	}
}
