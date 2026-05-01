module main

import vphp

// ============================================
// Callable type bridging test - Sub-goal 1
// Tests that vphp.Callable params emit ZEND_ARG_CALLABLE_INFO
// so PHP reflection sees them as callable-typed.
// ============================================

// Global function with callable parameter
@[php_function]
fn v_invoke_callable(callback vphp.Callable) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	// Call with no args
	result := callback.call([])
	return 'Result: ' + result.to_string()
}

// Global function with callable + other params
@[php_function]
fn v_invoke_with_arg(callback vphp.Callable, value string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	args := [vphp.ZVal.new_string(value)]
	result := callback.call(args)
	return result.to_string()
}

// Class with callable method parameter
@[heap; php_class]
struct CallableProcessor {
pub mut:
	prefix string
}

@[php_method]
pub fn (p &CallableProcessor) construct(prefix string) {
	unsafe {
		mut self := p
		self.prefix = prefix
	}
}

@[php_method]
pub fn (p &CallableProcessor) process(callback vphp.Callable) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call([])
	return p.prefix + result.to_string()
}

@[php_method]
pub fn (p &CallableProcessor) transform(callback vphp.Callable, input string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	args := [vphp.ZVal.new_string(input)]
	result := callback.call(args)
	return p.prefix + result.to_string()
}

// Static method with callable
@[php_method]
pub fn CallableProcessor.apply(callback vphp.Callable, data string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	args := [vphp.ZVal.new_string(data)]
	return callback.call(args).to_string()
}

@[php_method: 'structClosure']
pub fn CallableProcessor.struct_closure() fn (StructClosureArgs) string {
	return my_struct_closure
}

fn my_zval_0(args ...vphp.ZVal) vphp.ZVal {
	_ = args.len
	return vphp.ZVal.new_string('variadic-0-result')
}

fn my_zval_1(args ...vphp.ZVal) vphp.ZVal {
	a := if args.len > 0 { args[0] } else { vphp.ZVal.new_null() }
	return vphp.ZVal.new_string('got:' + a.to_string())
}

fn my_zval_2(args ...vphp.ZVal) vphp.ZVal {
	a := if args.len > 0 { args[0] } else { vphp.ZVal.new_null() }
	b := if args.len > 1 { args[1] } else { vphp.ZVal.new_null() }
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string())
}

fn my_zval_3(args ...vphp.ZVal) vphp.ZVal {
	a := if args.len > 0 { args[0] } else { vphp.ZVal.new_null() }
	b := if args.len > 1 { args[1] } else { vphp.ZVal.new_null() }
	c := if args.len > 2 { args[2] } else { vphp.ZVal.new_null() }
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string() + '+' + c.to_string())
}

fn my_zval_4(args ...vphp.ZVal) vphp.ZVal {
	a := if args.len > 0 { args[0] } else { vphp.ZVal.new_null() }
	b := if args.len > 1 { args[1] } else { vphp.ZVal.new_null() }
	c := if args.len > 2 { args[2] } else { vphp.ZVal.new_null() }
	d := if args.len > 3 { args[3] } else { vphp.ZVal.new_null() }
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string() + '+' + c.to_string() + '+' +
		d.to_string())
}

fn my_zval_void(args ...vphp.ZVal) {
	mut text := ''
	for arg in args {
		text += arg.to_string()
	}
	_ = text
}

@[params]
struct StructClosureArgs {
	name  string
	count int
}

fn my_struct_closure(args StructClosureArgs) string {
	return '${args.name}:${args.count}'
}

fn my_variadic_value_closure(args ...vphp.PhpValue) string {
	mut parts := []string{}
	for arg in args {
		parts << arg.to_string()
	}
	return '${args.len}:' + parts.join('|')
}

fn my_variadic_zval_closure(args ...vphp.ZVal) vphp.ZVal {
	mut parts := []string{}
	for arg in args {
		parts << arg.to_string()
	}
	return vphp.ZVal.new_string('${args.len}:' + parts.join('|'))
}

fn my_variadic_zval_void(args ...vphp.ZVal) {
	_ = args.len
}

fn my_variadic_scalar_string(args ...vphp.VScalarValue) string {
	mut parts := []string{}
	for arg in args {
		parts << arg.to_string()
	}
	return '${args.len}:' + parts.join('|')
}

fn my_variadic_scalar_i64(args ...vphp.VScalarValue) i64 {
	mut total := i64(0)
	for arg in args {
		match arg {
			i64 {
				total += arg
			}
			f64 {
				total += i64(arg)
			}
			bool {
				if arg {
					total++
				}
			}
			string {
				total += arg.i64()
			}
		}
	}
	return total
}

fn my_variadic_scalar_value(args ...vphp.VScalarValue) vphp.VScalarValue {
	if args.len == 0 {
		return vphp.VScalarValue(i64(0))
	}
	return args[0]
}

@[php_function]
fn v_get_closure_0() fn (...vphp.ZVal) vphp.ZVal {
	return my_zval_0
}

@[php_function]
fn v_get_closure_1() fn (...vphp.ZVal) vphp.ZVal {
	return my_zval_1
}

@[php_function]
fn v_get_closure_2() fn (...vphp.ZVal) vphp.ZVal {
	return my_zval_2
}

@[php_function]
fn v_get_closure_3() fn (...vphp.ZVal) vphp.ZVal {
	return my_zval_3
}

@[php_function]
fn v_get_closure_4() fn (...vphp.ZVal) vphp.ZVal {
	return my_zval_4
}

@[php_function]
fn v_get_closure_3_void() fn (...vphp.ZVal) {
	return my_zval_void
}

@[php_function]
fn v_get_closure_4_void() fn (...vphp.ZVal) {
	return my_zval_void
}

@[php_function]
fn v_get_struct_param_closure() fn (StructClosureArgs) string {
	return my_struct_closure
}

@[php_function]
fn v_get_variadic_value_closure() fn (...vphp.PhpValue) string {
	return my_variadic_value_closure
}

@[php_function]
fn v_get_variadic_zval_closure() fn (...vphp.ZVal) vphp.ZVal {
	return my_variadic_zval_closure
}

@[php_function]
fn v_get_variadic_zval_void() fn (...vphp.ZVal) {
	return my_variadic_zval_void
}

@[php_function]
fn v_get_variadic_scalar_string() fn (...vphp.VScalarValue) string {
	return my_variadic_scalar_string
}

@[php_function]
fn v_get_variadic_scalar_i64() fn (...vphp.VScalarValue) i64 {
	return my_variadic_scalar_i64
}

@[php_function]
fn v_get_variadic_scalar_value() fn (...vphp.VScalarValue) vphp.VScalarValue {
	return my_variadic_scalar_value
}
