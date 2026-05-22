module main

import vphp

// ext_config 是 VPHP 编译器用以提取当前 PHP 扩展元数据（如扩展名、版本、描述和 ini 配置）的全局入口。
// 规则与限制：
// 1. 整个扩展项目中必须且只能有一个被有效提取的配置。
// 2. 常量的变量名称必须以 `ext_config` 结尾（例如 `ext_config` 或 `vslim_ext_config`）。
// 3. 常量值的类型必须为 `vphp.ExtensionConfig`。
const ext_config = vphp.ExtensionConfig{
	name:        'vslim'
	version:     '0.1.0'
	description: 'Slim-inspired PHP extension powered by vphp'
}
