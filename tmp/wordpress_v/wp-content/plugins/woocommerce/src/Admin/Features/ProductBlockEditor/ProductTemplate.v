import rt

struct Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate {
	rt.PhpObjectBase
pub mut:
	id                    rt.PhpVal = rt.new_null()
	title                 rt.PhpVal = rt.new_null()
	product_data          rt.PhpVal = rt.new_null()
	order                 rt.PhpVal = rt.new_int(999)
	layout_template_id    rt.PhpVal = rt.new_null()
	description           rt.PhpVal = rt.new_null()
	icon                  rt.PhpVal = rt.new_null()
	is_selectable_by_user rt.PhpVal = rt.new_bool(true)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) construct(mut var_data Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array) {
	this.id = var_data.array_get('id')
	this.title = var_data.array_get('title')
	this.product_data = var_data.array_get('product_data')
	if var_data.array_isset(rt.new_string('order')) {
		this.order = var_data.array_get('order')
	}
	if var_data.array_isset(rt.new_string('layout_template_id')) {
		this.layout_template_id = var_data.array_get('layout_template_id')
	}
	if var_data.array_isset(rt.new_string('description')) {
		this.description = var_data.array_get('description')
	}
	if var_data.array_isset(rt.new_string('icon')) {
		this.icon = var_data.array_get('icon')
	}
	if var_data.array_isset(rt.new_string('is_selectable_by_user')) {
		this.is_selectable_by_user = var_data.array_get('is_selectable_by_user')
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_id() rt.PhpVal {
	return this.id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_title() rt.PhpVal {
	return this.title
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_layout_template_id() rt.PhpVal {
	return this.layout_template_id
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) set_layout_template_id(layout_template_id string) {
	this.layout_template_id = rt.new_string(layout_template_id).dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_product_data() rt.PhpVal {
	return this.product_data
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_description() rt.PhpVal {
	return this.description
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) set_description(description string) {
	this.description = rt.new_string(description).dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_icon() rt.PhpVal {
	return this.icon
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) set_icon(icon string) {
	this.icon = rt.new_string(icon).dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_order() rt.PhpVal {
	return this.order
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) get_is_selectable_by_user() rt.PhpVal {
	return this.is_selectable_by_user
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) set_order(order i64) {
	this.order = rt.new_int(order).dup()
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) to_json() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() },
		rt.ArrayItem{ key: 'title', val: this.get_title() }, rt.ArrayItem{
			key: 'description'
			val: this.get_description()
		}, rt.ArrayItem{ key: 'icon', val: this.get_icon() },
		rt.ArrayItem{ key: 'order', val: this.get_order() }, rt.ArrayItem{
			key: 'layoutTemplateId'
			val: this.get_layout_template_id()
		}, rt.ArrayItem{ key: 'productData', val: this.get_product_data() },
		rt.ArrayItem{ key: 'isSelectableByUser', val: this.get_is_selectable_by_user() }])
}

fn create_automattic_woocommerce_admin_features_productblockeditor_producttemplate(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate{
		PhpObjectBase:         rt.PhpObjectBase{}
		id:                    rt.new_null()
		title:                 rt.new_null()
		product_data:          rt.new_null()
		order:                 rt.new_int(999)
		layout_template_id:    rt.new_null()
		description:           rt.new_null()
		icon:                  rt.new_null()
		is_selectable_by_user: rt.new_bool(true)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_id' {
			return this.get_id()
		}
		'get_title' {
			return this.get_title()
		}
		'get_layout_template_id' {
			return this.get_layout_template_id()
		}
		'set_layout_template_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_layout_template_id(dispatch_arg_0)
			return rt.new_null()
		}
		'get_product_data' {
			return this.get_product_data()
		}
		'get_description' {
			return this.get_description()
		}
		'set_description' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_description(dispatch_arg_0)
			return rt.new_null()
		}
		'get_icon' {
			return this.get_icon()
		}
		'set_icon' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.set_icon(dispatch_arg_0)
			return rt.new_null()
		}
		'get_order' {
			return this.get_order()
		}
		'get_is_selectable_by_user' {
			return this.get_is_selectable_by_user()
		}
		'set_order' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.set_order(dispatch_arg_0)
			return rt.new_null()
		}
		'to_json' {
			return this.to_json()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'title' { return this.title }
		'product_data' { return this.product_data }
		'order' { return this.order }
		'layout_template_id' { return this.layout_template_id }
		'description' { return this.description }
		'icon' { return this.icon }
		'is_selectable_by_user' { return this.is_selectable_by_user }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_ProductBlockEditor_ProductTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'product_data' {
			this.product_data = val
			return true
		}
		'order' {
			this.order = val
			return true
		}
		'layout_template_id' {
			this.layout_template_id = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'icon' {
			this.icon = val
			return true
		}
		'is_selectable_by_user' {
			this.is_selectable_by_user = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_admin_features_productblockeditor_producttemplate_php() {
}
