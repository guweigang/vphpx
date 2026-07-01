import rt

pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_error() string {
	return 'error'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning() string {
	return 'warning'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update() string {
	return 'update'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational() string {
	return 'info'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing() string {
	return 'marketing'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_survey() string {
	return 'survey'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_email() string {
	return 'email'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending() string {
	return 'pending'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() string {
	return 'unactioned'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned() string {
	return 'actioned'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_snoozed() string {
	return 'snoozed'
}
pub fn Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_sent() string {
	return 'sent'
}
struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
pub mut:
		object_type rt.PhpVal = rt.new_string('admin-note')
		cache_group rt.PhpVal = rt.new_string('admin-note')
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) construct(data string)  {
	this.dispatch_set_prop('data', rt.create_array([rt.ArrayItem{ key: 'name', val: '-' }, rt.ArrayItem{ key: 'type', val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational() }, rt.ArrayItem{ key: 'locale', val: 'en_US' }, rt.ArrayItem{ key: 'title', val: '-' }, rt.ArrayItem{ key: 'content', val: '-' }, rt.ArrayItem{ key: 'content_data', val: create_automattic_woocommerce_admin_notes_stdclass() }, rt.ArrayItem{ key: 'status', val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() }, rt.ArrayItem{ key: 'source', val: 'woocommerce' }, rt.ArrayItem{ key: 'date_created', val: '0000-00-00 00:00:00' }, rt.ArrayItem{ key: 'date_reminder', val: rt.new_null() }, rt.ArrayItem{ key: 'is_snoozable', val: false }, rt.ArrayItem{ key: 'actions', val: rt.new_array() }, rt.ArrayItem{ key: 'layout', val: 'plain' }, rt.ArrayItem{ key: 'image', val: '' }, rt.ArrayItem{ key: 'is_deleted', val: false }, rt.ArrayItem{ key: 'is_read', val: false }]))
	this.Class_Automattic_WooCommerce_Admin_Notes_WC_Data.construct(rt.new_string(data))
	if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(data), 'Automattic_WooCommerce_Admin_Notes_Note'))) {
		this.set_id(rt.call_function('absint', [rt.call_method(rt.new_string(data), 'get_id', []rt.PhpVal{})]))
	} else if rt.is_true(rt.new_bool(rt.new_string(data).is_long() || rt.new_string(data).is_double())) {
		this.set_id(rt.new_string(data))
	} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.new_string(data).is_object())) && !(!rt.is_true(rt.get_property(rt.new_string(data), 'note_id'))))) {
		this.set_id(rt.get_property(rt.new_string(data), 'note_id'))
		rt.get_property(rt.new_string(data), 'icon') = rt.new_null()
		this.set_props(rt.cast_array(rt.new_string(data)))
		this.set_object_read(rt.new_bool(true))
	} else {
		this.set_object_read(rt.new_bool(true))
	}
	this.dispatch_set_prop('data_store', fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.load_data_store() }())
	if rt.is_true(rt.greater(this.get_id(), rt.new_int(0))) {
		rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'data_store'), 'read', [rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this)])
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) apply_changes()  {
	this.dispatch_set_prop('data', rt.call_function('array_replace_recursive', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'data'), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'changes')]))
	if rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'changes').array_isset(rt.new_string('actions')) {
		rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'data').array_set('actions', rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'changes').array_get('actions'))
	}
	this.dispatch_set_prop('changes', rt.new_array())
}

fn Class_Automattic_WooCommerce_Admin_Notes_Note.get_deprecated_types() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_email() }])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_types() rt.PhpVal {
	mut var_allowed_types := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_error() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_survey() }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_note_types'), var_allowed_types.dup()])
}

fn Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_statuses() rt.PhpVal {
	mut var_allowed_statuses := rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_snoozed() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Admin_Notes_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_sent() }])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_note_statuses'), var_allowed_statuses.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_Notes_Note', ['Automattic_WooCommerce_Admin_Notes_WC_Data'], &this), 'data')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_name(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('name'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_type(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('type'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_locale(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('locale'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_title(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('title'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_content(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('content'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_content_data(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('content_data'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_status(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('status'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_source(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('source'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_date_created(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_created'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_date_reminder(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('date_reminder'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_is_snoozable(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('is_snoozable'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_actions(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('actions'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_action(var_action_name rt.PhpVal, context string) rt.PhpVal {
	mut var_actions := this.get_prop(rt.new_string('actions'), rt.new_string(context))
	mut var_matching_action := rt.new_null()
	{
		mut iter_1 := var_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.identical(rt.get_property(var_action, 'name'), var_action_name)) {
				// unsupported expression: Expr_AssignRef
				break
			}
		}
	}
	return var_matching_action.dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_layout(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('layout'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_image(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('image'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_is_deleted(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('is_deleted'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) get_is_read(context string) rt.PhpVal {
	return this.get_prop(rt.new_string('is_read'), rt.new_string(context))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_name(var_name rt.PhpVal)  {
	mut var_name_mutated := var_name
	if !rt.is_true(var_name_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note name prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('name'), var_name_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_type(var_type rt.PhpVal)  {
	if !rt.is_true(var_type) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note type prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.call_function('in_array', [var_type.dup(), Class_Automattic_WooCommerce_Admin_Notes_Note.get_deprecated_types(), rt.new_bool(true)])) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note type prop is deprecated.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_type.dup(), Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_types(), rt.new_bool(true)]))))) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The admin note type prop (%s) is not one of the supported types.'), rt.new_string('woocommerce')]), var_type.dup()]))
	}
	this.set_prop(rt.new_string('type'), var_type.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_locale(var_locale rt.PhpVal)  {
	if !rt.is_true(var_locale) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note locale prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('locale'), var_locale.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_title(var_title rt.PhpVal)  {
	if !rt.is_true(var_title) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note title prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('title'), var_title.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_icon(var_icon rt.PhpVal)  {
	rt.call_function('wc_deprecated_function', [rt.new_string('set_icon'), rt.new_string('4.3')])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_content(var_content rt.PhpVal)  {
	mut var_content_mutated := var_content
	mut var_allowed_html := rt.create_array([rt.ArrayItem{ key: 'br', val: rt.new_array() }, rt.ArrayItem{ key: 'em', val: rt.new_array() }, rt.ArrayItem{ key: 'strong', val: rt.new_array() }, rt.ArrayItem{ key: 'a', val: rt.create_array([rt.ArrayItem{ key: 'href', val: true }, rt.ArrayItem{ key: 'rel', val: true }, rt.ArrayItem{ key: 'name', val: true }, rt.ArrayItem{ key: 'target', val: true }, rt.ArrayItem{ key: 'download', val: rt.create_array([rt.ArrayItem{ key: 'valueless', val: 'y' }]) }]) }, rt.ArrayItem{ key: 'p', val: rt.new_array() }])
	var_content_mutated = rt.call_function('wp_kses', [var_content_mutated.dup(), var_allowed_html.dup()])
	if !rt.is_true(var_content_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note content prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('content'), var_content_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_content_data(var_content_data rt.PhpVal)  {
	mut var_allowed_type := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_content_data, 'Automattic_WooCommerce_Admin_Notes_stdClass')))))) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note content_data prop must be an instance of stdClass.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('content_data'), var_content_data.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_status(var_status rt.PhpVal)  {
	mut var_status_mutated := var_status
	if !rt.is_true(var_status_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note status prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_status_mutated.dup(), Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_statuses(), rt.new_bool(true)]))))) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The admin note status prop (%s) is not one of the supported statuses.'), rt.new_string('woocommerce')]), var_status_mutated.dup()]))
	}
	this.set_prop(rt.new_string('status'), var_status_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_source(var_source rt.PhpVal)  {
	if !rt.is_true(var_source) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note source prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	this.set_prop(rt.new_string('source'), var_source.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_date_created(var_date rt.PhpVal)  {
	mut var_date_mutated := var_date
	if !rt.is_true(var_date_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note date prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_mutated.dup().is_string())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_date_mutated.dup().is_long() || var_date_mutated.dup().is_double()))))))) {
		var_date_mutated = rt.call_function('wc_string_to_timestamp', [var_date_mutated.dup()])
	}
	this.set_date_prop(rt.new_string('date_created'), var_date_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_date_reminder(var_date rt.PhpVal)  {
	mut var_date_mutated := var_date
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_date_mutated.dup().is_string())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_date_mutated.dup().is_long() || var_date_mutated.dup().is_double()))))))) {
		var_date_mutated = rt.call_function('wc_string_to_timestamp', [var_date_mutated.dup()])
	}
	this.set_date_prop(rt.new_string('date_reminder'), var_date_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_is_snoozable(var_is_snoozable rt.PhpVal) rt.PhpVal {
	return this.set_prop(rt.new_string('is_snoozable'), var_is_snoozable.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) clear_actions()  {
	this.set_prop(rt.new_string('actions'), rt.new_array())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_layout(var_layout rt.PhpVal)  {
	mut var_layout_mutated := var_layout
	if !rt.is_true(var_layout_mutated) {
		var_layout_mutated = rt.new_string(rt.new_string('plain'))
	}
	mut var_valid_layouts := rt.create_array([rt.ArrayItem{ key: none, val: 'plain' }, rt.ArrayItem{ key: none, val: 'thumbnail' }])
	if rt.is_true(rt.call_function('in_array', [var_layout_mutated.dup(), var_valid_layouts.dup(), rt.new_bool(true)])) {
		this.set_prop(rt.new_string('layout'), var_layout_mutated.dup())
	} else {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note layout has a wrong prop value.'), rt.new_string('woocommerce')]))
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_image(var_image rt.PhpVal)  {
	this.set_prop(rt.new_string('image'), var_image.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_is_deleted(var_is_deleted rt.PhpVal)  {
	this.set_prop(rt.new_string('is_deleted'), var_is_deleted.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_is_read(var_is_read rt.PhpVal)  {
	this.set_prop(rt.new_string('is_read'), var_is_read.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) add_action(var_name rt.PhpVal, var_label rt.PhpVal, url string, var_status rt.PhpVal, primary bool, actioned_text string)  {
	mut var_name_mutated := var_name
	mut var_label_mutated := var_label
	mut var_status_mutated := var_status
	mut actioned_text_mutated := actioned_text
	var_name_mutated = rt.call_function('wc_clean', [var_name_mutated.dup()])
	var_label_mutated = rt.call_function('wc_clean', [var_label_mutated.dup()])
	mut var_query := rt.call_function('esc_url_raw', [rt.new_string(url)])
	var_status_mutated = rt.call_function('wc_clean', [var_status_mutated.dup()])
	actioned_text_mutated = (rt.call_function('wc_clean', [rt.new_string(actioned_text_mutated).dup()])).str()
	if !rt.is_true(var_name_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note action name prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	if !rt.is_true(var_label_mutated) {
		this.error(rt.new_string('admin_note_invalid_data'), rt.call_function('__', [rt.new_string('The admin note action label prop cannot be empty.'), rt.new_string('woocommerce')]))
	}
	mut var_action := rt.create_array([rt.ArrayItem{ key: 'name', val: var_name_mutated }, rt.ArrayItem{ key: 'label', val: var_label_mutated }, rt.ArrayItem{ key: 'query', val: var_query }, rt.ArrayItem{ key: 'status', val: var_status_mutated }, rt.ArrayItem{ key: 'actioned_text', val: actioned_text_mutated }, rt.ArrayItem{ key: 'nonce_name', val: rt.new_null() }, rt.ArrayItem{ key: 'nonce_action', val: rt.new_null() }])
	mut var_note_actions := this.get_prop(rt.new_string('actions'), rt.new_string('edit'))
	var_note_actions.array_push(// unsupported expression: Expr_Cast_Object)
	this.set_prop(rt.new_string('actions'), var_note_actions.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) set_actions(var_actions rt.PhpVal)  {
	mut var_actions_mutated := var_actions
	this.set_prop(rt.new_string('actions'), var_actions_mutated.dup())
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) add_nonce_to_action(note_action_name string, nonce_action string, nonce_name string)  {
	mut var_actions := this.get_prop(rt.new_string('actions'), rt.new_string('edit'))
	mut var_matching_action := rt.new_null()
	{
		mut iter_1 := var_actions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_action := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.identical(rt.get_property(, 'name'), rt.new_string(note_action_name))) {
				// unsupported expression: Expr_AssignRef
			}
		}
	}
	if !rt.is_true(var_matching_action) {
		
	}
	
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Data {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_stdClass {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_note(data string) &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
		object_type: rt.new_string('admin-note')
		cache_group: rt.new_string('admin-note')
	}
	obj.construct(data)
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_data() &Class_Automattic_WooCommerce_Admin_Notes_WC_Data {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_stdclass() &Class_Automattic_WooCommerce_Admin_Notes_stdClass {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'apply_changes' {
			this.apply_changes()
			return rt.new_null()
		}
		'get_deprecated_types' {
			return Class_Automattic_WooCommerce_Admin_Notes_Note.get_deprecated_types()
		}
		'get_allowed_types' {
			return Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_types()
		}
		'get_allowed_statuses' {
			return Class_Automattic_WooCommerce_Admin_Notes_Note.get_allowed_statuses()
		}
		'get_data' {
			return this.get_data()
		}
		'get_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_name(dispatch_arg_0)
		}
		'get_type' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_type(dispatch_arg_0)
		}
		'get_locale' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_locale(dispatch_arg_0)
		}
		'get_title' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_title(dispatch_arg_0)
		}
		'get_content' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_content(dispatch_arg_0)
		}
		'get_content_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_content_data(dispatch_arg_0)
		}
		'get_status' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_status(dispatch_arg_0)
		}
		'get_source' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_source(dispatch_arg_0)
		}
		'get_date_created' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_created(dispatch_arg_0)
		}
		'get_date_reminder' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_date_reminder(dispatch_arg_0)
		}
		'get_is_snoozable' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_is_snoozable(dispatch_arg_0)
		}
		'get_actions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_actions(dispatch_arg_0)
		}
		'get_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_action(dispatch_arg_0, dispatch_arg_1)
		}
		'get_layout' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_layout(dispatch_arg_0)
		}
		'get_image' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_image(dispatch_arg_0)
		}
		'get_is_deleted' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_is_deleted(dispatch_arg_0)
		}
		'get_is_read' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_is_read(dispatch_arg_0)
		}
		'set_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_name(dispatch_arg_0)
			return rt.new_null()
		}
		'set_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_type(dispatch_arg_0)
			return rt.new_null()
		}
		'set_locale' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_locale(dispatch_arg_0)
			return rt.new_null()
		}
		'set_title' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_title(dispatch_arg_0)
			return rt.new_null()
		}
		'set_icon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_icon(dispatch_arg_0)
			return rt.new_null()
		}
		'set_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_content(dispatch_arg_0)
			return rt.new_null()
		}
		'set_content_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_content_data(dispatch_arg_0)
			return rt.new_null()
		}
		'set_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_status(dispatch_arg_0)
			return rt.new_null()
		}
		'set_source' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_source(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_created' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_created(dispatch_arg_0)
			return rt.new_null()
		}
		'set_date_reminder' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_date_reminder(dispatch_arg_0)
			return rt.new_null()
		}
		'set_is_snoozable' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_is_snoozable(dispatch_arg_0)
		}
		'clear_actions' {
			this.clear_actions()
			return rt.new_null()
		}
		'set_layout' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_layout(dispatch_arg_0)
			return rt.new_null()
		}
		'set_image' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_image(dispatch_arg_0)
			return rt.new_null()
		}
		'set_is_deleted' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_is_deleted(dispatch_arg_0)
			return rt.new_null()
		}
		'set_is_read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_is_read(dispatch_arg_0)
			return rt.new_null()
		}
		'add_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_bool()
			dispatch_arg_5 := (if args.len > 5 { args[5] } else { rt.new_null() }).str()
			this.add_action(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'set_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_actions(dispatch_arg_0)
			return rt.new_null()
		}
		'add_nonce_to_action' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			this.add_nonce_to_action(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'object_type' { return this.object_type }
		'cache_group' { return this.cache_group }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'object_type' { this.object_type = val; return true }
		'cache_group' { this.cache_group = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_notes_note_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
