CREATE TABLE `featured_articles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '特集記事のタイトル表記',
  `catch_copy` varchar(255) NOT NULL COMMENT '特集記事のキャッチコピー表記',
  `statement` text COMMENT '特集記事の本文表記',
  `thumbnail_url` text COMMENT '特集記事のメイン画像サムネイルURL',
  `publish_flag` int(1) NOT NULL DEFAULT '0' COMMENT '特集記事用公開フラグ（0:公開 1:非公開）',
  `author` varchar(255) NOT NULL COMMENT '特集記事の著者表記',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '特集記事更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
