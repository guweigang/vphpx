import rt
import crypto.md5

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.modes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled()
		},
	])
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled() string {
	return 'disabled'
}

pub fn Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_enabled() string {
	return 'enabled'
}

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register {
	rt.PhpObjectBase
pub mut:
	mode_option rt.PhpVal = rt.new_string('wc_downloads_approved_directories_mode')
	cache       rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) init() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_SyncUI.class(),
		]), 'init_hooks', []rt.PhpVal{})
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Admin_UI.class(),
		]), 'init_hooks', []rt.PhpVal{})
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.new_closure(closure_1_fn)])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Synchronize.class(),
		]), 'init_hooks', []rt.PhpVal{})
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('before_woocommerce_init'),
		rt.new_closure(closure_2_fn)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) get_table() string {
	mut var_wpdb := rt.new_null()
	return (rt.get_property(var_wpdb, 'prefix')).str() + 'wc_product_download_directories'
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) get_mode() string {
	mut var_current_mode := rt.call_function('get_option', [this.mode_option,
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled()])
	return (if rt.is_true(rt.call_function('in_array', [var_current_mode.clone(),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.modes(),
		rt.new_bool(true)]))
	{
		var_current_mode
	} else {
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.mode_disabled()
	}).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) set_mode(mode string) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string(mode),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register.modes(),
		rt.new_bool(true),
	])))))
	{
		return false
	}
	rt.call_function('update_option', [this.mode_option, rt.new_string(mode)])
	return (rt.identical(rt.call_function('get_option', [this.mode_option]), rt.new_string(mode))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) add_approved_directory(url string, enabled bool) i64 {
	mut var_wpdb := rt.new_null()
	mut url_mutated := url
	mut enabled_mutated := enabled
	url_mutated = this.prepare_url_for_upsert(url_mutated)
	mut var_existing := rt.new_bool(this.get_by_url(url_mutated))
	if rt.is_true(var_existing) {
		return (rt.call_method(var_existing, 'get_id', []rt.PhpVal{})).to_i64()
	}
	mut var_insert_fields := rt.create_array([
		rt.ArrayItem{ key: 'url', val: url_mutated },
		rt.ArrayItem{ key: 'enabled', val: i64(enabled_mutated) },
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb,
		'insert', [rt.new_string(this.get_table()), var_insert_fields.clone()])))))
	{
		this.cache = rt.new_null()
		return (rt.get_property(var_wpdb, 'insert_id')).to_i64()
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException',
		[]string{}, create_automattic_woocommerce_internal_productdownloads_approveddirectories_approveddirectoriesexception(rt.call_function('__', [
		rt.new_string('URL could not be added (probable database error).'),
		rt.new_string('woocommerce'),
	]),
		Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException.db_error())))
	return i64(0)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) update_approved_directory(id i64, url string, enabled bool) bool {
	mut var_wpdb := rt.new_null()
	mut url_mutated := url
	mut enabled_mutated := enabled
	url_mutated = this.prepare_url_for_upsert(url_mutated)
	mut var_existing_path := rt.new_bool(this.get_by_url(url_mutated))
	if rt.is_true(var_existing_path)
		&& rt.is_true(rt.identical(rt.call_method(var_existing_path, 'get_url', []rt.PhpVal{}), rt.new_string(url_mutated)))
		&& rt.is_true(rt.identical(rt.new_bool(enabled_mutated), rt.call_method(var_existing_path, 'is_enabled', []rt.PhpVal{}))) {
		return true
	}
	mut var_fields := rt.create_array([rt.ArrayItem{ key: 'url', val: url_mutated },
		rt.ArrayItem{ key: 'enabled', val: i64(enabled_mutated) }])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_method(var_wpdb, 'update', [
		rt.new_string(this.get_table()),
		var_fields.clone(),
		rt.create_array([rt.ArrayItem{ key: 'url_id', val: id }]),
	])))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException',
			[]string{}, create_automattic_woocommerce_internal_productdownloads_approveddirectories_approveddirectoriesexception(rt.call_function('__', [
			rt.new_string('URL could not be updated (probable database error).'),
			rt.new_string('woocommerce'),
		]),
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException.db_error())))
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) approved_directory_exists(url string) bool {
	mut url_mutated := url
	return this.get_by_url(url_mutated)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) get_by_id(id i64) bool {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_string(this.get_table())
	mut var_result := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_table.to_string()} WHERE url_id = %d'),
			rt.create_array([rt.ArrayItem{ key: none, val: id }]),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	return (create_automattic_woocommerce_internal_productdownloads_approveddirectories_storedurl(rt.get_property(var_result,
		'url_id'), rt.get_property(var_result, 'url'), rt.get_property(var_result, 'enabled'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) get_by_url(url string) bool {
	mut var_wpdb := rt.new_null()
	mut url_mutated := url
	mut var_table := rt.new_string(this.get_table())
	url_mutated = (rt.call_function('trailingslashit', [rt.new_string(url_mutated).clone()])).str()
	mut var_result := rt.call_method(var_wpdb, 'get_row', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT * FROM ${var_table.to_string()} WHERE url = %s'),
			rt.create_array([rt.ArrayItem{ key: none, val: url_mutated }]),
		]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return false
	}
	return (create_automattic_woocommerce_internal_productdownloads_approveddirectories_storedurl(rt.get_property(var_result,
		'url_id'), rt.get_property(var_result, 'url'), rt.get_property(var_result, 'enabled'))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) is_valid_path(download_url string) bool {
	mut var_wpdb := rt.new_null()
	mut var_url_cache_key := rt.new_string('url:' + download_url)
	if this.cache.array_isset(var_url_cache_key) {
		return (this.cache.array_get(var_url_cache_key)).to_bool()
	}
	mut var_url :=
		create_automattic_woocommerce_internal_utilities_url(this.normalize_url(download_url))
	mut var_parents := rt.call_method(var_url, 'get_all_parent_urls', []rt.PhpVal{})
	if !(!rt.is_true(var_parents)) {
		rt.call_function('sort', [var_parents.clone()])
		mut var_parents_sql := rt.new_string("'" +
			(rt.call_function('implode', [rt.new_string("','"), rt.call_function('array_map', [rt.new_string('esc_sql'), var_parents.clone()])])).str() +
			"'")
		mut var_parents_cache_key := rt.new_string('parents:' +
			md5.hexhash(var_parents_sql.clone().to_string()))
		if !(this.cache.array_isset(var_parents_cache_key)) {
			this.cache.array_set(var_parents_cache_key, (rt.call_method(var_wpdb, 'get_var', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT 1\n\t\t\t\t\t FROM `'),
					this.get_table()),
					rt.new_string('`\n\t\t\t\t\t WHERE enabled = 1 AND url IN (')), var_parents_sql),
					rt.new_string(')')),
			])).to_bool())
		}
		this.cache.array_set(var_url_cache_key, this.cache.array_get(var_parents_cache_key))
	} else {
		this.cache.array_set(var_url_cache_key, false)
	}
	return (this.cache.array_get(var_url_cache_key)).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) prepare_url_for_upsert(url string) string {
	mut url_mutated := url
	url_mutated = (rt.call_function('trailingslashit', [
		rt.new_string(this.normalize_url(url_mutated)),
	])).str()
	if rt.is_true(rt.greater(rt.call_function('mb_strlen', [rt.new_string(url_mutated).clone()]),
		rt.new_int(256)))
	{
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException',
			[]string{}, create_automattic_woocommerce_internal_productdownloads_approveddirectories_approveddirectoriesexception(rt.call_function('__', [
			rt.new_string('Approved directory URLs cannot be longer than 256 characters.'),
			rt.new_string('woocommerce'),
		]),
			Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException.invalid_url())))
	}
	return url_mutated
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) normalize_url(url string) string {
	mut url_mutated := url
	url_mutated = (rt.call_function('untrailingslashit', [
		rt.new_string(url_mutated.trim_space()),
	])).str()
	return (rt.call_method(create_automattic_woocommerce_internal_utilities_url(rt.new_string(url_mutated).clone()),
		'get_url', []rt.PhpVal{})).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) list(mut var_args Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'enabled', val: rt.new_null() },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'order_by', val: 'url' },
			rt.ArrayItem{ key: 'page', val: 1 }, rt.ArrayItem{ key: 'per_page', val: 20 },
			rt.ArrayItem{ key: 'search', val: '' }]),
		var_args_mutated,
	])
	mut var_table := rt.new_string(this.get_table())
	mut var_paths := rt.new_array()
	mut var_order := if rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get(rt.new_string('order')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'ASC' },
			rt.ArrayItem{ key: none, val: 'DESC' }]),
		rt.new_bool(true),
	]))
	{ var_args_mutated.array_get(rt.new_string('order')) } else { rt.new_string('ASC') }
	mut var_order_by := if rt.is_true(rt.call_function('in_array', [
		var_args_mutated.array_get(rt.new_string('order_by')),
		rt.create_array([rt.ArrayItem{ key: none, val: 'url_id' },
			rt.ArrayItem{ key: none, val: 'url' }]),
		rt.new_bool(true),
	]))
	{ var_args_mutated.array_get(rt.new_string('order_by')) } else { rt.new_string('url') }
	mut var_page := rt.call_function('absint', [var_args_mutated.array_get(rt.new_string('page'))])
	mut var_per_page := rt.call_function('absint', [
		var_args_mutated.array_get(rt.new_string('per_page')),
	])
	mut var_enabled := if var_args_mutated.array_get(rt.new_string('enabled')).is_bool() {
		var_args_mutated.array_get(rt.new_string('enabled'))
	} else {
		rt.new_null()
	}
	mut var_search := rt.new_string('%' +
		(rt.call_method(var_wpdb, 'esc_like', [rt.call_function('sanitize_text_field', [var_args_mutated.array_get(rt.new_string('search'))])])).str() +
		'%')
	if rt.is_true(rt.less(var_page, rt.new_int(1))) {
		var_page = rt.new_int(1)
	}
	if rt.is_true(rt.less(var_per_page, rt.new_int(1))) {
		var_per_page = rt.new_int(1)
	}
	mut var_where := rt.new_array()
	mut var_where_sql := rt.new_string('')
	if !(!rt.is_true(var_search)) {
		var_where.array_push(rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('url LIKE %s'),
			var_search.clone(),
		]))
	}
	if rt.is_true(rt.new_bool(var_enabled.clone().is_bool())) {
		var_where.array_push('enabled = ' + rt.new_int(var_enabled.to_i64()).str())
	}
	if !(!rt.is_true(var_where)) {
		var_where_sql = rt.new_string('WHERE ' +
			(rt.call_function('join', [rt.new_string(' AND '), var_where.clone()])).str())
	}
	mut var_limit_sql := rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('LIMIT %d, %d'),
		rt.mul(rt.sub(var_page, rt.new_int(1)), var_per_page),
		var_per_page.clone(),
	])
	mut var_results := rt.call_method(var_wpdb, 'get_results', [
		rt.new_string('\n\t\t\t\tSELECT   url_id, url, enabled\n\t\t\t\tFROM     ${var_table.to_string()}\n\t\t\t\t${var_where_sql.to_string()}\n\t\t\t\tORDER BY ${var_order_by.to_string()} ${var_order.to_string()}\n\t\t\t\t${var_limit_sql.to_string()}\n\t\t\t'),
	])
	mut var_total_rows := rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.new_string('SELECT COUNT( * ) FROM ${var_table.to_string()} ${var_where_sql.to_string()}'),
	])).to_i64())
	mut iter_1 := var_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_single_result := item_1.val
		var_paths.array_push(create_automattic_woocommerce_internal_productdownloads_approveddirectories_storedurl(rt.get_property(var_single_result,
			'url_id'), rt.get_property(var_single_result, 'url'), rt.get_property(var_single_result,
			'enabled')))
	}
	return rt.create_array([rt.ArrayItem{ key: 'total_urls', val: var_total_rows },
		rt.ArrayItem{ key: 'total_pages', val: rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_rows, var_per_page),
		])).to_i64()) }, rt.ArrayItem{ key: 'approved_directories', val: var_paths }])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) delete_by_id(id i64) bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'delete', [
		rt.new_string(this.get_table()),
		rt.create_array([rt.ArrayItem{ key: 'url_id', val: id }]),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) delete_all() bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.new_string('DELETE FROM '), this.get_table()),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) enable_by_id(id i64) bool {
	mut var_wpdb := rt.new_null()
	mut var_table := rt.new_string(this.get_table())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'update', [
		var_table.clone(),
		rt.create_array([rt.ArrayItem{ key: 'enabled', val: 1 }]),
		rt.create_array([rt.ArrayItem{ key: 'url_id', val: id }]),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) disable_by_id(id i64) bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'update', [
		rt.new_string(this.get_table()),
		rt.create_array([rt.ArrayItem{ key: 'enabled', val: 0 }]),
		rt.create_array([rt.ArrayItem{ key: 'url_id', val: id }]),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) enable_all() bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), this.get_table()),
			rt.new_string(' SET enabled = 1')),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) disable_all() bool {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wpdb, 'query', [
		rt.concat(rt.concat(rt.new_string('UPDATE '), this.get_table()),
			rt.new_string(' SET enabled = 0')),
	])))))
	{
		return false
	}
	this.cache = rt.new_null()
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) count(enabled bool) i64 {
	mut var_wpdb := rt.new_null()
	mut enabled_mutated := enabled
	mut var_table := rt.new_string(this.get_table())
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT COUNT(*) FROM ${var_table.to_string()} WHERE enabled = %d'),
			rt.new_int(if rt.is_true(rt.new_bool(enabled_mutated)) { 1 } else { 0 }),
		]),
	])).to_i64())
}

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Utilities_URL {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_register(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register{
		PhpObjectBase: rt.PhpObjectBase{}
		mode_option:   rt.new_string('wc_downloads_approved_directories_mode')
		cache:         rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_approveddirectoriesexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_productdownloads_approveddirectories_storedurl(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_utilities_url(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Utilities_URL {
	mut obj := &Class_Automattic_WooCommerce_Internal_Utilities_URL{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_table' {
			return rt.new_string(this.get_table())
		}
		'get_mode' {
			return rt.new_string(this.get_mode())
		}
		'set_mode' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_mode(dispatch_arg_0))
		}
		'add_approved_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.add_approved_directory(dispatch_arg_0, dispatch_arg_1))
		}
		'update_approved_directory' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.update_approved_directory(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'approved_directory_exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.approved_directory_exists(dispatch_arg_0))
		}
		'get_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.get_by_id(dispatch_arg_0))
		}
		'get_by_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.get_by_url(dispatch_arg_0))
		}
		'is_valid_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.is_valid_path(dispatch_arg_0))
		}
		'prepare_url_for_upsert' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.prepare_url_for_upsert(dispatch_arg_0))
		}
		'normalize_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.normalize_url(dispatch_arg_0))
		}
		'list' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.list(mut dispatch_arg_0)
		}
		'delete_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.delete_by_id(dispatch_arg_0))
		}
		'delete_all' {
			return rt.new_bool(this.delete_all())
		}
		'enable_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.enable_by_id(dispatch_arg_0))
		}
		'disable_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(this.disable_by_id(dispatch_arg_0))
		}
		'enable_all' {
			return rt.new_bool(this.enable_all())
		}
		'disable_all' {
			return rt.new_bool(this.disable_all())
		}
		'count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_int(this.count(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mode_option' { return this.mode_option }
		'cache' { return this.cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_Register) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mode_option' {
			this.mode_option = val
			return true
		}
		'cache' {
			this.cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_ApprovedDirectoriesException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductDownloads_ApprovedDirectories_StoredUrl) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Utilities_URL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
