/**
 * データベースの新規作成用のSQL
 */
create database visual_effect_sample;
create database test_visual_effect_sample;

/**
 * 新規作成したデータベースに対してアクセス権限を付与する
 */
grant all on visual_effect_sample.* to 'just1factory'@'%';
grant all on test_visual_effect_sample.* to 'just1factory'@'%';
