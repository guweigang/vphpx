module builder

import strings
import compiler.repr

// INI 配置项
pub struct IniEntry {
pub:
	name          string
	default_value string
	access        string = 'all'
}

// 模块构建器：负责 zend_module_entry 相关的 C 代码生成
pub struct ModuleBuilder {
pub mut:
	ext_name           string
	version            string
	description        string
	functions          []FuncBuilder
	minit_content      []string // 注入到 MINIT 中的代码行
	rinit_content      []string // 注入到 RINIT 中的代码行
	mshutdown_content  []string
	ini_entries        []IniEntry
	globals            repr.PhpGlobalsRepr
	has_native_traits  bool
	has_static_request bool
}

pub fn new_module_builder(ext_name string, version string, description string) &ModuleBuilder {
	return &ModuleBuilder{
		ext_name:    ext_name
		version:     if version != '' { version } else { '1.0.0' }
		description: description
	}
}

pub fn (mut b ModuleBuilder) add_function(fn_builder FuncBuilder) {
	b.functions << fn_builder
}

pub fn (mut b ModuleBuilder) add_minit_line(line string) {
	b.minit_content << line
}

pub fn (mut b ModuleBuilder) add_rinit_line(line string) {
	b.rinit_content << line
}

pub fn (mut b ModuleBuilder) add_ini_entry(name string, def_val string) {
	b.ini_entries << IniEntry{name, def_val, 'all'}
}

pub fn (mut b ModuleBuilder) add_ini_entry_with_access(name string, def_val string, access string) {
	b.ini_entries << IniEntry{name, def_val, access}
}

fn ini_c_string(value string) string {
	mut out := strings.new_builder(value.len)
	for byte in value.bytes() {
		if byte == `\\` {
			out.write_string('\\\\')
		} else if byte == `"` {
			out.write_string('\\"')
		} else if byte < 32 || byte >= 127 {
			out.write_u8(`\\`)
			out.write_u8(`0` + ((byte >> 6) & 7))
			out.write_u8(`0` + ((byte >> 3) & 7))
			out.write_u8(`0` + (byte & 7))
		} else {
			out.write_u8(byte)
		}
	}
	return out.str()
}

// 渲染函数表 (zend_function_entry)
pub fn (b &ModuleBuilder) render_functions_table() string {
	mut res := strings.new_builder(512)
	res.write_string('static const zend_function_entry ${b.ext_name}_functions[] = {\n')
	for f in b.functions {
		res.write_string(f.for_php_version([f.render_fe()]).join('\n') + '\n')
	}
	if b.has_static_request {
		name := 'vphp_${b.ext_name}_with_static_request'
		res.write_string('    PHP_FE(${name}, arginfo_${name})\n')
	}
	res.write_string('    PHP_FE_END\n};\n')
	return res.str()
}

// 渲染 INI 定义
pub fn (b &ModuleBuilder) render_ini_entries() string {
	if b.ini_entries.len == 0 { return '' }
	mut res := strings.new_builder(256)
	res.write_string('PHP_INI_BEGIN()\n')
	for entry in b.ini_entries {
		res.write_string('    PHP_INI_ENTRY("${ini_c_string(entry.name)}", "${ini_c_string(entry.default_value)}", PHP_INI_${entry.access.to_upper()}, NULL)\n')
	}
	res.write_string('PHP_INI_END()\n')
	return res.str()
}

// 渲染 Zend Globals 结构体
pub fn (b &ModuleBuilder) render_globals_struct() string {
	if b.globals.name == '' { return '' }
	mut res := strings.new_builder(256)
	res.write_string('ZEND_BEGIN_MODULE_GLOBALS(${b.ext_name})\n')
	for field in b.globals.fields {
		c_type := match field.v_type {
			'int' { 'zend_long' }
			'string' { 'v_string' }
			'i64' { 'zend_long' }
			'f64' { 'double' }
			'bool' { 'zend_bool' }
			else { 'void*' }
		}

		res.write_string('    ${c_type} ${field.name};\n')
	}
	res.write_string('ZEND_END_MODULE_GLOBALS(${b.ext_name})\n\n')

	res.write_string('ZEND_DECLARE_MODULE_GLOBALS(${b.ext_name})\n')
	res.write_string('#define VPHP_G(v) ZEND_MODULE_GLOBALS_ACCESSOR(${b.ext_name}, v)\n')
	return res.str()
}

// 渲染 GINIT (Globals Initialization)
pub fn (b &ModuleBuilder) render_ginit() string {
	if b.globals.name == '' { return '' }
	mut res := strings.new_builder(256)
	res.write_string('static void php_${b.ext_name}_init_globals(zend_${b.ext_name}_globals *globals) {\n')
	for field in b.globals.fields {
		// 默认初始化为 0 或空
		if field.v_type == 'string' {
			res.write_string('    globals->${field.name}.str = NULL;\n')
			res.write_string('    globals->${field.name}.len = 0;\n')
			res.write_string('    globals->${field.name}.is_lit = 0;\n')
		} else {
			res.write_string('    globals->${field.name} = 0;\n')
		}
	}
	res.write_string('}\n')
	return res.str()
}

// 渲染 MINIT 函数
pub fn (b &ModuleBuilder) render_minit() string {
	mut res := strings.new_builder(1024)
	res.write_string('PHP_MINIT_FUNCTION(${b.ext_name}) {\n')
	if compound_min_version := b.compound_function_min_version() {
		mut setup := []string{}
		setup << '#if PHP_VERSION_ID >= 80300'
		setup << b.compound_function_setup()
		setup << '#endif'
		setup << '    if (zend_register_functions(NULL, ${b.ext_name}_functions, NULL, type) != SUCCESS) {'
		setup << '        return FAILURE;'
		setup << '    }'
		setup << '    EG(current_module)->functions = ${b.ext_name}_functions;'
		// PHP 8.2 only accepts scalar masks and literal class names during registration.
		if compound_min_version == 0 {
			setup << '#if PHP_VERSION_ID < 80300'
			for function in b.functions {
				if function.min_php_version != 0 || function.compound_arginfo_setup().len == 0 {
					continue
				}
				lines := registered_compound_arginfo_setup(function.php_name, 'CG(function_table)',
					function.return_spec, if function.uses_context { [] } else { function.args },
					function.table)
				setup << lines.map('    ' + it)
			}
			setup << '#endif'
		}
		res.write_string(for_php_version(compound_min_version, setup).join('\n') + '\n')
	}
	res.write_string('    _vinit_caller();\n')
	res.write_string('    vphp_framework_init(module_number);\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_auto_startup");\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_startup");\n')

	if b.ini_entries.len > 0 {
		res.write_string('    REGISTER_INI_ENTRIES();\n')
	}

	for line in b.minit_content {
		res.write_string('    ${line}\n')
	}
	res.write_string('    vphp_apply_auto_interface_bindings(0);\n')
	if b.has_native_traits {
		res.write_string('    vphp_init_native_trait_cache_guard(module_number);\n')
	}

	res.write_string('    return SUCCESS;\n}\n')
	return res.str()
}

fn (b &ModuleBuilder) compound_function_setup() []string {
	mut lines := []string{}
	for function in b.functions {
		lines << function.for_php_version(function.compound_arginfo_setup().map('    ' + it))
	}
	return lines
}

fn (b &ModuleBuilder) compound_function_min_version() ?int {
	mut min_version := max_int
	for function in b.functions {
		if function.min_php_version < min_version && function.compound_arginfo_setup().len > 0 {
			min_version = function.min_php_version
		}
	}
	return if min_version == max_int { none } else { min_version }
}

// 渲染 MSHUTDOWN (如果需要卸载 INI)
pub fn (b &ModuleBuilder) render_mshutdown() string {
	mut res := strings.new_builder(256)
	res.write_string('PHP_MSHUTDOWN_FUNCTION(${b.ext_name}) {\n')
	if b.ini_entries.len > 0 {
		res.write_string('    UNREGISTER_INI_ENTRIES();\n')
	}
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_shutdown");\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_auto_shutdown");\n')
	res.write_string('    vphp_framework_shutdown();\n')
	for line in b.mshutdown_content {
		res.write_string('    ${line}\n')
	}
	res.write_string('    vphp_release_attribute_arrays();\n')
	res.write_string('    vphp_release_php_property_storage();\n')
	res.write_string('#if PHP_VERSION_ID >= 80400\n    vphp_release_property_hooks();\n#endif\n')
	res.write_string('    _vcleanup_caller();\n')
	res.write_string('    if (type != MODULE_TEMPORARY) { vphp_release_enum_case_aliases(); }\n')
	if b.has_native_traits {
		res.write_string('    vphp_release_native_trait_cache_guard();\n')
	}
	res.write_string('    return SUCCESS;\n}\n')
	return res.str()
}

pub fn (b &ModuleBuilder) render_rinit() string {
	mut res := strings.new_builder(256)
	res.write_string('PHP_RINIT_FUNCTION(${b.ext_name}) {\n')
	if b.has_native_traits {
		res.write_string('    vphp_enable_native_trait_cache_guard();\n')
	}
	res.write_string('    vphp_framework_request_startup();\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_request_auto_startup");\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_request_startup");\n')
	for line in b.rinit_content {
		res.write_string('    ${line}\n')
	}
	res.write_string('    return SUCCESS;\n}\n')
	return res.str()
}

pub fn (b &ModuleBuilder) render_rshutdown() string {
	mut res := strings.new_builder(256)
	res.write_string('PHP_RSHUTDOWN_FUNCTION(${b.ext_name}) {\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_request_shutdown");\n')
	res.write_string('    vphp_call_optional_void_symbol("vphp_ext_request_auto_shutdown");\n')
	res.write_string('    vphp_framework_request_shutdown();\n')
	res.write_string('    if (type == MODULE_TEMPORARY) { vphp_release_enum_case_aliases(); }\n')
	res.write_string('    return SUCCESS;\n}\n')
	return res.str()
}

// 渲染 MINFO 函数
pub fn (b &ModuleBuilder) render_minfo() string {
	mut res := strings.new_builder(1024)
	res.write_string('PHP_MINFO_FUNCTION(${b.ext_name}) {\n')
	res.write_string('    php_info_print_table_start();\n')
	res.write_string('    php_info_print_table_header(2, "${b.ext_name} support", "enabled");\n')
	res.write_string('    php_info_print_table_row(2, "Version", "${ini_c_string(b.version)}");\n')
	if b.description != '' {
		res.write_string('    php_info_print_table_row(2, "Description", "${ini_c_string(b.description)}");\n')
	}
	res.write_string('    php_info_print_table_end();\n')
	if b.ini_entries.len > 0 {
		res.write_string('    DISPLAY_INI_ENTRIES();\n')
	}
	res.write_string('}\n')
	return res.str()
}

// 渲染模块结构体定义
pub fn (b &ModuleBuilder) render_module_entry() string {
	mut res := strings.new_builder(512)
	mshutdown := 'PHP_MSHUTDOWN(${b.ext_name})'

	res.write_string('zend_module_entry ${b.ext_name}_module_entry = {\n')
	// Zend registers module entry functions before MINIT. Compound arginfo needs
	// initialized Zend strings, so that module registers its table from MINIT.
	res.write_string('    STANDARD_MODULE_HEADER, "${b.ext_name}",\n')
	if compound_min_version := b.compound_function_min_version() {
		if compound_min_version > 0 {
			res.write_string('#if PHP_VERSION_ID >= ${compound_min_version}\n    NULL,\n#else\n    ${b.ext_name}_functions,\n#endif\n')
		} else {
			res.write_string('    NULL,\n')
		}
	} else {
		res.write_string('    ${b.ext_name}_functions,\n')
	}
	res.write_string('    PHP_MINIT(${b.ext_name}), ${mshutdown}, PHP_RINIT(${b.ext_name}), PHP_RSHUTDOWN(${b.ext_name}), PHP_MINFO(${b.ext_name}), "${ini_c_string(b.version)}",\n')
	if b.globals.name != '' {
		res.write_string('    PHP_MODULE_GLOBALS(${b.ext_name}),\n')
		res.write_string('    (void (*)(void*)) php_${b.ext_name}_init_globals,\n')
		res.write_string('    NULL,\n') // GSHUTDOWN
	} else {
		res.write_string('    NO_MODULE_GLOBALS,\n')
	}
	res.write_string('    NULL,\n') // post_deactivate
	res.write_string('    STANDARD_MODULE_PROPERTIES_EX\n};\n')
	return res.str()
}

// 渲染最终的模块导出宏
pub fn (b &ModuleBuilder) render_get_module() string {
	res := '
#ifdef COMPILE_DL_${b.ext_name.to_upper()}
ZEND_GET_MODULE(${b.ext_name})
#endif
'
	return res
}

// 渲染供 V 调用的全局变量获取器
pub fn (b &ModuleBuilder) render_globals_getter() string {
	if b.globals.name == '' { return '' }
	return '
void* vphp_get_active_globals() {
#ifdef ZTS
    return ZEND_MODULE_GLOBALS_BULK(${b.ext_name});
#else
    return &${b.ext_name}_globals;
#endif
}
'
}

// 渲染所需的显示声明，防止编译器警告
pub fn (b &ModuleBuilder) render_declarations() string {
	return '
typedef struct { void* str; int64_t len; int64_t is_lit; } v_string;

extern void _vinit_caller(void);
extern void _vcleanup_caller(void);
extern void vphp_framework_init(int module_number);
extern void vphp_framework_shutdown(void);
extern void vphp_framework_request_startup(void);
extern void vphp_framework_request_shutdown(void);
'
}
