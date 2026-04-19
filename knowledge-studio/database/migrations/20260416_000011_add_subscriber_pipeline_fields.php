<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->addColumn('subscriber_accounts', 'assignee_user_id varchar(64) null');
        } catch (\Throwable) {
        }

        try {
            $this->addColumn('subscriber_accounts', 'next_followup_at datetime null');
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropColumn('subscriber_accounts', 'assignee_user_id');
        } catch (\Throwable) {
        }

        try {
            $this->dropColumn('subscriber_accounts', 'next_followup_at');
        } catch (\Throwable) {
        }

        return true;
    }
};
