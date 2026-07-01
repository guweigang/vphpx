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
		instance rt.PhpVal = rt.new_null()
		post_id_to_email_type_cache rt.PhpVal = rt.new_array()
		email_class_name_cache rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_emails_by_id() rt.PhpVal {
	mut var_all_emails := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails{}; return temp.instance() }(), 'get_emails', []rt.PhpVal{})
	mut var_indexed := rt.new_array()
	{
		mut iter_1 := var_all_emails.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_email, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email'))) && !(!rt.is_true(rt.get_property(var_email, 'id'))))) {
				var_indexed.array_set(rt.get_property(var_email, 'id'), var_email.dup())
			}
		}
	}
	return var_indexed.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_by_id(email_id string) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(email_id))) {
		return rt.new_null()
	}
	return if !(this.get_emails_by_id().array_get(email_id)).is_null() { this.get_emails_by_id().array_get(email_id) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_post(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	mut var_post_id := this.get_email_template_post_id(var_email_type_mutated.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_null()
	}
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Post')))))) {
		return rt.new_null()
	}
	return var_post.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_from_post_id(var_post_id rt.PhpVal, skip_cache bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_post_id_mutated := var_post_id
	if !rt.is_true(var_post_id_mutated) {
		return rt.new_null()
	}
	var_post_id_mutated = // unsupported expression: Expr_Cast_Int
	mut var_cache_key := rt.new_string(this.get_cache_key_for_post_id(var_post_id_mutated.dup()))
	if !(var_skip_cache) {
		if rt.is_true(rt.new_bool(this.post_id_to_email_type_cache.array_isset(var_post_id_mutated.dup()))) {
			return this.post_id_to_email_type_cache.array_get(var_post_id_mutated)
		}
		mut var_email_type := rt.call_function('wp_cache_get', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group()])
		if !(!rt.is_true(var_email_type)) {
			this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type.dup())
			return var_email_type.dup()
		}
	}
	// unsupported statement: Stmt_Global
	mut var_option_name := rt.call_method(var_wpdb, 'get_var', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT option_name FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name LIKE %s AND option_value = %s LIMIT 1')), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.wc_option_name(), var_post_id_mutated.dup()])])
	if !rt.is_true(var_option_name) {
		return rt.new_null()
	}
	var_email_type = this.get_email_type_from_option_name(var_option_name.dup())
	this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type.dup())
	rt.call_function('wp_cache_set', [var_cache_key.dup(), var_email_type.dup(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_expiration()])
	return var_email_type.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) template_exists(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	return // unsupported expression: Expr_BinaryOp_NotIdentical
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) save_email_template_post_id(var_email_type rt.PhpVal, var_post_id rt.PhpVal)  {
	mut var_email_type_mutated := var_email_type
	mut var_post_id_mutated := var_post_id
	mut var_option_name := this.get_option_name(var_email_type_mutated.dup())
	mut var_previous_id := rt.call_function('get_option', [var_option_name.dup()])
	rt.call_function('update_option', [var_option_name.dup(), var_post_id_mutated.dup()])
	if !(!rt.is_true(var_previous_id)) {
		this.invalidate_cache_for_template(// unsupported expression: Expr_Cast_Int, 'post_id')
	}
	this.invalidate_cache_for_template(var_email_type_mutated.dup(), 'email_type')
	this.post_id_to_email_type_cache.array_set(var_post_id_mutated, var_email_type_mutated.dup())
	rt.call_function('wp_cache_set', [this.get_cache_key_for_post_id(var_post_id_mutated.dup()), var_email_type_mutated.dup(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_expiration()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_template_post_id(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	mut var_post_id_from_cache := rt.call_function('array_search', [var_email_type_mutated.dup(), this.post_id_to_email_type_cache, rt.new_bool(true)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_post_id_from_cache.dup()
	}
	mut var_option_name := this.get_option_name(var_email_type_mutated.dup())
	mut var_post_id := rt.call_function('get_option', [var_option_name.dup()])
	if !(!rt.is_true(var_post_id)) {
		var_post_id = // unsupported expression: Expr_Cast_Int
		this.post_id_to_email_type_cache.array_set(var_post_id, var_email_type_mutated.dup())
	}
	return var_post_id.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) delete_email_template(var_email_type rt.PhpVal)  {
	mut var_email_type_mutated := var_email_type
	mut var_option_name := this.get_option_name(var_email_type_mutated.dup())
	mut var_post_id := rt.call_function('get_option', [var_option_name.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		return rt.new_null()
	}
	rt.call_function('delete_option', [var_option_name.dup()])
	this.invalidate_cache_for_template(var_post_id.dup(), 'post_id')
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) invalidate_cache_for_template(var_value rt.PhpVal, type string)  {
	mut var_post_id_array := rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('post_id'), rt.new_string(type))) {
		var_post_id_array.array_push(// unsupported expression: Expr_Cast_Int)
	} else if rt.is_true(rt.identical(rt.new_string('email_type'), rt.new_string(type))) {
		var_post_id_array = rt.call_function('array_merge', [var_post_id_array.dup(), rt.call_function('array_unique', [rt.func_array_keys(this.post_id_to_email_type_cache, var_value.dup(), rt.new_bool(true))])])
	}
	{
		mut iter_1 := var_post_id_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_id := item_1.val
			this.post_id_to_email_type_cache.array_unset(var_post_id)
			mut var_cache_key := rt.new_string(this.get_cache_key_for_post_id(var_post_id.dup()))
			rt.call_function('wp_cache_delete', [var_cache_key.dup(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.cache_group()])
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) clear_caches()  {
	this.post_id_to_email_type_cache = rt.new_array()
	this.email_class_name_cache = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_cache_key_for_post_id(var_post_id rt.PhpVal) string {
	mut var_post_id_mutated := var_post_id
	return 'post_id_to_email_type_' + (var_post_id_mutated).str()
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_option_name(var_email_type rt.PhpVal) rt.PhpVal {
	mut var_email_type_mutated := var_email_type
	return rt.call_function('str_replace', [rt.new_string('%'), var_email_type_mutated.dup(), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager.wc_option_name()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_from_option_name(var_option_name rt.PhpVal) rt.PhpVal {
	mut var_option_name_mutated := var_option_name
	return rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_email_templates_' }, rt.ArrayItem{ key: none, val: '_post_id' }]), rt.new_string(''), var_option_name_mutated.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_class_name_from_email_id(var_email_id rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_email_id) {
		return rt.new_null()
	}
	if this.email_class_name_cache.array_isset(var_email_id) {
		return this.email_class_name_cache.array_get(var_email_id)
	}
	mut var_emails := rt.call_method(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'mailer', []rt.PhpVal{}), 'get_emails', []rt.PhpVal{})
	{
		mut iter_1 := var_emails.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email := item_1.val
			this.email_class_name_cache.array_set(rt.get_property(var_email, 'id'), rt.call_function('get_class', [var_email.dup()]))
		}
	}
	return if !(this.email_class_name_cache.array_get(var_email_id)).is_null() { this.email_class_name_cache.array_get(var_email_id) } else { rt.new_null() }
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) get_email_type_class_name_from_post_id(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	if !rt.is_true(var_post_id_mutated) {
		return rt.new_null()
	}
	return this.get_email_type_class_name_from_email_id(this.get_email_type_from_post_id(var_post_id_mutated.dup(), false))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
		instance: rt.new_null()
		post_id_to_email_type_cache: rt.new_array()
		email_class_name_cache: rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wc_emails() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Emails {
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
			return this.template_exists(dispatch_arg_0)
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
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'instance' { return this.instance }
		'post_id_to_email_type_cache' { return this.post_id_to_email_type_cache }
		'email_class_name_cache' { return this.email_class_name_cache }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'instance' { this.instance = val; return true }
		'post_id_to_email_type_cache' { this.post_id_to_email_type_cache = val; return true }
		'email_class_name_cache' { this.email_class_name_cache = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager_php() {
	// unsupported statement: Stmt_Declare
}
