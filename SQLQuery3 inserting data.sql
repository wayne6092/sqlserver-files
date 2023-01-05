--add default value 0-0
--change to not null
alter table game
add constraint game_score_df default '0-0' for score;

alter table game
alter column score char(10) not null;