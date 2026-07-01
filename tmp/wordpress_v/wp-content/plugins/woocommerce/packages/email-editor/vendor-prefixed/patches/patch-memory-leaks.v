import rt



pub fn init_wp_content_plugins_woocommerce_packages_email_editor_vendor_prefixed_patches_patch_memory_leaks_php() {
	mut var_base := rt.new_string(@DIR + '/../packages')
	mut var_patches := []rt.PhpVal{}
	var_patches << rt.create_array([rt.ArrayItem{ key: 'file', val: (var_base).str() + '/Pelago/Emogrifier/Utilities/DeclarationBlockParser.php' }, rt.ArrayItem{ key: 'marker', val: 'public static function clearCache(): void' }, rt.ArrayItem{ key: 'search', val: '    private static $cache = [];\n\n    /**\n     * CSS custom properties (variables) have case-sensitive names, so their case must be preserved.' }, rt.ArrayItem{ key: 'replace', val: '    private static $cache = [];\n\n    /**\n     * Clears the static declaration block cache.\n     *\n     * This should be called between processing separate HTML documents to prevent\n     * unbounded memory growth in long-running processes.\n     */\n    public static function clearCache(): void\n    {\n        self::$cache = [];\n    }\n\n    /**\n     * CSS custom properties (variables) have case-sensitive names, so their case must be preserved.' }])
	var_patches << rt.create_array([rt.ArrayItem{ key: 'file', val: (var_base).str() + '/Pelago/Emogrifier/CssInliner.php' }, rt.ArrayItem{ key: 'marker', val: 'DeclarationBlockParser::clearCache();' }, rt.ArrayItem{ key: 'search', val: '    private function clearAllCaches(): void\n    {\n        $this->caches = [\n            self::CACHE_KEY_SELECTOR => [],\n            self::CACHE_KEY_COMBINED_STYLES => [],\n        ];\n    }' }, rt.ArrayItem{ key: 'replace', val: '    private function clearAllCaches(): void\n    {\n        $this->caches = [\n            self::CACHE_KEY_SELECTOR => [],\n            self::CACHE_KEY_COMBINED_STYLES => [],\n        ];\n        DeclarationBlockParser::clearCache();\n    }' }])
	var_patches << rt.create_array([rt.ArrayItem{ key: 'file', val: (var_base).str() + '/Symfony/Component/CssSelector/CssSelectorConverter.php' }, rt.ArrayItem{ key: 'marker', val: 'maxCachedItems' }, rt.ArrayItem{ key: 'search', val: '    private $translator;\n    private $cache;\n\n    private static $xmlCache = [];\n    private static $htmlCache = [];' }, rt.ArrayItem{ key: 'replace', val: '    private $translator;\n    private $cache;\n\n    /**\n     * Maximum number of cached items per prefix before LRU eviction kicks in.\n     *\n     * @var int\n     */\n    public static $maxCachedItems = 200;\n\n    private static $xmlCache = [];\n    private static $htmlCache = [];' }])
	var_patches << rt.create_array([rt.ArrayItem{ key: 'file', val: (var_base).str() + '/Symfony/Component/CssSelector/CssSelectorConverter.php' }, rt.ArrayItem{ key: 'marker', val: 'array_key_first' }, rt.ArrayItem{ key: 'search', val: '    public function toXPath(string $cssExpr, string $prefix = \'descendant-or-self::\')\n    {\n        return $this->cache[$prefix][$cssExpr] ?? $this->cache[$prefix][$cssExpr] = $this->translator->cssToXPath($cssExpr, $prefix);\n    }' }, rt.ArrayItem{ key: 'replace', val: '    public function toXPath(string $cssExpr, string $prefix = \'descendant-or-self::\')\n    {\n        if (isset($this->cache[$prefix][$cssExpr])) {\n            // Promote to most-recently-used position.\n            $value = $this->cache[$prefix][$cssExpr];\n            unset($this->cache[$prefix][$cssExpr]);\n\n            return $this->cache[$prefix][$cssExpr] = $value;\n        }\n\n        $value = $this->translator->cssToXPath($cssExpr, $prefix);\n\n        if (\\count($this->cache[$prefix] ?? []) >= self::$maxCachedItems) {\n            // Evict least-recently-used entry.\n            unset($this->cache[$prefix][\\array_key_first($this->cache[$prefix])]);\n        }\n\n        return $this->cache[$prefix][$cssExpr] = $value;\n    }' }])
	mut var_failed := false
	for var_patch in var_patches {
		mut var_name := rt.call_function('basename', [var_patch.array_get('file')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_patch.array_get('file')]))))) {
			print(rt.concat(rt.concat(rt.new_string('FAIL: File not found: '), var_patch.array_get('file')), rt.new_string('\n')))
			var_failed = true
			continue
		}
		mut var_content := rt.call_function('file_get_contents', [var_patch.array_get('file')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			print(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SKIP: '), var_name), rt.new_string(' — already patched (')), var_patch.array_get('marker')), rt.new_string(')\n')))
			continue
		}
		if rt.is_true(rt.identical(rt.call_function('strpos', [var_content.dup(), var_patch.array_get('search')]), rt.new_bool(false))) {
			print("FAIL: ${var_name.to_string()} — search string not found. File may have changed upstream.\n")
			var_failed = true
			continue
		}
		mut var_patched := rt.call_function('str_replace', [var_patch.array_get('search'), var_patch.array_get('replace'), var_content.dup()])
		rt.call_function('file_put_contents', [var_patch.array_get('file'), var_patched.dup()])
		print("OK:   ${var_name.to_string()} — patch applied\n")
	}
	if var_failed {
		print('\nSome patches failed. Please check the output above.\n')
		// unsupported expression: Expr_Exit
	}
	print('\nAll patches applied successfully.\n')
}
