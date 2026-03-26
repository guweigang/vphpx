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
@[heap]
@[php_class]
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

// ============================================
// Universal Closure Export Tests (Sub-goal 2b)
// ============================================

fn my_universal_0() vphp.ZVal {
	return vphp.ZVal.new_string('universal-0-result')
}

fn my_universal_1(a vphp.ZVal) vphp.ZVal {
	return vphp.ZVal.new_string('got:' + a.to_string())
}

fn my_universal_2(a vphp.ZVal, b vphp.ZVal) vphp.ZVal {
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string())
}

fn my_universal_3(a vphp.ZVal, b vphp.ZVal, c vphp.ZVal) vphp.ZVal {
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string() + '+' + c.to_string())
}

fn my_universal_4(a vphp.ZVal, b vphp.ZVal, c vphp.ZVal, d vphp.ZVal) vphp.ZVal {
	return vphp.ZVal.new_string(a.to_string() + '+' + b.to_string() + '+' + c.to_string() + '+' + d.to_string())
}

fn my_universal_3_void(a vphp.ZVal, b vphp.ZVal, c vphp.ZVal) {
	// Side-effect only - would log or store in real usage
	_ = a.to_string() + b.to_string() + c.to_string()
}

fn my_universal_4_void(a vphp.ZVal, b vphp.ZVal, c vphp.ZVal, d vphp.ZVal) {
	// Side-effect only - would log or store in real usage
	_ = a.to_string() + b.to_string() + c.to_string() + d.to_string()
}

@[php_function]
fn v_get_closure_0(ctx vphp.Context) {
    ctx.wrap_closure_universal_0(my_universal_0)
}

@[php_function]
fn v_get_closure_1(ctx vphp.Context) {
    ctx.wrap_closure_universal_1(my_universal_1)
}

@[php_function]
fn v_get_closure_2(ctx vphp.Context) {
    ctx.wrap_closure_universal_2(my_universal_2)
}

@[php_function]
fn v_get_closure_3(ctx vphp.Context) {
    ctx.wrap_closure_universal_3(my_universal_3)
}

@[php_function]
fn v_get_closure_4(ctx vphp.Context) {
    ctx.wrap_closure_universal_4(my_universal_4)
}

@[php_function]
fn v_get_closure_3_void(ctx vphp.Context) {
    ctx.wrap_closure_universal_3_void(my_universal_3_void)
}

@[php_function]
fn v_get_closure_4_void(ctx vphp.Context) {
    ctx.wrap_closure_universal_4_void(my_universal_4_void)
}
