import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) get_schema() rt.PhpVal {
	mut var_typography_props := rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
		return temp.object(arg_0)
	}(rt.create_array([
		rt.ArrayItem{ key: 'fontFamily', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontSize', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontStyle', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'fontWeight', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'letterSpacing', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'lineHeight', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'textTransform', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'textDecoration', val: rt.call_method(fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.string()
		}(), 'nullable', []rt.PhpVal{}) },
	])), 'nullable', []rt.PhpVal{})
	return rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
		return temp.object(arg_0)
	}(rt.create_array([
		rt.ArrayItem{ key: 'version', val: fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.integer()
		}() },
		rt.ArrayItem{ key: 'styles', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
			return temp.object(arg_0)
		}(rt.create_array([
			rt.ArrayItem{ key: 'spacing', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
				return temp.object(arg_0)
			}(rt.create_array([
				rt.ArrayItem{ key: 'padding', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'top', val: fn () rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
						return temp.string()
					}() },
					rt.ArrayItem{ key: 'right', val: fn () rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
						return temp.string()
					}() },
					rt.ArrayItem{ key: 'bottom', val: fn () rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
						return temp.string()
					}() },
					rt.ArrayItem{ key: 'left', val: fn () rt.PhpVal {
						mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
						return temp.string()
					}() },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'blockGap', val: rt.call_method(fn () rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.string()
				}(), 'nullable', []rt.PhpVal{}) },
			])), 'nullable', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'color', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
				return temp.object(arg_0)
			}(rt.create_array([
				rt.ArrayItem{ key: 'background', val: rt.call_method(fn () rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.string()
				}(), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'text', val: rt.call_method(fn () rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.string()
				}(), 'nullable', []rt.PhpVal{}) },
			])), 'nullable', []rt.PhpVal{}) },
			rt.ArrayItem{ key: 'typography', val: var_typography_props },
			rt.ArrayItem{ key: 'elements', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
				mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
				return temp.object(arg_0)
			}(rt.create_array([
				rt.ArrayItem{ key: 'heading', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'button', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'link', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h1', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h2', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h3', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h4', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h5', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
				rt.ArrayItem{ key: 'h6', val: rt.call_method(fn (arg_0 rt.PhpVal) rt.PhpVal {
					mut temp := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
					return temp.object(arg_0)
				}(rt.create_array([
					rt.ArrayItem{ key: 'typography', val: var_typography_props },
				])), 'nullable', []rt.PhpVal{}) },
			])), 'nullable', []rt.PhpVal{}) },
		])), 'nullable', []rt.PhpVal{}) },
	])), 'to_array', []rt.PhpVal{})
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_email_styles_schema() &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder() &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_schema' {
			return this.get_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Email_Styles_Schema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_class_email_styles_schema_php() {
	// unsupported statement: Stmt_Declare
}
