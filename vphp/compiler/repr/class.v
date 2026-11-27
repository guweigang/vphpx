module repr

import compiler.php_types

pub struct PhpClassRepr {
pub mut:
	name                          string // V struct 名 (如 VPhpTask)
	module_name                   string // V module 名，如 main 或 src.http
	php_name                      string // PHP 侧类名 (如 VPhp\Task)，可含命名空间
	min_php_version               int
	parent                        string // 继承关系
	direct_internal_parent        bool
	uses_inherited_object         bool
	inherited_receiver_parent     ?PhpReceiverParent
	is_enum                       bool
	is_trait                      bool
	is_native_trait               bool
	userland_subclass             ?PhpUserlandSubclassRepr
	native_trait_uses             []string
	native_trait_use_types        []string
	native_trait_alias_spec       string
	native_trait_adaptations      []PhpTypedTraitAdaptation
	native_trait_aliases          []PhpTraitAlias
	native_trait_precedence_specs []PhpTypedTraitPrecedence
	native_trait_precedences      []PhpTraitPrecedence
	is_final                      bool
	is_abstract                   bool
	is_readonly                   bool
	has_free_method               bool
	has_cleanup_method            bool
	has_init_php_state_method     bool
	cloneable                     bool
	copy_parent_embeds            []string
	copy_parent_properties        []PhpClassPropRepr
	serializable                  bool
	copy_zend_properties          bool
	has_v_fields                  bool
	has_clone_into                bool
	embeds_v                      []string
	implements_v                  []string
	implements_attr               []string
	implements                    []string
	internal_implements           []string
	auto_interface_bindings       []string
	shadow_const_name             string // 绑定的影子常量名，如 "article_consts"
	shadow_static_name            string // 新增：绑定的影子静态属性名，如 "article_statics"
	shadow_const_type             string // 绑定的影子常量的 V 侧类型
	shadow_static_type            string // 新增：绑定的影子静态属性的 V 侧类型
	constants                     []PhpClassConstRepr
	properties                    []PhpClassPropRepr
	methods                       []PhpMethodRepr
	attributes                    []PhpAttributeRepr
}

pub struct PhpUserlandSubclassRepr {
pub:
	name   string
	parent string
}

pub struct PhpReceiverParent {
pub:
	name        string
	module_name string
}

pub fn (r PhpClassRepr) type_ref() string {
	if r.module_name == '' || r.module_name == 'main' {
		return r.name
	}
	return '${r.module_name.all_after_last('.')}.${r.name}'
}

pub fn (r PhpClassRepr) is_php_readonly() bool {
	if r.is_readonly {
		return true
	}
	return !r.uses_inherited_object && !r.direct_internal_parent
		&& r.properties.any(!it.is_static && !it.is_property_only)
		&& !r.properties.any(!it.is_static && it.is_mut)
}

// C 宏安全名称：将 \ 替换为 _
pub fn (r PhpClassRepr) c_name() string {
	return r.php_name.replace('\\', '_')
}

pub struct PhpClassConstRepr {
pub:
	name                      string // PHP 侧大写名，如 "MAX_TITLE_LEN"
	v_field_name              string // V 侧原始名，如 "max_title_len"
	value                     string
	const_type                string
	attributes                []PhpAttributeRepr
	visibility                string
	is_final                  bool
	enum_alias                ?PhpEnumCaseAlias
	min_php_version           int
	max_php_version_exclusive int
}

pub struct PhpClassPropRepr {
pub:
	name                      string
	v_field_name              string
	v_type                    string // V 端的原始类型，如 'int', 'string', 'bool'
	php_type                  string // Explicit type for a PHP-only property.
	visibility                string // 'public', 'protected', 'private'
	is_static                 bool
	is_static_shadow          bool
	is_mut                    bool
	is_property_only          bool
	explicit_mixed            bool
	abstract_get              bool
	abstract_get_by_reference bool
	abstract_set              bool
	is_final                  bool
	attributes                []PhpAttributeRepr
	default_value             ?PhpAttributeArg
	default_error             string
	set_visibility            ?string
	min_php_version           int
}

pub fn (prop PhpClassPropRepr) declaration_type() string {
	return if prop.is_property_only { prop.php_type } else { prop.v_type }
}

pub fn (r PhpClassRepr) property_min_php_version(prop PhpClassPropRepr) int {
	if prop.min_php_version >= 80500 {
		return prop.min_php_version
	}
	if prop.is_static && prop.set_visibility != none {
		return 80500
	}
	if prop.min_php_version >= 80400 || prop.is_final || prop.set_visibility != none
		|| prop.abstract_get || prop.abstract_set || r.methods.any(it.hook_property == prop.name) {
		return 80400
	}
	return prop.min_php_version
}

pub struct PhpMethodRepr {
pub mut:
	hook_property             string
	hook_kind                 string
	name                      string // PHP 侧方法名，如 "create"
	v_name                    string // V 侧原始方法名，如 "spawn"
	v_c_func                  string // V 导出的 C 符号名，如 "Article_create"
	is_static                 bool   // 是否为静态方法
	trait_static_receiver     string
	native_trait_source       string
	native_trait_alias        string
	return_spec               PhpReturnRepr
	borrowed_return           bool
	delegated_target_type     string
	delegated_target_method   string
	args                      []PhpArgRepr
	attributes                []PhpAttributeRepr
	has_export                bool
	visibility                string
	is_abstract               bool
	is_final                  bool
	is_trait_final            bool
	has_explicit_visibility   bool
	min_php_version           int
	max_php_version_exclusive int
}

pub struct PhpTraitAlias {
pub:
	trait_name                string
	method                    string
	alias                     string
	visibility                string
	is_final                  bool
	min_php_version           int
	max_php_version_exclusive int
}

pub struct PhpTypedTraitAdaptation {
pub:
	source_v_type string
	rule          PhpTraitAlias
}

pub struct PhpTraitPrecedence {
pub:
	trait_name                string
	method                    string
	excluded_traits           []string
	min_php_version           int
	max_php_version_exclusive int
}

pub struct PhpTypedTraitPrecedence {
pub:
	source_v_type    string
	method           string
	excluded_v_types []string
}

pub fn (method PhpMethodRepr) php_name() string {
	return if method.native_trait_alias != '' {
		method.native_trait_alias
	} else {
		php_method_name(method.name)
	}
}

pub fn (method PhpMethodRepr) property_hook_returns_reference() bool {
	return method.hook_kind == 'get'
		&& php_types.is_reference_return(method.return_spec.effective_v_type())
}

pub fn (method PhpMethodRepr) is_constructor() bool {
	return method.php_name().to_lower() == '__construct'
}

pub fn (method PhpMethodRepr) handler_symbol(owner string) string {
	if method.native_trait_source != '' {
		return '${method.native_trait_source}_${php_method_name(method.name)}'
	}
	return '${owner}_${method.php_name()}'
}

pub fn php_method_name(name string) string {
	return match name {
		'construct', 'init' { '__construct' }
		'str' { '__toString' }
		else { name }
	}
}

pub struct PhpArgRepr {
pub mut:
	name            string
	v_type          string
	php_type        string
	is_optional     bool
	is_variadic     bool
	php_default     string
	use_php_default bool
	source          PhpArgSource
	attributes      []PhpAttributeRepr
}

pub enum PhpArgSourceKind {
	direct
	params_field
}

pub struct PhpArgSource {
pub mut:
	kind                    PhpArgSourceKind = .direct
	direct_name             string
	params_arg_name         string
	params_type             string
	params_field            string
	params_v_default        string
	params_computed_default bool
}

pub struct PhpParamsStruct {
pub mut:
	name        string
	module_name string
	fields      []PhpParamsField
}

pub fn params_struct_key(module_name string, type_name string) string {
	if type_name.contains('.') {
		return type_name
	}
	return if module_name == '' { 'main.${type_name}' } else { '${module_name}.${type_name}' }
}

pub fn (r PhpParamsStruct) type_ref() string {
	name := r.name.all_after_last('.')
	if r.module_name == '' || r.module_name == 'main' {
		return name
	}
	return '${r.module_name.all_after_last('.')}.${name}'
}

pub struct PhpParamsField {
pub mut:
	name             string
	v_type           string
	php_named_type   string
	v_default        string
	php_default      string
	has_default      bool
	computed_default bool
	is_sensitive     bool
}

pub fn (field PhpParamsField) has_computed_default() bool {
	return field.computed_default
}

pub struct PhpAttributeRepr {
pub:
	name        string
	args        []PhpAttributeArg
	parse_error string
}

pub fn (attr PhpAttributeRepr) is_allow_dynamic_properties() bool {
	return attr.name.trim_left('\\').to_lower() == 'allowdynamicproperties'
}

pub struct PhpAttributeArg {
pub:
	kind     string
	name     string
	value    string
	key_kind string
	key      string
	items    []PhpAttributeArg
}

pub fn (arg PhpAttributeArg) has_constant_expression() bool {
	return arg.kind == 'class_constant'
		|| arg.items.any(it.key_kind == 'class_constant' || it.has_constant_expression())
}

pub fn new_class_repr() &PhpClassRepr {
	return &PhpClassRepr{}
}
