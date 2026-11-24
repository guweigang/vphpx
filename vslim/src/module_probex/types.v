module module_probex

import eventx
import httpx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Dev\\PhpSignatureProbe')]
@[heap]
pub struct VSlimPhpSignatureProbe {
mut:
	provider_ref &eventx.VSlimPsr14ListenerProvider = unsafe { nil } @[vphp.PhpIgnoreField]
}

const signature_probe_properties = vphp.PhpDeclaredProperties[VSlimPhpSignatureProbe]{
	properties: [vphp.PhpDeclaredPropertySpec{
		name:          'readonlyDefault'
		php_type:      'int'
		default_value: '86'
		is_readonly:   true
		since:         .php86
	}]
}

@[vphp.PhpExportClass(name: 'VSlim\\Debug\\ObjectProbe')]
@[heap]
pub struct VSlimDebugObjectProbe {}

@[vphp.PhpExportClass(name: 'VSlim\\Dev\\CloneResponseProbe')]
@[vphp.PhpObjectCopy(cloneable: true, serializable: false)]
@[heap]
pub struct VSlimCloneResponseProbe {
	httpx.VSlimPsr7Response
pub mut:
	label string
}

pub fn (response &VSlimCloneResponseProbe) clone_into(mut target VSlimCloneResponseProbe) {
	response.VSlimPsr7Response.clone_into(mut target.VSlimPsr7Response)
	target.label = response.label.clone()
}

@[vphp.PhpExportClass(name: 'VSlim\\Dev\\SerializableUriProbe')]
@[vphp.PhpObjectCopy(cloneable: false, serializable: true)]
@[heap]
pub struct VSlimSerializableUriProbe {
	httpx.VSlimPsr7Uri
pub mut:
	label string
}

@[vphp.PhpExportMethod(name: '__serialize')]
pub fn (uri &VSlimSerializableUriProbe) serialize_probe_state() vphp.PhpArray {
	mut parent := uri.VSlimPsr7Uri.serialize_state()
	defer {
		parent.release()
	}
	data := vphp.PhpArray.new()
	data.set_zval('uri', parent.to_zval())
	data.string('label', uri.label)
	return data
}

@[vphp.PhpExportMethod(name: '__unserialize')]
pub fn (mut uri VSlimSerializableUriProbe) unserialize_probe_state(data vphp.PhpArray) {
	parent := data.array_value('uri') or {
		vphp.PhpException.raise_class('UnexpectedValueException', 'Invalid URI probe state', 0)
		return
	}
	label := data.string_value('label') or {
		vphp.PhpException.raise_class('UnexpectedValueException', 'Invalid URI probe label', 0)
		return
	}
	uri.VSlimPsr7Uri.unserialize_state(parent)
	if !vphp.PhpException.has_current() {
		uri.label = label.value()
	}
}

@[vphp.PhpExportTrait(name: 'VSlim\\Dev\\UserlandCounterMethods')]
@[vphp.PhpUserlandSubclass(name: 'VSlim\\Dev\\UserlandCounter', parent: 'VphpFixture\\Author\\Counter')]
@[vphp.PhpDeclaredPropertyWithDefault('steps', 'int', '0')]
pub struct VSlimUserlandCounterMethods {}

@[vphp.PhpExportMethod(name: 'advance')]
@[vphp.PhpArgDefault(v_name: 'amount', default_value: '1')]
pub fn (counter VSlimUserlandCounterMethods) advance(ctx vphp.Context, amount int) int {
	obj := ctx.ex.this_zend_object()
	total := obj.prop_borrowed('steps').to_int() + amount
	mut value := vphp.PhpInt.of(i64(total))
	obj.set_prop_input('steps', value)
	value.release()
	return total
}

@[vphp.PhpExportTrait(name: 'VSlim\\Dev\\LegacySignatureTrait')]
@[vphp.PhpClassAttribute(name: 'Deprecated', args: 'message: "Use PhpSignatureProbe"')]
pub struct VSlimLegacySignatureTrait {}

@[vphp.PhpExportMethod(name: 'legacySignature')]
pub fn (probe &VSlimLegacySignatureTrait) legacy_signature() string {
	return 'legacy'
}
