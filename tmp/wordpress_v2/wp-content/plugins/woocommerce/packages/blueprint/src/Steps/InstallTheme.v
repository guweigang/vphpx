import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	rt.PhpObjectBase
pub mut:
	slug     rt.PhpVal = rt.new_null()
	resource rt.PhpVal = rt.new_null()
	options  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) construct(var_slug rt.PhpVal, var_resource rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Blueprint_Steps_array) {
	this.slug = var_slug.clone()
	this.resource = var_resource.clone()
	this.options = var_options
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) prepare_json_array() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: 'step'
			val: Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_step_name()
		},
		rt.ArrayItem{ key: 'themeData', val: rt.create_array([
			rt.ArrayItem{ key: 'resource', val: this.resource },
			rt.ArrayItem{ key: 'slug', val: this.slug },
		]) },
		rt.ArrayItem{ key: 'options', val: this.options },
	])
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_schema(version i64) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'step', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{
						key: none
						val: Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_step_name()
					},
				]) },
			]) },
			rt.ArrayItem{ key: 'themeData', val: rt.create_array([
				rt.ArrayItem{ key: 'anyOf', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/VFSReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/LiteralReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/CorePluginReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/CoreThemeReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/UrlReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/GitDirectoryReference.php', '3') },
					rt.ArrayItem{ key: none, val: rt.include_file(@DIR +
						'/schemas/definitions/DirectoryLiteralReference.php', '3') },
				]) },
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'activate', val: rt.create_array([
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
				]) },
			]) },
		]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'step' },
			rt.ArrayItem{ key: none, val: 'themeData' },
		]) }])
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_step_name() string {
	return 'installTheme'
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_steps_installtheme(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme{
		PhpObjectBase: rt.PhpObjectBase{}
		slug:          rt.new_null()
		resource:      rt.new_null()
		options:       rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_step(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blueprint_Steps_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'prepare_json_array' {
			return this.prepare_json_array()
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_schema(dispatch_arg_0)
		}
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme.get_step_name())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'slug' { return this.slug }
		'resource' { return this.resource }
		'options' { return this.options }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_InstallTheme) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'slug' {
			this.slug = val
			return true
		}
		'resource' {
			this.resource = val
			return true
		}
		'options' {
			this.options = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_Step) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
