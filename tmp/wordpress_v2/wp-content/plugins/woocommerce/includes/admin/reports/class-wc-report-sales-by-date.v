import rt

struct Class_WC_Report_Sales_By_Date {
	rt.PhpObjectBase
pub mut:
	chart_colours rt.PhpVal = rt.new_array()
	report_data   rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Report_Sales_By_Date) get_report_data() rt.PhpVal {
	if !rt.is_true(this.report_data) {
		this.query_report_data()
	}
	return this.report_data
}

fn (mut this Class_WC_Report_Sales_By_Date) query_report_data() {
	this.report_data = create_stdclass()
	rt.set_property(this.report_data, 'order_counts', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: 'COUNT' },
				rt.ArrayItem{ key: 'name', val: 'count' },
				rt.ArrayItem{ key: 'distinct', val: true },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'group_by_query') },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
			rt.new_string('order-count'),
		]) },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	rt.set_property(this.report_data, 'coupons', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'order_item_name', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'order_item_name' },
			]) },
			rt.ArrayItem{ key: 'discount_amount', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'coupon' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'discount_amount' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'order_items.order_item_type' },
				rt.ArrayItem{ key: 'value', val: 'coupon' },
				rt.ArrayItem{ key: 'operator', val: '=' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val:
			(rt.get_property(rt.new_object('WC_Report_Sales_By_Date', ['WC_Admin_Report'], &this), 'group_by_query')).str() +
			', order_item_name' },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
			rt.new_string('order-count'),
		]) },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	rt.set_property(this.report_data, 'order_items', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_qty', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_count' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'where', val: rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'key', val: 'order_items.order_item_type' },
				rt.ArrayItem{ key: 'value', val: 'line_item' },
				rt.ArrayItem{ key: 'operator', val: '=' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'group_by_query') },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
			rt.new_string('order-count'),
		]) },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	rt.set_property(this.report_data, 'refunded_order_items', rt.call_function('absint', [
		this.get_order_report_data(rt.create_array([
			rt.ArrayItem{ key: 'data', val: rt.create_array([
				rt.ArrayItem{ key: '_qty', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
					rt.ArrayItem{ key: 'order_item_type', val: 'line_item' },
					rt.ArrayItem{ key: 'function', val: 'SUM' },
					rt.ArrayItem{ key: 'name', val: 'order_item_count' },
				]) },
			]) },
			rt.ArrayItem{ key: 'where', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'key', val: 'order_items.order_item_type' },
					rt.ArrayItem{ key: 'value', val: 'line_item' },
					rt.ArrayItem{ key: 'operator', val: '=' },
				]) },
			]) },
			rt.ArrayItem{ key: 'query_type', val: 'get_var' },
			rt.ArrayItem{ key: 'filter_range', val: true },
			rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
				rt.new_string('order-count'),
			]) },
			rt.ArrayItem{ key: 'order_status', val: rt.create_array([
				rt.ArrayItem{
					key: none
					val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded()
				},
			]) },
		])),
	]))
	rt.set_property(this.report_data, 'orders', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_order_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'total_sales' },
			]) },
			rt.ArrayItem{ key: '_order_shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping' },
			]) },
			rt.ArrayItem{ key: '_order_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'total_tax' },
			]) },
			rt.ArrayItem{ key: '_order_shipping_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping_tax' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'group_by_query') },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_types', val: rt.call_function('wc_get_order_types', [
			rt.new_string('sales-reports'),
		]) },
		rt.ArrayItem{ key: 'order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	rt.set_property(this.report_data, 'full_refunds', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: '_order_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'parent_meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_refund' },
			]) },
			rt.ArrayItem{ key: '_order_shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'parent_meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping' },
			]) },
			rt.ArrayItem{ key: '_order_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'parent_meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_tax' },
			]) },
			rt.ArrayItem{ key: '_order_shipping_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'parent_meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping_tax' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: 'posts.post_parent' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: false },
		rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	mut iter_1 := rt.get_property(this.report_data, 'full_refunds').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_order := item_1.val
		mut var_key := item_1.key
		mut var_total_refund := if rt.get_property(var_order, 'total_refund').is_long()
			|| rt.get_property(var_order, 'total_refund').is_double() {
			rt.get_property(var_order, 'total_refund')
		} else {
			rt.new_int(0)
		}
		mut var_total_shipping := if rt.get_property(var_order, 'total_shipping').is_long()
			|| rt.get_property(var_order, 'total_shipping').is_double() {
			rt.get_property(var_order, 'total_shipping')
		} else {
			rt.new_int(0)
		}
		mut var_total_tax := if rt.get_property(var_order, 'total_tax').is_long()
			|| rt.get_property(var_order, 'total_tax').is_double() {
			rt.get_property(var_order, 'total_tax')
		} else {
			rt.new_int(0)
		}
		mut var_total_shipping_tax := if rt.get_property(var_order, 'total_shipping_tax').is_long()
			|| rt.get_property(var_order, 'total_shipping_tax').is_double() {
			rt.get_property(var_order, 'total_shipping_tax')
		} else {
			rt.new_int(0)
		}
		rt.set_property(rt.get_property(this.report_data, 'full_refunds').array_get(var_key),
			'net_refund', rt.sub(var_total_refund, rt.add(rt.add(var_total_shipping, var_total_tax),
			var_total_shipping_tax)))
	}
	rt.set_property(this.report_data, 'partial_refunds', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'refund_id' },
			]) },
			rt.ArrayItem{ key: '_refund_amount', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_refund' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
			rt.ArrayItem{ key: 'order_item_type', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'item_type' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_sales' },
			]) },
			rt.ArrayItem{ key: '_order_shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_tax' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_shipping_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping_tax' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_qty', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_count' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: 'refund_id' },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: false },
		rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
		]) },
	]))))
	mut iter_2 := rt.get_property(this.report_data, 'partial_refunds').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_order := item_2.val
		mut var_key := item_2.key
		rt.set_property(rt.get_property(this.report_data, 'partial_refunds').array_get(var_key),
			'net_refund', rt.new_float((rt.get_property(var_order, 'total_refund')).to_f64()) -
			rt.new_float((rt.get_property(var_order, 'total_shipping')).to_f64()) +
			rt.new_float((rt.get_property(var_order, 'total_tax')).to_f64()) +
			rt.new_float((rt.get_property(var_order, 'total_shipping_tax')).to_f64()))
	}
	rt.set_property(this.report_data, 'refund_lines', rt.cast_array(this.get_order_report_data(rt.create_array([
		rt.ArrayItem{ key: 'data', val: rt.create_array([
			rt.ArrayItem{ key: 'ID', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'refund_id' },
			]) },
			rt.ArrayItem{ key: '_refund_amount', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_refund' },
			]) },
			rt.ArrayItem{ key: 'post_date', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'post_data' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'post_date' },
			]) },
			rt.ArrayItem{ key: 'order_item_type', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'item_type' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_total', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_sales' },
			]) },
			rt.ArrayItem{ key: '_order_shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_tax' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_order_shipping_tax', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'meta' },
				rt.ArrayItem{ key: 'function', val: '' },
				rt.ArrayItem{ key: 'name', val: 'total_shipping_tax' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
			rt.ArrayItem{ key: '_qty', val: rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'order_item_meta' },
				rt.ArrayItem{ key: 'function', val: 'SUM' },
				rt.ArrayItem{ key: 'name', val: 'order_item_count' },
				rt.ArrayItem{ key: 'join_type', val: 'LEFT' },
			]) },
		]) },
		rt.ArrayItem{ key: 'group_by', val: 'refund_id' },
		rt.ArrayItem{ key: 'order_by', val: 'post_date ASC' },
		rt.ArrayItem{ key: 'query_type', val: 'get_results' },
		rt.ArrayItem{ key: 'filter_range', val: true },
		rt.ArrayItem{ key: 'order_status', val: false },
		rt.ArrayItem{ key: 'parent_order_status', val: rt.create_array([
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.completed() },
			rt.ArrayItem{
				key: none
				val: Class_Automattic_WooCommerce_Enums_OrderStatus.processing()
			},
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.on_hold() },
			rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.refunded() },
		]) },
	]))))
	rt.set_property(this.report_data, 'total_tax_refunded', rt.new_int(0))
	rt.set_property(this.report_data, 'total_shipping_refunded', rt.new_int(0))
	rt.set_property(this.report_data, 'total_shipping_tax_refunded', rt.new_int(0))
	rt.set_property(this.report_data, 'total_refunds', rt.new_int(0))
	rt.set_property(this.report_data, 'refunded_orders', rt.call_function('array_merge', [
		rt.get_property(this.report_data, 'partial_refunds'),
		rt.get_property(this.report_data, 'full_refunds'),
	]))
	mut iter_3 := rt.get_property(this.report_data, 'refunded_orders').iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_value := item_3.val
		mut var_key := item_3.key
		rt.get_property(this.report_data, 'total_tax_refunded') = rt.add(rt.get_property(this.report_data,
			'total_tax_refunded'), rt.new_float(if rt.is_true(rt.less(rt.get_property(var_value,
			'total_tax'), rt.new_int(0)))
		{
			rt.mul(rt.get_property(var_value, 'total_tax'), -1)
		} else {
			rt.get_property(var_value, 'total_tax')
		}.to_f64()))
		rt.get_property(this.report_data, 'total_refunds') = rt.add(rt.get_property(this.report_data,
			'total_refunds'), rt.new_float(rt.get_property(var_value, 'total_refund').to_f64()))
		rt.get_property(this.report_data, 'total_shipping_tax_refunded') = rt.add(rt.get_property(this.report_data,
			'total_shipping_tax_refunded'), rt.new_float(if rt.is_true(rt.less(rt.get_property(var_value,
			'total_shipping_tax'), rt.new_int(0)))
		{
			rt.mul(rt.get_property(var_value, 'total_shipping_tax'), -1)
		} else {
			rt.get_property(var_value, 'total_shipping_tax')
		}.to_f64()))
		rt.get_property(this.report_data, 'total_shipping_refunded') = rt.add(rt.get_property(this.report_data,
			'total_shipping_refunded'), rt.new_float(if rt.is_true(rt.less(rt.get_property(var_value,
			'total_shipping'), rt.new_int(0)))
		{
			rt.mul(rt.get_property(var_value, 'total_shipping'), -1)
		} else {
			rt.get_property(var_value, 'total_shipping')
		}.to_f64()))
		if !(rt.get_property(var_value, 'order_item_count')).is_null() {
			rt.get_property(this.report_data, 'refunded_order_items') = rt.add(rt.get_property(this.report_data,
				'refunded_order_items'), rt.new_float(if rt.is_true(rt.less(rt.get_property(var_value,
				'order_item_count'), rt.new_int(0)))
			{
				rt.mul(rt.get_property(var_value, 'order_item_count'), -1)
			} else {
				rt.get_property(var_value, 'order_item_count')
			}.to_f64()))
		}
	}
	rt.set_property(this.report_data, 'total_tax', rt.call_function('wc_format_decimal', [
		rt.sub(rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'orders'),
				rt.new_string('total_tax'),
			]),
		]), rt.get_property(this.report_data, 'total_tax_refunded')),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'total_shipping', rt.call_function('wc_format_decimal', [
		rt.sub(rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'orders'),
				rt.new_string('total_shipping'),
			]),
		]), rt.get_property(this.report_data, 'total_shipping_refunded')),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'total_shipping_tax', rt.call_function('wc_format_decimal', [
		rt.sub(rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'orders'),
				rt.new_string('total_shipping_tax'),
			]),
		]), rt.get_property(this.report_data, 'total_shipping_tax_refunded')),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'total_sales', rt.call_function('wc_format_decimal', [
		rt.sub(rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'orders'),
				rt.new_string('total_sales'),
			]),
		]), rt.get_property(this.report_data, 'total_refunds')),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'net_sales', rt.call_function('wc_format_decimal', [
		rt.sub(rt.sub(rt.sub(rt.get_property(this.report_data, 'total_sales'), rt.get_property(this.report_data,
			'total_shipping')), rt.call_function('max', [rt.new_int(0),
			rt.get_property(this.report_data, 'total_tax')])), rt.call_function('max', [
			rt.new_int(0), rt.get_property(this.report_data, 'total_shipping_tax')])),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'average_sales', rt.call_function('wc_format_decimal', [
		rt.div(rt.get_property(this.report_data, 'net_sales'), rt.add(rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.new_int(1))),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'average_total_sales', rt.call_function('wc_format_decimal', [
		rt.div(rt.get_property(this.report_data, 'total_sales'), rt.add(rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.new_int(1))),
		rt.new_int(2),
	]))
	rt.set_property(this.report_data, 'total_coupons', rt.call_function('number_format', [
		rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'coupons'),
				rt.new_string('discount_amount'),
			]),
		]),
		rt.new_int(2),
		rt.new_string('.'),
		rt.new_string(''),
	]))
	rt.set_property(this.report_data, 'total_refunded_orders', rt.call_function('absint', [
		rt.new_int(rt.get_property(this.report_data, 'full_refunds').array_count()),
	]))
	rt.set_property(this.report_data, 'total_orders', rt.call_function('absint', [
		rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'order_counts'),
				rt.new_string('count'),
			]),
		]),
	]))
	rt.set_property(this.report_data, 'total_items', rt.call_function('absint', [
		rt.call_function('array_sum', [
			rt.call_function('wp_list_pluck', [
				rt.get_property(this.report_data, 'order_items'),
				rt.new_string('order_item_count'),
			]),
		]),
	]))
	this.report_data = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_report_data'),
		this.report_data,
	])
}

fn (mut this Class_WC_Report_Sales_By_Date) get_chart_legend() rt.PhpVal {
	mut var_legend := []rt.PhpVal{}
	mut var_data := this.get_report_data()
	mut switch_val_1 := rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
		'WC_Admin_Report',
	], &this), 'chart_groupby')
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('day'))) {
		mut var_average_total_sales_title := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s average gross daily sales'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'average_total_sales')])).str() +
				'</strong>'),
		])
		mut var_average_sales_title := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s average net daily sales'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'average_sales')])).str() +
				'</strong>'),
		])
	} else {
		var_average_total_sales_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s average gross monthly sales'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'average_total_sales')])).str() +
				'</strong>'),
		])
		var_average_sales_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s average net monthly sales'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'average_sales')])).str() +
				'</strong>'),
		])
	}
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s gross sales in this period'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'total_sales')])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
			rt.new_string('This is the sum of the order totals after any refunds and including shipping and taxes.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('sales_amount')) },
		rt.ArrayItem{ key: 'highlight_series', val: 6 },
	])
	if rt.is_true(rt.greater(rt.get_property(var_data, 'average_total_sales'), rt.new_int(0))) {
		var_legend << rt.create_array([
			rt.ArrayItem{ key: 'title', val: var_average_total_sales_title },
			rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('average')) },
			rt.ArrayItem{ key: 'highlight_series', val: 2 },
		])
	}
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s net sales in this period'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'net_sales')])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
			rt.new_string('This is the sum of the order totals after any refunds and excluding shipping and taxes.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{
			key: 'color'
			val: this.chart_colours.array_get(rt.new_string('net_sales_amount'))
		},
		rt.ArrayItem{ key: 'highlight_series', val: 7 },
	])
	if rt.is_true(rt.greater(rt.get_property(var_data, 'average_sales'), rt.new_int(0))) {
		var_legend << rt.create_array([
			rt.ArrayItem{ key: 'title', val: var_average_sales_title },
			rt.ArrayItem{
				key: 'color'
				val: this.chart_colours.array_get(rt.new_string('net_average'))
			},
			rt.ArrayItem{ key: 'highlight_series', val: 3 },
		])
	}
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s orders placed'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' + (rt.get_property(var_data, 'total_orders')).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('order_count')) },
		rt.ArrayItem{ key: 'highlight_series', val: 1 },
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s items purchased'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' + (rt.get_property(var_data, 'total_items')).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{ key: 'color', val: this.chart_colours.array_get(rt.new_string('item_count')) },
		rt.ArrayItem{ key: 'highlight_series', val: 0 },
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('%1$s refunded %2$d order (%3$d item)'),
				rt.new_string('%1$s refunded %2$d orders (%3$d items)'),
				rt.get_property(this.report_data, 'total_refunded_orders'),
				rt.new_string('woocommerce'),
			]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'total_refunds')])).str() +
				'</strong>'),
			rt.get_property(this.report_data, 'total_refunded_orders'),
			rt.get_property(this.report_data, 'refunded_order_items'),
		]) },
		rt.ArrayItem{
			key: 'color'
			val: this.chart_colours.array_get(rt.new_string('refund_amount'))
		},
		rt.ArrayItem{ key: 'highlight_series', val: 8 },
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s charged for shipping'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'total_shipping')])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{
			key: 'color'
			val: this.chart_colours.array_get(rt.new_string('shipping_amount'))
		},
		rt.ArrayItem{ key: 'highlight_series', val: 5 },
	])
	var_legend << rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s worth of coupons used'),
				rt.new_string('woocommerce')]),
			rt.new_string('<strong>' +
				(rt.call_function('wc_price', [rt.get_property(var_data, 'total_coupons')])).str() +
				'</strong>'),
		]) },
		rt.ArrayItem{
			key: 'color'
			val: this.chart_colours.array_get(rt.new_string('coupon_amount'))
		},
		rt.ArrayItem{ key: 'highlight_series', val: 4 },
	])
	return var_legend.clone()
}

fn (mut this Class_WC_Report_Sales_By_Date) output_report() {
	mut var_ranges := {
		'year':       rt.call_function('__', [rt.new_string('Year'),
			rt.new_string('woocommerce')])
		'last_month': rt.call_function('__', [rt.new_string('Last month'),
			rt.new_string('woocommerce')])
		'month':      rt.call_function('__', [rt.new_string('This month'),
			rt.new_string('woocommerce')])
		'7day':       rt.call_function('__', [rt.new_string('Last 7 days'),
			rt.new_string('woocommerce')])
	}
	this.chart_colours = rt.create_array([
		rt.ArrayItem{ key: 'sales_amount', val: '#b1d4ea' },
		rt.ArrayItem{ key: 'net_sales_amount', val: '#3498db' },
		rt.ArrayItem{ key: 'average', val: '#b1d4ea' },
		rt.ArrayItem{ key: 'net_average', val: '#3498db' },
		rt.ArrayItem{ key: 'order_count', val: '#dbe1e3' },
		rt.ArrayItem{ key: 'item_count', val: '#ecf0f1' },
		rt.ArrayItem{ key: 'shipping_amount', val: '#5cc488' },
		rt.ArrayItem{ key: 'coupon_amount', val: '#f1c40f' },
		rt.ArrayItem{ key: 'refund_amount', val: '#e74c3c' },
	])
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('7day') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_current_range.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'custom' },
			rt.ArrayItem{ key: none, val: 'year' },
			rt.ArrayItem{ key: none, val: 'last_month' },
			rt.ArrayItem{ key: none, val: 'month' },
			rt.ArrayItem{ key: none, val: '7day' },
		]),
		rt.new_bool(true)])))))
	{
		var_current_range = rt.new_string('7day')
	}
	this.check_current_range_nonce(var_current_range.clone())
	this.calculate_current_range(var_current_range.clone())
	rt.include_file(
		(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
		'/includes/admin/views/html-report-by-date.php', '1')
}

fn (mut this Class_WC_Report_Sales_By_Date) get_export_button() {
	mut var_current_range := if !(!rt.is_true(rt.get_superglobal('_GET').array_get(rt.new_string('range')))) { rt.call_function('sanitize_text_field', [
			rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get(rt.new_string('range'))]),
		]) } else { rt.new_string('7day') }
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_current_range.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.call_function('date_i18n', [rt.new_string('Y-m-d'),
			rt.call_function('current_time', [rt.new_string('timestamp')])]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Date'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [
		rt.get_property(rt.new_object('WC_Report_Sales_By_Date', ['WC_Admin_Report'], &this),
			'chart_groupby'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Export CSV'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WC_Report_Sales_By_Date) round_chart_totals(var_amount rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_amount.clone().is_array())) {
		return rt.create_array([
			rt.ArrayItem{ key: none, val: var_amount.array_get(rt.new_int(0)) },
			rt.ArrayItem{ key: none, val: rt.call_function('wc_format_decimal', [
				var_amount.array_get(rt.new_int(1)),
				rt.call_function('wc_get_price_decimals', []rt.PhpVal{}),
			]) },
		])
	} else {
		return rt.call_function('wc_format_decimal', [var_amount.clone(),
			rt.call_function('wc_get_price_decimals', []rt.PhpVal{})])
	}
	return rt.new_null()
}

fn (mut this Class_WC_Report_Sales_By_Date) get_main_chart() {
	mut var_wp_locale := rt.new_null()
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'order_counts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'order_counts'), rt.new_string('post_date'), rt.new_string('count'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'order_item_counts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'order_items'), rt.new_string('post_date'), rt.new_string('order_item_count'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'order_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'orders'), rt.new_string('post_date'), rt.new_string('total_sales'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'coupon_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'coupons'), rt.new_string('post_date'), rt.new_string('discount_amount'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'shipping_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'orders'), rt.new_string('post_date'), rt.new_string('total_shipping'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'refund_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'refund_lines'), rt.new_string('post_date'), rt.new_string('total_refund'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'net_refund_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'refunded_orders'), rt.new_string('post_date'), rt.new_string('net_refund'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'shipping_tax_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'orders'), rt.new_string('post_date'), rt.new_string('total_shipping_tax'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'tax_amounts', val: this.prepare_chart_data(rt.get_property(this.report_data,
			'orders'), rt.new_string('post_date'), rt.new_string('total_tax'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_interval'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'start_date'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
			'WC_Admin_Report',
		], &this), 'chart_groupby')) },
		rt.ArrayItem{ key: 'net_order_amounts', val: []rt.PhpVal{} },
		rt.ArrayItem{ key: 'gross_order_amounts', val: []rt.PhpVal{} },
	])
	mut iter_4 := var_data.array_get(rt.new_string('order_amounts')).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_order_amount_value := item_4.val
		mut var_order_amount_key := item_4.key
		var_data.array_get_mut('gross_order_amounts').array_set(var_order_amount_key,
			var_order_amount_value.clone())
		var_data.array_get(rt.new_string('gross_order_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)) = rt.sub(var_data.array_get(rt.new_string('gross_order_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)),
			var_data.array_get(rt.new_string('refund_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)))
		var_data.array_get_mut('net_order_amounts').array_set(var_order_amount_key,
			var_order_amount_value.clone())
		var_data.array_get(rt.new_string('net_order_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)) = rt.sub(var_data.array_get(rt.new_string('net_order_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)), rt.add(rt.add(rt.add(var_data.array_get(rt.new_string('net_refund_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1)),
			var_data.array_get(rt.new_string('shipping_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1))),
			var_data.array_get(rt.new_string('shipping_tax_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1))),
			var_data.array_get(rt.new_string('tax_amounts')).array_get(var_order_amount_key).array_get(rt.new_int(1))))
	}
	var_data = rt.call_function('apply_filters', [
		rt.new_string('woocommerce_admin_report_chart_data'),
		var_data.clone(),
	])
	mut var_chart_data := rt.call_function('wp_json_encode', [
		rt.create_array([
			rt.ArrayItem{ key: 'order_counts', val: rt.call_function('array_values', [
				var_data.array_get(rt.new_string('order_counts')),
			]) },
			rt.ArrayItem{ key: 'order_item_counts', val: rt.call_function('array_values', [
				var_data.array_get(rt.new_string('order_item_counts')),
			]) },
			rt.ArrayItem{ key: 'order_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('order_amounts')),
				]),
			]) },
			rt.ArrayItem{ key: 'gross_order_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('gross_order_amounts')),
				]),
			]) },
			rt.ArrayItem{ key: 'net_order_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('net_order_amounts')),
				]),
			]) },
			rt.ArrayItem{ key: 'shipping_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('shipping_amounts')),
				]),
			]) },
			rt.ArrayItem{ key: 'coupon_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('coupon_amounts')),
				]),
			]) },
			rt.ArrayItem{ key: 'refund_amounts', val: rt.call_function('array_map', [
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Report_Sales_By_Date', [
						'WC_Admin_Report',
					], &this) },
					rt.ArrayItem{ key: none, val: 'round_chart_totals' },
				]),
				rt.call_function('array_values', [
					var_data.array_get(rt.new_string('refund_amounts')),
				]),
			]) },
		]),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('rawurlencode', [var_chart_data.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Number of items sold'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('item_count'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('item_count'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(rt.new_object('WC_Report_Sales_By_Date', ['WC_Admin_Report'], &this),
			'barwidth'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Number of orders'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('order_count'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('order_count'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(rt.new_object('WC_Report_Sales_By_Date', ['WC_Admin_Report'], &this),
			'barwidth'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Average gross sales amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('min', [
			rt.func_array_keys(var_data.array_get(rt.new_string('order_amounts'))),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(this.report_data, 'average_total_sales'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('max', [
			rt.func_array_keys(var_data.array_get(rt.new_string('order_amounts'))),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(this.report_data, 'average_total_sales'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [this.chart_colours.array_get(rt.new_string('average'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Average net sales amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('min', [
			rt.func_array_keys(var_data.array_get(rt.new_string('order_amounts'))),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(this.report_data, 'average_sales'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('max', [
			rt.func_array_keys(var_data.array_get(rt.new_string('order_amounts'))),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(this.report_data, 'average_sales'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('net_average'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Coupon amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('coupon_amount'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_currency_tooltip())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Shipping amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		this.chart_colours.array_get(rt.new_string('shipping_amount')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Gross sales amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('sales_amount'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_currency_tooltip())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Net sales amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		this.chart_colours.array_get(rt.new_string('net_sales_amount')),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_currency_tooltip())
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('__', [rt.new_string('Refund amount'),
			rt.new_string('woocommerce')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[this.chart_colours.array_get(rt.new_string('refund_amount'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('get_woocommerce_currency_symbol', []rt.PhpVal{}))
	// unsupported statement: Stmt_InlineHTML
	print(if rt.is_true(rt.identical(rt.new_string('day'), rt.get_property(rt.new_object('WC_Report_Sales_By_Date', [
		'WC_Admin_Report',
	], &this), 'chart_groupby')))
	{ '%d %b' } else { '%b' })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('rawurlencode', [
		rt.call_function('wp_json_encode', [
			rt.call_function('array_values', [
				rt.get_property(var_wp_locale, 'month_abbrev'),
			]),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(rt.new_object('WC_Report_Sales_By_Date', ['WC_Admin_Report'], &this),
			'chart_groupby'),
	]))
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WC_Admin_Report {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wc_report_sales_by_date(_args ...rt.PhpVal) &Class_WC_Report_Sales_By_Date {
	mut obj := &Class_WC_Report_Sales_By_Date{
		PhpObjectBase: rt.PhpObjectBase{}
		chart_colours: rt.new_array()
		report_data:   rt.new_null()
	}
	return obj
}

fn create_wc_admin_report(_args ...rt.PhpVal) &Class_WC_Admin_Report {
	mut obj := &Class_WC_Admin_Report{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Report_Sales_By_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_report_data' {
			return this.get_report_data()
		}
		'query_report_data' {
			this.query_report_data()
			return rt.new_null()
		}
		'get_chart_legend' {
			return this.get_chart_legend()
		}
		'output_report' {
			this.output_report()
			return rt.new_null()
		}
		'get_export_button' {
			this.get_export_button()
			return rt.new_null()
		}
		'round_chart_totals' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.round_chart_totals(dispatch_arg_0)
		}
		'get_main_chart' {
			this.get_main_chart()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Report_Sales_By_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'chart_colours' { return this.chart_colours }
		'report_data' { return this.report_data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Report_Sales_By_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'chart_colours' {
			this.chart_colours = val
			return true
		}
		'report_data' {
			this.report_data = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Admin_Report) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Admin_Report) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Report) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}
