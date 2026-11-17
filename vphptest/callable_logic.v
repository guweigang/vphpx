module main

import vphp

// ============================================
// Callable type bridging test - Sub-goal 1
// Tests that vphp.PhpCallable params emit ZEND_ARG_CALLABLE_INFO
// so PHP reflection sees them as callable-typed.
// ============================================

// Global function with callable parameter
@[php_function]
fn v_invoke_callable(callback vphp.PhpCallable) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call[vphp.PhpString]() or { return 'Error: ${err.msg()}' }
	return 'Result: ' + result.value()
}

// Global function with callable + other params
@[php_function]
fn v_invoke_with_arg(callback vphp.PhpCallable, value string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call[vphp.PhpString](vphp.PhpString.of(value)) or {
		return 'Error: ${err.msg()}'
	}
	return result.value()
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
pub fn (p &CallableProcessor) process(callback vphp.PhpCallable) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call[vphp.PhpString]() or { return 'Error: ${err.msg()}' }
	return p.prefix + result.value()
}

@[php_method]
pub fn (p &CallableProcessor) transform(callback vphp.PhpCallable, input string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call[vphp.PhpString](vphp.PhpString.of(input)) or {
		return 'Error: ${err.msg()}'
	}
	return p.prefix + result.value()
}

// Static method with callable
@[php_method]
pub fn CallableProcessor.apply(callback vphp.PhpCallable, data string) string {
	if !callback.is_callable() {
		return 'Error: not callable'
	}
	result := callback.call[vphp.PhpString](vphp.PhpString.of(data)) or {
		return 'Error: ${err.msg()}'
	}
	return result.value()
}

@[php_method: 'structClosure']
pub fn CallableProcessor.struct_closure() fn (StructClosureArgs) string {
	return my_struct_closure
}

@[php_method: 'computedParams']
pub fn (p &CallableProcessor) computed_params(params VPhpComputedParamsDemo) string {
	return v_php_computed_params(p.prefix, params)
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

@[params]
struct StructClosureDefaults {
	name     string
	count    int     = 7
	flag     bool    = true
	label    ?string = none
	computed int     = struct_closure_default_count()
}

fn struct_closure_default_count() int {
	return 7
}

__global (
	struct_closure_default_calls int
)

@[params]
struct StructClosureComputedDefaults {
	name   string
	first  int  = next_struct_closure_default()
	second ?int = next_struct_closure_default()
	flag   bool = true
}

fn next_struct_closure_default() int {
	struct_closure_default_calls++
	return struct_closure_default_calls
}

fn format_struct_closure_computed_defaults(args StructClosureComputedDefaults) string {
	second := if value := args.second { value.str() } else { '<null>' }
	return '${args.name}:${args.first}:${second}:${args.flag}'
}

struct NativeClosurePayload {
	value int
}

@[params]
struct StructClosureNativeDefaults {
	payload NativeClosurePayload = next_native_closure_payload()
	label   string               = 'trailing'
}

fn next_native_closure_payload() NativeClosurePayload {
	return NativeClosurePayload{ value: next_struct_closure_default() }
}

fn format_struct_closure_native_defaults(args StructClosureNativeDefaults) string {
	return '${args.label}:${args.payload.value}'
}

fn format_struct_closure_defaults(args StructClosureDefaults) string {
	label := args.label or { '' }
	return '${args.name}:${args.count}:${args.flag}:${args.computed}:${label}'
}

fn print_struct_closure_defaults(args StructClosureDefaults) {
	vphp.PhpOutput.line(format_struct_closure_defaults(args))
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
fn v_get_struct_default_closure() fn (StructClosureDefaults) string {
	return format_struct_closure_defaults
}

@[php_function]
fn v_get_struct_default_closure_void() fn (StructClosureDefaults) {
	return print_struct_closure_defaults
}

@[php_function]
fn v_get_struct_computed_defaults_closure() fn (StructClosureComputedDefaults) string {
	return format_struct_closure_computed_defaults
}

@[php_function]
fn v_get_struct_native_defaults_closure() fn (StructClosureNativeDefaults) string {
	return format_struct_closure_native_defaults
}

@[params]
struct StructClosureFailingDefaults {
	first  int  = fail_struct_closure_default()
	second int  = next_struct_closure_default()
	tail   bool = true
}

fn fail_struct_closure_default() int {
	vphp.PhpException.raise_class('RuntimeException', 'closure default failed', 0)
	return 0
}

@[php_function]
fn v_get_struct_failing_defaults_closure() fn (StructClosureFailingDefaults) string {
	return fn (args StructClosureFailingDefaults) string {
		return '${args.first}:${args.second}:${args.tail}'
	}
}

type LegacyStructClosureVoid = fn (StructClosureDefaults)

@[php_function]
fn v_invoke_legacy_struct_closure(ctx vphp.Context) {
	ctx.invoke_struct_closure[fn (StructClosureDefaults) string, StructClosureDefaults, string](format_struct_closure_defaults,
		StructClosureDefaults{ name: 'legacy' })
}

@[php_function]
fn v_invoke_legacy_struct_closure_void(ctx vphp.Context) {
	callback := LegacyStructClosureVoid(print_struct_closure_defaults)
	ctx.invoke_struct_closure_void[LegacyStructClosureVoid, StructClosureDefaults](callback,
		StructClosureDefaults{ name: 'legacy void' })
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

type LegacyVariadicScalarCallback = fn (...vphp.VScalarValue) i64

@[php_function]
fn v_invoke_legacy_variadic_scalar(ctx vphp.Context) {
	ctx.invoke_variadic_closure[fn (...vphp.VScalarValue) string, string](my_variadic_scalar_string)
}

@[php_function]
fn v_invoke_legacy_variadic_scalar_alias(ctx vphp.Context) {
	callback := LegacyVariadicScalarCallback(my_variadic_scalar_i64)
	ctx.invoke_variadic_closure[LegacyVariadicScalarCallback, i64](callback)
}

type LegacyVariadicVoidCallback = fn (...vphp.VScalarValue)

fn print_variadic_scalar_args(args ...vphp.VScalarValue) {
	vphp.PhpOutput.line(my_variadic_scalar_string(...args))
}

@[php_function]
fn v_invoke_legacy_variadic_void(ctx vphp.Context) {
	ctx.invoke_variadic_closure_void[fn (...vphp.VScalarValue)](print_variadic_scalar_args)
}

@[php_function]
fn v_invoke_legacy_variadic_void_alias(ctx vphp.Context) {
	callback := LegacyVariadicVoidCallback(print_variadic_scalar_args)
	ctx.invoke_variadic_closure_void[LegacyVariadicVoidCallback](callback)
}

@[params]
pub struct VPhpLiteralParamsDemo {
	message  string         = 'a\n\t\x00\u263a\$\'\\"'
	raw      string         = r'\n${literal}'
	octal    int            = (-(0o17))
	binary   i64            = 0B1010_0001
	floating f64            = (2)
	single   f32            = 0.1
	option   ?string        = ('present')
	nullable ?int           = none
	items    []int          = [1, 0x10]
	empty    []string       = []string{}
	lookup   map[string]int = {
		'count': 0x10
	}
	tail     bool = true
}

fn describe_literal_params(params VPhpLiteralParamsDemo) string {
	option := params.option or { '<null>' }
	nullable := if value := params.nullable { value.str() } else { '<null>' }
	return '${params.message.bytes().hex()}|${params.raw}|${params.octal}|${params.binary}|${params.floating}|${f64(params.single)}|${option}|${nullable}|${params.items}|${params.empty}|${params.lookup}|${params.tail}'
}

@[php_function]
fn v_php_literal_params(params VPhpLiteralParamsDemo) string {
	return describe_literal_params(params)
}

@[php_method: 'literalParams']
pub fn CallableProcessor.literal_params(params VPhpLiteralParamsDemo) string {
	return describe_literal_params(params)
}

@[php_function]
fn v_get_struct_literal_defaults_closure() fn (VPhpLiteralParamsDemo) string {
	return describe_literal_params
}

@[params]
pub struct VPhpOverriddenParamsDemo {
	option   ?string = 'native option'
	spacer   string  = 'native spacer'
	count    int     = next_computed_params_value()
	nullable ?string = 'native nullable'
	items    vphp.PhpArray
	tail     bool = true
}

fn describe_overridden_params(prefix string, params VPhpOverriddenParamsDemo) string {
	option := params.option or { '<null>' }
	nullable := params.nullable or { '<null>' }
	return '${prefix}:${option}:${params.spacer}:${params.count}:${nullable}:${params.items.count()}:${params.tail}'
}

@[php_arg_default(option: '"php\tvalue"', count: 'VPHP_PARAMS_OVERRIDE_COUNT', nullable: 'null', items: '[1, 2]')]
@[php_function]
fn v_php_overridden_params(prefix string, params VPhpOverriddenParamsDemo) string {
	return describe_overridden_params(prefix, params)
}

@[php_arg_default(option: '"php\tvalue"', count: 'VPHP_PARAMS_OVERRIDE_COUNT', nullable: 'null', items: '[1, 2]')]
@[php_method: 'overriddenParams']
pub fn (p &CallableProcessor) overridden_params(ctx vphp.Context, params VPhpOverriddenParamsDemo) string {
	_ = ctx
	return describe_overridden_params(p.prefix, params)
}

fn describe_direct_defaults(count int, values ?vphp.PhpArray, label ?string, enabled bool) string {
	array := if present := values { present.to_json() } else { '<null>' }
	name := label or { '<null>' }
	return '${count}|${array}|${name}|${enabled}'
}

@[php_arg_default(count: 'VPHP_ORDINARY_ARG_COUNT', values: '[1, VPHP_ORDINARY_ARG_COUNT]', label: '"fallback"', enabled: 'true')]
@[php_function]
fn v_php_direct_defaults(prefix string, count int, values ?vphp.PhpArray, label ?string, enabled bool) string {
	return prefix + describe_direct_defaults(count, values, label, enabled)
}

@[php_arg_default(count: 'VPHP_ORDINARY_ARG_COUNT', values: '[1, VPHP_ORDINARY_ARG_COUNT]', label: '"fallback"', enabled: 'true')]
@[php_method: 'directDefaults']
pub fn CallableProcessor.direct_defaults(ctx vphp.Context, prefix string, count int, values ?vphp.PhpArray, label ?string, enabled bool) string {
	_ = ctx
	return prefix + describe_direct_defaults(count, values, label, enabled)
}

@[php_arg_default(before: '5', blocked: '9')]
@[php_arg_optional(blocked: false, tail: true)]
@[php_function]
fn v_php_legacy_optional_tail(before int, blocked int, tail int) string {
	return '${before}|${blocked}|${tail}'
}
