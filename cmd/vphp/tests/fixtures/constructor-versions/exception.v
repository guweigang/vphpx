module main

import vphp
import ancestor

@[vphp.PhpExportClass(name: 'VphpVersionedException')]
@[vphp.PhpExtends(name: 'Exception')]
pub struct VersionedException {
pub:
	identity         int           = 97
	readonly_payload vphp.PhpValue = vphp.PhpValue.int(41)
pub mut:
	label   string        = 'fallback'
	counter i64           = 19
	enabled bool          = true
	ratio   f64           = 2.5
	payload vphp.PhpValue = vphp.PhpValue.string('initial payload')
}

@[vphp.PhpExportClass(name: 'VphpDefaultsChild')]
@[vphp.PhpExtends(name: 'VersionedException')]
pub struct DefaultsChild {
	VersionedException
pub mut:
	child_label string = 'child default'
}

@[vphp.PhpExportMethod(name: 'advanceParent')]
pub fn (mut child DefaultsChild) advance_parent() !i64 {
	child.child_label += '!'
	return child.VersionedException.advance_result(false)
}

@[vphp.PhpExportClass(name: 'VphpCrossModuleChild')]
pub struct CrossModuleChild {
	ancestor.NativeAncestor
}

@[vphp.PhpExportClass(name: 'VphpCrossModuleGrandchild')]
pub struct CrossModuleGrandchild {
	CrossModuleChild
}

@[vphp.PhpExportMethod(name: 'updateAncestor')]
pub fn (mut child CrossModuleGrandchild) update_ancestor(value vphp.PhpValue) int {
	child.value = value
	child.count++
	return child.count
}

@[vphp.PhpExportClass(name: 'VphpDefaultArray')]
@[vphp.PhpExtends(name: 'ArrayObject')]
pub struct DefaultArray {
pub mut:
	title string = 'native array'
}

@[vphp.PhpExportClass(name: 'VphpReadonlyDefaults')]
@[vphp.PhpExtends(name: 'Exception')]
pub struct ReadonlyDefaults {
pub:
	label string = 'readonly'
}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (target &VersionedException) construct(message string) {
	object := vphp.ZendObject.current()
	object.set_prop('message', vphp.ZVal.new_string('child: ' + message))
}

@[vphp.PhpExportMethod(name: 'readState')]
pub fn (target &VersionedException) read_state() string {
	return '${target.label}|${target.counter}|${target.enabled}|${target.ratio:.2f}'
}

@[vphp.PhpExportMethod(name: 'readIdentity')]
pub fn (target &VersionedException) read_identity() int {
	return target.identity
}

@[vphp.PhpExportMethod(name: 'advanceState')]
pub fn (mut target VersionedException) advance_state() {
	target.label += '!'
	target.counter += 1
	target.enabled = !target.enabled
	target.ratio += 0.5
}

@[vphp.PhpExportMethod(name: 'advanceResult')]
pub fn (mut target VersionedException) advance_result(fail bool) !i64 {
	target.counter++
	if fail {
		return error('state advanced before failure')
	}
	return target.counter
}

@[vphp.PhpExportMethod(name: 'advanceOption')]
pub fn (mut target VersionedException) advance_option(missing bool) ?i64 {
	target.counter++
	if missing {
		return none
	}
	return target.counter
}

@[vphp.PhpExportMethod(name: 'advanceVoidResult')]
pub fn (mut target VersionedException) advance_void_result(fail bool) ! {
	target.enabled = !target.enabled
	if fail {
		return error('flag changed before failure')
	}
}

@[vphp.PhpExportMethod(name: 'advanceObject')]
pub fn (mut target VersionedException) advance_object(missing bool) ?&VersionedConstructor {
	target.counter++
	if missing {
		return none
	}
	return &VersionedConstructor{ level: int(target.counter) }
}

@[vphp.PhpExportMethod(name: 'advanceThroughCallback')]
pub fn (mut target VersionedException) advance_through_callback(callback vphp.PhpCallable) !i64 {
	target.counter++
	return callback.call[vphp.PhpInt]()!.value()
}

@[vphp.PhpExportMethod(name: 'flipZero')]
pub fn (mut target VersionedException) flip_zero() {
	target.ratio = -target.ratio
}

@[vphp.PhpExportMethod(name: 'readScalarProperties')]
pub fn (target &VersionedException) read_scalar_properties() string {
	object := vphp.ZendObject.current()
	label := object.prop_string_or('magicLabel', 'missing')
	count := object.prop_i64_or('missingValue', 23)
	invalid := vphp.ZendObject.invalid()
	flag := invalid.prop_bool_or('unreadable', true)
	ratio := object.prop_f64_or('missingValue', 9.5)
	return '${label}|${count}|${flag}|${ratio:.2f}'
}

@[vphp.PhpExportMethod(name: 'readPayload')]
pub fn (target &VersionedException) read_payload() vphp.PhpValue {
	return target.payload
}

@[vphp.PhpExportMethod(name: 'setPayload')]
pub fn (mut target VersionedException) set_payload(value vphp.PhpValue) {
	target.payload = value
}

@[vphp.PhpExportMethod(name: 'editPayload')]
pub fn (mut target VersionedException) edit_payload(value i64) {
	target.payload.to_zval().add_assoc_long('changed', value)
}
