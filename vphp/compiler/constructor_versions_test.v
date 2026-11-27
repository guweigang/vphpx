module compiler

import compiler.repr

fn test_constructor_handlers_are_compiled_only_for_their_php_versions() {
	generator := CGenerator{}
	mut class := repr.PhpClassRepr{
		name:     'Probe'
		php_name: 'Probe'
		methods:  [
			repr.PhpMethodRepr{
				name:            '__construct'
				v_name:          'construct'
				min_php_version: 80600
			},
		]
	}
	code := generator.gen_class_c(&class).join('\n')
	assert code.contains('#if PHP_VERSION_ID >= 80600\nPHP_METHOD(Probe, __construct) {')
	assert code.contains('#if PHP_VERSION_ID < 80600\n\nZEND_NAMED_FUNCTION(ZEND_MN(Probe_vphp_default_construct)) {')

	class.parent = 'Exception'
	class.direct_internal_parent = true
	inherited := generator.gen_class_c(&class).join('\n')
	assert inherited.contains('#if PHP_VERSION_ID >= 80600\nPHP_METHOD(Probe, __construct) {')
	assert !inherited.contains('Probe_vphp_default_construct')
}
