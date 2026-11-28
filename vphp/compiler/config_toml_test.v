module compiler

import compiler.parser as cparser

fn test_toml_merge_preserves_v_config_and_matches_ini_defaults() {
	config := parse_extension_toml('[extension]\nname = "demo"\nversion = "1"\n[ini."demo.flag"]\ndefault = "1"\naccess = "system"\n[other]\nvalue = true\n', 'config.toml') or { panic(err) }
	mut c := new([]string{})
	c.config_path = 'config.toml'
	meta := cparser.ExtensionMeta{
		name:        'demo'
		ini_entries: {
			'demo.flag':   '1'
			'demo.legacy': 'keep'
		}
		present:     {
			'name': true
		}
	}
	c.merge_extension_config(meta, true, config) or { panic(err) }
	assert c.ext_name == 'demo'
	assert c.ext_version == '1'
	assert c.ini_entries['demo.legacy'] == 'keep'
	assert c.ini_entries['demo.flag'] == '1'
	assert c.ini_access['demo.flag'] == 'system'
}

fn test_toml_only_and_legacy_only_metadata() {
	config := parse_extension_toml('[extension]\nname = "demo"\n[ini."demo.flag"]\ndefault = ""\n', 'config.toml') or { panic(err) }
	mut toml_only := new([]string{})
	toml_only.config_path = 'config.toml'
	toml_only.merge_extension_config(cparser.ExtensionMeta{}, false, config) or { panic(err) }
	assert toml_only.ext_name == 'demo'
	assert toml_only.ini_entries['demo.flag'] == ''
	assert toml_only.ini_access['demo.flag'] == 'all'
	mut legacy := new([]string{})
	legacy.config_path = 'config.toml'
	legacy.merge_extension_config(cparser.ExtensionMeta{
		name:    'legacy'
		present: {
			'name': true
		}
	}, true, TomlExtensionConfig{}) or { panic(err) }
	assert legacy.ext_name == 'legacy'
}

fn test_toml_conflicts_and_invalid_values_are_rejected() {
	for input in ['[extension]\nname = 123', '[ini."demo.a"]\ndefault = true',
		'[ini."demo.a"]\ndefault = "1"\naccess = "unknown"', '[ini."demo.a"]\naccess = "all"',
		'[ini."demo.a"]\ndefault = "1"\nacess = "all"', '[extension\n'] {
		if _ := parse_extension_toml(input, 'config.toml') {
			assert false, 'expected invalid TOML configuration to fail: ${input}'
		}
	}
	meta := cparser.ExtensionMeta{
		name:        'demo'
		ini_entries: {
			'demo.flag': '1'
		}
		present:     {
			'name': true
		}
	}
	for input in ['[extension]\nname = "different"', '[ini."demo.flag"]\ndefault = "2"'] {
		config := parse_extension_toml(input, 'config.toml') or { panic(err) }
		mut c := new([]string{})
		c.config_path = 'config.toml'
		if _ := c.merge_extension_config(meta, true, config) {
			assert false, 'expected conflict: ${input}'
		}
	}
}
