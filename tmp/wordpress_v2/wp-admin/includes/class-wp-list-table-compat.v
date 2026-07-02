import rt

struct Class__WP_List_Table_Compat {
	rt.PhpObjectBase
pub mut:
	_screen  rt.PhpVal = rt.new_null()
	_columns rt.PhpVal = rt.new_null()
}

fn (mut this Class__WP_List_Table_Compat) construct(var_screen rt.PhpVal, var_columns rt.PhpVal) {
	mut var_screen_mutated := var_screen
	mut var_columns_mutated := var_columns
	if rt.is_true(rt.new_bool(var_screen_mutated.clone().is_string())) {
		var_screen_mutated = rt.call_function('convert_to_screen', [
			var_screen_mutated.clone()])
	}
	this._screen = var_screen_mutated.clone()
	if !(!rt.is_true(var_columns_mutated)) {
		this._columns = var_columns_mutated.clone()
		rt.call_function('add_filter', [
			rt.new_string('manage_' + (rt.get_property(var_screen_mutated, 'id')).str() + '_columns'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('_WP_List_Table_Compat', [
					'WP_List_Table',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_columns' },
			]),
			rt.new_int(0),
		])
	}
}

fn (mut this Class__WP_List_Table_Compat) get_column_info() rt.PhpVal {
	mut var_columns := rt.call_function('get_column_headers', [this._screen])
	mut var_hidden := rt.call_function('get_hidden_columns', [this._screen])
	mut var_sortable := rt.new_array()
	mut var_primary := this.get_default_primary_column_name()
	return rt.create_array([rt.ArrayItem{ key: none, val: var_columns },
		rt.ArrayItem{ key: none, val: var_hidden }, rt.ArrayItem{ key: none, val: var_sortable },
		rt.ArrayItem{ key: none, val: var_primary }])
}

fn (mut this Class__WP_List_Table_Compat) get_columns() rt.PhpVal {
	return this._columns
}

struct Class_WP_List_Table {
	rt.PhpObjectBase
}

fn create__wp_list_table_compat(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class__WP_List_Table_Compat {
	mut obj := &Class__WP_List_Table_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
		_screen:       rt.new_null()
		_columns:      rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_wp_list_table(_args ...rt.PhpVal) &Class_WP_List_Table {
	mut obj := &Class_WP_List_Table{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class__WP_List_Table_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_column_info' {
			return this.get_column_info()
		}
		'get_columns' {
			return this.get_columns()
		}
		else {
			return none
		}
	}
}

fn (this &Class__WP_List_Table_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'_screen' { return this._screen }
		'_columns' { return this._columns }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class__WP_List_Table_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'_screen' {
			this._screen = val
			return true
		}
		'_columns' {
			this._columns = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_List_Table) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_List_Table) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_List_Table) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
