import rt

struct Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	rt.PhpObjectBase
}

fn Class_WordPress_AiClient_Common_AbstractDataTransferObject.validatefromarraydata(mut var_data Class_WordPress_AiClient_Common_array, mut var_requiredKeys Class_WordPress_AiClient_Common_array) {
	mut var_data_mutated := var_data
	mut var_missingKeys := rt.new_array()
	{
		mut iter_1 := var_requiredKeys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data_mutated.dup().array_isset(var_key.dup())))))) {
				var_missingKeys.array_push(var_key.dup())
			}
		}
	}
	if !(!rt.is_true(var_missingKeys)) {
		rt.throw_exception(rt.new_object('WordPress_AiClient_Common_Exception_InvalidArgumentException',
			[]string{}, create_wordpress_aiclient_common_exception_invalidargumentexception(rt.call_function('sprintf', [
			rt.new_string('%s::fromArray() missing required keys: %s'),
			Class_WordPress_AiClient_Common_static.class(),
			rt.call_function('implode', [rt.new_string(', '),
				var_missingKeys.dup()]),
		]))))
	}
}

fn Class_WordPress_AiClient_Common_AbstractDataTransferObject.isarrayshape(mut var_array Class_WordPress_AiClient_Common_array) bool {
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_WordPress_AiClient_Common_AbstractDataTransferObject{}
		return temp.fromarray(arg_0)
	}(rt.new_object('WordPress_AiClient_Common_array', []string{}, var_array))
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return true
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'WordPress_AiClient_Common_Exception_InvalidArgumentException') {
		mut var_e := var_e_1.dup()
		return false
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return false
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) jsonserialize() rt.PhpVal {
	mut var_data := this.toarray()
	mut var_schema := fn () rt.PhpVal {
		mut temp := Class_WordPress_AiClient_Common_AbstractDataTransferObject{}
		return temp.getjsonschema()
	}()
	return this.convertemptyarraystoobjects(var_data.dup(), mut
		rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](var_schema))
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) convertemptyarraystoobjects(var_data rt.PhpVal, mut var_schema Class_WordPress_AiClient_Common_array) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_schema_mutated := var_schema
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_data_mutated.dup().is_array()))
		&& !rt.is_true(var_data_mutated)))
		&& var_schema_mutated.array_isset(rt.new_string('type'))))
		&& rt.is_true(rt.identical(var_schema_mutated.array_get('type'), rt.new_string('object')))))
	{
		return create_stdclass()
	}
	if rt.is_true(rt.new_bool(var_data_mutated.dup().is_array())) {
		if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('properties'))
			&& rt.is_true(rt.new_bool(var_schema_mutated.array_get('properties').is_array()))))
		{
			{
				mut iter_1 := var_data_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_value := item_1.val
					mut var_key := item_1.key
					if rt.is_true(rt.new_bool(
						var_schema_mutated.array_get('properties').array_isset(var_key)
						&& rt.is_true(rt.new_bool(var_schema_mutated.array_get('properties').array_get(var_key).is_array()))))
					{
						var_data_mutated.array_set(var_key, this.convertemptyarraystoobjects(var_value.dup(), mut
							rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](var_schema_mutated.array_get('properties').array_get(var_key))))
					}
				}
			}
		}
		if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(rt.new_string('items'))
			&& rt.is_true(rt.new_bool(var_schema_mutated.array_get('items').is_array()))))
		{
			{
				mut iter_1 := var_data_mutated.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_item := item_1.val
					mut var_index := item_1.key
					var_data_mutated.array_set(var_index, this.convertemptyarraystoobjects(var_item.dup(), mut
						rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](var_schema_mutated.array_get('items'))))
				}
			}
		}
		{
			mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'oneOf' },
				rt.ArrayItem{ key: none, val: 'anyOf' }]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_keyword := item_1.val
				if rt.is_true(rt.new_bool(var_schema_mutated.array_isset(var_keyword)
					&& rt.is_true(rt.new_bool(var_schema_mutated.array_get(var_keyword).is_array()))))
				{
					{
						mut iter_2 := var_schema_mutated.array_get(var_keyword).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_possibleSchema := item_2.val
							if rt.is_true(rt.new_bool(var_possibleSchema.dup().is_array())) {
								return this.convertemptyarraystoobjects(var_data_mutated.dup(), mut
									rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](var_possibleSchema))
							}
						}
					}
				}
			}
		}
	}
	return var_data_mutated.dup()
}

struct Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wordpress_aiclient_common_abstractdatatransferobject() &Class_WordPress_AiClient_Common_AbstractDataTransferObject {
	mut obj := &Class_WordPress_AiClient_Common_AbstractDataTransferObject{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wordpress_aiclient_common_exception_invalidargumentexception() &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException {
	mut obj := &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'validateFromArrayData' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			Class_WordPress_AiClient_Common_AbstractDataTransferObject.validatefromarraydata(mut dispatch_arg_0, mut
				dispatch_arg_1)
			return rt.new_null()
		}
		'isArrayShape' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_WordPress_AiClient_Common_AbstractDataTransferObject.isarrayshape(mut dispatch_arg_0))
		}
		'jsonSerialize' {
			return this.jsonserialize()
		}
		'convertEmptyArraysToObjects' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WordPress_AiClient_Common_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.convertemptyarraystoobjects(dispatch_arg_0, mut dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_AbstractDataTransferObject) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WordPress_AiClient_Common_Exception_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_php_ai_client_src_common_abstractdatatransferobject_php() {
	// unsupported statement: Stmt_Declare
}
