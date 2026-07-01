import rt
import crypto.sha1

pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.backfill_complete_option() string {
	return 'woocommerce_email_template_sync_backfill_complete'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key() string {
	return '_wc_email_template_status'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key() string {
	return '_wc_email_template_source_hash'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.version_meta_key() string {
	return '_wc_email_template_version'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_synced_at_meta_key() string {
	return '_wc_email_last_synced_at'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.last_core_render_meta_key() string {
	return '_wc_email_template_last_core_render'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.backfilled_meta_key() string {
	return '_wc_email_backfilled'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync() string {
	return 'in_sync'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_uncustomized() string {
	return 'core_updated_uncustomized'
}
pub fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_customized() string {
	return 'core_updated_customized'
}
struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector {
	rt.PhpObjectBase
pub mut:
		logger rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.run_sweep()  {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return rt.new_null()
	}
	mut var_registry := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}; return temp.get_sync_enabled_emails() }()
	if !rt.is_true(var_registry) {
		return rt.new_null()
	}
	mut var_posts_manager := fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}; return temp.get_instance() }()
	mut var_canonical_emails := rt.call_method(var_posts_manager, 'get_emails_by_id', []rt.PhpVal{})
	{
		mut iter_1 := var_registry.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var__config := item_1.val
			mut var_email_id := item_1.key
			mut var_email := if !(var_canonical_emails.array_get(var_email_id)).is_null() { var_canonical_emails.array_get(var_email_id) } else { rt.new_null() }
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_email, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email')))))) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_post := rt.call_method(var_posts_manager, 'get_email_post', [// unsupported expression: Expr_Cast_String])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Post')))))) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_stored_source_hash := // unsupported expression: Expr_Cast_String
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(rt.new_string(''), var_stored_source_hash)) {
				rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger(), 'warning', [rt.call_function('sprintf', [rt.new_string('Email template divergence sweep skipped post %d for email "%s": no stored source hash.'), // unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_String]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'post_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'context', val: 'email_template_divergence_detector' }])])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_status := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.classify_post((// unsupported expression: Expr_Cast_Int).to_i64(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](var_email), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_array](rt.create_array([rt.ArrayItem{ key: 'post_content', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'stored_source_hash', val: var_stored_source_hash }])))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(rt.new_null(), var_status)) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			mut var_existing_status := // unsupported expression: Expr_Cast_String
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(var_existing_status, var_status)) {
				continue
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			rt.call_function('update_post_meta', [// unsupported expression: Expr_Cast_Int, Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key(), var_status.dup()])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Throwable') {
				mut var_e := var_e_1.dup()
				rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger(), 'error', [rt.call_function('sprintf', [rt.new_string('Email template divergence sweep failed for email "%s": %s'), // unsupported expression: Expr_Cast_String, rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: // unsupported expression: Expr_Cast_String }, rt.ArrayItem{ key: 'context', val: 'email_template_divergence_detector' }])])
				continue
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
			// unsupported statement: Stmt_Nop
		}
	}
	// unsupported statement: Stmt_Nop
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.classify_post(post_id i64, mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email, mut var_stamps Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_array) string {
	mut post_id_mutated := post_id
	mut var_email_mutated := var_email
	rt.new_int(post_id_mutated) = rt.new_null()
	mut var_current_core_hash := rt.new_string(rt.new_string(sha1.hexhash(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}; return temp.compute_canonical_post_content(arg_0) }(rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email', []string{}, var_email_mutated)).to_string())))
	mut var_current_post_hash := rt.new_string(rt.new_string(sha1.hexhash(// unsupported expression: Expr_Cast_String.to_string())))
	mut var_stored_source_hash := // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.is_sha1_hash((var_stored_source_hash).str()))))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.identical(var_current_core_hash, var_stored_source_hash)) {
		return (if rt.is_true(rt.identical(var_current_post_hash, var_stored_source_hash)) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync() } else { rt.new_null() }).str()
	}
	return (if rt.is_true(rt.identical(var_current_post_hash, var_stored_source_hash)) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_uncustomized() } else { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_customized() }).str()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.set_logger(mut var_logger Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.is_sha1_hash(hash string) bool {
	return 40 == hash.len && rt.is_true(rt.call_function('ctype_xdigit', [rt.new_string(hash)]))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatedivergencedetector() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector{
		PhpObjectBase: rt.PhpObjectBase{}
		logger: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry() &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{
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

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'run_sweep' {
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.run_sweep()
			return rt.new_null()
		}
		'classify_post' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.classify_post(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'set_logger' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface](if args.len > 0 { args[0] } else { rt.new_null() })
			Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.set_logger(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_logger' {
			return Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger()
		}
		'is_sha1_hash' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.is_sha1_hash(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'logger' { return this.logger }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'logger' { this.logger = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_src_internal_emaileditor_wctransactionalemails_wcemailtemplatedivergencedetector_php() {
	// unsupported statement: Stmt_Declare
}
