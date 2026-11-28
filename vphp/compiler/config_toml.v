module compiler

import os
import toml
import compiler.parser as cparser

struct TomlIniEntry {
	default_value string
	access        string = 'all'
}

struct TomlExtensionConfig {
	fields map[string]string
	ini    map[string]TomlIniEntry
}

fn require_toml_table(value toml.Any, location string) !map[string]toml.Any {
	if value is map[string]toml.Any { return value }
	return error('${location} must be a TOML table')
}

fn require_toml_string(value toml.Any, location string) !string {
	if value is string { return value }
	return error('${location} must be a TOML string')
}

fn parse_extension_toml(text string, path string) !TomlExtensionConfig {
	doc := toml.parse_text(text) or { return error('${path}: invalid TOML: ${err}') }
	root := require_toml_table(doc.to_any(), path)!
	mut fields := map[string]string{}
	if ext_value := root['extension'] {
		ext := require_toml_table(ext_value, '${path}: [extension]')!
		for key in ['name', 'version', 'description'] {
			if value := ext[key] {
				fields[key] = require_toml_string(value, '${path}: extension.${key}')!
			}
		}
	}
	mut ini := map[string]TomlIniEntry{}
	if ini_value := root['ini'] {
		entries := require_toml_table(ini_value, '${path}: [ini]')!
		for name, entry in entries {
			if name == '' || name.contains('\x00') {
				return error('${path}: invalid empty or NUL INI name')
			}
			spec := require_toml_table(entry, '${path}: ini.${name}')!
			for key in spec.keys() {
				if key !in ['default', 'access'] {
					return error('${path}: unknown field ini.${name}.${key}')
				}
			}
			value := spec['default'] or { return error('${path}: ini.${name}.default is required') }
			default_value := require_toml_string(value, '${path}: ini.${name}.default')!
			if default_value.contains('\x00') {
				return error('${path}: ini.${name}.default contains NUL')
			}
			mut access := 'all'
			if access_value := spec['access'] {
				access = require_toml_string(access_value, '${path}: ini.${name}.access')!
			}
			if access !in ['all', 'user', 'perdir', 'system'] {
				return error('${path}: ini.${name}.access must be all, user, perdir or system')
			}
			ini[name] = TomlIniEntry{default_value, access}
		}
	}
	return TomlExtensionConfig{fields, ini}
}

fn (mut c Compiler) apply_extension_config(meta cparser.ExtensionMeta, has_meta bool) ! {
	mut config := TomlExtensionConfig{}
	if c.config_path != '' && os.exists(c.config_path) {
		text := os.read_file(c.config_path) or { return error('${c.config_path}: ${err}') }
		config = parse_extension_toml(text, c.config_path)!
	}
	c.merge_extension_config(meta, has_meta, config)!
}

fn (mut c Compiler) merge_extension_config(meta cparser.ExtensionMeta, has_meta bool, config TomlExtensionConfig) ! {
	mut values := {
		'name':        meta.name
		'version':     meta.version
		'description': meta.description
	}
	for key, value in config.fields {
		if has_meta && meta.present[key] && values[key] != value {
			return error('${c.config_path}: extension.${key} conflicts with ExtensionConfig.${key}')
		}
		values[key] = value
	}
	c.ext_name = values['name']
	c.ext_version = values['version']
	c.ext_description = values['description']
	if c.ext_version.contains('\x00') || c.ext_description.contains('\x00') {
		return error('${c.config_path}: extension metadata must not contain NUL')
	}
	if c.ext_name == '' {
		return error('extension name is required in ExtensionConfig or ${c.config_path}')
	}
	if !c.ext_name.bytes().all(it.is_alnum() || it == `_`) || c.ext_name[0].is_digit() {
		return error('extension name must be a C identifier: ${c.ext_name}')
	}
	c.ini_entries = meta.ini_entries.clone()
	c.ini_access = map[string]string{}
	for name, entry in config.ini {
		if name in c.ini_entries && c.ini_entries[name] != entry.default_value {
			return error('${c.config_path}: ini.${name}.default conflicts with ExtensionConfig.ini_entries')
		}
		c.ini_entries[name] = entry.default_value
		c.ini_access[name] = entry.access
	}
}
