module hybrid

import rt

// HybridManager 统筹管理所有实现了 IPhpObject 规范的系统内置/原生 V 混合类实例
pub struct HybridManager {
pub mut:
	instances map[string]rt.IPhpObject
}

fn get_hybrid_manager() &HybridManager {
	unsafe {
		mut static mgr := &HybridManager(nil)
		if mgr == nil {
			mut inst := map[string]rt.IPhpObject{}
			inst['pdo'] = new_v_pdo('mysql:host=localhost;dbname=test', 'root', '')
			inst['pdostatement'] = &VPdoStatement{ statement_sql: '' }
			inst['redis'] = new_v_redis()
			mgr = &HybridManager{
				instances: inst
			}
		}
		return mgr
	}
}

// dispatch_hybrid_method 统一按照 Class 路由到对象并触发由转译器/标准库定义的 dispatch_method 接口
pub fn dispatch_hybrid_method(func_name string, args []rt.PhpVal) rt.PhpVal {
	parts := func_name.split('::')
	if parts.len != 2 {
		return rt.new_null()
	}
	class_name := parts[0].to_lower()
	method_name := parts[1].to_lower()

	mut mgr := get_hybrid_manager()
	if mut obj := mgr.instances[class_name] {
		res := obj.dispatch_method(method_name, args) or { return rt.new_null() }
		return res
	}
	return rt.new_null()
}
