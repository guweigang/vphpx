import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Utilities_CallbackUtil {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_callback_signature(var_callback rt.PhpVal) string {
	if rt.is_true(rt.new_bool(var_callback.dup().is_string())) {
		return var_callback.str()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_callback.dup().is_array()))
		&& 2 == var_callback.dup().array_count()))
	{
		mut var_target := var_callback.array_get(0)
		mut var_method := var_callback.array_get(1)
		if rt.is_true(rt.new_bool(
			rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_target.dup().is_object()))
			|| rt.is_true(rt.new_bool(var_target.dup().is_string()))))
			&& rt.is_true(rt.new_bool(var_method.dup().is_string()))))
		{
			mut var_class := if rt.is_true(rt.new_bool(var_target.dup().is_object())) { rt.call_function('get_class', [
					var_target.dup(),
				]) } else { var_target }
			return '${var_class.to_string()}::${var_method.to_string()}'
		}
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_callback,
		'Automattic_WooCommerce_Utilities_Closure')))
	{
		return (Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_closure_signature(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_Closure](var_callback))).str()
		unsafe {
			goto end_label_1
		}
		catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Utilities_Exception') {
			mut var_e := var_e_1.dup()
			return 'Closure@' + (rt.call_function('spl_object_hash', [var_callback.dup()])).str()
			unsafe {
				goto end_label_1
			}
		} else {
			rt.throw_exception(var_e_1)
			unsafe {
				goto end_label_1
			}
		}

		end_label_1:
	}
	if rt.is_true(rt.new_bool(var_callback.dup().is_object())) {
		return (Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_invokable_signature(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_object](var_callback))).str()
		unsafe {
			goto end_label_2
		}
		catch_label_2:
		mut var_e_2 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_2, 'Automattic_WooCommerce_Utilities_Exception') {
			mut var_e := var_e_2.dup()
			return (rt.call_function('get_class', [var_callback.dup()])).str() + '::__invoke'
			unsafe {
				goto end_label_2
			}
		} else {
			rt.throw_exception(var_e_2)
			unsafe {
				goto end_label_2
			}
		}

		end_label_2:
	}
	return (rt.call_function('serialize', [var_callback.dup()])).str()
}

fn Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_hook_callback_signatures(hook_name string) rt.PhpVal {
	mut var_wp_filter := rt.new_null()
	mut var_callback_data := rt.new_null()
	// unsupported statement: Stmt_Global
	if !(var_wp_filter.array_isset(rt.new_string(hook_name))) {
		return rt.new_array()
	}
	mut var_result := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_wp_filter.array_get(hook_name), 'callbacks').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_priority_callbacks := item_1.val
			mut var_priority := item_1.key
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
					mut var_callback_data := if args.len > 0 { args[0].dup() } else { rt.new_null() }
					return Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_callback_signature(var_callback_data.array_get('function'))
				}
				mut var_callback_data := if args.len > 0 { args[0].dup() } else { rt.new_null() }
				return Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_callback_signature(var_callback_data.array_get('function'))
			}
			var_result.array_set(var_priority, rt.call_function('array_map', [
				rt.new_closure(closure_1_fn),
				rt.call_function('array_values', [var_priority_callbacks.dup()]),
			]))
		}
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_closure_signature(mut var_closure Class_Automattic_WooCommerce_Utilities_Closure) string {
	mut var_reflection :=
		create_automattic_woocommerce_utilities_reflectionfunction(var_closure.dup())
	mut var_file := var_reflection.getfilename()
	mut var_start := var_reflection.getstartline()
	mut var_end := var_reflection.getendline()
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_file))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_start))))
		|| rt.is_true(rt.identical(rt.new_bool(false), var_end))))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Utilities_ReflectionException',
			[]string{},
			create_automattic_woocommerce_utilities_reflectionexception(rt.new_string('Unable to get closure location information'))))
	}
	return (rt.call_function('sprintf', [rt.new_string('Closure@%s:%d-%d'),
		var_file.dup(), var_start.dup(), var_end.dup()])).str()
}

fn Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_invokable_signature(mut var_invokable Class_Automattic_WooCommerce_Utilities_object) string {
	mut var_method := create_automattic_woocommerce_utilities_reflectionmethod(var_invokable.dup(),
		rt.new_string('__invoke'))
	mut var_class := rt.call_method(var_method, 'getDeclaringClass', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_class, 'isAnonymous', []rt.PhpVal{}))))) {
		return (rt.call_method(var_class, 'getName', []rt.PhpVal{})).str() + '::__invoke'
	}
	return (rt.call_function('sprintf', [
		rt.new_string('class@anonymous[%s]::__invoke@%s:%d-%d'),
		rt.new_string(md5.hexhash(rt.call_method(var_class, 'getName', []rt.PhpVal{}).to_string())),
		rt.call_method(var_method, 'getFileName', []rt.PhpVal{}),
		rt.call_method(var_method, 'getStartLine', []rt.PhpVal{}),
		rt.call_method(var_method, 'getEndLine', []rt.PhpVal{}),
	])).str()
}

struct Class_Automattic_WooCommerce_Utilities_ReflectionFunction {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ReflectionException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_ReflectionMethod {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_callbackutil() &Class_Automattic_WooCommerce_Utilities_CallbackUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_CallbackUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_reflectionfunction() &Class_Automattic_WooCommerce_Utilities_ReflectionFunction {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ReflectionFunction{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_reflectionexception() &Class_Automattic_WooCommerce_Utilities_ReflectionException {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ReflectionException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_reflectionmethod() &Class_Automattic_WooCommerce_Utilities_ReflectionMethod {
	mut obj := &Class_Automattic_WooCommerce_Utilities_ReflectionMethod{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_CallbackUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_callback_signature' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_callback_signature(dispatch_arg_0))
		}
		'get_hook_callback_signatures' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_hook_callback_signatures(dispatch_arg_0)
		}
		'get_closure_signature' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_Closure](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_closure_signature(mut dispatch_arg_0))
		}
		'get_invokable_signature' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Utilities_object](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Utilities_CallbackUtil.get_invokable_signature(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Utilities_CallbackUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_CallbackUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionFunction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ReflectionFunction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionFunction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ReflectionException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionMethod) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_ReflectionMethod) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_ReflectionMethod) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_utilities_callbackutil_php() {
	// unsupported statement: Stmt_Declare
}
