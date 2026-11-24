module parser

import compiler.repr
import compiler.syntax as ast

fn test_static_interface_methods_validate_names() {
	for names, expected in {
		'other':          'PHP interface Probe::other: unknown static method'
		'choose, choose': 'PHP interface Probe::choose: duplicate static declaration'
		'init':           'PHP interface Probe::init: a constructor cannot be static'
	} {
		mut iface := repr.PhpInterfaceRepr{
			php_name: 'Probe'
			methods:  [
				repr.PhpMethodRepr{ name: 'choose', v_name: 'choose' },
				repr.PhpMethodRepr{ name: 'init', v_name: 'init' },
			]
		}
		bind_interface_static_methods(mut iface, [
			ast.Attr{ name: 'vphp.PhpInterfaceStaticMethods', args: {
				'names': names
			} },
		]) or {
			assert err.msg() == expected
			continue
		}
		assert false, 'accepted an invalid static interface method declaration'
	}
}

fn test_typed_interface_methods_reject_duplicate_php_names_and_unknown_parameters() {
	for invalid, expected in {
		'method':    'PHP interface Probe::other: duplicate PHP method name'
		'parameter': 'PHP interface Probe::choose: unknown parameter $missing'
		'alias':     'PHP interface Probe::choose: duplicate PHP parameter name $y'
	} {
		mut iface := repr.PhpInterfaceRepr{
			php_name: 'Probe'
			methods:  [
				repr.PhpMethodRepr{
					name:   'choose'
					v_name: 'choose'
					args:   [repr.PhpArgRepr{ name: 'x' }, repr.PhpArgRepr{ name: 'y' }]
				},
				repr.PhpMethodRepr{ name: 'other', v_name: 'other' },
			]
		}
		decl := match invalid {
			'method' { InterfaceMethodDecl{ v_name: 'choose', php_name: 'OTHER' } }
			'parameter' {
				InterfaceMethodDecl{
					v_name:     'choose'
					parameters: {
						'missing': InterfaceParameterDecl{ php_name: 'field' }
					}
				}
			}
			else {
				InterfaceMethodDecl{
					v_name:     'choose'
					parameters: {
						'x': InterfaceParameterDecl{ php_name: 'y' }
					}
				}
			}
		}
		bind_interface_methods(mut iface, [decl]) or {
			assert err.msg() == expected
			continue
		}
		assert false, 'accepted an invalid typed interface method declaration'
	}
}
