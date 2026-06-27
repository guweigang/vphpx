module emitter

pub struct VarScope {
pub mut:
	declared map[string]bool
}

pub fn VarScope.new() VarScope {
	return VarScope{
		declared: map[string]bool{}
	}
}

// clone 克隆当前的 VarScope，复制 declared 的 map 避免引用共用
pub fn (s VarScope) clone() VarScope {
	return VarScope{
		declared: s.declared.clone()
	}
}

// has_var 检查变量是否已被声明
pub fn (s VarScope) has_var(name string) bool {
	return name in s.declared
}

// declare 标记变量为已声明
pub fn (mut s VarScope) declare(name string) {
	s.declared[name] = true
}
