import rt

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.wc_option_name() string {
	return 'woocommerce_email_templates_%_post_id'
}

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group() string {
	return 'wc_block_email_templates'
}

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_expiration() rt.PhpVal {
	return rt.get_constant('WEEK_IN_SECONDS')
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
pub mut:
	post_id_to_email_type_cache rt.PhpVal = rt.new_array()
	email_class_name_cache      rt.PhpVal = rt.new_array()
}

fn init_static_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager() {
	rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager',
		'instance', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager',
		'instance')))
	{
		rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager',
			'instance', rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self',
			[]string{},
			create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_self()))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager',
		'instance')
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_emails_by_id() rt.PhpVal {
	mut iife_temp_0 :=
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails{}
	mut iife_result_0 := iife_temp_0.instance()
	mut var_all_emails := rt.call_method(iife_result_0, 'get_emails', []rt.PhpVal{})
	mut var_indexed := rt.new_array()
	mut iter_1 := var_all_emails.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_email := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_email, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email')))
			&& !(!rt.is_true(rt.get_property(var_email, 'id'))) {
			var_indexed.array_set(rt.get_property(var_email, 'id'), var_email.clone())
		}
	}
	return var_indexed.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_by_id(email_id string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(email_id))) {
		return rt.new_null()
	}
	return if !(this.get_emails_by_id().array_get(rt.new_string(email_id))).is_null() {
		this.get_emails_by_id().array_get(rt.new_string(email_id))
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_post(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	mut var_post_id := this.get_email_template_post_id(var_email_type_mutated.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_null()
	}
	mut var_post := rt.call_function('get_post', [var_post_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post,
		'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Post'))))))
	{
		return rt.new_null()
	}
	return var_post.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_from_post_id(var_post_id rt.PhpVal, skip_cache bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	if !rt.is_true(var_post_id_mutated) {
		return rt.new_null()
	}
	var_post_id_mutated = rt.new_int(var_post_id_mutated.to_i64())
	mut var_cache_key := rt.new_string(this.get_cache_key_for_post_id(var_post_id_mutated.clone()))
	if !var_skip_cache {
		if rt.is_true(rt.new_bool(this.post_id_to_email_type_cache.array_isset(var_post_id_mutated.clone()))) {
			return this.post_id_to_email_type_cache.array_get(var_post_id_mutated)
		}
		mut var_email_type := rt.call_function('wp_cache_get', [
			var_cache_key.clone(),
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group()])
		if !(!rt.is_true(var_email_type)) {
			this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type.clone())
			return var_email_type.clone()
		}
	}
	mut var_option_name := rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb,
				'options')),
				rt.new_string(' WHERE option_name LIKE %s AND option_value = %s LIMIT 1')),
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.wc_option_name(),
			var_post_id_mutated.clone(),
		]),
	])
	if !rt.is_true(var_option_name) {
		return rt.new_null()
	}
	var_email_type = this.get_email_type_from_option_name(var_option_name.clone())
	this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type.clone())
	rt.call_function('wp_cache_set', [var_cache_key.clone(), var_email_type.clone(),
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group(),
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_expiration()])
	return var_email_type.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) template_exists(var_email_type rt.PhpVal) bool {
	mut var_email_type_mutated := var_email_type
	return rt.new_bool(!rt.is_true(rt.identical(rt.new_null(),
		this.get_email_post(var_email_type_mutated.clone()))))
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) save_email_template_post_id(var_email_type rt.PhpVal, var_post_id rt.PhpVal) {
	mut var_email_type_mutated := var_email_type
	mut var_post_id_mutated := var_post_id
	mut var_option_name := this.get_option_name(var_email_type_mutated.clone())
	mut var_previous_id := rt.call_function('get_option', [var_option_name.clone()])
	rt.call_function('update_option', [var_option_name.clone(),
		var_post_id_mutated.clone()])
	if !(!rt.is_true(var_previous_id)) {
		this.invalidate_cache_for_template(rt.new_int(var_previous_id.to_i64()), 'post_id')
	}
	this.invalidate_cache_for_template(var_email_type_mutated.clone(), 'email_type')
	this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type_mutated.clone())
	rt.call_function('wp_cache_set', [
		rt.new_string(this.get_cache_key_for_post_id(var_post_id_mutated.clone())),
		var_email_type_mutated.clone(),
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group(),
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_expiration(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_template_post_id(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	mut var_post_id_from_cache := rt.call_function('array_search', [
		var_email_type_mutated.clone(), this.post_id_to_email_type_cache, rt.new_bool(true)])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_post_id_from_cache)))) {
		return var_post_id_from_cache.clone()
	}
	mut var_option_name := this.get_option_name(var_email_type_mutated.clone())
	mut var_post_id := rt.call_function('get_option', [var_option_name.clone()])
	if !(!rt.is_true(var_post_id)) {
		var_post_id = rt.new_int(var_post_id.to_i64())
		this.post_id_to_email_type_cache.array_set(var_post_id, var_email_type_mutated.clone())
	}
	return var_post_id.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) delete_email_template(var_email_type rt.PhpVal) {
	mut var_email_type_mutated := var_email_type
	mut var_option_name := this.get_option_name(var_email_type_mutated.clone())
	mut var_post_id := rt.call_function('get_option', [var_option_name.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return
	}
	rt.call_function('delete_option', [var_option_name.clone()])
	this.invalidate_cache_for_template(var_post_id.clone(), 'post_id')
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) invalidate_cache_for_template(var_value rt.PhpVal, type string) {
	mut var_post_id_array := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('post_id'), rt.new_string(type))) {
		var_post_id_array.array_push(rt.new_int(var_value.to_i64()))
	} else if rt.is_true(rt.identical(rt.new_string('email_type'), rt.new_string(type))) {
		var_post_id_array = rt.call_function('array_merge', [
			var_post_id_array.clone(),
			rt.call_function('array_unique', [
				rt.func_array_keys(this.post_id_to_email_type_cache, var_value.clone(),
					rt.new_bool(true)),
			])])
	}
	mut iter_2 := var_post_id_array.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_id := item_2.val
		this.post_id_to_email_type_cache.array_unset(var_post_id)
		mut var_cache_key := rt.new_string(this.get_cache_key_for_post_id(var_post_id.clone()))
		rt.call_function('wp_cache_delete', [var_cache_key.clone(),
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group()])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) clear_caches() {
	this.post_id_to_email_type_cache = rt.new_array()
	this.email_class_name_cache = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_cache_key_for_post_id(var_post_id rt.PhpVal) string {
	mut var_post_id_mutated := var_post_id
	return 'post_id_to_email_type_' + var_post_id_mutated.str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_option_name(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	return rt.call_function('str_replace', [rt.new_string('%'),
		var_email_type_mutated.clone(),
		Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.wc_option_name()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_from_option_name(var_option_name rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
	return rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_email_templates_' },
			rt.ArrayItem{ key: none, val: '_post_id' }]),
		rt.new_string(''),
		var_option_name_mutated.clone(),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_class_name_from_email_id(var_email_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_email_id) {
		return rt.new_null()
	}
	if this.email_class_name_cache.array_isset(var_email_id) {
		return this.email_class_name_cache.array_get(var_email_id)
	}
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}),
		'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	mut iter_3 := var_emails.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_email := item_3.val
		this.email_class_name_cache.array_set(rt.get_property(var_email, 'id'), rt.call_function('get_class', [
			var_email.clone(),
		]))
	}
	return if !(this.email_class_name_cache.array_get(var_email_id)).is_null() {
		this.email_class_name_cache.array_get(var_email_id)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_class_name_from_post_id(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	if !rt.is_true(var_post_id_mutated) {
		return rt.new_null()
	}
	return this.get_email_type_class_name_from_email_id(this.get_email_type_from_post_id(var_post_id_mutated.clone(),
		false))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase:               rt.PhpObjectBase{}
		post_id_to_email_type_cache: rt.new_array()
		email_class_name_cache:      rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wc_emails(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.get_instance()
		}
		'get_emails_by_id' {
			return this.get_emails_by_id()
		}
		'get_email_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_email_by_id(dispatch_arg_0)
		}
		'get_email_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_post(dispatch_arg_0)
		}
		'get_email_type_from_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.get_email_type_from_post_id(dispatch_arg_0, dispatch_arg_1)
		}
		'template_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.template_exists(dispatch_arg_0))
		}
		'save_email_template_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.save_email_template_post_id(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_email_template_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_template_post_id(dispatch_arg_0)
		}
		'delete_email_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_email_template(dispatch_arg_0)
			return rt.new_null()
		}
		'invalidate_cache_for_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.invalidate_cache_for_template(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'clear_caches' {
			this.clear_caches()
			return rt.new_null()
		}
		'get_cache_key_for_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_cache_key_for_post_id(dispatch_arg_0))
		}
		'get_option_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_option_name(dispatch_arg_0)
		}
		'get_email_type_from_option_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_type_from_option_name(dispatch_arg_0)
		}
		'get_email_type_class_name_from_email_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_type_class_name_from_email_id(dispatch_arg_0)
		}
		'get_email_type_class_name_from_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_email_type_class_name_from_post_id(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'post_id_to_email_type_cache' { return this.post_id_to_email_type_cache }
		'email_class_name_cache' { return this.email_class_name_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'post_id_to_email_type_cache' {
			this.post_id_to_email_type_cache = val
			return true
		}
		'email_class_name_cache' {
			this.email_class_name_cache = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
