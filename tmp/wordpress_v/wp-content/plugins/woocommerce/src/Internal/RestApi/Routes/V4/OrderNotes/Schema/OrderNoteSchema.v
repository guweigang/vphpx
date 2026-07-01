import rt

pub fn Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.identifier() string {
	return 'order_note'
}
struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema) get_item_schema_properties() rt.PhpVal {
	mut var_schema := rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order ID the note belongs to.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order note author.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order note was created, in the site\'s timezone.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The date the order note was created, as GMT.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'date-time' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order note content.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'required', val: true }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The title of the order note group.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'group', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The group of order note.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'is_customer_note', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('If true, the note will be shown to customers. If false, the note will be for admin reference only.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'context', val: Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema.view_edit_embed_context() }]) }])
	return var_schema.dup()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema) get_item_response(var_note rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_include_fields Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_array) rt.PhpVal {
	mut var_group := rt.call_function('get_comment_meta', [rt.get_property(var_note, 'comment_ID'), rt.new_string('note_group'), rt.new_bool(true)])
	mut var_title := rt.call_function('get_comment_meta', [rt.get_property(var_note, 'comment_ID'), rt.new_string('note_title'), rt.new_bool(true)])
	mut var_is_customer_note := rt.call_function('wc_string_to_bool', [rt.call_function('get_comment_meta', [rt.get_property(var_note, 'comment_ID'), rt.new_string('is_customer_note'), rt.new_bool(true)])])
	if rt.is_true(rt.new_bool(rt.is_true(var_group) && rt.is_true(rt.new_bool(!(rt.is_true(var_title)))))) {
		var_title = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup{}; return temp.get_default_group_title(arg_0) }(var_group.dup())
	}
	return rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'order_id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'author', val: rt.get_property(var_note, 'comment_author') }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_note, 'comment_date')]) }, rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_note, 'comment_date_gmt')]) }, rt.ArrayItem{ key: 'note', val: rt.get_property(var_note, 'comment_content') }, rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'group', val: var_group }, rt.ArrayItem{ key: 'is_customer_note', val: var_is_customer_note }])
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_ordernotes_schema_ordernoteschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractschema() &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_orders_ordernotegroup() &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup {
	mut obj := &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_item_schema_properties' {
			return this.get_item_schema_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Orders_OrderNoteGroup) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_restapi_routes_v4_ordernotes_schema_ordernoteschema_php() {
	// unsupported statement: Stmt_Declare
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}
