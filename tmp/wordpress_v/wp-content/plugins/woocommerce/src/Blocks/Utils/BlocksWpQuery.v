import rt
import crypto.md5

struct Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) construct(query string) {
	if !(query == '') {
		this.init()
		this.dispatch_set_prop('query', rt.call_function('wp_parse_args', [
			rt.new_string(query),
		]))
		this.dispatch_set_prop('query_vars', rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery', [
			'WP_Query',
		], &this), 'query'))
		this.parse_query_vars()
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) get_cached_posts(transient_version string) rt.PhpVal {
	mut var_hash := rt.new_string(rt.new_string(md5.hexhash(rt.call_function('wp_json_encode', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery', [
			'WP_Query',
		], &this), 'query_vars'),
	]).to_string())))
	mut var_transient_name := rt.new_string('wc_blocks_query_' + var_hash.str())
	mut var_transient_value := rt.call_function('get_transient', [
		var_transient_name.dup()])
	if rt.is_true(rt.new_bool(!var_transient_value.is_null()
		&& var_transient_value.array_isset(rt.new_string('version'))
		&& var_transient_value.array_isset(rt.new_string('value'))
		&& rt.is_true(rt.identical(var_transient_value.array_get('version'), rt.new_string(transient_version)))))
	{
		return var_transient_value.array_get('value')
	}
	mut var_results := this.get_posts()
	rt.call_function('set_transient', [var_transient_name.dup(),
		rt.create_array([rt.ArrayItem{ key: 'version', val: transient_version },
			rt.ArrayItem{ key: 'value', val: var_results }]),
		rt.mul(rt.get_constant('DAY_IN_SECONDS'), rt.new_int(30))])
	return var_results.dup()
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_utils_blockswpquery(query string) &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(query)
	return obj
}

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'get_cached_posts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_cached_posts(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_BlocksWpQuery) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_utils_blockswpquery_php() {
}
