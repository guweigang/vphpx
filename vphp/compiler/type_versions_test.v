module compiler

import compiler.repr

fn test_hidden_class_keeps_only_its_class_entry_symbol() {
	generator := CGenerator{}
	class := repr.PhpClassRepr{
		name:            'Probe'
		php_name:        'Probe'
		min_php_version: 80600
		methods:         [repr.PhpMethodRepr{ name: 'number', v_name: 'number' }]
	}
	fragments := generator.build_class_export(&class)
	assert fragments.implementations[0] == 'zend_class_entry *probe_ce = NULL;'
	assert fragments.implementations[1] == '#if PHP_VERSION_ID >= 80600'
	assert fragments.implementations.join('\n').contains('PHP_METHOD(Probe, number)')
	assert fragments.implementations.last() == '#endif'
	assert fragments.minit_lines == [
		'#if PHP_VERSION_ID >= 80600',
		'if (probe_register_class() != SUCCESS) { return FAILURE; }',
		'#endif',
	]
}
