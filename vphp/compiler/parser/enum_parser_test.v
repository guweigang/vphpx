module parser

import compiler.syntax as ast

fn test_rejects_php_backing_values_on_unit_enum_cases() {
	parsed := parse_enum_decl(ast.EnumDecl{
		name:   'Probe'
		attrs:  [ast.Attr{ name: 'php_enum' }, ast.Attr{ name: 'vphp.PhpUnitEnum' }]
		fields: [ast.ValueField{
			name:  'first'
			attrs: [ast.Attr{
				name: 'vphp.PhpEnumCaseValue'
				args: {
					'value': 'first'
				}
			}]
		}]
	}, ast.new_table()) or { panic('expected an exported enum') }
	assert parsed.parse_err == 'PHP unit enum Probe cannot declare PhpEnumCaseValue'
}

fn test_rejects_missing_and_duplicate_php_string_backing_values() {
	table := ast.new_table()
	empty_backing := ast.Attr{
		name: 'vphp.PhpEnumCaseValue'
		args: {
			'value': ''
		}
	}
	first := ast.ValueField{
		name:  'first'
		attrs: [empty_backing]
	}
	for second in [
		ast.ValueField{ name: 'missing' },
		ast.ValueField{ name: 'duplicate', attrs: [empty_backing] },
	] {
		parsed := parse_enum_decl(ast.EnumDecl{
			name:   'Probe'
			attrs:  [ast.Attr{ name: 'php_enum' }]
			fields: [first, second]
		}, table) or { panic('expected an exported enum') }
		if second.name == 'missing' {
			assert parsed.parse_err == 'PHP string-backed enum Probe::missing requires PhpEnumCaseValue'
		} else {
			assert parsed.parse_err == 'PHP enum Probe::duplicate duplicates the backing value of first'
		}
	}
}
