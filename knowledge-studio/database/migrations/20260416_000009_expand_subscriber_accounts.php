<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->addColumn('subscriber_accounts', 'contact_name varchar(120) not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'company_name varchar(160) not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'source_label varchar(120) not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'notes text not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'updated_at datetime not null');
        } catch (\Throwable) {
        }

        try {
            $this->execute("UPDATE `subscriber_accounts` SET `contact_name` = '' WHERE `contact_name` IS NULL");
            $this->execute("UPDATE `subscriber_accounts` SET `company_name` = '' WHERE `company_name` IS NULL");
            $this->execute("UPDATE `subscriber_accounts` SET `source_label` = 'brand_page' WHERE `source_label` IS NULL OR `source_label` = ''");
            $this->execute("UPDATE `subscriber_accounts` SET `notes` = '' WHERE `notes` IS NULL");
            $this->execute("UPDATE `subscriber_accounts` SET `updated_at` = `created_at` WHERE `updated_at` IS NULL OR `updated_at` = ''");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('subscriber_accounts', 'contact_name');
        } catch (\Throwable) {
        }
        try {
            $this->dropColumn('subscriber_accounts', 'company_name');
        } catch (\Throwable) {
        }
        try {
            $this->dropColumn('subscriber_accounts', 'source_label');
        } catch (\Throwable) {
        }
        try {
            $this->dropColumn('subscriber_accounts', 'notes');
        } catch (\Throwable) {
        }
        try {
            $this->dropColumn('subscriber_accounts', 'updated_at');
        } catch (\Throwable) {
        }

        return true;
    }
};
