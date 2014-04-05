function games = f_getGames(cfgSource)

webstr = urlread(cfgSource.source.url);

games = [];
switch cfgSource.name
    case 'Betfair'
        games = aux_betfair(webstr);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    function games = aux_betfair(webstr)
        % using hidemyass.com software to change ip address every x mins
        tmp = regexp(webstr,'<a href="/exchange/football/event.*?href="#">','match');
        tmp = strrep(strrep(strrep(strrep(strrep(tmp,'Watch now on Betfair Live video',''),'''',''),'&prime;',''),'Live TV',''),'&nbsp;','0');
        tmp = regexprep(regexprep(regexprep(regexprep(regexprep(regexprep(tmp,'<.*?>',','),'\n',''),'\s+',' '),', ',','),' ,',','),',+',',');
        tmp = strrep(tmp,'Loading,-,Click for Extra Time,-,Click for Penalties,Rules,Other markets,','');
        u_log(tmp);
        tmp = regexp(tmp, ',', 'split');
        games = [];
        for i = 1 : numel(tmp)
            games.time{i,1} = tmp{i}{5};
            if strcmp(tmp{i}{3},'v')
                games.score(i,:) = [0,0];
            else
                games.score(i,:) = str2double(regexp(tmp{i}{3}, ' - ', 'split'));
            end
            games.home{i,1} = tmp{i}{2};
            games.away{i,1} = tmp{i}{4};
            games.win(i,1)  = u_odds2prob(str2double(tmp{i}{6}),str2double(tmp{i}{7}));
            games.draw(i,1) = u_odds2prob(str2double(tmp{i}{8}),str2double(tmp{i}{9}));
            games.lose(i,1) = u_odds2prob(str2double(tmp{i}{10}),str2double(tmp{i}{11}));
        end
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
