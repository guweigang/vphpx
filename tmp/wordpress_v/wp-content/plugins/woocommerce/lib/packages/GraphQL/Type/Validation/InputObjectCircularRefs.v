import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs {
	rt.PhpObjectBase
pub mut:
	schemaValidationContext  rt.PhpVal = rt.new_null()
	visitedTypes             rt.PhpVal = rt.new_array()
	fieldPath                rt.PhpVal = rt.new_array()
	fieldPathIndexByTypeName rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) construct(mut var_schemaValidationContext Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext) {
	this.schemaValidationContext = var_schemaValidationContext.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) validate(mut var_inputObj Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType) {
	if this.visitedTypes.array_isset(rt.get_property(var_inputObj, 'name')) {
		return rt.new_null()
	}
	this.visitedTypes.array_set(rt.get_property(var_inputObj, 'name'), true)
	this.fieldPathIndexByTypeName.array_set(rt.get_property(var_inputObj, 'name'),
		this.fieldPath.array_count())
	mut var_fieldMap := var_inputObj.getfields()
	{
		mut iter_1 := var_fieldMap.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_type := rt.call_method(var_field, 'getType', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(rt.instance_of(var_type,
				'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_NonNull')))
			{
				mut var_fieldType := rt.call_method(var_type, 'getWrappedType', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(rt.instance_of(var_fieldType,
					'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType')))
				{
					this.fieldPath.array_push(var_field.dup())
					if !(this.fieldPathIndexByTypeName.array_isset(rt.get_property(var_fieldType,
						'name'))) {
						this.validate(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](var_fieldType))
					} else {
						mut var_cycleIndex := this.fieldPathIndexByTypeName.array_get(rt.get_property(var_fieldType,
							'name'))
						mut var_cyclePath := rt.call_function('array_slice', [
							this.fieldPath,
							var_cycleIndex.dup(),
						])
						closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
							closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
								mut var_field := if args.len > 0 {
									args[0].dup()
								} else {
									rt.new_null()
								}
								return rt.get_property(var_field, 'name')
							}
							mut var_field := if args.len > 0 { args[0].dup() } else { rt.new_null() }
							return rt.get_property(var_field, 'name')
						}
						mut var_fieldNames := rt.call_function('implode', [
							rt.new_string('.'),
							rt.call_function('array_map', [rt.new_closure(closure_1_fn),
								var_cyclePath.dup()]),
						])
						closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
							closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
								mut var_field := if args.len > 0 {
									args[0].dup()
								} else {
									rt.new_null()
								}
								return rt.get_property(var_field, 'astNode')
							}
							mut var_field := if args.len > 0 { args[0].dup() } else { rt.new_null() }
							return rt.get_property(var_field, 'astNode')
						}
						mut var_fieldNodes := rt.call_function('array_map', [
							rt.new_closure(closure_3_fn),
							var_cyclePath.dup(),
						])
						rt.call_method(this.schemaValidationContext, 'reportError', [
							rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('Cannot reference Input Object "'), rt.get_property(var_fieldType,
								'name')),
								rt.new_string('" within itself through a series of non-null fields: "')),
								var_fieldNames), rt.new_string('".')),
							var_fieldNodes.dup(),
						])
					}
				}
			}
			rt.call_function('array_pop', [this.fieldPath])
		}
	}
	this.fieldPathIndexByTypeName.array_unset(rt.get_property(var_inputObj, 'name'))
}

fn create_automattic_woocommerce_vendor_graphql_type_validation_inputobjectcircularrefs(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs{
		PhpObjectBase:            rt.PhpObjectBase{}
		schemaValidationContext:  rt.new_null()
		visitedTypes:             rt.new_array()
		fieldPath:                rt.new_array()
		fieldPathIndexByTypeName: rt.new_array()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_SchemaValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'validate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_InputObjectType](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.validate(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'schemaValidationContext' { return this.schemaValidationContext }
		'visitedTypes' { return this.visitedTypes }
		'fieldPath' { return this.fieldPath }
		'fieldPathIndexByTypeName' { return this.fieldPathIndexByTypeName }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Validation_InputObjectCircularRefs) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'schemaValidationContext' {
			this.schemaValidationContext = val
			return true
		}
		'visitedTypes' {
			this.visitedTypes = val
			return true
		}
		'fieldPath' {
			this.fieldPath = val
			return true
		}
		'fieldPathIndexByTypeName' {
			this.fieldPathIndexByTypeName = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_validation_inputobjectcircularrefs_php() {
	// unsupported statement: Stmt_Declare
}
