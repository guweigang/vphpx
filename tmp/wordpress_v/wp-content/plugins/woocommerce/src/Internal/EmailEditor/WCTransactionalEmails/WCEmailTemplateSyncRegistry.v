import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	rt.PhpObjectBase
pub mut:
		first_party_ids rt.PhpVal = rt.new_null()
		registry_cache rt.PhpVal = rt.new_null()
		logger rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_sync_enabled_emails() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_email_sync_config(email_id string) rt.PhpVal {
	mut var_registry := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_sync_enabled_emails()
	return if !(var_registry.array_get(email_id)).is_null() { var_registry.array_get(email_id) } else { rt.new_null() }
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.is_enabled(email_id string) bool {
	mut var_registry := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_sync_enabled_emails()
	return (rt.new_bool(var_registry.array_isset(rt.new_string(email_id)))).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.reset_cache()  {
	// unsupported assign target: Expr_StaticPropertyFetch
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.set_logger(mut var_logger Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.resolve() rt.PhpVal {
	mut var_eligible_ids := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{}; return temp.get_transactional_emails() }()
	if !rt.is_true(var_eligible_ids) {
		return rt.new_array()
	}
	mut var_emails_by_id := rt.call_method(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }(), 'get_emails_by_id', []rt.PhpVal{})
	mut var_registry := rt.new_array()
	{
		mut iter_1 := var_eligible_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_email_id := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_email_id.dup().is_string()))))) || rt.is_true(rt.identical(rt.new_string(''), var_email_id)))) {
				continue
			}
			mut var_email := if !(var_emails_by_id.array_get(var_email_id)).is_null() { var_emails_by_id.array_get(var_email_id) } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_null(), var_email)) {
				rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_logger(), 'notice', [rt.call_function('sprintf', [rt.new_string('Email template sync skipped for email "%s": no WC_Email subclass registered.'), var_email_id.dup()]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: var_email_id }, rt.ArrayItem{ key: 'context', val: 'email_template_sync_registry' }])])
				continue
			}
			mut var_source := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.classify_source((var_email_id).str())
			mut var_template_path := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}; return temp.resolve_block_template_path(arg_0) }(var_email.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_template_path)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [var_template_path.dup()]))))))) {
				rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_logger(), 'notice', [rt.call_function('sprintf', [rt.new_string('Email template sync skipped for email "%s": template path not resolvable. source=%s'), var_email_id.dup(), var_source.dup()]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: var_email_id }, rt.ArrayItem{ key: 'source', val: var_source }, rt.ArrayItem{ key: 'template_path', val: var_template_path }, rt.ArrayItem{ key: 'context', val: 'email_template_sync_registry' }])])
				continue
			}
			mut var_version := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.parse_version_header((var_template_path).str())
			if rt.is_true(rt.identical(rt.new_string(''), var_version)) {
				rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_logger(), 'warning', [rt.call_function('sprintf', [rt.new_string('Email template sync skipped for email "%s": missing @version header in %s. source=%s'), var_email_id.dup(), var_template_path.dup(), var_source.dup()]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: var_email_id }, rt.ArrayItem{ key: 'source', val: var_source }, rt.ArrayItem{ key: 'template_path', val: var_template_path }, rt.ArrayItem{ key: 'context', val: 'email_template_sync_registry' }])])
				continue
			}
			var_registry.array_set(var_email_id, rt.create_array([rt.ArrayItem{ key: 'version', val: var_version }, rt.ArrayItem{ key: 'template_path', val: var_template_path }, rt.ArrayItem{ key: 'source', val: var_source }]))
		}
	}
	return var_registry.dup()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.classify_source(email_id string) string {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return if rt.is_true(rt.call_function('in_array', [rt.new_string(email_id), // unsupported expression: Expr_StaticPropertyFetch, rt.new_bool(true)])) { 'core' } else { 'third_party' }
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.parse_version_header(file string) string {
	mut var_match := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_readable', [rt.new_string(file)]))))) {
		return ''
	}
	mut var_handle := rt.call_function('fopen', [rt.new_string(file), rt.new_string('r')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_handle)) {
		return ''
	}
	mut var_contents := rt.call_function('fread', [var_handle.dup(), rt.new_int(8192)])
	rt.call_function('fclose', [var_handle.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_contents)) {
		return ''
	}
	var_contents = rt.call_function('str_replace', [rt.new_string('\r'), rt.new_string('\n'), var_contents.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', ['/^[ \\t\\/*#@]*' + (rt.call_function('preg_quote', [rt.new_string('@version'), rt.new_string('/')])).str() + '(.*)$/mi', var_contents.dup(), var_match.dup()])) && !(!rt.is_true(var_match.array_get(1))))) {
		return rt.call_function('_cleanup_header_comment', [var_match.array_get(1)]).to_string().trim_space()
	}
	return ''
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_logger() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
		first_party_ids: rt.new_null()
		registry_cache: rt.new_null()
		logger: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemails() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_sync_enabled_emails' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_sync_enabled_emails()
		}
		'get_email_sync_config' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_email_sync_config(dispatch_arg_0)
		}
		'is_enabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.is_enabled(dispatch_arg_0))
		}
		'reset_cache' {
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.reset_cache()
			return rt.new_null()
		}
		'set_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.set_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'resolve' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.resolve()
		}
		'classify_source' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.classify_source(dispatch_arg_0))
		}
		'parse_version_header' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.parse_version_header(dispatch_arg_0))
		}
		'get_logger' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry.get_logger()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'first_party_ids' { return this.first_party_ids }
		'registry_cache' { return this.registry_cache }
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'first_party_ids' { this.first_party_ids = val; return true }
		'registry_cache' { this.registry_cache = val; return true }
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry_php() {
	// unsupported statement: Stmt_Declare
}
