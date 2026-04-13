<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('knowledge_release_items', [
            'id varchar(64) primary key',
            'release_id varchar(64) not null',
            'workspace_id varchar(64) not null',
            'item_type varchar(32) not null',
            'item_id varchar(64) not null',
            'created_at datetime not null',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('knowledge_release_items');

        return true;
    }
};
