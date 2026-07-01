import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor {
	rt.PhpObjectBase
pub mut:
	deferred_updates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) replace_token(new_content string) {
	this.set_bookmark(rt.new_string('here'))
	mut var_here := rt.get_property(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get('here')
	this.deferred_updates.array_push(create_wp_html_text_replacement(rt.get_property(var_here,
		'start'), rt.get_property(var_here, 'length'), rt.new_string(new_content).dup()))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) flush_updates() {
	{
		mut iter_1 := this.deferred_updates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_update := item_1.val
			mut var_key := item_1.key
			rt.get_property(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor', [
				'WP_HTML_Tag_Processor',
			], &this), 'lexical_updates').array_push(var_update.dup())
			this.deferred_updates.array_unset(var_key)
		}
	}
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Text_Replacement {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_html_tag_processor() &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor{
		PhpObjectBase:    rt.PhpObjectBase{}
		deferred_updates: rt.new_array()
	}
	return obj
}

fn create_wp_html_tag_processor() &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_text_replacement() &Class_WP_HTML_Text_Replacement {
	mut obj := &Class_WP_HTML_Text_Replacement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'replace_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.replace_token(dispatch_arg_0)
			return rt.new_null()
		}
		'flush_updates' {
			this.flush_updates()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'deferred_updates' { return this.deferred_updates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'deferred_updates' {
			this.deferred_updates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Text_Replacement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_personalizationtags_class_html_tag_processor_php() {
	// unsupported statement: Stmt_Declare
}
