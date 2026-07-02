import rt

struct Class_Akismet_Ability_Get_Stats {
	rt.PhpObjectBase
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_ability_name() string {
	return 'akismet/get-stats'
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_label() string {
	return (rt.call_function('__', [rt.new_string('Get Akismet statistics'), rt.new_string('akismet')])).str()
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_description() string {
	return (rt.call_function('__', [rt.new_string('Retrieves Akismet spam protection statistics including spam blocked count, accuracy percentage, and other key metrics.'), rt.new_string('akismet')])).str()
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_input_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: rt.create_array([rt.ArrayItem{ key: none, val: 'object' }, rt.ArrayItem{ key: none, val: 'null' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'interval', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The time interval for stats. Options: "6-months", "all", or "60-days".'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: '6-months' }, rt.ArrayItem{ key: none, val: 'all' }, rt.ArrayItem{ key: none, val: '60-days' }]) }, rt.ArrayItem{ key: 'default', val: '6-months' }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_output_schema() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'success', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the stats were successfully retrieved.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'spam', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total number of spam comments blocked.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'ham', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total number of legitimate comments approved.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'missed_spam', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of spam comments that were missed.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'false_positives', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of legitimate comments incorrectly marked as spam.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'accuracy', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'number' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Accuracy percentage of spam detection.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'time_saved', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Estimated time saved by Akismet blocking spam, in seconds.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'breakdown', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Monthly breakdown of statistics.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'additionalProperties', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'spam', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total number of spam comments blocked in this period.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'ham', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Total number of legitimate comments approved in this period.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'missed_spam', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of spam comments that were missed in this period.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'false_positives', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Number of legitimate comments incorrectly marked as spam in this period.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'da', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Date for this period.'), rt.new_string('akismet')]) }]) }]) }]) }]) }, rt.ArrayItem{ key: 'interval', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The time interval for these stats.'), rt.new_string('akismet')]) }]) }, rt.ArrayItem{ key: 'error', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Error message if the operation could not be completed.'), rt.new_string('akismet')]) }]) }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }])
}

fn (mut this Class_Akismet_Ability_Get_Stats) get_config() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'label', val: this.get_label() }, rt.ArrayItem{ key: 'description', val: this.get_description() }, rt.ArrayItem{ key: 'category', val: Class_Akismet_Abilities.category_slug() }, rt.ArrayItem{ key: 'input_schema', val: this.get_input_schema() }, rt.ArrayItem{ key: 'output_schema', val: this.get_output_schema() }, rt.ArrayItem{ key: 'execute_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Akismet_Ability_Get_Stats', ['Akismet_Ability', 'Akismet_Ability_Interface'], &this) }, rt.ArrayItem{ key: none, val: 'execute' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Akismet_Ability_Get_Stats', ['Akismet_Ability', 'Akismet_Ability_Interface'], &this) }, rt.ArrayItem{ key: none, val: 'current_user_has_permission' }]) }, rt.ArrayItem{ key: 'meta', val: rt.create_array([rt.ArrayItem{ key: 'annotations', val: rt.create_array([rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'destructive', val: false }, rt.ArrayItem{ key: 'idempotent', val: true }]) }, rt.ArrayItem{ key: 'mcp', val: rt.create_array([rt.ArrayItem{ key: 'public', val: rt.identical(rt.call_function('get_option', [rt.new_string('akismet_enable_mcp_access')]), rt.new_string('1')) }, rt.ArrayItem{ key: 'type', val: 'tool' }]) }, rt.ArrayItem{ key: 'show_in_rest', val: true }]) }])
}

fn (mut this Class_Akismet_Ability_Get_Stats) execute(mut var_input Class_?array) rt.PhpVal {
	mut var_interval := if var_input.array_isset(rt.new_string('interval')) { var_input.array_get(rt.new_string('interval')) } else { rt.new_string('6-months') }
	mut iife_temp_0 := Class_Akismet{}
	mut iife_result_0 := iife_temp_0.get_stats(var_interval.clone())
	mut var_data := iife_result_0
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		return create_wp_error(rt.new_string('stats_fetch_failed'), rt.call_function('__', [rt.new_string('Failed to retrieve stats from Akismet API.'), rt.new_string('akismet')]))
	}
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'success', val: true }, rt.ArrayItem{ key: 'interval', val: var_interval }]), rt.cast_array(var_data)])
}

struct Class_Akismet_Ability {
	rt.PhpObjectBase
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_akismet_ability_get_stats(_args ...rt.PhpVal) &Class_Akismet_Ability_Get_Stats {
	mut obj := &Class_Akismet_Ability_Get_Stats{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet_ability(_args ...rt.PhpVal) &Class_Akismet_Ability {
	mut obj := &Class_Akismet_Ability{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Ability_Get_Stats) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_ability_name' {
			return rt.new_string(this.get_ability_name())
		}
		'get_label' {
			return rt.new_string(this.get_label())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_input_schema' {
			return this.get_input_schema()
		}
		'get_output_schema' {
			return this.get_output_schema()
		}
		'get_config' {
			return this.get_config()
		}
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.execute(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Akismet_Ability_Get_Stats) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Ability_Get_Stats) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet_Ability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet_Ability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Ability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}
