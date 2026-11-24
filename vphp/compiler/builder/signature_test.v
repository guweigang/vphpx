module builder

fn test_interface_signature_type_rejects_invalid_positions_and_compounds() {
	for invalid in ['void', 'never', 'static', '?mixed', 'int||string', 'Countable&int'] {
		validate_interface_signature_type(invalid, false) or { continue }
		assert false, 'accepted invalid parameter type ${invalid}'
	}
	validate_interface_signature_type('?never', true) or { return }
	assert false, 'accepted nullable never as an interface return type'
}

fn test_php_signature_comparison_preserves_reference_and_parameter_shape() {
	signature := ClassMethod{
		return_spec: new_return_spec('int', '', '')
		args:        [ClassMethodArg{ type_: 'int' }]
	}
	for changed_arg in [
		ClassMethodArg{ type_: 'vphp.PhpReference', php_type: 'int' },
		ClassMethodArg{ type_: 'int', is_optional: true },
		ClassMethodArg{ type_: '[]int', is_variadic: true },
		ClassMethodArg{ type_: 'string' },
	] {
		changed := ClassMethod{ ...signature, args: [changed_arg] }
		assert !signature.same_php_signature(changed, unsafe { nil })
	}
	changed_return := ClassMethod{
		...signature
		return_spec: new_return_spec('vphp.PhpReference', 'int', '')
	}
	assert !signature.same_php_signature(changed_return, unsafe { nil })
}
