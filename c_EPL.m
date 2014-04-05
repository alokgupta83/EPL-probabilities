function cfg = c_EPL

%% setup
cfg = [];
cfg.name = 'EPL';

%% teams
cfg.teams.name{1,1} = 'Arsenal'; cfg.teams.hashtags{1,1} = {'AFC','gunners'};
cfg.teams.name{2,1} = 'Chelsea'; cfg.teams.hashtags{2,1} = {'CFC','chelski'};
cfg.teams.name{3,1} = 'Liverpool'; cfg.teams.hashtags{3,1} = {'LFC','ynwa'};
cfg.teams.name{4,1} = 'Man Utd'; cfg.teams.hashtags{4,1} = {'MUFC'};
cfg.teams.name{5,1} = 'Man City'; cfg.teams.hashtags{5,1} = {'MCFC'};
cfg.teams.name{6,1} = 'Tottenham'; cfg.teams.hashtags{6,1} = {'spurs','coys'};
cfg.teams.name{7,1} = 'Everton'; cfg.teams.hashtags{7,1} = {'EFC','COYB'};
cfg.teams.name{8,1} = 'Newcastle'; cfg.teams.hashtags{8,1} = {'NUFC'};
cfg.teams.name{9,1} = 'Sunderland'; cfg.teams.hashtags{9,1} = {'SAFC','HawayTheLads'};
cfg.teams.name{10,1} = 'West Ham'; cfg.teams.hashtags{10,1} = {'WHUFC'};
cfg.teams.name{11,1} = 'Aston Villa'; cfg.teams.hashtags{11,1} = {'AVFC'};
cfg.teams.name{12,1} = 'Cardiff'; cfg.teams.hashtags{12,1} = {'CardiffCity','OnThisCardiffCityDay'};
cfg.teams.name{13,1} = 'Swansea'; cfg.teams.hashtags{13,1} = {'Swans'};
cfg.teams.name{14,1} = 'West Brom'; cfg.teams.hashtags{14,1} = {'WBAFC','WBA'};
cfg.teams.name{15,1} = 'Hull'; cfg.teams.hashtags{15,1} = {'HCAFC','UTT'};
cfg.teams.name{16,1} = 'C Palace'; cfg.teams.hashtags{16,1} = {'CPFC'};
cfg.teams.name{17,1} = 'Norwich'; cfg.teams.hashtags{17,1} = {'NCFC'};
cfg.teams.name{18,1} = 'Southampton'; cfg.teams.hashtags{18,1} = {'saintsfc'};
cfg.teams.name{19,1} = 'Stoke'; cfg.teams.hashtags{19,1} = {'scfc'};
cfg.teams.name{20,1} = 'Fulham'; cfg.teams.hashtags{20,1} = {'ffc','fulhamfc','coyw','bytheriver'};
% cfg.teams.name{21,1} = 'Elche'; cfg.teams.hashtags{21,1} = {};
% cfg.teams.name{22,1} = 'Ath Bilbao'; cfg.teams.hashtags{22,1} = {};
% cfg.teams.name{23,1} = 'St Patricks'; cfg.teams.hashtags{23,1} = {};

% log
u_log(cfg.teams);

end
