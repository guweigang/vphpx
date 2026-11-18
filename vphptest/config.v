module main

import vphp

const ext_config = vphp.ExtensionConfig{
    name: 'vphptest'
    version: '0.1.0'
    description: 'PHP Bindings for V'
    ini_entries: {
        'vphptest.enable_cache': '1'
        'vphptest.max_threads': '4'
    }
}

@[php_globals]
pub struct ExtGlobals {
pub mut:
    request_count int
    last_user     string
}

@[vphp.PhpExportConstant]
const app_version = '1.0.0'

@[vphp.PhpExportConstant]
const max_retry = 3

@[vphp.PhpExportConstant]
const pi_value = 3.14159

@[vphp.PhpExportConstant]
const debug_mode = false
