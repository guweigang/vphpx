module parser

import compiler.repr

fn test_interface_defaults_reject_invalid_targets_and_order() {
	for field, message in {
		'missing': 'PHP interface Probe::pick($missing): unknown parameter'
		'x':       'PHP interface Probe::pick($y): required parameter follows a default'
		'rest':    'PHP interface Probe::pick($rest): variadic parameters cannot have defaults'
	} {
		mut iface := repr.PhpInterfaceRepr{
			php_name: 'Probe'
			methods:  [
				repr.PhpMethodRepr{
					v_name: 'pick'
					args:   [
						repr.PhpArgRepr{ name: 'x' },
						repr.PhpArgRepr{ name: 'y' },
						repr.PhpArgRepr{ name: 'rest', is_variadic: true },
					]
				},
			]
		}
		bind_interface_defaults(mut iface, [InterfaceParamDefault{'pick', field, 'null'}]) or {
			assert err.msg() == message
			continue
		}
		assert false, 'accepted an invalid interface default'
	}
}
