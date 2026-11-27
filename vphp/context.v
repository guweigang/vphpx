module vphp

import vphp.zend as _

// ============================================
// Context — PHP 函数调用上下文
// ============================================

pub struct Context {
pub:
	ex  ZendExecuteData
	ret PhpReturn
}

// ======== 构造与基础状态 ========

pub fn Context.from_ptr(ex voidptr, ret voidptr) Context {
	return Context{
		ex:  ZendExecuteData.from_ptr(ex)
		ret: PhpReturn.from_ptr(ret)
	}
}

pub fn (ctx Context) arg_at(index int) PhpArg {
	return ctx.arg_named(index, '')
}

pub fn (ctx Context) arg_named(index int, name string) PhpArg {
	return ctx.ex.php_arg(index, name)
}

pub fn (ctx Context) arg_meta(meta PhpArgMeta) PhpArg {
	return ctx.ex.php_arg_meta(meta)
}

pub fn (ctx Context) args() PhpArgs {
	return ctx.args_with_meta([]PhpArgMeta{})
}

pub fn (ctx Context) args_with_meta(metas []PhpArgMeta) PhpArgs {
	return PhpArgs.new(ctx.arg_items(metas, 0))
}

fn (ctx Context) arg_items(metas []PhpArgMeta, min_capacity int) []PhpArg {
	num := ctx.num_args()
	mut indexed := true
	for index, meta in metas {
		if meta.index != index {
			indexed = false
			break
		}
	}
	capacity := if num > min_capacity { num } else { min_capacity }
	mut items := []PhpArg{cap: capacity}
	for index in 0 .. num {
		mut arg_meta := PhpArgMeta{
			index: index
		}
		if indexed {
			if index < metas.len {
				arg_meta = metas[index]
			}
		} else {
			for meta in metas {
				if meta.index == index {
					arg_meta = meta
					break
				}
			}
		}
		items << ctx.arg_meta(arg_meta.with_attribute_target(.parameter))
	}
	return items
}

pub fn (ctx Context) args_with_php_defaults(metas []PhpArgMeta) !PhpArgs {
	mut items := ctx.arg_items(metas, metas.len)
	for meta in metas {
		if !meta.use_php_default || meta.index < 0
			|| (meta.index < items.len && items[meta.index].is_present()) {
			continue
		}
		arg := ctx.ex.php_arg_default(meta.with_attribute_target(.parameter))!
		for items.len <= meta.index {
			items << PhpArg.from_value(PhpValue.invalid())
		}
		items[meta.index] = arg
	}
	return PhpArgs.new(items)
}

pub fn (ctx Context) @return() PhpReturn {
	return ctx.ret
}

pub fn (ctx Context) num_args() int {
	return ctx.ex.num_args()
}

pub fn (ctx Context) active_class_entry() ZendClassEntry {
	return ctx.ex.active_class_entry()
}
