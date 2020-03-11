CREATE TABLE `item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT 'アイテムのタイトル表記',
  `statement` text COMMENT 'アイテムの概要本文表記',
  `thumbnail_url` text COMMENT 'アイテムのメイン画像サムネイルURL',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT 'アイテム用公開フラグ（0:公開 1:非公開）',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'アイテム更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;