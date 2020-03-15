CREATE TABLE `item_tags` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(11) unsigned NOT NULL COMMENT 'アイテムID',
  `tag_id` int(11) unsigned NOT NULL COMMENT 'タグID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムとタグを紐づける中間データ作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムとタグを紐づける中間データ更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: items & item_tags / tags & item_tags テーブルに対して外部キー制約を付与する

ALTER TABLE `item_tags` ADD FOREIGN KEY (`tag_id`) REFERENCES tags(`id`) ON DELETE CASCADE;
ALTER TABLE `item_tags` ADD FOREIGN KEY (`item_id`) REFERENCES items(`id`) ON DELETE CASCADE;
