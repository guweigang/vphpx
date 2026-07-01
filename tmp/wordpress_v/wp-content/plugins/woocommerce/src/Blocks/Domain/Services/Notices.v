import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices {
	rt.PhpObjectBase
pub mut:
	package          rt.PhpVal = rt.new_null()
	notice_templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) construct(mut var_package Class_Automattic_WooCommerce_Blocks_Domain_Package) {
	this.package = var_package.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) init() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))
			|| rt.is_true(rt.call_function('apply_filters', [rt.new_string('woocommerce_use_block_notices_in_classic_theme'), rt.new_bool(false)]))))
		{
			rt.call_function('add_filter', [rt.new_string('wc_get_template'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Notices',
						[]string{}, &this) },
					rt.ArrayItem{ key: none, val: 'get_notices_template' },
				]),
				rt.new_int(10), rt.new_int(5)])
		}
		return rt.new_null()
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'),
		rt.new_closure(closure_1_fn)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_kses_notice_allowed_tags'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Notices',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_kses_notice_allowed_tags' },
		]),
	])
	rt.call_function('add_action', [rt.new_string('wp_head'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_Notices',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_notice_styles' },
		])])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) add_kses_notice_allowed_tags(var_allowed_tags rt.PhpVal) rt.PhpVal {
	mut var_svg_args := rt.create_array([
		rt.ArrayItem{ key: 'svg', val: rt.create_array([
			rt.ArrayItem{ key: 'aria-hidden', val: true },
			rt.ArrayItem{ key: 'xmlns', val: true },
			rt.ArrayItem{ key: 'width', val: true },
			rt.ArrayItem{ key: 'height', val: true },
			rt.ArrayItem{ key: 'viewbox', val: true },
			rt.ArrayItem{ key: 'focusable', val: true },
		]) },
		rt.ArrayItem{ key: 'path', val: rt.create_array([
			rt.ArrayItem{ key: 'd', val: true },
		]) },
	])
	return rt.call_function('array_merge', [var_allowed_tags.dup(),
		var_svg_args.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) get_notices_template(var_template rt.PhpVal, var_template_name rt.PhpVal, var_args rt.PhpVal, var_template_path rt.PhpVal, var_default_path rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	if rt.is_true(rt.call_function('in_array', [var_template_name.dup(), this.notice_templates,
		rt.new_bool(true)]))
	{
		mut var_directory := rt.call_function('get_stylesheet_directory', []rt.PhpVal{})
		mut var_file := rt.new_string(var_directory.str() + '/woocommerce/' +
			var_template_name.str())
		if rt.is_true(rt.call_function('file_exists', [var_file.dup()])) {
			return var_file.dup()
		}
		var_template_mutated = rt.call_method(this.package, 'get_path', [
			'templates/block-' + var_template_name.str(),
		])
		rt.call_function('wp_enqueue_style', [rt.new_string('wc-blocks-style')])
	}
	return var_template_mutated.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) enqueue_notice_styles() {
	rt.call_function('wp_enqueue_style', [rt.new_string('wc-blocks-style')])
}

fn create_automattic_woocommerce_blocks_domain_services_notices(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices{
		PhpObjectBase:    rt.PhpObjectBase{}
		package:          rt.new_null()
		notice_templates: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Package](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'add_kses_notice_allowed_tags' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_kses_notice_allowed_tags(dispatch_arg_0)
		}
		'get_notices_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.get_notices_template(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3, dispatch_arg_4)
		}
		'enqueue_notice_styles' {
			this.enqueue_notice_styles()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'package' { return this.package }
		'notice_templates' { return this.notice_templates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_Notices) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'package' {
			this.package = val
			return true
		}
		'notice_templates' {
			this.notice_templates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_notices_php() {
}
