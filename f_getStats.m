function stats = f_getStats(cfgTeams,games)

stats = [];
j = 0;

% loop through home and away teams
for i = 1 : numel(games.time)
    % if home team recognised
    idxTeam = find(strcmp(games.home{i},cfgTeams.teams.name),1);
    if ~isempty(idxTeam)
        j = j + 1;
        stats.ts(j,1)    = now;
        stats.team{j,1}  = games.home{i};
        stats.vs{j,1}    = games.away{i};
        stats.time{j,1}  = games.time{i};
        stats.score(j,:) = games.score(i,:);
        stats.side{j,1}  = 'h';
        if ~isempty(cfgTeams.teams.hashtags{idxTeam})
            stats.hash{j,1} = cell2mat(strcat('#',cfgTeams.teams.hashtags{idxTeam}));
        else
            stats.hash{j,1} = '';
        end
        if diff(games.score(i,:)) <= 0 %if home team not losing
            stats.result{j,1} = 'win';
            stats.prob(j,1)   = games.win(i);
        else
            stats.result{j} = 'draw';
            stats.prob(j)   = games.draw(i);
        end
    end
    % if away team recognised
    idxTeam = find(strcmp(games.away{i},cfgTeams.teams.name),1);
    if ~isempty(idxTeam)
        j = j + 1;
        stats.ts(j,1)    = now;
        stats.team{j,1}  = games.away{i};
        stats.vs{j,1}    = games.home{i};
        stats.time{j,1}  = games.time{i};
        stats.score(j,:) = games.score(i,:);
        stats.side{j,1}  = 'a';
        if ~isempty(cfgTeams.teams.hashtags{idxTeam})
            stats.hash{j,1}  = cell2mat(strcat('#',cfgTeams.teams.hashtags{idxTeam}));
        else
            stats.hash{j,1} = '';
        end
        if diff(games.score(i,:)) >= 0 %if away team not losing
            stats.result{j,1} = 'win';
            stats.prob(j,1)   = games.lose(i);
        else
            stats.result{j,1} = 'draw';
            stats.prob(j,1)   = games.draw(i);
        end
    end
end

% log
u_log(stats);

end
