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

// PhpExportTrait exports a V struct as a native PHP trait.
@[attribute: 'struct']
pub struct PhpExportTrait {
pub:
	name string
}

// PhpUserlandSubclass pairs a native VPHP trait with a PHP class declaration.
@[attribute: 'struct']
pub struct PhpUserlandSubclass {
pub:
	name   string
	parent string
}

// PhpUsesTraits names a constant array of V trait values to compose.
@[attribute: 'struct']
pub struct PhpUsesTraits {
pub:
	source string
}

// PhpTraitAliases declares PHP-style method aliases on a native exported trait.
@[attribute: 'struct']
pub struct PhpTraitAliases {
pub:
	aliases string
}

// PhpTraitAdaptations names a constant array of method adaptations for a native trait.
@[attribute: 'struct']
pub struct PhpTraitAdaptations {
pub:
	source string
}

pub interface PhpNativeTraitSource {}

pub enum PhpTraitAccess {
	inherit
	public
	protected
	private
}

pub struct PhpTraitAdaptation {
pub:
	source     PhpNativeTraitSource
	method     string
	alias      string
	visibility PhpTraitAccess
	is_final   bool
}

// PhpTraitPrecedences names a constant array of insteadof rules.
@[attribute: 'struct']
pub struct PhpTraitPrecedences {
pub:
	source string
}

pub struct PhpTraitPrecedence {
pub:
	source     PhpNativeTraitSource
	method     string
	instead_of []PhpNativeTraitSource
}

// PhpTraitRules associates native PHP trait rules with the exported V type T.
pub struct PhpTraitRules[T] {
pub:
	uses        []PhpNativeTraitSource
	precedences []PhpTraitPrecedence
	adaptations []PhpTraitAdaptation
}

// PhpConstantTable exports fields of C as constants on the exported PHP type T.
pub struct PhpConstantTable[T, C] {
pub:
	values C
}

// PhpStaticTable binds mutable V state S to the exported PHP class T.
pub struct PhpStaticTable[T, S] {
pub:
	values S
}

// PhpAbstractClass declares an exported PHP class abstract.
@[attribute: 'struct']
pub struct PhpAbstractClass {}

// PhpFinalClass prevents PHP subclasses of the exported class.
@[attribute: 'struct']
pub struct PhpFinalClass {}

// PhpReadonlyClass declares an exported PHP class readonly.
@[attribute: 'struct']
pub struct PhpReadonlyClass {}

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

// PhpSensitiveParameter asks PHP to redact a parameter in stack traces.
@[attribute: 'fn']
pub struct PhpSensitiveParameter {
pub:
	v_name string
}

// PhpSensitiveField applies PHP's sensitive-parameter metadata to a params field.
@[attribute: 'field']
pub struct PhpSensitiveField {}

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

// PhpInterfaceConstants exports the fields of a V constant struct as PHP interface constants.
@[attribute: 'interface']
pub struct PhpInterfaceConstants {
pub:
	source string
}

// PhpExportEnum exports a V enum as a native PHP enum.
@[attribute: 'enum']
pub struct PhpExportEnum {
pub:
	name string
}

// PhpUnitEnum exports the cases without PHP backing values.
@[attribute: 'enum']
pub struct PhpUnitEnum {}

// PhpEnumImplements lists the PHP interfaces an exported enum implements.
@[attribute: 'enum']
pub struct PhpEnumImplements {
pub:
	names string
}

// PhpEnumConstants exports the fields of a V constant struct as ordinary PHP enum constants.
@[attribute: 'enum']
pub struct PhpEnumConstants {
pub:
	source string
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

pub enum PhpInterfacePropertyAccess {
	get
	set
	get_set
	get_ref
	get_ref_set
}

// PhpInterfaceProperty declares a PHP interface property contract.
pub struct PhpInterfaceProperty {
pub:
	name     string
	php_type string
	access   PhpInterfacePropertyAccess
	since    PhpVersion
}

// PhpInterfaceProperties binds property contracts to the exported V interface T.
pub struct PhpInterfaceProperties[T] {
pub:
	properties []PhpInterfaceProperty
}

// PhpInterfaceStaticMethods marks V interface methods as static in the PHP export.
@[attribute: 'interface']
pub struct PhpInterfaceStaticMethods {
pub:
	names string
}

// PhpAttributeSpec describes a PHP attribute in a declaration table.
pub struct PhpAttributeSpec {
pub:
	name string
	args string
}

// PhpExternalInterface associates a V type with an interface declared by PHP.
@[attribute: 'interface']
pub struct PhpExternalInterface {
pub:
	name string
}

// PhpInterfaceParameter customizes a parameter or flattened params field.
pub struct PhpInterfaceParameter {
pub:
	v_name     string
	php_name   string
	php_type   string
	attributes []PhpAttributeSpec
}

// PhpInterfaceMethod customizes the PHP signature of a V interface method.
pub struct PhpInterfaceMethod {
pub:
	v_name          string
	php_name        string
	static_         bool
	php_return_type string
	parameters      []PhpInterfaceParameter
	attributes      []PhpAttributeSpec
	since           PhpVersion
}

// PhpInterfaceMethods binds PHP method declarations to the exported V interface T.
pub struct PhpInterfaceMethods[T] {
pub:
	methods []PhpInterfaceMethod
}

// PhpInterfaceDefault declares the PHP default expression for an interface method parameter.
pub struct PhpInterfaceDefault {
pub:
	method        string
	parameter     string
	default_value string
}

// PhpInterfaceDefaults binds PHP parameter defaults to the exported V interface T.
pub struct PhpInterfaceDefaults[T] {
pub:
	defaults []PhpInterfaceDefault
}

// PhpAbstractProperty declares the abstract accessors of a PHP class property.
pub struct PhpAbstractProperty {
pub:
	name     string
	php_type string
	access   PhpInterfacePropertyAccess
	since    PhpVersion
}

// PhpAbstractProperties binds property contracts to the exported abstract V class T.
pub struct PhpAbstractProperties[T] {
pub:
	properties []PhpAbstractProperty
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
	name     string
	php_type string
}

// PhpDeclaredPropertyWithDefault declares a writable PHP property with a literal default.
@[attribute: 'struct']
pub struct PhpDeclaredPropertyWithDefault {
pub:
	name          string
	php_type      string
	default_value string
}

// PhpDeclaredStaticProperty declares a PHP static property without a V field.
@[attribute: 'struct']
pub struct PhpDeclaredStaticProperty {
pub:
	name     string
	php_type string
}

// PhpDeclaredStaticPropertyWithDefault declares a PHP static property with a literal default.
@[attribute: 'struct']
pub struct PhpDeclaredStaticPropertyWithDefault {
pub:
	name          string
	php_type      string
	default_value string
}

// PhpFinalDeclaredProperty makes a PHP-only property final on PHP 8.4+.
@[attribute: 'struct']
pub struct PhpFinalDeclaredProperty {
pub:
	name string
}

// PhpDeclaredProperties binds PHP-managed properties to an exported class or trait.
pub struct PhpDeclaredProperties[T] {
pub:
	properties []PhpDeclaredPropertySpec
}

pub struct PhpDeclaredPropertySpec {
pub:
	name           string
	php_type       string
	default_value  ?string
	visibility     PhpPropertyVisibility
	set_visibility ?PhpSetVisibility
	is_static      bool
	is_readonly    bool
	is_final       bool
	since          PhpVersion
}

// PhpSetVisibility restricts writes to a public PHP property.
pub enum PhpSetVisibility {
	protected
	private
}

// PhpDeclaredPropertyWithSetVisibility declares a public typed property on PHP 8.4+.
@[attribute: 'struct']
pub struct PhpDeclaredPropertyWithSetVisibility {
pub:
	name           string
	php_type       string
	set_visibility PhpSetVisibility
}

// PhpDeclaredPropertyWithSetVisibilityAndDefault declares a restricted setter with a literal default on PHP 8.4+.
@[attribute: 'struct']
pub struct PhpDeclaredPropertyWithSetVisibilityAndDefault {
pub:
	name           string
	php_type       string
	set_visibility PhpSetVisibility
	default_value  string
}

// PhpDeclaredStaticPropertyWithSetVisibility declares a public static typed property on PHP 8.5+.
@[attribute: 'struct']
pub struct PhpDeclaredStaticPropertyWithSetVisibility {
pub:
	name           string
	php_type       string
	set_visibility PhpSetVisibility
}

// PhpDeclaredStaticPropertyWithSetVisibilityAndDefault declares a static restricted setter with a literal default on PHP 8.5+.
@[attribute: 'struct']
pub struct PhpDeclaredStaticPropertyWithSetVisibilityAndDefault {
pub:
	name           string
	php_type       string
	set_visibility PhpSetVisibility
	default_value  string
}

// PhpPropertyVisibility controls access to a PHP property.
pub enum PhpPropertyVisibility {
	public
	protected
	private
}

// PhpDeclaredPropertyVisibility sets the read visibility of a PHP-only property.
@[attribute: 'struct']
pub struct PhpDeclaredPropertyVisibility {
pub:
	name       string
	visibility PhpPropertyVisibility
}

// PhpDeclaredReadonlyProperty declares a readonly property stored by Zend.
@[attribute: 'struct']
pub struct PhpDeclaredReadonlyProperty {
pub:
	name       string
	php_type   string
	visibility PhpPropertyVisibility
}

// PhpClassConstants exports fields as PHP constants on a class or through an embedded PhpTrait.
@[attribute: 'struct']
pub struct PhpClassConstants {
pub:
	source string
}

pub enum PhpClassConstantAccess {
	public
	protected
	private
}

// PhpClassConstantName sets the exact PHP name of an exported class constant.
@[attribute: 'field']
pub struct PhpClassConstantName {
pub:
	name string
}

// PhpClassConstantVisibility sets the visibility of an exported class constant.
@[attribute: 'field']
pub struct PhpClassConstantVisibility {
pub:
	visibility PhpClassConstantAccess
}

// PhpFinalClassConstant prevents PHP subclasses from overriding an exported class constant.
@[attribute: 'field']
pub struct PhpFinalClassConstant {}

// PhpClassConstantSince sets the minimum PHP version for an exported member constant.
@[attribute: 'field']
pub struct PhpClassConstantSince {
pub:
	version PhpVersion
}

// PhpClassConstantAttribute adds a PHP attribute to an exported class constant.
@[attribute: 'field']
pub struct PhpClassConstantAttribute {
pub:
	name string
	args string
}

// PhpEnumCaseName sets the PHP name of an exported enum case.
@[attribute: 'value']
pub struct PhpEnumCaseName {
pub:
	name string
}

// PhpEnumCaseValue sets the PHP string backing value of an exported enum case.
// Set it on every case to export a string-backed enum.
@[attribute: 'value']
pub struct PhpEnumCaseValue {
pub:
	value string
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

// PhpPropertyGet binds an instance method to an exported property's native get hook.
@[attribute: 'fn']
pub struct PhpPropertyGet {
pub:
	property string
}

// PhpPropertySet binds an instance method to an exported property's native set hook.
@[attribute: 'fn']
pub struct PhpPropertySet {
pub:
	property string
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

pub enum PhpVersion {
	php82
	php83
	php84
	php85
	php86
}

// PhpTypeSince sets the minimum PHP version for an exported class, interface, trait or enum.
@[attribute]
pub struct PhpTypeSince {
pub:
	version PhpVersion
}

// PhpMethodSince sets the minimum PHP version for an exported method or property hook.
@[attribute: 'fn']
pub struct PhpMethodSince {
pub:
	version PhpVersion
}

// PhpFunctionSince sets the minimum PHP version for an exported top-level function.
@[attribute: 'fn']
pub struct PhpFunctionSince {
pub:
	version PhpVersion
}

pub enum PhpMethodAccess {
	public
	protected
	private
}

// PhpMethodVisibility overrides the inferred visibility of an exported PHP method.
@[attribute: 'fn']
pub struct PhpMethodVisibility {
pub:
	visibility PhpMethodAccess
}

// PhpAbstractMethod declares an exported PHP method abstract.
@[attribute: 'fn']
pub struct PhpAbstractMethod {}

// PhpFinalMethod prevents PHP subclasses from overriding an exported method or property hook.
@[attribute: 'fn']
pub struct PhpFinalMethod {}

// PhpBorrowedReturn declares that an exported callable borrows its return object.
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

// PhpArgOptional controls whether PHP may omit a direct parameter without
// an explicit PHP default. A V option still allows null when required.
@[attribute: 'fn']
pub struct PhpArgOptional {
pub:
	v_name   string
	optional bool
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

// PhpExportConstant exports a V scalar constant. An empty name uses the uppercase V name.
@[attribute]
pub struct PhpExportConstant {
pub:
	name string
}

// PhpGlobalConstantSince sets the minimum PHP version for an exported global constant.
@[attribute]
pub struct PhpGlobalConstantSince {
pub:
	version PhpVersion
}

// PhpGlobalConstantAttribute adds a PHP attribute to an exported constant on PHP 8.5+.
@[attribute]
pub struct PhpGlobalConstantAttribute {
pub:
	name string
	args string
}

// PhpGlobals declares the struct used for an extension's Zend module globals.
@[attribute: 'struct']
pub struct PhpGlobals {}

// PhpExportTask registers a V task under the given PHP task name.
@[attribute: 'struct']
pub struct PhpExportTask {
pub:
	name string
}
