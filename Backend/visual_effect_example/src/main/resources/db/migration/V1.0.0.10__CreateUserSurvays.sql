CREATE TABLE `user_survays` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT 'ユーザーID',
  `question1` varchar(255) NOT NULL COMMENT 'Q1.あなたの年齢を教えてください',
  `question2` varchar(255) NOT NULL COMMENT 'Q2.あなたの性別を教えてください',
  `question3` varchar(255) NOT NULL COMMENT 'Q3.あなたの職業を教えてください',
  `question4` varchar(255) NOT NULL COMMENT 'Q4.あなたが一番利用するSNSを教えてください',
  `question5` varchar(255) NOT NULL COMMENT 'Q5.あなたが一番関心があることを下記カテゴリーから教えてください',
  `free_comment` text COMMENT '自由記載コメント',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザーへの調査作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'ユーザーへの調査更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
