module vphp

// PhpExportClass exports a V struct as a PHP class.
@[attribute: 'struct']
pub struct PhpExportClass {
pub:
	name string
}

// PhpTrait marks a V struct whose PHP members are composed into an embedding class.
@[attribute: 'struct']
pub struct PhpTrait {}

// PhpAbstractClass declares an exported PHP class abstract.
@[attribute: 'struct']
pub struct PhpAbstractClass {}

// PhpFinalClass prevents PHP subclasses of the exported class.
@[attribute: 'struct']
pub struct PhpFinalClass {}

// PhpClassAttribute adds a PHP attribute to an exported class.
@[attribute: 'struct']
pub struct PhpClassAttribute {
pub:
	name string
	args string
}

// PhpInterfaceAttribute adds a PHP attribute to an exported interface.
@[attribute: 'interface']
pub struct PhpInterfaceAttribute {
pub:
	name string
	args string
}

// PhpEnumAttribute adds a PHP attribute to an exported enum.
@[attribute: 'enum']
pub struct PhpEnumAttribute {
pub:
	name string
	args string
}

// PhpParameterAttribute adds a PHP attribute to the parameter named v_name.
@[attribute: 'fn']
pub struct PhpParameterAttribute {
pub:
	v_name string
	name   string
	args   string
}

// PhpCallableAttribute adds a PHP attribute to an exported function or method.
@[attribute: 'fn']
pub struct PhpCallableAttribute {
pub:
	name string
	args string
}

// PhpExportInterface exports a V interface to PHP.
@[attribute: 'interface']
pub struct PhpExportInterface {
pub:
	name string
}

// PhpExportEnum exports a V enum as a PHP backed enum.
@[attribute: 'enum']
pub struct PhpExportEnum {
pub:
	name string
}

// PhpExtends declares the parent of an exported PHP class.
@[attribute: 'struct']
pub struct PhpExtends {
pub:
	name string
}

// PhpExtendsInterfaces lists the parents of an exported PHP interface.
@[attribute: 'interface']
pub struct PhpExtendsInterfaces {
pub:
	names string
}

// PhpImplements lists the PHP interfaces an exported class implements.
@[attribute: 'struct']
pub struct PhpImplements {
pub:
	names string
}

// PhpProperty sets the PHP name of an exported V field.
@[attribute: 'field']
pub struct PhpProperty {
pub:
	name string
}

// PhpDeclaredProperty declares a PHP property without a backing V field.
@[attribute: 'struct']
pub struct PhpDeclaredProperty {
pub:
	name   string
	v_type string
}

// PhpDeclaredReadonlyProperty declares a readonly property stored by Zend.
@[attribute: 'struct']
pub struct PhpDeclaredReadonlyProperty {
pub:
	name       string
	v_type     string
	visibility string
}

// PhpClassConstants exports the fields of a V constant struct as PHP class constants.
@[attribute: 'struct']
pub struct PhpClassConstants {
pub:
	source string
}

// PhpClassConstantAttribute adds a PHP attribute to an exported class constant.
@[attribute: 'field']
pub struct PhpClassConstantAttribute {
pub:
	name string
	args string
}

// PhpEnumCaseAttribute adds a PHP attribute to an exported enum case.
@[attribute: 'value']
pub struct PhpEnumCaseAttribute {
pub:
	name string
	args string
}

// PhpClassStatics binds PHP static properties to a V constant struct with mutable fields.
@[attribute: 'struct']
pub struct PhpClassStatics {
pub:
	source string
}

// PhpIgnoreField keeps a V field out of the exported PHP properties.
@[attribute: 'field']
pub struct PhpIgnoreField {}

// PhpStaticProperty declares a PHP static property from a V field.
@[attribute: 'field']
pub struct PhpStaticProperty {}

// PhpPropertyAttribute adds a PHP attribute to an exported property.
@[attribute: 'field']
pub struct PhpPropertyAttribute {
pub:
	name string
	args string
}

// PhpExportFunction exports a V function to PHP. An empty name uses the V name.
@[attribute: 'fn']
pub struct PhpExportFunction {
pub:
	name string
}

// PhpExportMethod exports a V method to PHP. An empty name uses the V name.
@[attribute: 'fn']
pub struct PhpExportMethod {
pub:
	name string
}

// PhpAbstractMethod declares an exported PHP method abstract.
@[attribute: 'fn']
pub struct PhpAbstractMethod {}

// PhpBorrowedReturn declares that an exported method borrows its return object.
@[attribute: 'fn']
pub struct PhpBorrowedReturn {}

// PhpArgType overrides the PHP type of the parameter named v_name.
@[attribute: 'fn']
pub struct PhpArgType {
pub:
	v_name   string
	php_type string
}

// PhpArgName sets the PHP name of a V parameter.
@[attribute: 'fn']
pub struct PhpArgName {
pub:
	v_name   string
	php_name string
}

// PhpArgNames sets PHP parameter names from comma-separated v_name=php_name pairs.
@[attribute: 'fn']
pub struct PhpArgNames {
pub:
	names string
}

// PhpArgTypes sets PHP parameter types from comma-separated v_name=php_type pairs.
@[attribute: 'fn']
pub struct PhpArgTypes {
pub:
	types string
}

// PhpArgDefault sets the PHP default expression for a V parameter.
@[attribute: 'fn']
pub struct PhpArgDefault {
pub:
	v_name        string
	default_value string
}

// PhpArgDefaults sets PHP default expressions from comma-separated v_name=value pairs.
@[attribute: 'fn']
pub struct PhpArgDefaults {
pub:
	defaults string
}

// PhpReturnType overrides the inferred PHP return type.
@[attribute: 'fn']
pub struct PhpReturnType {
pub:
	php_type string
}

// PhpExportConstant exports a V constant as an uppercase PHP global constant.
@[attribute]
pub struct PhpExportConstant {}

// PhpGlobals declares the struct used for an extension's Zend module globals.
@[attribute: 'struct']
pub struct PhpGlobals {}

// PhpExportTask registers a V task under the given PHP task name.
@[attribute: 'struct']
pub struct PhpExportTask {
pub:
	name string
}
