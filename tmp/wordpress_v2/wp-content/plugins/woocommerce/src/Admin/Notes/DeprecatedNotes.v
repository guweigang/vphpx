import rt

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_error() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_error()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_warning() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_warning()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_update() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_update()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_informational() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_informational()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_marketing() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_marketing()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_survey() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_survey()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_pending() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_pending()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_unactioned() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_unactioned()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_actioned() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_actioned()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_snoozed() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_snoozed()
}

pub fn Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note.e_wc_admin_note_email() rt.PhpVal {
	return Class_Automattic_WooCommerce_Admin_Notes_Note.e_wc_admin_note_email()
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_note() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Note',
		'facade_over_classname', rt.new_string('Automattic\\WooCommerce\\Admin\\Notes\\Note'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Note',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note) construct(data string) {
	this.dispatch_set_prop('instance', rt.create_object_dynamically(rt.get_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Note',
		'facade_over_classname'), [rt.new_string(data)]))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes',
		'facade_over_classname', rt.new_string('Automattic\\WooCommerce\\Admin\\Notes\\Notes'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_customize_store_with_blocks() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\CustomizeStoreWithBlocks'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_edit_products_on_the_move() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\EditProductsOnTheMove'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_eu_vat_number() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\EUVATNumber'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_facebook_marketing_expert() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Admin\\Notes\\FacebookMarketingExpert'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_first_product() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\FirstProduct'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_giving_feedback_notes() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\GivingFeedbackNotes'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_install_jp_and_wcs_plugins() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\InstallJPAndWCSPlugins'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_launch_checklist() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\LaunchChecklist'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_migrate_from_shopify() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\MigrateFromShopify'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_mobile_app() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\MobileApp'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_new_sales_record() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\NewSalesRecord'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_email_marketing() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Admin\\Notes\\OnboardingEmailMarketing'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_payments() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\OnboardingPayments'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_online_clothing_store() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\OnlineClothingStore'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_order_milestones() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\OrderMilestones'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_performance_on_mobile() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\PerformanceOnMobile'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_personalize_store() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\PersonalizeStore'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_real_time_order_alerts() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\RealTimeOrderAlerts'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_selling_online_courses() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\SellingOnlineCourses'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_tracking_opt_in() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\TrackingOptIn'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_woo_subscriptions_notes() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\WooSubscriptionsNotes'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_payments() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\WooCommercePayments'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions {
	rt.PhpObjectBase
}

fn init_static_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_subscriptions() {
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions',
		'facade_over_classname',
		rt.new_string('Automattic\\WooCommerce\\Internal\\Admin\\Notes\\WooCommerceSubscriptions'))
	rt.init_static_prop('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions',
		'deprecated_in_version', rt.new_string('4.8.0'))
}

struct Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_wc_admin_note(data string) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct(data)
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_customize_store_with_blocks(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_edit_products_on_the_move(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_eu_vat_number(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_facebook_marketing_expert(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_first_product(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_giving_feedback_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_install_jp_and_wcs_plugins(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_launch_checklist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_migrate_from_shopify(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_mobile_app(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_new_sales_record(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_email_marketing(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_online_clothing_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_order_milestones(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_performance_on_mobile(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_personalize_store(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_real_time_order_alerts(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_selling_online_courses(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_tracking_opt_in(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_woo_subscriptions_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_payments(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_subscriptions(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_deprecatedclassfacade(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade {
	mut obj := &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Note) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_DeprecatedClassFacade) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Note', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		obj := create_automattic_woocommerce_admin_notes_wc_admin_note(c_arg_0)
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Note', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks', fn (args []rt.PhpVal) rt.PhpVal {
		obj :=
			create_automattic_woocommerce_admin_notes_wc_admin_notes_customize_store_with_blocks()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Customize_Store_With_Blocks', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_edit_products_on_the_move()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Edit_Products_On_The_Move', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_eu_vat_number()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_EU_VAT_Number', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_facebook_marketing_expert()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Facebook_Marketing_Expert', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_first_product()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_First_Product', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_giving_feedback_notes()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Giving_Feedback_Notes', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_install_jp_and_wcs_plugins()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Install_JP_And_WCS_Plugins', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_launch_checklist()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Launch_Checklist', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_migrate_from_shopify()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Migrate_From_Shopify', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_mobile_app()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Mobile_App', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_new_sales_record()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_New_Sales_Record', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_email_marketing()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Email_Marketing', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_onboarding_payments()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Onboarding_Payments', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_online_clothing_store()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Online_Clothing_Store', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_order_milestones()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Order_Milestones', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_performance_on_mobile()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Performance_On_Mobile', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_personalize_store()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Personalize_Store', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_real_time_order_alerts()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Real_Time_Order_Alerts', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_selling_online_courses()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Selling_Online_Courses', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_tracking_opt_in()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Tracking_Opt_In', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_woo_subscriptions_notes()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_Woo_Subscriptions_Notes', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_payments()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Payments', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_notes_wc_admin_notes_woocommerce_subscriptions()
		return rt.new_object('Automattic_WooCommerce_Admin_Notes_WC_Admin_Notes_WooCommerce_Subscriptions', [
			'Automattic_WooCommerce_Admin_DeprecatedClassFacade',
		], obj)
	})
	rt.register_class_factory('Automattic_WooCommerce_Admin_DeprecatedClassFacade', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_automattic_woocommerce_admin_deprecatedclassfacade()
		return rt.new_object('Automattic_WooCommerce_Admin_DeprecatedClassFacade', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}
