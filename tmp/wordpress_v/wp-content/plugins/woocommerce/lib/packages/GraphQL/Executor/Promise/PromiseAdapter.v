import rt

interface PromiseAdapter {
	isthenable(rt.PhpVal) rt.PhpVal
	convertthenable(rt.PhpVal) rt.PhpVal
	then(rt.PhpVal, rt.PhpVal, rt.PhpVal) rt.PhpVal
	create(rt.PhpVal) rt.PhpVal
	createfulfilled(rt.PhpVal) rt.PhpVal
	createrejected(rt.PhpVal) rt.PhpVal
	all(rt.PhpVal) rt.PhpVal
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_executor_promise_promiseadapter_php() {
	mut var_value := rt.new_null()
	mut var_thenable := rt.new_null()
	mut var_promise := rt.new_null()
	mut var_onFulfilled := rt.new_null()
	mut var_onRejected := rt.new_null()
	mut var_resolver := rt.new_null()
	mut var_reason := rt.new_null()
	mut var_promisesOrValues := rt.new_null()
	// unsupported statement: Stmt_Declare
}
