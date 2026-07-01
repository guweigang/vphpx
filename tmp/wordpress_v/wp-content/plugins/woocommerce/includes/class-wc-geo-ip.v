import rt

pub fn Class_WC_Geo_IP.geoip_country_begin() i64 {
	return 16776960
}
pub fn Class_WC_Geo_IP.geoip_state_begin_rev0() i64 {
	return 16700000
}
pub fn Class_WC_Geo_IP.geoip_state_begin_rev1() i64 {
	return 16000000
}
pub fn Class_WC_Geo_IP.geoip_memory_cache() i64 {
	return 1
}
pub fn Class_WC_Geo_IP.geoip_shared_memory() i64 {
	return 2
}
pub fn Class_WC_Geo_IP.structure_info_max_size() i64 {
	return 20
}
pub fn Class_WC_Geo_IP.geoip_country_edition() i64 {
	return 1
}
pub fn Class_WC_Geo_IP.geoip_proxy_edition() i64 {
	return 8
}
pub fn Class_WC_Geo_IP.geoip_asnum_edition() i64 {
	return 9
}
pub fn Class_WC_Geo_IP.geoip_netspeed_edition() i64 {
	return 10
}
pub fn Class_WC_Geo_IP.geoip_region_edition_rev0() i64 {
	return 7
}
pub fn Class_WC_Geo_IP.geoip_region_edition_rev1() i64 {
	return 3
}
pub fn Class_WC_Geo_IP.geoip_city_edition_rev0() i64 {
	return 6
}
pub fn Class_WC_Geo_IP.geoip_city_edition_rev1() i64 {
	return 2
}
pub fn Class_WC_Geo_IP.geoip_org_edition() i64 {
	return 5
}
pub fn Class_WC_Geo_IP.geoip_isp_edition() i64 {
	return 4
}
pub fn Class_WC_Geo_IP.segment_record_length() i64 {
	return 3
}
pub fn Class_WC_Geo_IP.standard_record_length() i64 {
	return 3
}
pub fn Class_WC_Geo_IP.org_record_length() i64 {
	return 4
}
pub fn Class_WC_Geo_IP.geoip_shm_key() i64 {
	return 1329681409
}
pub fn Class_WC_Geo_IP.geoip_domain_edition() i64 {
	return 11
}
pub fn Class_WC_Geo_IP.geoip_country_edition_v6() i64 {
	return 12
}
pub fn Class_WC_Geo_IP.geoip_locationa_edition() i64 {
	return 13
}
pub fn Class_WC_Geo_IP.geoip_accuracyradius_edition() i64 {
	return 14
}
pub fn Class_WC_Geo_IP.geoip_city_edition_rev1_v6() i64 {
	return 30
}
pub fn Class_WC_Geo_IP.geoip_city_edition_rev0_v6() i64 {
	return 31
}
pub fn Class_WC_Geo_IP.geoip_netspeed_edition_rev1() i64 {
	return 32
}
pub fn Class_WC_Geo_IP.geoip_netspeed_edition_rev1_v6() i64 {
	return 33
}
pub fn Class_WC_Geo_IP.geoip_usertype_edition() i64 {
	return 28
}
pub fn Class_WC_Geo_IP.geoip_usertype_edition_v6() i64 {
	return 29
}
pub fn Class_WC_Geo_IP.geoip_asnum_edition_v6() i64 {
	return 21
}
pub fn Class_WC_Geo_IP.geoip_isp_edition_v6() i64 {
	return 22
}
pub fn Class_WC_Geo_IP.geoip_org_edition_v6() i64 {
	return 23
}
pub fn Class_WC_Geo_IP.geoip_domain_edition_v6() i64 {
	return 24
}
struct Class_WC_Geo_IP {
	rt.PhpObjectBase
pub mut:
		flags rt.PhpVal = rt.new_null()
		filehandle rt.PhpVal = rt.new_null()
		memory_buffer rt.PhpVal = rt.new_null()
		databaseType rt.PhpVal = rt.new_null()
		databaseSegments rt.PhpVal = rt.new_null()
		record_length rt.PhpVal = rt.new_null()
		shmid rt.PhpVal = rt.new_null()
		GEOIP_COUNTRY_CODES rt.PhpVal = rt.new_array()
		GEOIP_COUNTRY_CODES3 rt.PhpVal = rt.new_array()
		GEOIP_COUNTRY_NAMES rt.PhpVal = rt.new_array()
		GEOIP_CONTINENT_CODES rt.PhpVal = rt.new_array()
		log rt.PhpVal = rt.new_bool(false)
}

fn Class_WC_Geo_IP.log(var_message rt.PhpVal, level string)  {
	if !rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	rt.call_method(// unsupported expression: Expr_StaticPropertyFetch, 'log', [rt.new_string(level), var_message.dup(), rt.create_array([rt.ArrayItem{ key: 'source', val: 'geoip' }])])
}

fn (mut this Class_WC_Geo_IP) geoip_open(var_filename rt.PhpVal, var_flags rt.PhpVal)  {
	this.flags = var_flags.dup()
	if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_shared_memory())) {
		this.shmid = rt.call_function('shmop_open', [Class_WC_Geo_IP.geoip_shm_key(), rt.new_string('a'), rt.new_int(0), rt.new_int(0)])
	} else {
		if rt.is_true(this.filehandle = rt.call_function('fopen', [var_filename.dup(), rt.new_string('rb')])) {
			if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_memory_cache())) {
				mut var_s_array := rt.call_function('fstat', [this.filehandle])
				this.memory_buffer = rt.call_function('fread', [this.filehandle, var_s_array.array_get('size')])
			}
		} else {
			Class_WC_Geo_IP.log('GeoIP API: Can not open ' + (var_filename).str(), rt.new_string('error'))
		}
	}
	this._setup_segments()
}

fn (mut this Class_WC_Geo_IP) _setup_segments() rt.PhpVal {
	this.databaseType = Class_WC_Geo_IP.geoip_country_edition()
	this.record_length = Class_WC_Geo_IP.standard_record_length()
	if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_shared_memory())) {
		mut var_offset := rt.sub(rt.call_function('shmop_size', [this.shmid]), rt.new_int(3))
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, Class_WC_Geo_IP.structure_info_max_size()))) { break }
				mut var_delim := rt.call_function('shmop_read', [this.shmid, var_offset.dup(), rt.new_int(3)])
				// unsupported expression: Expr_AssignOp_Plus
				if rt.is_true(rt.equal((rt.call_function('chr', [rt.new_int(255)])).str() + (rt.call_function('chr', [rt.new_int(255)])).str() + (rt.call_function('chr', [rt.new_int(255)])).str(), var_delim)) {
					this.databaseType = rt.call_function('ord', [rt.call_function('shmop_read', [this.shmid, var_offset.dup(), rt.new_int(1)])])
					if rt.is_true(rt.greater_equal(this.databaseType, rt.new_int(106))) {
						// unsupported expression: Expr_AssignOp_Minus
					}
					rt.post_inc(var_offset)
					if rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_region_edition_rev0(), this.databaseType)) {
						this.databaseSegments = Class_WC_Geo_IP.geoip_state_begin_rev0()
					} else if rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_region_edition_rev1(), this.databaseType)) {
						this.databaseSegments = Class_WC_Geo_IP.geoip_state_begin_rev1()
					} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev0(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev1(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_usertype_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_usertype_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_locationa_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_accuracyradius_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev0_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev1_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition_rev1(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition_rev1_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_asnum_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_asnum_edition_v6(), this.databaseType)))) {
						this.databaseSegments = rt.new_int(0)
						mut var_buf := rt.call_function('shmop_read', [this.shmid, var_offset.dup(), Class_WC_Geo_IP.segment_record_length()])
						{
							mut var_j := rt.new_int(rt.new_int(0))
							for {
								if !(rt.is_true(rt.less(var_j, Class_WC_Geo_IP.segment_record_length()))) { break }
								// unsupported expression: Expr_AssignOp_Plus
								rt.post_inc(var_j)
							}
						}
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition_v6(), this.databaseType)))) {
							this.record_length = Class_WC_Geo_IP.org_record_length()
						}
					}
					break
				} else {
					// unsupported expression: Expr_AssignOp_Minus
				}
				rt.post_inc(var_i)
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_country_edition(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_country_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_proxy_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition(), this.databaseType)))) {
			this.databaseSegments = Class_WC_Geo_IP.geoip_country_begin()
		}
	} else {
		mut var_filepos := rt.call_function('ftell', [this.filehandle])
		rt.call_function('fseek', [this.filehandle, // unsupported expression: Expr_UnaryMinus, rt.get_constant('SEEK_END')])
		{
			mut var_i := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_i, Class_WC_Geo_IP.structure_info_max_size()))) { break }
				mut var_delim := rt.call_function('fread', [this.filehandle, rt.new_int(3)])
				if rt.is_true(rt.equal((rt.call_function('chr', [rt.new_int(255)])).str() + (rt.call_function('chr', [rt.new_int(255)])).str() + (rt.call_function('chr', [rt.new_int(255)])).str(), var_delim)) {
					this.databaseType = rt.call_function('ord', [rt.call_function('fread', [this.filehandle, rt.new_int(1)])])
					if rt.is_true(rt.greater_equal(this.databaseType, rt.new_int(106))) {
						// unsupported expression: Expr_AssignOp_Minus
					}
					if rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_region_edition_rev0(), this.databaseType)) {
						this.databaseSegments = Class_WC_Geo_IP.geoip_state_begin_rev0()
					} else if rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_region_edition_rev1(), this.databaseType)) {
						this.databaseSegments = Class_WC_Geo_IP.geoip_state_begin_rev1()
					} else if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev0(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev1(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev0_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev1_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_locationa_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_accuracyradius_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition_rev1(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition_rev1_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_usertype_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_usertype_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_asnum_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_asnum_edition_v6(), this.databaseType)))) {
						this.databaseSegments = rt.new_int(0)
						mut var_buf := rt.call_function('fread', [this.filehandle, Class_WC_Geo_IP.segment_record_length()])
						{
							mut var_j := rt.new_int(rt.new_int(0))
							for {
								if !(rt.is_true(rt.less(var_j, Class_WC_Geo_IP.segment_record_length()))) { break }
								// unsupported expression: Expr_AssignOp_Plus
								rt.post_inc(var_j)
							}
						}
						if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_org_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_domain_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_isp_edition_v6(), this.databaseType)))) {
							this.record_length = Class_WC_Geo_IP.org_record_length()
						}
					}
					break
				} else {
					rt.call_function('fseek', [this.filehandle, // unsupported expression: Expr_UnaryMinus, rt.get_constant('SEEK_CUR')])
				}
				rt.post_inc(var_i)
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_country_edition(), this.databaseType)) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_country_edition_v6(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_proxy_edition(), this.databaseType)))) || rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_netspeed_edition(), this.databaseType)))) {
			this.databaseSegments = Class_WC_Geo_IP.geoip_country_begin()
		}
		rt.call_function('fseek', [this.filehandle, var_filepos.dup(), rt.get_constant('SEEK_SET')])
	}
	return rt.new_object('WC_Geo_IP', []string{}, this)
}

fn (mut this Class_WC_Geo_IP) geoip_close() bool {
	if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_shared_memory())) {
		return true
	}
	return (rt.call_function('fclose', [this.filehandle])).to_bool()
}

fn (mut this Class_WC_Geo_IP) _common_get_record(var_seek_country rt.PhpVal) rt.PhpVal {
	mut var_seek_country_mutated := var_seek_country
	mut var_mbExists := rt.call_function('extension_loaded', [rt.new_string('mbstring')])
	if rt.is_true(var_mbExists) {
		mut var_enc := rt.call_function('mb_internal_encoding', []rt.PhpVal{})
		rt.call_function('mb_internal_encoding', [rt.new_string('ISO-8859-1')])
	}
	mut var_record_pointer := rt.add(var_seek_country_mutated, rt.mul(rt.sub(rt.mul(rt.new_int(2), this.record_length), rt.new_int(1)), this.databaseSegments))
	if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_memory_cache())) {
		mut var_record_buf := rt.call_function('substr', [this.memory_buffer, var_record_pointer.dup(), rt.get_constant('FULL_RECORD_LENGTH')])
	} else if rt.is_true(rt.bitwise_and(this.flags, Class_WC_Geo_IP.geoip_shared_memory())) {
		var_record_buf = rt.call_function('shmop_read', [this.shmid, var_record_pointer.dup(), rt.get_constant('FULL_RECORD_LENGTH')])
	} else {
		rt.call_function('fseek', [this.filehandle, var_record_pointer.dup(), rt.get_constant('SEEK_SET')])
		var_record_buf = rt.call_function('fread', [this.filehandle, rt.get_constant('FULL_RECORD_LENGTH')])
	}
	mut var_record := create_wc_geo_ip_record()
	mut var_record_buf_pos := rt.new_int(rt.new_int(0))
	mut var_char := rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), var_record_buf_pos.dup(), rt.new_int(1)])])
	rt.set_property(var_record, 'country_code', this.GEOIP_COUNTRY_CODES.array_get(var_char))
	rt.set_property(var_record, 'country_code3', this.GEOIP_COUNTRY_CODES3.array_get(var_char))
	rt.set_property(var_record, 'country_name', this.GEOIP_COUNTRY_NAMES.array_get(var_char))
	rt.set_property(var_record, 'continent_code', this.GEOIP_CONTINENT_CODES.array_get(var_char))
	mut var_str_length := rt.new_int(rt.new_int(0))
	rt.post_inc(var_record_buf_pos)
	var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.post_inc(var_str_length)
		var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	}
	if rt.is_true(rt.greater(var_str_length, rt.new_int(0))) {
		rt.set_property(var_record, 'region', rt.call_function('substr', [var_record_buf.dup(), var_record_buf_pos.dup(), var_str_length.dup()]))
	}
	// unsupported expression: Expr_AssignOp_Plus
	var_str_length = rt.new_int(rt.new_int(0))
	var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.post_inc(var_str_length)
		var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	}
	if rt.is_true(rt.greater(var_str_length, rt.new_int(0))) {
		rt.set_property(var_record, 'city', rt.call_function('substr', [var_record_buf.dup(), var_record_buf_pos.dup(), var_str_length.dup()]))
	}
	// unsupported expression: Expr_AssignOp_Plus
	var_str_length = rt.new_int(rt.new_int(0))
	var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	for rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		rt.post_inc(var_str_length)
		var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.add(var_record_buf_pos, var_str_length), rt.new_int(1)])])
	}
	if rt.is_true(rt.greater(var_str_length, rt.new_int(0))) {
		rt.set_property(var_record, 'postal_code', rt.call_function('substr', [var_record_buf.dup(), var_record_buf_pos.dup(), var_str_length.dup()]))
	}
	// unsupported expression: Expr_AssignOp_Plus
	mut var_latitude := rt.new_int(rt.new_int(0))
	mut var_longitude := rt.new_int(rt.new_int(0))
	{
		mut var_j := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_j, rt.new_int(3)))) { break }
			var_char = rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.post_inc(var_record_buf_pos), rt.new_int(1)])])
			// unsupported expression: Expr_AssignOp_Plus
			rt.pre_inc(var_j)
		}
	}
	rt.set_property(var_record, 'latitude', rt.sub(rt.div(var_latitude, rt.new_int(10000)), rt.new_int(180)))
	{
		mut var_j := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_j, rt.new_int(3)))) { break }
			mut var_char := rt.call_function('ord', [rt.call_function('substr', [var_record_buf.dup(), rt.post_inc(var_record_buf_pos), rt.new_int(1)])])
			// unsupported expression: Expr_AssignOp_Plus
			rt.pre_inc(var_j)
		}
	}
	rt.set_property(var_record, 'longitude', rt.sub(rt.div(var_longitude, rt.new_int(10000)), rt.new_int(180)))
	if rt.is_true(rt.equal(Class_WC_Geo_IP.geoip_city_edition_rev1(), this.databaseType)) {
		mut var_metroarea_combo := rt.new_int(rt.new_int(0))
		if rt.is_true(rt.identical(, )) {
			{
				
				for {
					if !(rt.is_true()) { break }
					
				}
			}
		}
	}
	if rt.is_true(var_mbExists) {
		
	}
	return .dup()
}

fn (mut this Class_WC_Geo_IP) _get_record(var_ipnum rt.PhpVal) rt.PhpVal {
	mut var_ipnum_mutated := var_ipnum
}

fn (mut this Class_WC_Geo_IP) _geoip_seek_country_v6(var_ipnum rt.PhpVal) rt.PhpVal {
	mut var_ipnum_mutated := var_ipnum
}

fn (mut this Class_WC_Geo_IP) _geoip_seek_country(var_ipnum rt.PhpVal) rt.PhpVal {
	mut var_ipnum_mutated := var_ipnum
}

fn (mut this Class_WC_Geo_IP) geoip_record_by_addr(var_addr rt.PhpVal) i64 {
}

fn (mut this Class_WC_Geo_IP) geoip_country_id_by_addr_v6(var_addr rt.PhpVal) bool {
}

fn (mut this Class_WC_Geo_IP) geoip_country_id_by_addr(var_addr rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_Geo_IP) geoip_country_code_by_addr_v6(var_addr rt.PhpVal) bool {
}

fn (mut this Class_WC_Geo_IP) geoip_country_code_by_addr(var_addr rt.PhpVal) bool {
}

fn (mut this Class_WC_Geo_IP) _safe_substr(var_string rt.PhpVal, var_start rt.PhpVal, var_length rt.PhpVal) rt.PhpVal {
}

struct Class_WC_Geo_IP_Record {
	rt.PhpObjectBase
}

fn create_wc_geo_ip() &Class_WC_Geo_IP {
	mut obj := &Class_WC_Geo_IP{
		PhpObjectBase: rt.PhpObjectBase{}
		flags: rt.new_null()
		filehandle: rt.new_null()
		memory_buffer: rt.new_null()
		databaseType: rt.new_null()
		databaseSegments: rt.new_null()
		record_length: rt.new_null()
		shmid: rt.new_null()
		GEOIP_COUNTRY_CODES: rt.new_array()
		GEOIP_COUNTRY_CODES3: rt.new_array()
		GEOIP_COUNTRY_NAMES: rt.new_array()
		GEOIP_CONTINENT_CODES: rt.new_array()
		log: rt.new_bool(false)
	}
	return obj
}

fn create_wc_geo_ip_record() &Class_WC_Geo_IP_Record {
	mut obj := &Class_WC_Geo_IP_Record{
		PhpObjectBase: rt.PhpObjectBase{}
		country_code: rt.new_null()
		country_code3: rt.new_null()
		country_name: rt.new_null()
		region: rt.new_null()
		city: rt.new_null()
		postal_code: rt.new_null()
		latitude: rt.new_null()
		longitude: rt.new_null()
		area_code: rt.new_null()
		dma_code: rt.new_null()
		metro_code: rt.new_null()
		continent_code: rt.new_null()
	}
	return obj
}

fn (mut this Class_WC_Geo_IP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'log' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			Class_WC_Geo_IP.log(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'geoip_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.geoip_open(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'_setup_segments' {
			return this._setup_segments()
		}
		'geoip_close' {
			return rt.new_bool(this.geoip_close())
		}
		'_common_get_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._common_get_record(dispatch_arg_0)
		}
		'_get_record' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._get_record(dispatch_arg_0)
		}
		'_geoip_seek_country_v6' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._geoip_seek_country_v6(dispatch_arg_0)
		}
		'_geoip_seek_country' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._geoip_seek_country(dispatch_arg_0)
		}
		'geoip_record_by_addr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.geoip_record_by_addr(dispatch_arg_0))
		}
		'geoip_country_id_by_addr_v6' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.geoip_country_id_by_addr_v6(dispatch_arg_0))
		}
		'geoip_country_id_by_addr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.geoip_country_id_by_addr(dispatch_arg_0)
		}
		'geoip_country_code_by_addr_v6' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.geoip_country_code_by_addr_v6(dispatch_arg_0))
		}
		'geoip_country_code_by_addr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.geoip_country_code_by_addr(dispatch_arg_0))
		}
		'_safe_substr' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._safe_substr(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WC_Geo_IP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'flags' { return this.flags }
		'filehandle' { return this.filehandle }
		'memory_buffer' { return this.memory_buffer }
		'databaseType' { return this.databaseType }
		'databaseSegments' { return this.databaseSegments }
		'record_length' { return this.record_length }
		'shmid' { return this.shmid }
		'GEOIP_COUNTRY_CODES' { return this.GEOIP_COUNTRY_CODES }
		'GEOIP_COUNTRY_CODES3' { return this.GEOIP_COUNTRY_CODES3 }
		'GEOIP_COUNTRY_NAMES' { return this.GEOIP_COUNTRY_NAMES }
		'GEOIP_CONTINENT_CODES' { return this.GEOIP_CONTINENT_CODES }
		'log' { return this.log }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Geo_IP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'flags' { this.flags = val; return true }
		'filehandle' { this.filehandle = val; return true }
		'memory_buffer' { this.memory_buffer = val; return true }
		'databaseType' { this.databaseType = val; return true }
		'databaseSegments' { this.databaseSegments = val; return true }
		'record_length' { this.record_length = val; return true }
		'shmid' { this.shmid = val; return true }
		'GEOIP_COUNTRY_CODES' { this.GEOIP_COUNTRY_CODES = val; return true }
		'GEOIP_COUNTRY_CODES3' { this.GEOIP_COUNTRY_CODES3 = val; return true }
		'GEOIP_COUNTRY_NAMES' { this.GEOIP_COUNTRY_NAMES = val; return true }
		'GEOIP_CONTINENT_CODES' { this.GEOIP_CONTINENT_CODES = val; return true }
		'log' { this.log = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Geo_IP_Record) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Geo_IP_Record) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Geo_IP_Record) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_geo_ip_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}
