module repr

pub struct PhpInterfacePropertyRepr {
pub:
	name             string
	php_type         string
	has_get          bool
	has_set          bool
	get_by_reference bool
	min_php_version  int
}

pub struct PhpInterfaceRepr {
pub mut:
	name            string
	php_name        string
	min_php_version int
	module_name     string
	extends_v       []string
	extends_attr    []string
	extends         []string
	constant_source ?string
	constants       []PhpClassConstRepr
	methods         []PhpMethodRepr
	properties      []PhpInterfacePropertyRepr
	attributes      []PhpAttributeRepr
}

pub fn (r PhpInterfaceRepr) c_name() string {
	return r.php_name.replace('\\', '_')
}

pub fn new_interface_repr() &PhpInterfaceRepr {
	return &PhpInterfaceRepr{}
}
