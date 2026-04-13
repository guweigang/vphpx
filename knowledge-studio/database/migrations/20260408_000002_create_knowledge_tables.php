<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->createTable('knowledge_documents', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'title varchar(200) not null',
            'coverage_focus varchar(255) not null',
            'summary text not null',
            'body text not null',
            'language varchar(16) not null',
            'source_type varchar(32) not null',
            'status varchar(32) not null',
            'chunks int not null',
            'updated_at datetime not null',
            'created_at datetime not null',
        ]);

        $this->createTable('knowledge_entries', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'kind varchar(32) not null',
            'title varchar(200) not null',
            'coverage_focus varchar(255) not null',
            'body text not null',
            'status varchar(32) not null',
            'owner varchar(120) not null',
            'created_at datetime not null',
        ]);

        $this->createTable('knowledge_releases', [
            'id varchar(64) primary key',
            'workspace_id varchar(64) not null',
            'version varchar(64) not null',
            'status varchar(32) not null',
            'created_at datetime not null',
        ]);

        return true;
    }

    public function down(): bool
    {
        $this->dropTable('knowledge_releases');
        $this->dropTable('knowledge_entries');
        $this->dropTable('knowledge_documents');

        return true;
    }
};
