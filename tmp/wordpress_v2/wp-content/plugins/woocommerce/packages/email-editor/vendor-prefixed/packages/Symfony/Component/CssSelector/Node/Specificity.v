import rt

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.a_factor() i64 {
	return 100
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.b_factor() i64 {
	return 10
}

pub fn Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.c_factor() i64 {
	return 1
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity {
	rt.PhpObjectBase
pub mut:
	a i64
	b i64
	c i64
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) construct(a i64, b i64, c i64) {
	this.a = a
	this.b = b
	this.c = c
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) plus(mut var_specificity Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self) rt.PhpVal {
	return rt.new_object('Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self',
		[]string{}, create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_self(rt.add(this.a, rt.get_property(var_specificity,
		'a')), rt.add(this.b, rt.get_property(var_specificity, 'b')), rt.add(this.c, rt.get_property(var_specificity,
		'c'))))
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) getvalue() i64 {
	return (rt.add(rt.add(rt.mul(this.a,
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.a_factor()), rt.mul(this.b,
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.b_factor())), rt.mul(this.c,
		Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity.c_factor()))).to_i64()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) compareto(mut var_specificity Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self) i64 {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.a,
		rt.get_property(var_specificity, 'a')))))
	{
		return if rt.is_true(rt.greater(this.a, rt.get_property(var_specificity, 'a'))) {
			1
		} else {
			-1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.b,
		rt.get_property(var_specificity, 'b')))))
	{
		return if rt.is_true(rt.greater(this.b, rt.get_property(var_specificity, 'b'))) {
			1
		} else {
			-1
		}
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.c,
		rt.get_property(var_specificity, 'c')))))
	{
		return if rt.is_true(rt.greater(this.c, rt.get_property(var_specificity, 'c'))) {
			1
		} else {
			-1
		}
	}
	return 0
}

struct Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_specificity(a i64, b i64, c i64) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity{
		PhpObjectBase: rt.PhpObjectBase{}
		a:             i64(0)
		b:             i64(0)
		c:             i64(0)
	}
	obj.construct(a, b, c)
	return obj
}

fn create_automattic_woocommerce_emaileditorvendor_symfony_component_cssselector_node_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self {
	mut obj := &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'plus' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.plus(mut dispatch_arg_0)
		}
		'getValue' {
			return rt.new_int(this.getvalue())
		}
		'compareTo' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_int(this.compareto(mut dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'a' { return rt.new_int(this.a) }
		'b' { return rt.new_int(this.b) }
		'c' { return rt.new_int(this.c) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_Specificity) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'a' {
			this.a = val.to_i64()
			return true
		}
		'b' {
			this.b = val.to_i64()
			return true
		}
		'c' {
			this.c = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditorVendor_Symfony_Component_CssSelector_Node_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}
