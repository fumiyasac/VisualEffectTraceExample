CREATE TABLE `item_favorites` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'ユーザーID',
  `item_id` int(11) unsigned NOT NULL COMMENT 'アイテムID',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムへのお気に入り作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテムへのお気に入り更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- // 外部キー制約の付与: item & item_images テーブルに対して外部キー制約を付与する

ALTER TABLE `item_favorites` ADD FOREIGN KEY (`user_id`) REFERENCES users(`id`) ON DELETE CASCADE;
ALTER TABLE `item_favorites` ADD FOREIGN KEY (`item_id`) REFERENCES items(`id`) ON DELETE CASCADE;
