<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->addColumn('subscriber_accounts', 'stage varchar(32) not null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'closed_reason varchar(200) null');
        } catch (\Throwable) {
        }

        try {
            $this->execute("UPDATE `subscriber_accounts` SET `stage` = 'new' WHERE `stage` IS NULL OR `stage` = ''");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('subscriber_accounts', 'stage');
        } catch (\Throwable) {
        }

        try {
            $this->dropColumn('subscriber_accounts', 'closed_reason');
        } catch (\Throwable) {
        }

        return true;
    }
};
