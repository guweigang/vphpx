module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'userland_subclass_probe' }

@[vphp.PhpExportTrait(name: 'VphpFixture\\Extension\\CounterMethods')]
@[vphp.PhpUserlandSubclass(name: 'VphpFixture\\Extension\\Counter', parent: 'VphpFixture\\Author\\Counter')]
@[vphp.PhpDeclaredPropertyWithDefault('steps', 'int', '0')]
pub struct CounterMethods {}

@[vphp.PhpExportMethod(name: 'advance')]
@[vphp.PhpArgDefault(v_name: 'amount', default_value: '1')]
pub fn (counter CounterMethods) advance(ctx vphp.Context, amount int) int {
	obj := ctx.ex.this_zend_object()
	total := obj.prop_borrowed('steps').to_int() + amount
	mut value := vphp.PhpInt.of(i64(total))
	obj.set_prop_input('steps', value)
	value.release()
	return total
}
