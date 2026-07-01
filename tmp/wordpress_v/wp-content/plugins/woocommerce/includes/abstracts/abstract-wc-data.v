import rt

pub fn Class_WC_Data.clone_mode_duplicate() string {
	return 'duplicate'
}
pub fn Class_WC_Data.clone_mode_cache() string {
	return 'cache'
}
struct Class_WC_Data {
	rt.PhpObjectBase
pub mut:
		id rt.PhpVal = rt.new_int(0)
		data rt.PhpVal = rt.new_array()
		changes rt.PhpVal = rt.new_array()
		object_read rt.PhpVal = rt.new_bool(false)
		object_type rt.PhpVal = rt.new_string('data')
		extra_data rt.PhpVal = rt.new_array()
		default_data rt.PhpVal = rt.new_array()
		data_store rt.PhpVal = rt.new_null()
		cache_group rt.PhpVal = rt.new_string('')
		meta_data rt.PhpVal = rt.new_null()
		clone_mode rt.PhpVal = rt.new_null()
		legacy_datastore_props rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Data) construct(read i64)  {
	this.data = rt.call_function('array_merge', [this.data, this.extra_data])
	this.default_data = this.data
}

fn (mut this Class_WC_Data) magic_sleep() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'id' }])
}

fn (mut this Class_WC_Data) magic_wakeup()  {
	this.construct((rt.call_function('absint', [this.id])).to_i64())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.dup()
		this.set_id(rt.new_int(0))
		this.set_object_read(true)
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
}

fn (mut this Class_WC_Data) magic_clone()  {
	if rt.is_true(rt.identical(Class_WC_Data.clone_mode_duplicate(), this.clone_mode)) {
		this.maybe_read_meta_data()
	}
	if !(!rt.is_true(this.meta_data)) {
		{
			mut iter_1 := this.meta_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				mut var_array_key := item_1.key
				this.meta_data.array_set(var_array_key, // unsupported expression: Expr_Clone)
				if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WC_Data.clone_mode_duplicate(), this.clone_mode)) && !(!rt.is_true(rt.get_property(var_meta, 'id'))))) {
					rt.set_property(this.meta_data.array_get(var_array_key), 'id', rt.new_null())
				}
			}
		}
	}
}

fn (mut this Class_WC_Data) set_clone_mode(var_mode rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_mode.dup(), rt.create_array([rt.ArrayItem{ key: none, val: Class_WC_Data.clone_mode_duplicate() }, rt.ArrayItem{ key: none, val: Class_WC_Data.clone_mode_cache() }]), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(rt.new_string('Clone mode must be either WC_Data::CLONE_MODE_DUPLICATE or WC_Data::CLONE_MODE_CACHE'))))
	}
	this.clone_mode = var_mode.dup()
}

fn (mut this Class_WC_Data) get_clone_mode() rt.PhpVal {
	return this.clone_mode
}

fn (mut this Class_WC_Data) get_data_store() rt.PhpVal {
	return this.data_store
}

fn (mut this Class_WC_Data) get_id() rt.PhpVal {
	return this.id
}

fn (mut this Class_WC_Data) delete(force_delete bool) bool {
	mut var_check := rt.call_function('apply_filters', [rt.concat(rt.new_string('woocommerce_pre_delete_'), this.object_type), rt.new_null(), rt.new_object('WC_Data', []string{}, &this), rt.new_bool(force_delete)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return (var_check).to_bool()
	}
	if rt.is_true(this.data_store) {
		rt.call_method(this.data_store, 'delete', [rt.new_object('WC_Data', []string{}, &this), rt.create_array([rt.ArrayItem{ key: 'force_delete', val: force_delete }])])
		this.set_id(rt.new_int(0))
		return true
	}
	return false
}

fn (mut this Class_WC_Data) save() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.data_store)))) {
		return this.get_id()
	}
	rt.call_function('do_action', ['woocommerce_before_' + (this.object_type).str() + '_object_save', rt.new_object('WC_Data', []string{}, &this), this.data_store])
	if rt.is_true(this.get_id()) {
		rt.call_method(this.data_store, 'update', [rt.new_object('WC_Data', []string{}, &this)])
	} else {
		rt.call_method(this.data_store, 'create', [rt.new_object('WC_Data', []string{}, &this)])
	}
	rt.call_function('do_action', ['woocommerce_after_' + (this.object_type).str() + '_object_save', rt.new_object('WC_Data', []string{}, &this), this.data_store])
	return this.get_id()
}

fn (mut this Class_WC_Data) magic_tostring() rt.PhpVal {
	return rt.call_function('wp_json_encode', [this.get_data()])
}

fn (mut this Class_WC_Data) get_data() rt.PhpVal {
	return rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'id', val: this.get_id() }]), this.data, rt.create_array([rt.ArrayItem{ key: 'meta_data', val: this.get_meta_data() }])])
}

fn (mut this Class_WC_Data) get_data_keys() rt.PhpVal {
	return rt.func_array_keys(this.data)
}

fn (mut this Class_WC_Data) get_extra_data_keys() rt.PhpVal {
	return rt.func_array_keys(this.extra_data)
}

fn (mut this Class_WC_Data) filter_null_meta(var_meta rt.PhpVal) bool {
	mut var_meta_mutated := var_meta
	return !(rt.is_true(rt.new_bool(rt.get_property(var_meta_mutated, 'value').is_null())))
}

fn (mut this Class_WC_Data) get_meta_data() rt.PhpVal {
	this.maybe_read_meta_data()
	return rt.call_function('array_values', [rt.call_function('array_filter', [this.meta_data, rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_null_meta' }])])])
}

fn (mut this Class_WC_Data) is_internal_meta_key(var_key rt.PhpVal) bool {
	mut var_internal_meta_key := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_key)) && rt.is_true(this.data_store))) && rt.is_true(rt.call_function('in_array', [var_key.dup(), rt.call_method(this.data_store, 'get_internal_meta_keys', []rt.PhpVal{}), rt.new_bool(true)]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_internal_meta_key)))) {
		return false
	}
	mut var_has_setter_or_getter := rt.new_bool(rt.new_bool(rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_' + var_key.dup().to_string().trim_left(' \t\n\r') }])])) || rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_' + var_key.dup().to_string().trim_left(' \t\n\r') }])]))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_setter_or_getter)))) {
		return false
	}
	if rt.is_true(rt.call_function('in_array', [var_key.dup(), this.legacy_datastore_props, rt.new_bool(true)])) {
		return true
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('wc_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Generic add/update/get meta methods should not be used for internal meta data, including "%s". Use getters and setters.'), rt.new_string('woocommerce')]), var_key.dup()]), rt.new_string('3.2.0')])
	return true
}

fn (mut this Class_WC_Data) get_meta(key string, single bool, context string) rt.PhpVal {
	if this.is_internal_meta_key(rt.new_string(key)) {
		mut var_function := rt.new_string('get_' + key.trim_left(' \t\n\r'))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_function }])])) {
			return rt.call_method(rt.new_object('WC_Data', []string{}, &this), var_function, []rt.PhpVal{})
		}
	}
	mut var_meta_data := this.get_meta_data()
	mut var_array_keys := rt.func_array_keys(rt.call_function('wp_list_pluck', [var_meta_data.dup(), rt.new_string('key')]), rt.new_string(key), rt.new_bool(true))
	mut var_value := if var_single { rt.new_string('') } else { rt.new_array() }
	if !(!rt.is_true(var_array_keys)) {
		if var_single {
			var_value = rt.get_property(var_meta_data.array_get(rt.call_function('current', [var_array_keys.dup()])), 'value')
		} else {
			var_value = rt.call_function('array_intersect_key', [var_meta_data.dup(), rt.call_function('array_flip', [var_array_keys.dup()])])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('view'), rt.new_string(context))) {
		var_value = rt.call_function('apply_filters', [this.get_hook_prefix() + key, var_value.dup(), rt.new_object('WC_Data', []string{}, &this)])
	}
	return var_value.dup()
}

fn (mut this Class_WC_Data) meta_exists(key string) rt.PhpVal {
	mut var_array_keys := rt.call_function('wp_list_pluck', [this.get_meta_data(), rt.new_string('key')])
	return rt.call_function('in_array', [rt.new_string(key), var_array_keys.dup(), rt.new_bool(true)])
}

fn (mut this Class_WC_Data) set_meta_data(var_data rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(!rt.is_true(var_data)) && rt.is_true(rt.new_bool(var_data.dup().is_array())))) {
		this.maybe_read_meta_data()
		{
			mut iter_1 := var_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				var_meta = rt.cast_array(var_meta)
				if var_meta.array_isset(rt.new_string('key')) && var_meta.array_isset(rt.new_string('value')) && var_meta.array_isset(rt.new_string('id')) {
					this.meta_data.array_push(create_wc_meta_data(rt.create_array([rt.ArrayItem{ key: 'id', val: var_meta.array_get('id') }, rt.ArrayItem{ key: 'key', val: var_meta.array_get('key') }, rt.ArrayItem{ key: 'value', val: var_meta.array_get('value') }])))
				}
			}
		}
	}
}

fn (mut this Class_WC_Data) add_meta_data(var_key rt.PhpVal, var_value rt.PhpVal, unique bool) rt.PhpVal {
	mut var_value_mutated := var_value
	if this.is_internal_meta_key(var_key.dup()) {
		mut var_function := rt.new_string('set_' + var_key.dup().to_string().trim_left(' \t\n\r'))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_function }])])) {
			return rt.call_method(rt.new_object('WC_Data', []string{}, &this), var_function, [var_value_mutated.dup()])
		}
	}
	this.maybe_read_meta_data()
	if var_unique {
		this.delete_meta_data(var_key.dup())
	}
	this.meta_data.array_push(create_wc_meta_data(rt.create_array([rt.ArrayItem{ key: 'key', val: var_key }, rt.ArrayItem{ key: 'value', val: var_value_mutated }])))
	return rt.new_null()
}

fn (mut this Class_WC_Data) update_meta_data(var_key rt.PhpVal, var_value rt.PhpVal, meta_id i64) rt.PhpVal {
	mut var_value_mutated := var_value
	if this.is_internal_meta_key(var_key.dup()) {
		mut var_function := rt.new_string('set_' + var_key.dup().to_string().trim_left(' \t\n\r'))
		if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Data', []string{}, &this) }, rt.ArrayItem{ key: none, val: var_function }])])) {
			return rt.call_method(rt.new_object('WC_Data', []string{}, &this), var_function, [var_value_mutated.dup()])
		}
	}
	this.maybe_read_meta_data()
	mut var_array_key := rt.new_bool(rt.new_bool(false))
	if var_meta_id != 0 {
		mut var_array_keys := rt.func_array_keys(rt.call_function('wp_list_pluck', [this.meta_data, rt.new_string('id')]), rt.new_int(meta_id), rt.new_bool(true))
		var_array_key = if rt.is_true(var_array_keys) { rt.call_function('current', [var_array_keys.dup()]) } else { rt.new_bool(false) }
	} else {
		mut var_matches := rt.new_array()
		{
			mut iter_1 := this.meta_data.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_meta := item_1.val
				mut var_meta_data_array_key := item_1.key
				if rt.is_true(rt.identical(rt.get_property(var_meta, 'key'), var_key)) {
					var_matches << var_meta_data_array_key.dup()
				}
			}
		}
		if !(!rt.is_true(var_matches)) {
			var_array_key = rt.call_function('array_shift', [var_matches.dup()])
			for var_meta_data_array_key in var_matches {
				rt.set_property(this.meta_data.array_get(var_meta_data_array_key), 'value', rt.new_null())
			}
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_meta := this.meta_data.array_get(var_array_key)
		rt.set_property(var_meta, 'key', var_key.dup())
		rt.set_property(var_meta, 'value', var_value_mutated.dup())
	} else {
		this.add_meta_data(var_key.dup(), var_value_mutated.dup(), true)
	}
	return rt.new_null()
}

fn (mut this Class_WC_Data) delete_meta_data(var_key rt.PhpVal)  {
	this.maybe_read_meta_data()
	mut var_array_keys := rt.func_array_keys(rt.call_function('wp_list_pluck', [this.meta_data, rt.new_string('key')]), var_key.dup(), rt.new_bool(true))
	if rt.is_true(var_array_keys) {
		{
			mut iter_1 := var_array_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_array_key := item_1.val
				rt.set_property(this.meta_data.array_get(var_array_key), 'value', rt.new_null())
			}
		}
	}
}

fn (mut this Class_WC_Data) delete_meta_data_value(var_key rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
	this.maybe_read_meta_data()
	mut var_array_keys := rt.func_array_keys(rt.call_function('wp_list_pluck', [this.meta_data, rt.new_string('key')]), var_key.dup(), rt.new_bool(true))
	if rt.is_true(var_array_keys) {
		{
			mut iter_1 := var_array_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_array_key := item_1.val
				if rt.is_true(rt.identical(var_value_mutated, rt.get_property(this.meta_data.array_get(var_array_key), 'value'))) {
					rt.set_property(this.meta_data.array_get(var_array_key), 'value', rt.new_null())
				}
			}
		}
	}
}

fn (mut this Class_WC_Data) delete_meta_data_by_mid(var_mid rt.PhpVal)  {
	this.maybe_read_meta_data()
	mut var_array_keys := rt.func_array_keys(rt.call_function('wp_list_pluck', [this.meta_data, rt.new_string('id')]), // unsupported expression: Expr_Cast_Int, rt.new_bool(true))
	if rt.is_true(var_array_keys) {
		{
			mut iter_1 := var_array_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_array_key := item_1.val
				rt.set_property(this.meta_data.array_get(var_array_key), 'value', rt.new_null())
			}
		}
	}
}

fn (mut this Class_WC_Data) maybe_read_meta_data()  {
	if rt.is_true(rt.new_bool(this.meta_data.is_null())) {
		this.read_meta_data(false)
	}
}

fn (mut this Class_WC_Data) get_meta_cache_key() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.get_id())))) {
		rt.call_function('wc_doing_it_wrong', [rt.new_string('get_meta_cache_key'), rt.new_string('ID needs to be set before fetching a cache key.'), rt.new_string('4.7.0')])
		return false
	}
	return (Class_WC_Data.generate_meta_cache_key(this.get_id(), this.cache_group)).to_bool()
}

fn Class_WC_Data.generate_meta_cache_key(var_id rt.PhpVal, var_cache_group rt.PhpVal) string {
	return  +  + (var_id).str()
}

fn Class_WC_Data.prime_raw_meta_data_cache(var_raw_meta_data_collection rt.PhpVal, var_cache_group rt.PhpVal)  {
	{
		mut iter_1 := var_raw_meta_data_collection.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_raw_meta_data_array := item_1.val
			mut var_object_id := item_1.key
			
		}
	}
}

fn (mut this Class_WC_Data) read_meta_data(force_read bool)  {
}

fn (mut this Class_WC_Data) init_meta_data(mut var_filtered_meta_data Class_array)  {
}

fn (mut this Class_WC_Data) save_meta_data()  {
}

fn (mut this Class_WC_Data) set_id(var_id rt.PhpVal)  {
}

fn (mut this Class_WC_Data) set_defaults()  {
}

fn (mut this Class_WC_Data) set_object_read(read bool)  {
}

fn (mut this Class_WC_Data) get_object_read() rt.PhpVal {
}

fn (mut this Class_WC_Data) set_props(var_props rt.PhpVal, context string) rt.PhpVal {
}

fn (mut this Class_WC_Data) set_prop(var_prop rt.PhpVal, var_value rt.PhpVal)  {
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Data) get_changes() rt.PhpVal {
}

fn (mut this Class_WC_Data) apply_changes()  {
}

fn (mut this Class_WC_Data) get_hook_prefix() string {
}

fn (mut this Class_WC_Data) get_prop(var_prop rt.PhpVal, context string) rt.PhpVal {
}

fn (mut this Class_WC_Data) set_date_prop(var_prop rt.PhpVal, var_value rt.PhpVal)  {
	mut var_date_bits := rt.new_null()
	mut var_value_mutated := var_value
}

fn (mut this Class_WC_Data) error(var_code rt.PhpVal, var_message rt.PhpVal, http_status_code i64, var_data rt.PhpVal)  {
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_WC_Meta_Data {
	rt.PhpObjectBase
}

fn create_wc_data(read i64) &Class_WC_Data {
	mut obj := &Class_WC_Data{
		PhpObjectBase: rt.PhpObjectBase{}
		id: rt.new_int(0)
		data: rt.new_array()
		changes: rt.new_array()
		object_read: rt.new_bool(false)
		object_type: rt.new_string('data')
		extra_data: rt.new_array()
		default_data: rt.new_array()
		data_store: rt.new_null()
		cache_group: rt.new_string('')
		meta_data: rt.new_null()
		clone_mode: rt.new_null()
		legacy_datastore_props: rt.new_array()
	}
	obj.construct(read)
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_meta_data() &Class_WC_Meta_Data {
	mut obj := &Class_WC_Meta_Data{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'__sleep' {
			return this.magic_sleep()
		}
		'__wakeup' {
			this.magic_wakeup()
			return rt.new_null()
		}
		'__clone' {
			this.magic_clone()
			return rt.new_null()
		}
		'set_clone_mode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_clone_mode(dispatch_arg_0)
			return rt.new_null()
		}
		'get_clone_mode' {
			return this.get_clone_mode()
		}
		'get_data_store' {
			return this.get_data_store()
		}
		'get_id' {
			return this.get_id()
		}
		'delete' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.delete(dispatch_arg_0))
		}
		'save' {
			return this.save()
		}
		'__toString' {
			return this.magic_tostring()
		}
		'get_data' {
			return this.get_data()
		}
		'get_data_keys' {
			return this.get_data_keys()
		}
		'get_extra_data_keys' {
			return this.get_extra_data_keys()
		}
		'filter_null_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.filter_null_meta(dispatch_arg_0))
		}
		'get_meta_data' {
			return this.get_meta_data()
		}
		'is_internal_meta_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_internal_meta_key(dispatch_arg_0))
		}
		'get_meta' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.get_meta(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'meta_exists' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.meta_exists(dispatch_arg_0)
		}
		'set_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_meta_data(dispatch_arg_0)
			return rt.new_null()
		}
		'add_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.add_meta_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'update_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.update_meta_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'delete_meta_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_meta_data(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_meta_data_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_meta_data_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_meta_data_by_mid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_meta_data_by_mid(dispatch_arg_0)
			return rt.new_null()
		}
		'maybe_read_meta_data' {
			this.maybe_read_meta_data()
			return rt.new_null()
		}
		'get_meta_cache_key' {
			return rt.new_bool(this.get_meta_cache_key())
		}
		'generate_meta_cache_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(Class_WC_Data.generate_meta_cache_key(dispatch_arg_0, dispatch_arg_1))
		}
		'prime_raw_meta_data_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Data.prime_raw_meta_data_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'read_meta_data' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.read_meta_data(dispatch_arg_0)
			return rt.new_null()
		}
		'init_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.init_meta_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'save_meta_data' {
			this.save_meta_data()
			return rt.new_null()
		}
		'set_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_id(dispatch_arg_0)
			return rt.new_null()
		}
		'set_defaults' {
			this.set_defaults()
			return rt.new_null()
		}
		'set_object_read' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			this.set_object_read(dispatch_arg_0)
			return rt.new_null()
		}
		'get_object_read' {
			return this.get_object_read()
		}
		'set_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.set_props(dispatch_arg_0, dispatch_arg_1)
		}
		'set_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_prop(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_changes' {
			return this.get_changes()
		}
		'apply_changes' {
			this.apply_changes()
			return rt.new_null()
		}
		'get_hook_prefix' {
			return rt.new_string(this.get_hook_prefix())
		}
		'get_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_prop(dispatch_arg_0, dispatch_arg_1)
		}
		'set_date_prop' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_date_prop(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'data' { return this.data }
		'changes' { return this.changes }
		'object_read' { return this.object_read }
		'object_type' { return this.object_type }
		'extra_data' { return this.extra_data }
		'default_data' { return this.default_data }
		'data_store' { return this.data_store }
		'cache_group' { return this.cache_group }
		'meta_data' { return this.meta_data }
		'clone_mode' { return this.clone_mode }
		'legacy_datastore_props' { return this.legacy_datastore_props }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' { this.id = val; return true }
		'data' { this.data = val; return true }
		'changes' { this.changes = val; return true }
		'object_read' { this.object_read = val; return true }
		'object_type' { this.object_type = val; return true }
		'extra_data' { this.extra_data = val; return true }
		'default_data' { this.default_data = val; return true }
		'data_store' { this.data_store = val; return true }
		'cache_group' { this.cache_group = val; return true }
		'meta_data' { this.meta_data = val; return true }
		'clone_mode' { this.clone_mode = val; return true }
		'legacy_datastore_props' { this.legacy_datastore_props = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WC_Meta_Data) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Meta_Data) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Meta_Data) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_includes_abstracts_abstract_wc_data_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
