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
}

fn init_static_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatedivergencedetector() {
		rt.init_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector', 'logger', rt.new_null())
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.run_sweep() {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('yes'), rt.call_function('get_option', [Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.backfill_complete_option()]))))) {
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{}
	mut iife_result_0 := iife_temp_0.get_sync_enabled_emails()
	mut var_registry := iife_result_0
	if !rt.is_true(var_registry) {
		return
	}
	mut iife_temp_1 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_posts_manager := iife_result_1
	mut var_canonical_emails := rt.call_method(var_posts_manager, 'get_emails_by_id', []rt.PhpVal{})
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
		mut var_post := rt.call_method(var_posts_manager, 'get_email_post', [rt.new_string((var_email_id).str())])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WP_Post')))))) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_stored_source_hash := rt.new_string((rt.call_function('get_post_meta', [rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.source_hash_meta_key(), rt.new_bool(true)])).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.identical(rt.new_string(''), var_stored_source_hash)) {
			rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger(), 'warning', [rt.call_function('sprintf', [rt.new_string('Email template divergence sweep skipped post %d for email "%s": no stored source hash.'), rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), rt.new_string((var_email_id).str())]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: (var_email_id).str() }, rt.ArrayItem{ key: 'post_id', val: rt.new_int((rt.get_property(var_post, 'ID')).to_i64()) }, rt.ArrayItem{ key: 'context', val: 'email_template_divergence_detector' }])])
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_status := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.classify_post(rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email](var_email), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_array](rt.create_array([rt.ArrayItem{ key: 'post_content', val: (rt.get_property(var_post, 'post_content')).str() }, rt.ArrayItem{ key: 'stored_source_hash', val: var_stored_source_hash }])))
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.identical(rt.new_null(), var_status)) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		mut var_existing_status := rt.new_string((rt.call_function('get_post_meta', [rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key(), rt.new_bool(true)])).str())
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		if rt.is_true(rt.identical(var_existing_status, var_status)) {
			continue
			if rt.has_exception() { unsafe { goto catch_label_1 } }
		}
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		rt.call_function('update_post_meta', [rt.new_int((rt.get_property(var_post, 'ID')).to_i64()), Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_meta_key(), var_status.clone()])
		if rt.has_exception() { unsafe { goto catch_label_1 } }
		unsafe { goto end_label_1 }

catch_label_1:
		mut var_e_1 := rt.get_and_clear_exception()
		if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Throwable') {
			mut var_e := var_e_1.clone()
			rt.call_method(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger(), 'error', [rt.call_function('sprintf', [rt.new_string('Email template divergence sweep failed for email "%s": %s'), rt.new_string((var_email_id).str()), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'email_id', val: (var_email_id).str() }, rt.ArrayItem{ key: 'context', val: 'email_template_divergence_detector' }])])
			continue
			unsafe { goto end_label_1 }
		}
		else {
			rt.throw_exception(var_e_1)
			unsafe { goto end_label_1 }
		}

end_label_1:
	}
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.classify_post(post_id i64, mut var_email Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email, mut var_stamps Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_array) string {
	mut post_id_mutated := post_id
	mut var_email_mutated := var_email
	rt.new_int(post_id_mutated) = rt.new_null()
	mut iife_temp_2 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}
	mut iife_result_2 := iife_temp_2.compute_canonical_post_content(rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email', []string{}, var_email_mutated))
	mut iife_temp_3 := Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{}
	mut iife_result_3 := iife_temp_3.compute_canonical_post_content(rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WC_Email', []string{}, var_email_mutated))
	mut var_current_core_hash := rt.new_string(sha1.hexhash(iife_result_3.to_string()))
	mut var_current_post_hash := rt.new_string(sha1.hexhash((if !(var_stamps.array_get(rt.new_string('post_content'))).is_null() { var_stamps.array_get(rt.new_string('post_content')) } else { rt.new_string('') }).str()))
	mut var_stored_source_hash := rt.new_string((if !(var_stamps.array_get(rt.new_string('stored_source_hash'))).is_null() { var_stamps.array_get(rt.new_string('stored_source_hash')) } else { rt.new_string('') }).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.is_sha1_hash((var_stored_source_hash).str()))))) {
		return (rt.new_null()).str()
	}
	if rt.is_true(rt.identical(var_current_core_hash, var_stored_source_hash)) {
		return (if rt.is_true(rt.identical(var_current_post_hash, var_stored_source_hash)) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_in_sync() } else { rt.new_null() }).str()
	}
	return (if rt.is_true(rt.identical(var_current_post_hash, var_stored_source_hash)) { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_uncustomized() } else { Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.status_core_updated_customized() }).str()
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.set_logger(mut var_logger Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_?Email_Editor_Logger_Interface) {
	rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector', 'logger', var_logger)
}

fn Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector.get_logger() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector', 'logger'))) {
		rt.set_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector', 'logger', rt.new_object('Automattic_WooCommerce_Internal_EmailEditor_Logger', []string{}, create_automattic_woocommerce_internal_emaileditor_logger(rt.call_function('wc_get_logger', []rt.PhpVal{}))))
	}
	return rt.get_static_prop('Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector', 'logger')
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

struct Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatedivergencedetector(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wcemailtemplatesyncregistry(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateSyncRegistry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsmanager(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsManager{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_wctransactionalemails_wctransactionalemailpostsgenerator(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCTransactionalEmailPostsGenerator{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_logger(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger{
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
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_WCTransactionalEmails_WCEmailTemplateDivergenceDetector) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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


fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_Logger) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
