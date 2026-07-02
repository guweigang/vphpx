import rt

struct Class_Automattic_WooCommerce_Blocks_Installer {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) init() {
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Installer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'install' },
		])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_create_pages'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Installer',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'create_pages' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) install() {
	this.maybe_create_tables()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) create_pages(var_pages rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string('<!-- wp:shortcode -->[woocommerce_cart]<!-- /wp:shortcode -->'), if !(var_pages.array_get(rt.new_string('cart')).array_get(rt.new_string('content'))).is_null() {
		var_pages.array_get(rt.new_string('cart')).array_get(rt.new_string('content'))
	} else {
		rt.new_null()
	}))
	{
		var_pages.array_get_mut('cart').array_set('content',
			'<!-- wp:woocommerce/classic-shortcode {"shortcode":"cart"} /-->')
	}
	if rt.is_true(rt.identical(rt.new_string('<!-- wp:shortcode -->[woocommerce_checkout]<!-- /wp:shortcode -->'), if !(var_pages.array_get(rt.new_string('checkout')).array_get(rt.new_string('content'))).is_null() {
		var_pages.array_get(rt.new_string('checkout')).array_get(rt.new_string('content'))
	} else {
		rt.new_null()
	}))
	{
		var_pages.array_get_mut('checkout').array_set('content',
			'<!-- wp:woocommerce/classic-shortcode {"shortcode":"checkout"} /-->')
	}
	return var_pages.clone()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) maybe_create_tables() rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_schema_version := rt.new_int(260)
	mut var_db_schema_version := rt.new_int((rt.call_function('get_option', [
		rt.new_string('wc_blocks_db_schema_version'),
		rt.new_int(0),
	])).to_i64())
	if rt.is_true(rt.greater_equal(var_db_schema_version, var_schema_version))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), var_db_schema_version)))) {
		return rt.new_null()
	}
	mut var_show_errors := rt.call_method(var_wpdb, 'hide_errors', []rt.PhpVal{})
	mut var_table_name := rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() +
		'wc_reserved_stock')
	mut var_collate := if rt.is_true(rt.call_method(var_wpdb, 'has_cap', [
		rt.new_string('collation'),
	]))
	{ rt.call_method(var_wpdb, 'get_charset_collate', []rt.PhpVal{}) } else { rt.new_string('') }
	mut var_exists := rt.new_bool(this.maybe_create_table(rt.new_string(
		(rt.get_property(var_wpdb, 'prefix')).str() + 'wc_reserved_stock'), rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tCREATE TABLE '), rt.get_property(var_wpdb,
		'prefix')),
		rt.new_string("wc_reserved_stock (\n\t\t\t\t`order_id` bigint(20) NOT NULL,\n\t\t\t\t`product_id` bigint(20) NOT NULL,\n\t\t\t\t`stock_quantity` double NOT NULL DEFAULT 0,\n\t\t\t\t`timestamp` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',\n\t\t\t\t`expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',\n\t\t\t\tPRIMARY KEY  (`order_id`, `product_id`),\n\t\t\t\tKEY product_id_expires (product_id, expires)\n\t\t\t) ")),
		var_collate), rt.new_string(';\n\t\t\t'))).str())))
	if rt.is_true(var_show_errors) {
		rt.call_method(var_wpdb, 'show_errors', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_exists)))) {
		this.add_create_table_notice(var_table_name.clone())
		return rt.new_null()
	}
	rt.call_function('update_option', [rt.new_string('wc_blocks_db_schema_version'),
		var_schema_version.clone()])
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) maybe_create_table(var_table_name rt.PhpVal, var_create_sql rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_table_name_mutated := var_table_name
	if rt.is_true(rt.call_function('in_array', [var_table_name_mutated.clone(),
		rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
				var_table_name_mutated.clone()]),
			rt.new_int(0),
		]),
		rt.new_bool(true)]))
	{
		return true
	}
	rt.call_method(var_wpdb, 'query', [var_create_sql.clone()])
	return (rt.call_function('in_array', [var_table_name_mutated.clone(),
		rt.call_method(var_wpdb, 'get_col', [
			rt.call_method(var_wpdb, 'prepare', [rt.new_string('SHOW TABLES LIKE %s'),
				var_table_name_mutated.clone()]),
			rt.new_int(0),
		]),
		rt.new_bool(true)])).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) add_create_table_notice(var_table_name rt.PhpVal) {
	mut var_table_name_mutated := var_table_name
	closure_1_fn := fn [var_table_name] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		print('<div class="error"><p>')
		rt.call_function('printf', [
			rt.call_function('esc_html__', [
				rt.new_string('WooCommerce %1$s table creation failed. Does the %2$s user have CREATE privileges on the %3$s database?'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<code>' +
				(rt.call_function('esc_html', [var_table_name_mutated.clone()])).str() + '</code>'),
			rt.new_string('<code>' +
				(rt.call_function('esc_html', [rt.get_constant('DB_USER')])).str() + '</code>'),
			rt.new_string('<code>' +
				(rt.call_function('esc_html', [rt.get_constant('DB_NAME')])).str() + '</code>'),
		])
		print('</p></div>')
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.new_closure(closure_1_fn)])
}

fn create_automattic_woocommerce_blocks_installer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Installer {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Installer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'install' {
			this.install()
			return rt.new_null()
		}
		'create_pages' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_pages(dispatch_arg_0)
		}
		'maybe_create_tables' {
			return this.maybe_create_tables()
		}
		'maybe_create_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.maybe_create_table(dispatch_arg_0, dispatch_arg_1))
		}
		'add_create_table_notice' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_create_table_notice(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Installer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Installer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
