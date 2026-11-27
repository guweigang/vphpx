module repr

pub enum PhpEnumBacking {
	integer
	string_
	unit
}

pub struct PhpEnumRepr {
pub mut:
	name             string
	php_name         string
	min_php_version  int
	module_name      string
	backing          PhpEnumBacking
	unsigned_backing bool
	cases            []PhpEnumCaseRepr
	interfaces       []string
	methods          []PhpMethodRepr
	constant_source  ?string
	constants        []PhpClassConstRepr
	attributes       []PhpAttributeRepr
	parse_err        string
}

pub struct PhpEnumCaseRepr {
pub:
	v_name     string
	php_name   string
	value      string
	attributes []PhpAttributeRepr
}

pub struct PhpEnumCaseRef {
pub:
	v_type      string
	module_name string
	case_name   string
}

pub struct PhpEnumCaseAlias {
pub:
	php_enum  string
	case_name string
}

pub fn (r PhpEnumRepr) c_name() string {
	return r.php_name.replace('\\', '_')
}

pub fn (r PhpEnumRepr) backing_values_function() string {
	return 'vphp_enum_backing_values_${r.c_name().to_lower()}'
}

// method_owner provides the shared method bridge with the enum's V and PHP type names.
pub fn (r PhpEnumRepr) method_owner() PhpClassRepr {
	return PhpClassRepr{
		name:        r.name
		module_name: r.module_name
		php_name:    r.php_name
		is_enum:     true
		methods:     r.methods
	}
}

pub fn new_enum_repr() &PhpEnumRepr {
	return &PhpEnumRepr{}
}
