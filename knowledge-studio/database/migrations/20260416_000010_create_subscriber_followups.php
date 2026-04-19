<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->createTable('subscriber_followups', [
                'id varchar(64) primary key',
                'workspace_id varchar(64) not null',
                'subscriber_id varchar(64) not null',
                'actor varchar(120) not null',
                'body text not null',
                'created_at datetime not null',
            ]);
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropTable('subscriber_followups');
        } catch (\Throwable) {
        }

        return true;
    }
};
