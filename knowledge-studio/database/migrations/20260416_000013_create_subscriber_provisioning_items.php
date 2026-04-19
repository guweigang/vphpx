<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        try {
            $this->createTable('subscriber_provisioning_items', [
                'id varchar(64) primary key',
                'workspace_id varchar(64) not null',
                'subscriber_id varchar(64) not null',
                'item_key varchar(64) not null',
                'label varchar(200) not null',
                'status varchar(32) not null',
                'created_at datetime not null',
                'completed_at datetime null',
            ]);
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        try {
            $this->dropTable('subscriber_provisioning_items');
        } catch (\Throwable) {
        }

        return true;
    }
};
