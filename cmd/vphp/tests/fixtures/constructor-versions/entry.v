module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'constructor_versions_probe' }

@[vphp.PhpExportClass(name: 'VphpVersionedConstructor')]
pub struct VersionedConstructor {
pub mut:
	level int = 82
}

@[vphp.PhpExportMethod(name: '__construct')]
@[vphp.PhpMethodSince(version: .php86)]
pub fn (mut target VersionedConstructor) construct(level int) {
	target.level = level
}

@[vphp.PhpExportMethod(name: 'currentLevel')]
pub fn (target &VersionedConstructor) current_level() int {
	return target.level
}
