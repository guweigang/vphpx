module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'attribute_constants_probe' }

@[vphp.PhpExportClass(name: 'VPHP\\AttributeConstants\\ParentType')]
pub struct AttributeConstantParent {}

struct AttributeParentValues {
	level        int
	legacy_level int @[vphp.PhpClassConstantName(name: 'LEGACY_LEVEL'); vphp.PhpClassConstantAttribute(name: 'Deprecated', args: 'message: "Use LEVEL", since: "2.0"')]
}

const parent_values = vphp.PhpConstantTable[AttributeConstantParent, AttributeParentValues]{
	values: AttributeParentValues{ level: 8, legacy_level: 7 }
}

@[vphp.PhpExportClass(name: 'VPHP\\AttributeConstants\\Subject')]
@[vphp.PhpExtends(name: 'VPHP\\AttributeConstants\\ParentType')]
@[vphp.PhpClassAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: 'self::LABEL, parent::LEVEL, self::class, parent::class, \\DateTimeInterface::class, option: [\\VPHP\\AttributeConstants\\Later::KEY => [\\VPHP\\AttributeConstants\\Mode::active, \\DateTimeInterface::ATOM]]')]
pub struct AttributeConstantSubject {
pub mut:
	value int @[vphp.PhpPropertyAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\ExternalLibrary\\Constants::VALUE')]
}

struct AttributeSubjectValues {
	label string @[vphp.PhpClassConstantName(name: 'LABEL'); vphp.PhpClassConstantVisibility(.private); vphp.PhpClassConstantAttribute('VPHP\\AttributeConstants\\Tag', '\\ExternalLibrary\\Constants::VALUE')]
}

const subject_values = vphp.PhpConstantTable[AttributeConstantSubject, AttributeSubjectValues]{
	values: AttributeSubjectValues{ label: 'subject value' }
}

@[vphp.PhpExportMethod(name: 'inspect')]
@[vphp.PhpCallableAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: 'self::LABEL, \\ExternalLibrary\\Constants::VALUE')]
@[vphp.PhpParameterAttribute('value', 'VPHP\\AttributeConstants\\Tag', 'caseValue: \\VPHP\\AttributeConstants\\Mode::active, externalCase: \\ExternalLibrary\\Constants::MODE')]
pub fn (subject &AttributeConstantSubject) inspect(value string) string {
	return value
}

@[vphp.PhpExportMethod(name: 'inspectSensitive')]
@[vphp.PhpSensitiveParameter(v_name: 'api_key')]
pub fn (subject &AttributeConstantSubject) inspect_sensitive(ctx vphp.Context, label string, api_key string) !string {
	return error('test trace')
}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\inspectSecrets')]
@[vphp.PhpParameterAttribute(v_name: 'secrets', name: 'SensitiveParameter', args: '')]
pub fn inspect_secrets(label string, secrets ...vphp.PhpArg) !string {
	if label == 'roundtrip' {
		return secrets.map(it.zval().to_string()).join('|')
	}
	return error('test trace')
}

@[params]
struct AttributeSensitiveOptions {
	api_key string = '' @[vphp.PhpSensitiveField]
}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\inspectSensitiveOptions')]
pub fn inspect_sensitive_options(label string, options AttributeSensitiveOptions) !string {
	return error('test trace')
}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\makeSensitiveClosure')]
pub fn make_sensitive_closure() fn (AttributeSensitiveOptions) !string {
	return fn (options AttributeSensitiveOptions) !string {
		if options.api_key == 'synthetic-closure' {
			return error('closure trace')
		}
		return options.api_key
	}
}

__global partial_options_calls int

fn next_partial_option() int {
	partial_options_calls++
	return partial_options_calls
}

@[params]
struct AttributePartialOptions {
	sequence int  = next_partial_option()
	enabled  bool = true
}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\partialOptions')]
pub fn partial_options(label string, options AttributePartialOptions) string {
	return '${label}:${options.sequence}:${options.enabled}'
}

@[vphp.PhpExportMethod(name: 'defaultOptions')]
@[vphp.PhpArgDefault(v_name: 'options', default_value: '[self::LABEL, parent::LEVEL, ExternalLibrary\\Constants::VALUE, VPHP_DEFAULT_OPTIONS + 2, namespace\\VPHP_DEFAULT_OPTIONS, true ? VPHP_DEFAULT_OPTIONS : 0, "nested" => [\\VPHP\\AttributeConstants\\Mode::active, ExternalLibrary\\Constants::VALUE]]')]
pub fn (subject &AttributeConstantSubject) default_options(options vphp.PhpValue, tail ?string) vphp.PhpValue {
	return options
}

@[vphp.PhpExportClass(name: 'VPHP\\AttributeConstants\\Later')]
pub struct AttributeLater {}

struct AttributeLaterValues {
	key string @[vphp.PhpClassConstantName(name: 'KEY')]
}

const later_values = vphp.PhpConstantTable[AttributeLater, AttributeLaterValues]{
	values: AttributeLaterValues{ key: 'format' }
}

@[vphp.PhpExportEnum(name: 'VPHP\\AttributeConstants\\Mode')]
pub enum AttributeMode {
	active  @[vphp.PhpEnumCaseAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\ExternalLibrary\\Constants::VALUE')]
	legacy  @[vphp.PhpEnumCaseAttribute(name: 'Deprecated', args: 'message: "Use active"')]
}

@[vphp.PhpExportInterface(name: 'VPHP\\AttributeConstants\\Contract')]
pub interface AttributeConstantContract {}

struct AttributeContractValues {
	legacy int @[vphp.PhpClassConstantAttribute(name: 'Deprecated', args: '')]
}

const contract_values = vphp.PhpConstantTable[AttributeConstantContract, AttributeContractValues]{
	values: AttributeContractValues{ legacy: 5 }
}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\plain')]
@[vphp.PhpCallableAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\DateTimeInterface::ATOM, caseValue: \\VPHP\\AttributeConstants\\Mode::active')]
pub fn attribute_constant_plain() {}

@[vphp.PhpExportFunction(name: 'VPHP\\AttributeConstants\\defaultObject')]
@[vphp.PhpArgDefault(v_name: 'options', default_value: 'new ExternalLibrary\\DefaultOptions(label: "literal", limit: PHP_INT_SIZE)')]
@[vphp.PhpCallableAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\ExternalLibrary\\Constants::VALUE')]
pub fn attribute_constant_default_object(options vphp.PhpValue, tail ?string) vphp.PhpValue {
	return options
}

@[vphp.PhpExportClass(name: 'VPHP\\AttributeConstants\\Repeated')]
@[php_attr: 'VPHP\\AttributeConstants\\Tag(1)']
@[vphp.PhpClassAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '2, option: ["before", \\ExternalLibrary\\Constants::KEY => ["雪", \\ExternalLibrary\\Constants::VALUE], "after"]')]
pub struct AttributeConstantRepeated {}

@[vphp.PhpExportConstant(name: 'VPHP\\AttributeConstants\\VERSION')]
@[vphp.PhpGlobalConstantAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\ExternalLibrary\\Constants::VALUE')]
pub const attribute_constant_version = 1

@[vphp.PhpExportClass(name: 'VPHP\\AttributeConstants\\HookOwner')]
@[vphp.PhpDeclaredProperty('score', 'int')]
pub struct AttributeConstantHookOwner {}

@[vphp.PhpPropertySet(property: 'score')]
@[vphp.PhpCallableAttribute('VPHP\\AttributeConstants\\Tag', '\\ExternalLibrary\\Constants::VALUE')]
@[vphp.PhpParameterAttribute('incoming', 'VPHP\\AttributeConstants\\Tag', '\\ExternalLibrary\\Constants::KEY')]
pub fn (mut owner AttributeConstantHookOwner) set_score(incoming int) {}

@[vphp.PhpExportTrait(name: 'VPHP\\AttributeConstants\\OriginalTrait')]
pub struct AttributeConstantOriginalTrait {}

struct AttributeTraitValues {
	legacy int @[vphp.PhpClassConstantAttribute(name: 'Deprecated', args: 'message: "Use the new value"')]
}

const trait_values = vphp.PhpConstantTable[AttributeConstantOriginalTrait, AttributeTraitValues]{
	values: AttributeTraitValues{ legacy: 6 }
}

@[vphp.PhpExportMethod(name: 'label')]
@[vphp.PhpCallableAttribute(name: 'VPHP\\AttributeConstants\\Tag', args: '\\ExternalLibrary\\Constants::VALUE')]
pub fn (owner &AttributeConstantOriginalTrait) label() string {
	return ''
}

@[vphp.PhpExportTrait(name: 'VPHP\\AttributeConstants\\ComposedTrait')]
pub struct AttributeConstantComposedTrait {}

const composed_rules = vphp.PhpTraitRules[AttributeConstantComposedTrait]{
	uses: [vphp.PhpNativeTraitSource(AttributeConstantOriginalTrait{})]
}
