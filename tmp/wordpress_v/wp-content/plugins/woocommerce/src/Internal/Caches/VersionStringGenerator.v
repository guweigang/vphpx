import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group() string {
	return 'woocommerce_version_strings'
}
struct Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator {
	rt.PhpObjectBase
pub mut:
		can_use rt.PhpVal = rt.new_null()
		legacy_proxy rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) init(mut var_legacy_proxy Class_Automattic_WooCommerce_Proxies_LegacyProxy)  {
	this.legacy_proxy = var_legacy_proxy.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) can_use() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.can_use.is_null()))))) {
		return (this.can_use).to_bool()
	}
	this.can_use = if !(rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('wp_using_ext_object_cache')])).is_null() { rt.call_method(this.legacy_proxy, 'call_function', [rt.new_string('wp_using_ext_object_cache')]) } else { rt.new_bool(false) }
	return (this.can_use).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) get_version(id string, generate bool) string {
	this.validate_input(id)
	mut var_cache_key := rt.new_string(this.get_cache_key(id))
	mut var_version := rt.call_function('wp_cache_get', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_version)) {
		if !(var_generate) {
			return (rt.new_null()).str()
		}
		var_version = rt.new_string(this.generate_version(id))
	} else {
		this.store_version(id, (var_version).str())
	}
	return (var_version).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) generate_version(id string) string {
	this.validate_input(id)
	mut var_version := rt.call_function('wp_generate_uuid4', []rt.PhpVal{})
	this.store_version(id, (var_version).str())
	return (var_version).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) store_version(id string, version string) bool {
	mut version_mutated := version
	mut var_cache_key := rt.new_string(this.get_cache_key(id))
	mut var_ttl := rt.call_function('apply_filters', [rt.new_string('woocommerce_version_string_generator_ttl'), rt.get_constant('DAY_IN_SECONDS'), rt.new_string(id)])
	var_ttl = rt.call_function('max', [rt.new_int(0), // unsupported expression: Expr_Cast_Int])
	mut var_result := rt.call_function('wp_cache_set', [var_cache_key.dup(), rt.new_string(version_mutated).dup(), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group(), var_ttl.dup()])
	if rt.is_true(rt.new_bool(var_result.dup().is_bool())) {
		return (var_result).to_bool()
	}
	mut var_stored_value := rt.call_function('wp_cache_get', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group()])
	if rt.is_true(rt.identical(var_stored_value, rt.new_string(version_mutated))) {
		return true
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('wp_cache_delete', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group()])
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) delete_version(id string) bool {
	this.validate_input(id)
	mut var_cache_key := rt.new_string(this.get_cache_key(id))
	mut var_result := rt.call_function('wp_cache_delete', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_Caches_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator.cache_group()])
	return rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_result.dup().is_bool()))))) || rt.is_true(var_result)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) get_cache_key(id string) string {
	return 'wc_version_string_' + md5.hexhash(id)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) validate_input(id string)  {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(id))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_Caches_InvalidArgumentException', []string{}, create_automattic_woocommerce_internal_caches_invalidargumentexception(rt.new_string('ID cannot be empty.'))))
	}
}

struct Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_caches_versionstringgenerator() &Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
		can_use: rt.new_null()
		legacy_proxy: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_caches_invalidargumentexception() &Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException {
	mut obj := &Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Proxies_LegacyProxy](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init(mut dispatch_arg_0)
			return rt.new_null()
		}
		'can_use' {
			return rt.new_bool(this.can_use())
		}
		'get_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_string(this.get_version(dispatch_arg_0, dispatch_arg_1))
		}
		'generate_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.generate_version(dispatch_arg_0))
		}
		'store_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.store_version(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_version' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.delete_version(dispatch_arg_0))
		}
		'get_cache_key' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.get_cache_key(dispatch_arg_0))
		}
		'validate_input' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.validate_input(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'can_use' { return this.can_use }
		'legacy_proxy' { return this.legacy_proxy }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_VersionStringGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'can_use' { this.can_use = val; return true }
		'legacy_proxy' { this.legacy_proxy = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Caches_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_caches_versionstringgenerator_php() {
	// unsupported statement: Stmt_Declare
}
