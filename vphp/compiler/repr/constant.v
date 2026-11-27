module repr

pub struct PhpConstRepr {
pub mut:
	name            string // PHP 常量全名，未指定时使用大写的 V 常量名
	value           string // 常量值的字符串形式
	const_type      string // 'int', 'f64', 'string', 'bool', 'struct'
	v_type          string // 该常量在 V 侧的类型名，如 "ArticleConsts"
	has_php_const   bool   // 是否显式导出为 PHP 全局常量
	min_php_version int
	attributes      []PhpAttributeRepr
	visibility      string // Only used by fields exported as class constants.
	is_final        bool
	enum_case       ?PhpEnumCaseRef
	fields          map[string]PhpConstRepr // 如果是结构体，存储其子字段
}

pub fn new_const_repr() &PhpConstRepr {
	return &PhpConstRepr{}
}

pub struct PhpConstantTableRepr {
pub:
	module_name string
	value_type  string
	source      PhpConstRepr
}

pub struct PhpStaticTableRepr {
pub:
	name        string
	module_name string
	value_type  string
	properties  []PhpClassPropRepr
}
