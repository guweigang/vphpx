import rt

struct Class_SimplePie_Cache_MySQL {
	rt.PhpObjectBase
pub mut:
		mysql rt.PhpVal = rt.new_null()
		options rt.PhpVal = rt.new_null()
		id rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_MySQL) construct(location string, name string, var_type rt.PhpVal) {
	this.options = rt.create_array([rt.ArrayItem{ key: 'user', val: rt.new_null() }, rt.ArrayItem{ key: 'pass', val: rt.new_null() }, rt.ArrayItem{ key: 'host', val: '127.0.0.1' }, rt.ArrayItem{ key: 'port', val: '3306' }, rt.ArrayItem{ key: 'path', val: '' }, rt.ArrayItem{ key: 'extras', val: rt.create_array([rt.ArrayItem{ key: 'prefix', val: '' }, rt.ArrayItem{ key: 'cache_purge_time', val: 2592000 }]) }])
	mut iife_temp_0 := Class_SimplePie_Cache_SimplePie_Cache{}
	mut iife_result_0 := iife_temp_0.parse_url(rt.new_string(location))
	this.options = rt.call_function('array_replace_recursive', [this.options, iife_result_0])
	this.options.array_set('dbname', rt.call_function('substr', [this.options.array_get(rt.new_string('path')), rt.new_int(1)]))
	this.mysql = create_simplepie_cache_pdo(rt.concat(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('mysql:dbname='), this.options.array_get(rt.new_string('dbname'))), rt.new_string(';host=')), this.options.array_get(rt.new_string('host'))), rt.new_string(';port=')), this.options.array_get(rt.new_string('port'))), this.options.array_get(rt.new_string('user')), this.options.array_get(rt.new_string('pass')), rt.create_array([rt.ArrayItem{ key: Class_SimplePie_Cache_PDO.mysql_attr_init_command(), val: 'SET NAMES utf8' }]))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SimplePie_Cache_PDOException') {
		mut var_e := var_e_1.clone()
		this.mysql = rt.new_null()
		return
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.id = name + (var_type).str()
	mut var_query := rt.call_method(this.mysql, 'query', [rt.new_string('SHOW TABLES')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_query)))) {
		this.mysql = rt.new_null()
		return
	}
	mut var_db := rt.new_array()
	mut var_row := rt.call_method(var_query, 'fetchColumn', []rt.PhpVal{})
	for rt.is_true(var_row) {
		var_db.array_push(var_row.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data'), var_db.clone()]))))) {
		var_query = rt.call_method(this.mysql, 'exec', [rt.new_string('CREATE TABLE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` (`id` TEXT CHARACTER SET utf8 NOT NULL, `items` SMALLINT NOT NULL DEFAULT 0, `data` BLOB NOT NULL, `mtime` INT UNSIGNED NOT NULL, UNIQUE (`id`(125)))')])
		if rt.is_true(rt.identical(var_query, rt.new_bool(false))) {
			rt.call_function('trigger_error', [rt.new_string('Can\'t create ' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data table, check permissions'), rt.get_constant('E_USER_WARNING')])
			this.mysql = rt.new_null()
			return
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string((this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items'), var_db.clone()]))))) {
		var_query = rt.call_method(this.mysql, 'exec', [rt.new_string('CREATE TABLE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` (`feed_id` TEXT CHARACTER SET utf8 NOT NULL, `id` TEXT CHARACTER SET utf8 NOT NULL, `data` MEDIUMBLOB NOT NULL, `posted` INT UNSIGNED NOT NULL, INDEX `feed_id` (`feed_id`(125)))')])
		if rt.is_true(rt.identical(var_query, rt.new_bool(false))) {
			rt.call_function('trigger_error', [rt.new_string('Can\'t create ' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items table, check permissions'), rt.get_constant('E_USER_WARNING')])
			this.mysql = rt.new_null()
			return
		}
	}
}

fn (mut this Class_SimplePie_Cache_MySQL) save(var_data rt.PhpVal) bool {
	mut var_database_ids := rt.new_null()
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(this.mysql, rt.new_null())) {
		return false
	}
	mut var_query := rt.call_method(this.mysql, 'prepare', [rt.new_string('DELETE i, cd FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` cd, ' + '`' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` i ' + 'WHERE cd.id = i.feed_id ' + 'AND cd.mtime < (unix_timestamp() - :purge_time)')])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':purge_time'), this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('cache_purge_time'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'SimplePie_Cache_SimplePie_SimplePie'))) {
		var_data_mutated = var_data_mutated.dup()
		mut iife_temp_1 := Class_SimplePie_Cache_MySQL{}
		mut iife_result_1 := iife_temp_1.prepare_simplepie_object_for_cache(var_data_mutated.clone())
		mut var_prepared := iife_result_1
		var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('SELECT COUNT(*) FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` WHERE `id` = :feed')])
		rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
		if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
			if rt.is_true(rt.greater(rt.call_method(var_query, 'fetchColumn', []rt.PhpVal{}), rt.new_int(0))) {
				mut var_items := rt.new_int(var_prepared.array_get(rt.new_int(1)).array_count())
				if rt.is_true(var_items) {
					mut var_sql := rt.new_string('UPDATE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` SET `items` = :items, `data` = :data, `mtime` = :time WHERE `id` = :feed')
					var_query = rt.call_method(this.mysql, 'prepare', [var_sql.clone()])
					rt.call_method(var_query, 'bindValue', [rt.new_string(':items'), var_items.clone()])
				} else {
				var_sql = rt.new_string('UPDATE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` SET `data` = :data, `mtime` = :time WHERE `id` = :feed')
				var_query = rt.call_method(this.mysql, 'prepare', [var_sql.clone()])
				}
				rt.call_method(var_query, 'bindValue', [rt.new_string(':data'), var_prepared.array_get(rt.new_int(0))])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':time'), rt.call_function('time', []rt.PhpVal{})])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{}))))) {
					return false
				}
			} else {
				var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('INSERT INTO `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` (`id`, `items`, `data`, `mtime`) VALUES(:feed, :count, :data, :time)')])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':count'), rt.new_int(var_prepared.array_get(rt.new_int(1)).array_count())])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':data'), var_prepared.array_get(rt.new_int(0))])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':time'), rt.call_function('time', []rt.PhpVal{})])
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{}))))) {
					return false
				}
			}
			mut var_ids := rt.func_array_keys(var_prepared.array_get(rt.new_int(1)))
			if !(!rt.is_true(var_ids)) {
				mut iter_1 := var_ids.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_id := item_1.val
					var_database_ids.array_push(rt.call_method(this.mysql, 'quote', [var_id.clone()]))
				}
				var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('SELECT `id` FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` WHERE `id` = ' + (rt.call_function('implode', [rt.new_string(' OR `id` = '), var_database_ids.clone()])).str() + ' AND `feed_id` = :feed')])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
				if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
					mut var_existing_ids := rt.new_array()
					mut var_row := rt.call_method(var_query, 'fetchColumn', []rt.PhpVal{})
					for rt.is_true(var_row) {
						var_existing_ids.array_push(var_row.clone())
					}
					mut var_new_ids := rt.call_function('array_diff', [var_ids.clone(), var_existing_ids.clone()])
					mut iter_2 := var_new_ids.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_new_id := item_2.val
						mut var_date := rt.call_method(var_prepared.array_get(rt.new_int(1)).array_get(var_new_id), 'get_date', [rt.new_string('U')])
						if rt.is_true(rt.new_bool(!(rt.is_true(var_date)))) {
						var_date = rt.call_function('time', []rt.PhpVal{})
						}
						var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('INSERT INTO `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` (`feed_id`, `id`, `data`, `posted`) VALUES(:feed, :id, :data, :date)')])
						rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
						rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), var_new_id.clone()])
						rt.call_method(var_query, 'bindValue', [rt.new_string(':data'), rt.call_function('serialize', [rt.get_property(var_prepared.array_get(rt.new_int(1)).array_get(var_new_id), 'data')])])
						rt.call_method(var_query, 'bindValue', [rt.new_string(':date'), var_date.clone()])
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{}))))) {
							return false
						}
					}
					return true
				}
			} else {
				return true
			}
		}
	} else {
		var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('SELECT `id` FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` WHERE `id` = :feed')])
		rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
		if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
			if rt.is_true(rt.greater(rt.call_method(var_query, 'rowCount', []rt.PhpVal{}), rt.new_int(0))) {
				var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('UPDATE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` SET `items` = 0, `data` = :data, `mtime` = :time WHERE `id` = :feed')])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':data'), rt.call_function('serialize', [var_data_mutated.clone()])])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':time'), rt.call_function('time', []rt.PhpVal{})])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
				if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
					return true
				}
			} else {
				var_query = rt.call_method(this.mysql, 'prepare', [rt.new_string('INSERT INTO `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` (`id`, `items`, `data`, `mtime`) VALUES(:id, 0, :data, :time)')])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), this.id])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':data'), rt.call_function('serialize', [var_data_mutated.clone()])])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':time'), rt.call_function('time', []rt.PhpVal{})])
				if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
					return true
				}
			}
		}
	}
	return false
}

fn (mut this Class_SimplePie_Cache_MySQL) load() bool {
	if rt.is_true(rt.identical(this.mysql, rt.new_null())) {
		return false
	}
	mut var_query := rt.call_method(this.mysql, 'prepare', [rt.new_string('SELECT `items`, `data` FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` WHERE `id` = :id')])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), this.id])
	mut var_row := rt.call_method(var_query, 'fetch', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) && rt.is_true(var_row) {
		mut var_data := rt.call_function('unserialize', [var_row.array_get(rt.new_int(1))])
		if this.options.array_get(rt.new_string('items')).array_isset(rt.new_int(0)) {
		mut var_items := rt.new_int((this.options.array_get(rt.new_string('items')).array_get(rt.new_int(0))).to_i64())
		} else {
		var_items = rt.new_int((var_row.array_get(rt.new_int(0))).to_i64())
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_items, rt.new_int(0))))) {
			if var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_isset(rt.new_int(0)) {
				mut var_feed := var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_get(rt.new_string('feed')).array_get(rt.new_int(0))
			} else if var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_isset(rt.new_int(0)) {
				var_feed = var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_03()).array_get(rt.new_string('feed')).array_get(rt.new_int(0))
			} else if var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_isset(rt.new_int(0)) {
				var_feed = var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rdf()).array_get(rt.new_string('RDF')).array_get(rt.new_int(0))
			} else if var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_isset(rt.new_int(0)) {
				var_feed = var_data.array_get(rt.new_string('child')).array_get(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_rss_20()).array_get(rt.new_string('rss')).array_get(rt.new_int(0))
			} else {
			var_feed = rt.new_null()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_feed, rt.new_null())))) {
				mut var_sql := rt.new_string('SELECT `data` FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` WHERE `feed_id` = :feed ORDER BY `posted` DESC')
				if rt.is_true(rt.greater(var_items, rt.new_int(0))) {
					var_sql = rt.concat(var_sql, rt.new_string(' LIMIT ' + (var_items).str()))
				}
				var_query = rt.call_method(this.mysql, 'prepare', [var_sql.clone()])
				rt.call_method(var_query, 'bindValue', [rt.new_string(':feed'), this.id])
				if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) {
					var_row = rt.call_method(var_query, 'fetchColumn', []rt.PhpVal{})
					for rt.is_true(var_row) {
						var_feed.array_get_mut('child').array_get_mut(Class_SimplePie_Cache_SimplePie_SimplePie.namespace_atom_10()).array_get_mut('entry').array_push(rt.call_function('unserialize', [rt.new_string((var_row).str())]))
					}
				} else {
					return false
				}
			}
		}
		return (var_data).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Cache_MySQL) mtime() rt.PhpVal {
	if rt.is_true(rt.identical(this.mysql, rt.new_null())) {
		return rt.new_bool(false)
	}
	mut var_query := rt.call_method(this.mysql, 'prepare', [rt.new_string('SELECT `mtime` FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` WHERE `id` = :id')])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), this.id])
	mut var_time := rt.call_method(var_query, 'fetchColumn', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) && rt.is_true(var_time) {
		return rt.new_int((var_time).to_i64())
	}
	return rt.new_bool(false)
}

fn (mut this Class_SimplePie_Cache_MySQL) touch() bool {
	if rt.is_true(rt.identical(this.mysql, rt.new_null())) {
		return false
	}
	mut var_query := rt.call_method(this.mysql, 'prepare', [rt.new_string('UPDATE `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` SET `mtime` = :time WHERE `id` = :id')])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':time'), rt.call_function('time', []rt.PhpVal{})])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), this.id])
	return rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) && rt.is_true(rt.greater(rt.call_method(var_query, 'rowCount', []rt.PhpVal{}), rt.new_int(0)))
}

fn (mut this Class_SimplePie_Cache_MySQL) unlink() bool {
	if rt.is_true(rt.identical(this.mysql, rt.new_null())) {
		return false
	}
	mut var_query := rt.call_method(this.mysql, 'prepare', [rt.new_string('DELETE FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'cache_data` WHERE `id` = :id')])
	rt.call_method(var_query, 'bindValue', [rt.new_string(':id'), this.id])
	mut var_query2 := rt.call_method(this.mysql, 'prepare', [rt.new_string('DELETE FROM `' + (this.options.array_get(rt.new_string('extras')).array_get(rt.new_string('prefix'))).str() + 'items` WHERE `feed_id` = :id')])
	rt.call_method(var_query2, 'bindValue', [rt.new_string(':id'), this.id])
	return rt.is_true(rt.call_method(var_query, 'execute', []rt.PhpVal{})) && rt.is_true(rt.call_method(var_query2, 'execute', []rt.PhpVal{}))
}

struct Class_SimplePie_Cache_DB {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_SimplePie_Cache_PDO {
	rt.PhpObjectBase
}

fn create_simplepie_cache_mysql(location string, name string, arg_2 rt.PhpVal) &Class_SimplePie_Cache_MySQL {
	mut obj := &Class_SimplePie_Cache_MySQL{
		PhpObjectBase: rt.PhpObjectBase{}
		mysql: rt.new_null()
		options: rt.new_null()
		id: rt.new_null()
	}
	obj.construct(location, name, arg_2)
	return obj
}

fn create_simplepie_cache_db(_args ...rt.PhpVal) &Class_SimplePie_Cache_DB {
	mut obj := &Class_SimplePie_Cache_DB{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_simplepie_cache(_args ...rt.PhpVal) &Class_SimplePie_Cache_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache_SimplePie_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache_pdo(_args ...rt.PhpVal) &Class_SimplePie_Cache_PDO {
	mut obj := &Class_SimplePie_Cache_PDO{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Cache_MySQL) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.save(dispatch_arg_0))
		}
		'load' {
			return rt.new_bool(this.load())
		}
		'mtime' {
			return this.mtime()
		}
		'touch' {
			return rt.new_bool(this.touch())
		}
		'unlink' {
			return rt.new_bool(this.unlink())
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Cache_MySQL) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'mysql' { return this.mysql }
		'options' { return this.options }
		'id' { return this.id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_MySQL) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'mysql' { this.mysql = val; return true }
		'options' { this.options = val; return true }
		'id' { this.id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_SimplePie_Cache_DB) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_DB) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_DB) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Cache_SimplePie_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_SimplePie_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_SimplePie_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SimplePie_Cache_PDO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache_PDO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache_PDO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Cache\\MySQL'), rt.new_string('SimplePie_Cache_MySQL')])
}
