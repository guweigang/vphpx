import rt

struct Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	rt.PhpObjectBase
pub mut:
		sql string
		name rt.PhpVal = rt.new_string('schema.sql')
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) construct(sql string, name string) {
	this.sql = sql
	this.name = rt.new_string(name)
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_step_name() string {
	return 'runSql'
}

fn Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_schema(version i64) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'step', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_step_name() }]) }]) }, rt.ArrayItem{ key: 'sql', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'contents' }, rt.ArrayItem{ key: none, val: 'resource' }, rt.ArrayItem{ key: none, val: 'name' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'resource', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'literal' }]) }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'contents', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'step' }, rt.ArrayItem{ key: none, val: 'sql' }]) }])
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) prepare_json_array() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'step', val: Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_step_name() }, rt.ArrayItem{ key: 'sql', val: rt.create_array([rt.ArrayItem{ key: 'resource', val: 'literal' }, rt.ArrayItem{ key: 'name', val: this.name }, rt.ArrayItem{ key: 'contents', val: this.sql }]) }])
}

struct Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blueprint_steps_runsql(sql string, name string) &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql{
		PhpObjectBase: rt.PhpObjectBase{}
		sql: ''
		name: rt.new_string('schema.sql')
	}
	obj.construct(sql, name)
	return obj
}

fn create_automattic_woocommerce_blueprint_steps_step(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blueprint_Steps_Step {
	mut obj := &Class_Automattic_WooCommerce_Blueprint_Steps_Step{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_step_name' {
			return rt.new_string(Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_step_name())
		}
		'get_schema' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Automattic_WooCommerce_Blueprint_Steps_RunSql.get_schema(dispatch_arg_0)
		}
		'prepare_json_array' {
			return this.prepare_json_array()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'sql' { return rt.new_string(this.sql) }
		'name' { return this.name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blueprint_Steps_RunSql) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'sql' { this.sql = (val).str(); return true }
		'name' { this.name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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
