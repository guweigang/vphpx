import rt

interface ISO3166DataProvider {
	name(rt.PhpVal) rt.PhpVal
	alpha2(rt.PhpVal) rt.PhpVal
	alpha3(rt.PhpVal) rt.PhpVal
	numeric(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_league_iso3166_iso3166dataprovider_php() {
	mut var_name := rt.new_null()
	mut var_alpha2 := rt.new_null()
	mut var_alpha3 := rt.new_null()
	mut var_numeric := rt.new_null()
	// unsupported statement: Stmt_Declare
}
