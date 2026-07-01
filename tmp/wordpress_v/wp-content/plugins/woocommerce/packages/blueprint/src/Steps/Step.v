import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
pub mut:
	meta_values rt.PhpVal = rt.new_array()
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_Step.get_step_name() string {
	return ''
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_Step.get_schema(version i64) {
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) prepare_json_array() {
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) set_meta_values(mut var_meta_values Class_Automattic_WooCommerce_Blueprint_Steps_array) {
	this.meta_values = var_meta_values.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) get_json_array() rt.PhpVal {
	mut var_json_array := this.prepare_json_array()
	if !(!rt.is_true(this.meta_values)) {
		var_json_array.array_set('meta', this.meta_values)
	}
	return var_json_array.dup()
}

fn create_automattic_woocommerce_blueprint_steps_step() &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
		meta_values:   rt.new_array()
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_Step.get_step_name())
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			Class_Automattic_WooCommerce_Blueprint_Steps_Step.get_schema(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_json_array' {
			this.prepare_json_array()
			return rt.new_null()
		}
		'set_meta_values' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Steps_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.set_meta_values(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_json_array' {
			return this.get_json_array()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_values' { return this.meta_values }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_values' {
			this.meta_values = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_blueprint_src_steps_step_php() {
}
