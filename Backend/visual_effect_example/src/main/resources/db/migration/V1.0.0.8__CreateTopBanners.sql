CREATE TABLE `top_banners` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banner_contents_id` int(11) unsigned NOT NULL COMMENT 'トップ用バナーコンテンツID',
  `banner_url` text COMMENT 'トップ用バナーコンテンツ画像URL',
  `title` varchar(255) NOT NULL COMMENT 'トップ用バナーコンテンツのタイトル表記',
  `caption` text COMMENT 'トップ用バナーコンテンツのキャプション表記',
  `announcement_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'トップ用バナーコンテンツ公開日',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'トップ用バナーコンテンツ作成日',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'トップ用バナーコンテンツ更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `top_banners` WRITE;

INSERT INTO `top_banners` (`id`, `banner_contents_id`, `banner_url`, `title`, `caption`, `announcement_at`, `created_at`, `updated_at`)
VALUES
	(1, 1, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/top_banner/top_banner_sample1.jpg', '春物ファッション特集', '新生活や春のライフスタイルを彩るファッション達を紹介。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(2, 2, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/top_banner/top_banner_sample2.jpg', 'お取り寄せグルメ特集', 'お家でもちょっと贅沢したい時に嬉しいグルメを集めました！', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00'),
	(3, 3, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/top_banner/top_banner_sample3.jpg', '日頃の感謝を伝える母の日特集', '日頃の感謝を伝える、そんな心にぐっと響くものを。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:08'),
	(4, 4, 'https://visual-effect-example.s3-ap-northeast-1.amazonaws.com/top_banner/top_banner_sample4.jpg', '日頃の感謝を伝える父の日特集', '日頃の感謝を伝える、長く愛用してもらえる一品を。', '2020-04-30 00:00:00', '2020-04-30 00:00:00', '2020-04-30 00:00:00');

UNLOCK TABLES;