import rt

struct Class_VHttpd_DbGateway_PDOStatement {
	rt.PhpObjectBase
pub mut:
		bindings rt.PhpVal = rt.new_array()
		rows rt.PhpVal = rt.new_array()
		cursor i64
		affectedRows rt.PhpVal = rt.new_int(0)
		lastInsertId rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) construct(mut var_pdo Class_VHttpd_DbGateway_PDO, sql string)  {
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) bindvalue(mut var_param Class_VHttpd_DbGateway_{"nodeType":"UnionType","line":24,"types":["int","string"]}, mut var_value Class_VHttpd_DbGateway_mixed) bool {
	this.bindings.array_set(var_param, var_value.dup())
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) bindparam(mut var_param Class_VHttpd_DbGateway_{"nodeType":"UnionType","line":30,"types":["int","string"]}, mut var_value Class_VHttpd_DbGateway_mixed) bool {
	this.bindings.array_set(var_param, var_value.dup())
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) execute(mut var_params Class_VHttpd_DbGateway_?array) bool {
	mut var_bindings := if !(var_params).is_null() { var_params } else { this.bindings }
	mut var_ordered := this.normalizebindings(mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](var_bindings))
	this.cursor = 0
	if rt.is_true(rt.call_method(rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'pdo'), 'isQuerySql', [rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'sql')])) {
		mut var_result := rt.call_method(rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'pdo'), 'gatewayQuery', [rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'sql'), var_ordered.dup()])
		this.rows = this.normalizerows(mut rt.cast_object_ptr[Class_VHttpd_DbGateway_mixed](if !(var_result.array_get('rows')).is_null() { var_result.array_get('rows') } else { rt.new_array() }))
		this.affectedRows = // unsupported expression: Expr_Cast_Int
		this.lastInsertId = if var_result.array_isset(rt.new_string('last_insert_id')) { // unsupported expression: Expr_Cast_String } else { rt.new_null() }
		return true
	}
	var_result = rt.call_method(rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'pdo'), 'gatewayExecute', [rt.get_property(rt.new_object('VHttpd_DbGateway_PDOStatement', []string{}, &this), 'sql'), var_ordered.dup()])
	this.rows = rt.new_array()
	this.affectedRows = // unsupported expression: Expr_Cast_Int
	this.lastInsertId = if var_result.array_isset(rt.new_string('last_insert_id')) { // unsupported expression: Expr_Cast_String } else { rt.new_null() }
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) fetch() bool {
	if !(this.rows.array_isset(this.cursor)) {
		return false
	}
	return (this.rows.array_get(rt.post_inc(this.cursor))).to_bool()
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) fetchall() rt.PhpVal {
	return this.rows
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) rowcount() i64 {
	return (if rt.is_true(rt.greater(this.affectedRows, rt.new_int(0))) { this.affectedRows } else { rt.new_int(this.rows.array_count()) }).to_i64()
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) lastinsertid() string {
	return (this.lastInsertId).str()
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) normalizebindings(mut var_bindings Class_VHttpd_DbGateway_array) rt.PhpVal {
	mut var_bindings_mutated := var_bindings
	if rt.is_true(rt.identical(var_bindings_mutated, rt.new_array())) {
		return rt.new_array()
	}
	mut var_allNumeric := rt.new_bool(rt.new_bool(true))
	{
		mut iter_1 := rt.func_array_keys(var_bindings_mutated.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_k := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_k.dup().is_long()))))) {
				var_allNumeric = rt.new_bool(rt.new_bool(false))
				break
			}
		}
	}
	if rt.is_true(var_allNumeric) {
		rt.call_function('ksort', [var_bindings_mutated.dup()])
		return rt.call_function('array_values', [var_bindings_mutated.dup()])
	}
	mut var_ordered := rt.new_array()
	{
		mut iter_1 := var_bindings_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			var_ordered.array_push(var_value.dup())
		}
	}
	return var_ordered.dup()
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) normalizerows(mut var_rows Class_VHttpd_DbGateway_mixed) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_rows.is_array()))))) {
		return rt.new_array()
	}
	mut var_out := rt.new_array()
	{
		mut iter_1 := var_rows.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_row := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_row.dup().is_array()))))) {
				continue
			}
			mut var_normalized := rt.new_array()
			{
				mut iter_2 := var_row.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_v := item_2.val
					mut var_k := item_2.key
					var_normalized.array_set(// unsupported expression: Expr_Cast_String, var_v.dup())
				}
			}
			var_out.array_push(var_normalized.dup())
		}
	}
	return var_out.dup()
}

fn create_vhttpd_dbgateway_pdostatement(arg_0 rt.PhpVal, sql string) &Class_VHttpd_DbGateway_PDOStatement {
	mut obj := &Class_VHttpd_DbGateway_PDOStatement{
		PhpObjectBase: rt.PhpObjectBase{}
		bindings: rt.new_array()
		rows: rt.new_array()
		cursor: i64(0)
		affectedRows: rt.new_int(0)
		lastInsertId: rt.new_null()
	}
	obj.construct(arg_0, sql)
	return obj
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_PDO](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.construct(mut dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'bindValue' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_{"nodeType":"UnionType","line":24,"types":["int","string"]}](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_mixed](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.bindvalue(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'bindParam' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_{"nodeType":"UnionType","line":30,"types":["int","string"]}](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_mixed](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.bindparam(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'execute' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.execute(mut dispatch_arg_0))
		}
		'fetch' {
			return rt.new_bool(this.fetch())
		}
		'fetchAll' {
			return this.fetchall()
		}
		'rowCount' {
			return rt.new_int(this.rowcount())
		}
		'lastInsertId' {
			return rt.new_string(this.lastinsertid())
		}
		'normalizeBindings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.normalizebindings(mut dispatch_arg_0)
		}
		'normalizeRows' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_VHttpd_DbGateway_mixed](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.normalizerows(mut dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_DbGateway_PDOStatement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'bindings' { return this.bindings }
		'rows' { return this.rows }
		'cursor' { return rt.new_int(this.cursor) }
		'affectedRows' { return this.affectedRows }
		'lastInsertId' { return this.lastInsertId }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'bindings' { this.bindings = val; return true }
		'rows' { this.rows = val; return true }
		'cursor' { this.cursor = (val).to_i64(); return true }
		'affectedRows' { this.affectedRows = val; return true }
		'lastInsertId' { this.lastInsertId = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_dbgateway_pdostatement_php() {
	// unsupported statement: Stmt_Declare
}
