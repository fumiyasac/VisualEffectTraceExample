CREATE TABLE announcement (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  title varchar(1000) NOT NULL DEFAULT '' COMMENT '運営からのお知らせ用タイトル',
  statement text COMMENT '運営からのお知らせ用本文',
  thumbnail_url text COMMENT '運営からのお知らせ用サムネイル画像URL',
  publish_flag int(1) NOT NULL DEFAULT '0' COMMENT '運営からのお知らせ用公開フラグ（0:公開 1:非公開）',
  created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '運営からのお知らせ用作成日',
  updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '運営からのお知らせ用更新日',
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;