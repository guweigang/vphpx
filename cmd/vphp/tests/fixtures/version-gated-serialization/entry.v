module main

import vphp

const ext_config = vphp.ExtensionConfig{name: 'version_gated_serialization'}

@[vphp.PhpExportClass(name: 'VersionGatedCopy')]
@[vphp.PhpObjectCopy(cloneable: false, serializable: true)]
pub struct VersionGatedCopy {}

@[vphp.PhpExportMethod(name: '__serialize')]
pub fn (c &VersionGatedCopy) serialize_state() vphp.PhpArray {
	return vphp.PhpArray.new()
}

@[vphp.PhpExportMethod(name: '__unserialize')]
@[vphp.PhpMethodSince(version: .php84)]
pub fn (mut c VersionGatedCopy) unserialize_state(data vphp.PhpArray) {
}
