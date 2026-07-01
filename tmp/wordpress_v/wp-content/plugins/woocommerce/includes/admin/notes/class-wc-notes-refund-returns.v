import rt

pub fn Class_WC_Notes_Refund_Returns.note_name() string {
	return 'wc-refund-returns-page'
}
struct Class_WC_Notes_Refund_Returns {
	rt.PhpObjectBase
}

fn Class_WC_Notes_Refund_Returns.init()  {
	rt.call_function('add_action', [rt.new_string('woocommerce_newly_installed'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'on_newly_installed' }])])
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_note_from_db'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'get_note_from_db' }]), rt.new_int(10), rt.new_int(1)])
}

fn Class_WC_Notes_Refund_Returns.on_newly_installed()  {
	mut var_page_id := rt.call_function('get_option', [rt.new_string('woocommerce_refund_returns_page_id')])
	if rt.is_true(var_page_id) {
		Class_WC_Notes_Refund_Returns.possibly_add_note(var_page_id.dup())
	}
}

fn Class_WC_Notes_Refund_Returns.possibly_add_note(var_page_id rt.PhpVal)  {
	mut var_page_id_mutated := var_page_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'is_wc_admin_active', []rt.PhpVal{}))))) {
		return rt.new_null()
	}
	mut var_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('admin-note'))
	mut var_note_id := rt.call_method(var_data_store, 'get_notes_with_name', [Class_WC_Notes_Refund_Returns.note_name()])
	if !(!rt.is_true(var_note_id)) {
		mut var_note := create_automattic_woocommerce_admin_notes_note(var_note_id.dup())
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(rt.identical(Class_{"nodeType":"Expr_Variable","line":62,"name":"note"}.e_wc_admin_note_actioned(), rt.call_method(var_note, 'get_status', []rt.PhpVal{}))))) {
			return rt.new_null()
		}
	}
	var_note = Class_WC_Notes_Refund_Returns.get_note(var_page_id_mutated.dup())
	rt.call_method(var_note, 'save', []rt.PhpVal{})
	rt.call_function('delete_option', [rt.new_string('woocommerce_refund_returns_page_created')])
}

fn Class_WC_Notes_Refund_Returns.get_note(var_page_id rt.PhpVal) rt.PhpVal {
	mut var_page_id_mutated := var_page_id
	mut var_note := create_automattic_woocommerce_admin_notes_note()
	rt.call_method(var_note, 'set_title', [rt.call_function('__', [rt.new_string('Setup a Refund and Returns Policy page to boost your store\'s credibility.'), rt.new_string('woocommerce')])])
	rt.call_method(var_note, 'set_content', [rt.call_function('__', [rt.new_string('We have created a sample draft Refund and Returns Policy page for you. Please have a look and update it to fit your store.'), rt.new_string('woocommerce')])])
	rt.call_method(var_note, 'set_type', [Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational()])
	rt.call_method(var_note, 'set_name', [Class_WC_Notes_Refund_Returns.note_name()])
	rt.call_method(var_note, 'set_content_data', [// unsupported expression: Expr_Cast_Object])
	rt.call_method(var_note, 'set_source', [rt.new_string('woocommerce-core')])
	rt.call_method(var_note, 'add_action', [rt.new_string('notify-refund-returns-page'), rt.call_function('__', [rt.new_string('Edit page'), rt.new_string('woocommerce')]), rt.call_function('admin_url', [rt.call_function('sprintf', [rt.new_string('post.php?post=%d&action=edit'), // unsupported expression: Expr_Cast_Int])])])
	return var_note.dup()
}

fn Class_WC_Notes_Refund_Returns.get_note_from_db(var_note_from_db rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_note_from_db, 'Automattic_WooCommerce_Admin_Notes_Note')))))) || rt.is_true(rt.identical(rt.call_function('get_user_locale', []rt.PhpVal{}), rt.call_method(var_note_from_db, 'get_locale', []rt.PhpVal{}))))) {
		return var_note_from_db.dup()
	}
	if rt.is_true(rt.identical(Class_WC_Notes_Refund_Returns.note_name(), rt.call_method(var_note_from_db, 'get_name', []rt.PhpVal{}))) {
		mut var_note := Class_WC_Notes_Refund_Returns.get_note(rt.new_int(0))
		rt.call_method(var_note_from_db, 'set_title', [rt.call_method(var_note, 'get_title', []rt.PhpVal{})])
		rt.call_method(var_note_from_db, 'set_content', [rt.call_method(var_note, 'get_content', []rt.PhpVal{})])
		mut var_action_from_db := rt.call_method(var_note_from_db, 'get_action', [rt.new_string('notify-refund-returns-page')])
		mut var_action_from_class := rt.call_method(var_note, 'get_action', [rt.new_string('notify-refund-returns-page')])
		if rt.is_true(rt.new_bool(rt.is_true(var_action_from_db) && rt.is_true(var_action_from_class))) {
			rt.set_property(var_action_from_db, 'label', rt.get_property(var_action_from_class, 'label'))
			rt.call_method(var_note_from_db, 'set_actions', [rt.create_array([rt.ArrayItem{ key: none, val: var_action_from_db }])])
		}
	}
	return var_note_from_db.dup()
}

struct Class_WC_Data_Store {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Note {
	rt.PhpObjectBase
}

fn create_wc_notes_refund_returns() &Class_WC_Notes_Refund_Returns {
	mut obj := &Class_WC_Notes_Refund_Returns{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_data_store() &Class_WC_Data_Store {
	mut obj := &Class_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_note() &Class_Automattic_WooCommerce_Admin_Notes_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Notes_Refund_Returns) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Notes_Refund_Returns.init()
			return rt.new_null()
		}
		'on_newly_installed' {
			Class_WC_Notes_Refund_Returns.on_newly_installed()
			return rt.new_null()
		}
		'possibly_add_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Notes_Refund_Returns.possibly_add_note(dispatch_arg_0)
			return rt.new_null()
		}
		'get_note' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Notes_Refund_Returns.get_note(dispatch_arg_0)
		}
		'get_note_from_db' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Notes_Refund_Returns.get_note_from_db(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Notes_Refund_Returns) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Notes_Refund_Returns) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_admin_notes_class_wc_notes_refund_returns_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
