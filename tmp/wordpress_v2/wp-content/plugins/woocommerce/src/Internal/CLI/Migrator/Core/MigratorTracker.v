import rt

pub fn Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name() string {
	return 'wc_migrator_analytics'
}

struct Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker {
	rt.PhpObjectBase
pub mut:
	current_session rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) construct() {
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) init_hooks() {
	rt.call_function('add_action', [rt.new_string('wc_migrator_session_started'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_session_started' },
		]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('wc_migrator_batch_processed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_batch_processed' },
		]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wc_migrator_session_completed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'on_session_completed' },
		]),
		rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) on_session_started(platform string, mut var_metadata Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut platform_mutated := platform
	this.current_session = rt.create_array([
		rt.ArrayItem{ key: 'platform', val: platform_mutated },
		rt.ArrayItem{ key: 'started_at', val: rt.call_function('time', []rt.PhpVal{}) },
		rt.ArrayItem{ key: 'products_total', val: 0 },
		rt.ArrayItem{ key: 'products_attempted', val: 0 },
		rt.ArrayItem{ key: 'products_successful', val: 0 },
		rt.ArrayItem{ key: 'products_failed', val: 0 },
		rt.ArrayItem{ key: 'products_skipped', val: 0 },
		rt.ArrayItem{ key: 'product_types', val: rt.new_array() },
		rt.ArrayItem{ key: 'total_time', val: 0 },
		rt.ArrayItem{
			key: 'is_dry_run'
			val: if !(var_metadata.array_get(rt.new_string('is_dry_run'))).is_null() {
				var_metadata.array_get(rt.new_string('is_dry_run'))
			} else {
				rt.new_bool(false)
			}
		},
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) on_batch_processed(mut var_batch_results Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_source_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_mapped_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	if !rt.is_true(this.current_session) {
		return
	}
	mut var_batch_stats := if !(var_batch_results.array_get(rt.new_string('stats'))).is_null() {
		var_batch_results.array_get(rt.new_string('stats'))
	} else {
		rt.new_array()
	}
	this.current_session.array_get(rt.new_string('products_attempted')) = rt.add(this.current_session.array_get(rt.new_string('products_attempted')),
		rt.new_int(var_mapped_data.array_count()))
	this.current_session.array_get(rt.new_string('products_successful')) = rt.add(this.current_session.array_get(rt.new_string('products_successful')), if !(var_batch_stats.array_get(rt.new_string('successful'))).is_null() {
		var_batch_stats.array_get(rt.new_string('successful'))
	} else {
		rt.new_int(0)
	})
	this.current_session.array_get(rt.new_string('products_failed')) = rt.add(this.current_session.array_get(rt.new_string('products_failed')), if !(var_batch_stats.array_get(rt.new_string('failed'))).is_null() {
		var_batch_stats.array_get(rt.new_string('failed'))
	} else {
		rt.new_int(0)
	})
	this.current_session.array_get(rt.new_string('products_skipped')) = rt.add(this.current_session.array_get(rt.new_string('products_skipped')), if !(var_batch_stats.array_get(rt.new_string('skipped'))).is_null() {
		var_batch_stats.array_get(rt.new_string('skipped'))
	} else {
		rt.new_int(0)
	})
	this.track_product_types(mut var_mapped_data, mut var_batch_results)
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) on_session_completed(platform string, mut var_final_stats Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut platform_mutated := platform
	if !rt.is_true(this.current_session) {
		if rt.is_true(rt.call_function('function_exists', [
			rt.new_string('wc_get_logger'),
		]))
		{
			rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'warning', [
				rt.new_string('Migration session completed event fired without active session.'),
				rt.create_array([rt.ArrayItem{ key: 'source', val: 'migrator_tracker' }]),
			])
		}
		return
	}
	mut var_completion_time := rt.call_function('time', []rt.PhpVal{})
	this.current_session.array_set('total_time', rt.sub(var_completion_time,
		this.current_session.array_get(rt.new_string('started_at'))))
	this.current_session.array_set('completed_at', var_completion_time.clone())
	this.current_session.array_set('products_total', if !(var_final_stats.array_get(rt.new_string('total_found'))).is_null() {
		var_final_stats.array_get(rt.new_string('total_found'))
	} else {
		this.current_session.array_get(rt.new_string('products_attempted'))
	})
	this.save_session_data()
	this.current_session = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) track_product_types(mut var_mapped_data Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array, mut var_batch_results Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	mut var_successful_results := rt.call_function('array_filter', [if !(var_batch_results.array_get(rt.new_string('results'))).is_null() {
		var_batch_results.array_get(rt.new_string('results'))
	} else {
		rt.new_array()
	}, rt.new_closure(closure_1_fn)])
	mut iter_1 := var_successful_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result := item_1.val
		mut var_index := item_1.key
		if !(var_mapped_data.array_isset(var_index)) {
			continue
		}
		mut var_product := var_mapped_data.array_get(var_index)
		mut var_type := if !(var_product.array_get(rt.new_string('type'))).is_null() {
			var_product.array_get(rt.new_string('type'))
		} else {
			rt.new_string('simple')
		}
		if !(this.current_session.array_get(rt.new_string('product_types')).array_isset(var_type)) {
			this.current_session.array_get_mut('product_types').array_set(var_type, 0)
		}
		rt.pre_inc(this.current_session.array_get(rt.new_string('product_types')).array_get(var_type))
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) save_session_data() {
	mut var_platform_data := rt.new_null()
	mut var_analytics := this.get_stored_analytics()
	mut var_platform := this.current_session.array_get(rt.new_string('platform'))
	if !(var_analytics.array_get(rt.new_string('platforms')).array_isset(var_platform)) {
		var_analytics.array_get_mut('platforms').array_set(var_platform, rt.create_array([
			rt.ArrayItem{ key: 'total_products_attempted', val: 0 },
			rt.ArrayItem{ key: 'total_products_successful', val: 0 },
			rt.ArrayItem{ key: 'total_products_failed', val: 0 },
			rt.ArrayItem{ key: 'total_products_skipped', val: 0 },
			rt.ArrayItem{ key: 'total_sessions', val: 0 },
			rt.ArrayItem{ key: 'total_time', val: 0 },
			rt.ArrayItem{ key: 'product_types', val: rt.new_array() },
			rt.ArrayItem{ key: 'last_migration', val: rt.new_null() },
			rt.ArrayItem{ key: 'dry_run_sessions', val: 0 },
		]))
	}
	var_platform_data = var_analytics.array_get(rt.new_string('platforms')).array_get(var_platform)
	mut var_products_attempted := if !(this.current_session.array_get(rt.new_string('products_attempted'))).is_null() {
		this.current_session.array_get(rt.new_string('products_attempted'))
	} else {
		rt.new_int(0)
	}
	mut var_products_successful := if !(this.current_session.array_get(rt.new_string('products_successful'))).is_null() {
		this.current_session.array_get(rt.new_string('products_successful'))
	} else {
		rt.new_int(0)
	}
	mut var_products_failed := if !(this.current_session.array_get(rt.new_string('products_failed'))).is_null() {
		this.current_session.array_get(rt.new_string('products_failed'))
	} else {
		rt.new_int(0)
	}
	mut var_products_skipped := if !(this.current_session.array_get(rt.new_string('products_skipped'))).is_null() {
		this.current_session.array_get(rt.new_string('products_skipped'))
	} else {
		rt.new_int(0)
	}
	mut var_total_time := if !(this.current_session.array_get(rt.new_string('total_time'))).is_null() {
		this.current_session.array_get(rt.new_string('total_time'))
	} else {
		rt.new_int(0)
	}
	mut var_completed_at := if !(this.current_session.array_get(rt.new_string('completed_at'))).is_null() {
		this.current_session.array_get(rt.new_string('completed_at'))
	} else {
		rt.call_function('time', []rt.PhpVal{})
	}
	mut var_product_types := if !(this.current_session.array_get(rt.new_string('product_types'))).is_null() {
		this.current_session.array_get(rt.new_string('product_types'))
	} else {
		rt.new_array()
	}
	mut var_is_dry_run := if !(this.current_session.array_get(rt.new_string('is_dry_run'))).is_null() {
		this.current_session.array_get(rt.new_string('is_dry_run'))
	} else {
		rt.new_bool(false)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dry_run)))) {
		var_platform_data.array_get(rt.new_string('total_products_attempted')) = rt.add(var_platform_data.array_get(rt.new_string('total_products_attempted')),
			var_products_attempted)
		var_platform_data.array_get(rt.new_string('total_products_successful')) = rt.add(var_platform_data.array_get(rt.new_string('total_products_successful')),
			var_products_successful)
		var_platform_data.array_get(rt.new_string('total_products_failed')) = rt.add(var_platform_data.array_get(rt.new_string('total_products_failed')),
			var_products_failed)
		var_platform_data.array_get(rt.new_string('total_products_skipped')) = rt.add(var_platform_data.array_get(rt.new_string('total_products_skipped')),
			var_products_skipped)
		var_platform_data.array_set('last_migration', var_completed_at.clone())
	} else {
		rt.pre_inc(var_platform_data.array_get(rt.new_string('dry_run_sessions')))
	}
	rt.pre_inc(var_platform_data.array_get(rt.new_string('total_sessions')))
	var_platform_data.array_get(rt.new_string('total_time')) = rt.add(var_platform_data.array_get(rt.new_string('total_time')),
		var_total_time)
	mut iter_2 := var_product_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_count := item_2.val
		mut var_type := item_2.key
		if !(var_platform_data.array_get(rt.new_string('product_types')).array_isset(var_type)) {
			var_platform_data.array_get_mut('product_types').array_set(var_type, 0)
		}
		var_platform_data.array_get(rt.new_string('product_types')).array_get(var_type) = rt.add(var_platform_data.array_get(rt.new_string('product_types')).array_get(var_type),
			var_count)
	}
	if !(var_analytics.array_isset(rt.new_string('totals')))
		|| !(var_analytics.array_get(rt.new_string('totals')).is_array()) {
		var_analytics.array_set('totals', rt.new_array())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_dry_run)))) {
		var_analytics.array_get_mut('totals').array_set('products_attempted', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_attempted'))).is_null() {
			var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_attempted'))
		} else {
			rt.new_int(0)
		}, var_products_attempted))
		var_analytics.array_get_mut('totals').array_set('products_successful', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_successful'))).is_null() {
			var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_successful'))
		} else {
			rt.new_int(0)
		}, var_products_successful))
		var_analytics.array_get_mut('totals').array_set('products_failed', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_failed'))).is_null() {
			var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_failed'))
		} else {
			rt.new_int(0)
		}, var_products_failed))
		var_analytics.array_get_mut('totals').array_set('products_skipped', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_skipped'))).is_null() {
			var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('products_skipped'))
		} else {
			rt.new_int(0)
		}, var_products_skipped))
	}
	var_analytics.array_get_mut('totals').array_set('total_sessions', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('total_sessions'))).is_null() {
		var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('total_sessions'))
	} else {
		rt.new_int(0)
	}, rt.new_int(1)))
	var_analytics.array_get_mut('totals').array_set('total_migration_time', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('total_migration_time'))).is_null() {
		var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('total_migration_time'))
	} else {
		rt.new_int(0)
	}, var_total_time))
	var_analytics.array_get_mut('totals').array_set('dry_run_sessions', rt.add(if !(var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('dry_run_sessions'))).is_null() {
		var_analytics.array_get(rt.new_string('totals')).array_get(rt.new_string('dry_run_sessions'))
	} else {
		rt.new_int(0)
	}, if rt.is_true(var_is_dry_run) { 1 } else { 0 }))
	this.save_analytics(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_analytics))
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) get_data() rt.PhpVal {
	mut var_analytics := this.get_stored_analytics()
	mut var_totals := if !(var_analytics.array_get(rt.new_string('totals'))).is_null() {
		var_analytics.array_get(rt.new_string('totals'))
	} else {
		rt.new_array()
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'products_attempted'
			val: if !(var_totals.array_get(rt.new_string('products_attempted'))).is_null() {
				var_totals.array_get(rt.new_string('products_attempted'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'products_successful'
			val: if !(var_totals.array_get(rt.new_string('products_successful'))).is_null() {
				var_totals.array_get(rt.new_string('products_successful'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'products_failed'
			val: if !(var_totals.array_get(rt.new_string('products_failed'))).is_null() {
				var_totals.array_get(rt.new_string('products_failed'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'products_skipped'
			val: if !(var_totals.array_get(rt.new_string('products_skipped'))).is_null() {
				var_totals.array_get(rt.new_string('products_skipped'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'total_migration_sessions'
			val: if !(var_totals.array_get(rt.new_string('total_sessions'))).is_null() {
				var_totals.array_get(rt.new_string('total_sessions'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'total_migration_time'
			val: if !(var_totals.array_get(rt.new_string('total_migration_time'))).is_null() {
				var_totals.array_get(rt.new_string('total_migration_time'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{
			key: 'dry_run_sessions'
			val: if !(var_totals.array_get(rt.new_string('dry_run_sessions'))).is_null() {
				var_totals.array_get(rt.new_string('dry_run_sessions'))
			} else {
				rt.new_int(0)
			}
		},
		rt.ArrayItem{ key: 'platforms_used', val: rt.func_array_keys(if !(var_analytics.array_get(rt.new_string('platforms'))).is_null() {
			var_analytics.array_get(rt.new_string('platforms'))
		} else {
			rt.new_array()
		}) },
		rt.ArrayItem{ key: 'platform_breakdown', val: rt.new_array() },
		rt.ArrayItem{
			key: 'success_rate'
			val: this.calculate_success_rate(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_totals))
		},
	])
	mut var_platforms := if !(var_analytics.array_get(rt.new_string('platforms'))).is_null() {
		var_analytics.array_get(rt.new_string('platforms'))
	} else {
		rt.new_array()
	}
	mut iter_3 := var_platforms.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_platform_data := item_3.val
		mut var_platform := item_3.key
		var_data.array_get_mut('platform_breakdown').array_set(var_platform, rt.create_array([
			rt.ArrayItem{
				key: 'products_attempted'
				val: if !(var_platform_data.array_get(rt.new_string('total_products_attempted'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_products_attempted'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'products_successful'
				val: if !(var_platform_data.array_get(rt.new_string('total_products_successful'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_products_successful'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'products_failed'
				val: if !(var_platform_data.array_get(rt.new_string('total_products_failed'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_products_failed'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'products_skipped'
				val: if !(var_platform_data.array_get(rt.new_string('total_products_skipped'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_products_skipped'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'sessions_count'
				val: if !(var_platform_data.array_get(rt.new_string('total_sessions'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_sessions'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'dry_run_sessions'
				val: if !(var_platform_data.array_get(rt.new_string('dry_run_sessions'))).is_null() {
					var_platform_data.array_get(rt.new_string('dry_run_sessions'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'total_time'
				val: if !(var_platform_data.array_get(rt.new_string('total_time'))).is_null() {
					var_platform_data.array_get(rt.new_string('total_time'))
				} else {
					rt.new_int(0)
				}
			},
			rt.ArrayItem{
				key: 'product_types'
				val: if !(var_platform_data.array_get(rt.new_string('product_types'))).is_null() {
					var_platform_data.array_get(rt.new_string('product_types'))
				} else {
					rt.new_array()
				}
			},
			rt.ArrayItem{
				key: 'last_migration'
				val: if !(var_platform_data.array_get(rt.new_string('last_migration'))).is_null() {
					var_platform_data.array_get(rt.new_string('last_migration'))
				} else {
					rt.new_null()
				}
			},
			rt.ArrayItem{
				key: 'success_rate'
				val: this.calculate_success_rate(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](var_platform_data))
			},
		]))
	}
	return var_data.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) calculate_success_rate(mut var_stats Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) f64 {
	mut var_attempted := if !(var_stats.array_get(rt.new_string('total_products_attempted'))).is_null() {
		var_stats.array_get(rt.new_string('total_products_attempted'))
	} else {
		if !(var_stats.array_get(rt.new_string('products_attempted'))).is_null() {
			var_stats.array_get(rt.new_string('products_attempted'))
		} else {
			rt.new_int(0)
		}
	}
	mut var_successful := if !(var_stats.array_get(rt.new_string('total_products_successful'))).is_null() {
		var_stats.array_get(rt.new_string('total_products_successful'))
	} else {
		if !(var_stats.array_get(rt.new_string('products_successful'))).is_null() {
			var_stats.array_get(rt.new_string('products_successful'))
		} else {
			rt.new_int(0)
		}
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_attempted)) {
		return 0
	}
	return (rt.call_function('round', [
		rt.mul(rt.div(var_successful, var_attempted), rt.new_int(100)),
		rt.new_int(2),
	])).to_f64()
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) get_stored_analytics() rt.PhpVal {
	mut var_defaults := rt.create_array([
		rt.ArrayItem{ key: 'totals', val: rt.create_array([
			rt.ArrayItem{ key: 'products_attempted', val: 0 },
			rt.ArrayItem{ key: 'products_successful', val: 0 },
			rt.ArrayItem{ key: 'products_failed', val: 0 },
			rt.ArrayItem{ key: 'products_skipped', val: 0 },
			rt.ArrayItem{ key: 'total_sessions', val: 0 },
			rt.ArrayItem{ key: 'total_migration_time', val: 0 },
			rt.ArrayItem{ key: 'dry_run_sessions', val: 0 },
		]) },
		rt.ArrayItem{ key: 'platforms', val: rt.new_array() },
	])
	mut var_stored := rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name(),
		rt.new_array(),
	])
	return rt.call_function('wp_parse_args', [var_stored.clone(),
		var_defaults.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) save_analytics(mut var_analytics Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array) {
	mut var_analytics_mutated := var_analytics
	if rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('get_option', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name(),
	])))
	{
		rt.call_function('add_option', [
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name(),
			var_analytics_mutated,
			rt.new_string(''),
			rt.new_string('no'),
		])
	} else {
		rt.call_function('update_option', [
			Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name(),
			var_analytics_mutated,
			rt.new_string('no'),
		])
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) clear_data() {
	rt.call_function('delete_option', [
		Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker.option_name(),
	])
	this.current_session = rt.new_array()
}

fn create_automattic_woocommerce_internal_cli_migrator_core_migratortracker() &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker {
	mut obj := &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker{
		PhpObjectBase:   rt.PhpObjectBase{}
		current_session: rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'on_session_started' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.on_session_started(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'on_batch_processed' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			this.on_batch_processed(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'on_session_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.on_session_completed(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'track_product_types' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.track_product_types(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'save_session_data' {
			this.save_session_data()
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		'calculate_success_rate' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_float(this.calculate_success_rate(mut dispatch_arg_0))
		}
		'get_stored_analytics' {
			return this.get_stored_analytics()
		}
		'save_analytics' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.save_analytics(mut dispatch_arg_0)
			return rt.new_null()
		}
		'clear_data' {
			this.clear_data()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'current_session' { return this.current_session }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_CLI_Migrator_Core_MigratorTracker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'current_session' {
			this.current_session = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
