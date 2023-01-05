alter table PARENT_PLAYER
add LivesWith char(1);

--Add default constraint
alter table PARENT_PLAYER
add constraint parentplayer_liveswith_df default 'Y' for LivesWith;

--Add check constraint
alter table PARENT_PLAYER
add constraint parentplayer_liveswith_ck check (LivesWith in('Y', 'N'));