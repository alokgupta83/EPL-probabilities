function [tweets,oldStats] = f_tweet(cfgTweet,oldStats,newStats,tw,tweetOn,hashOn)

tweets = [];
numTms = 0; if ~isempty(newStats); numTms = numel(newStats.team); end

% log old stats
u_log(oldStats)

twYes = [];
% for each stat
for i = 1 : numTms
    
    % find idx of previous tweet for this team
    if ~isempty(oldStats)
        idxOld = find(strcmp(newStats.team{i},oldStats.team),1);
        N = numel(oldStats.team);
    else
        idxOld = [];
        N = 0;
    end
    
    % sanity checks - skip if anything odd
    if strcmp(newStats.time{i},'In-Play')
        continue
    end
    
    scoreIf = 0;
    % if already tweeted this team
    if ~isempty(idxOld)
        twYes.idxOld(i,1) = idxOld;
        scoreIf = scoreIf + idxOld*1e7;
        % if result not changed and prob not changed enough and not first HT and not first FT, then next i
        if strcmp(newStats.result{i},oldStats.result{idxOld}) scoreIf = scoreIf + 1e6; end
        if ~any(newStats.score(i) - oldStats.score(idxOld)) scoreIf = scoreIf + 1e5; end
        if ((abs(newStats.prob(i) - oldStats.prob(idxOld)) <= cfgTweet.throttleProb) || (newStats.prob(i)==-1))  scoreIf = scoreIf + 1e4; end
        if ((newStats.ts(i) - oldStats.ts(idxOld) <= cfgTweet.throttleSecs * u_matlabSecond) || strcmp(newStats.time{i},'HT') || strcmp(newStats.time{i},'FT'))  scoreIf = scoreIf + 1e3; end
        if ((strcmp(newStats.time{i},'HT') && strcmp(oldStats.time{idxOld},'HT')) || (~strcmp(newStats.time{i},'HT') && ~strcmp(oldStats.time{idxOld},'HT')))  scoreIf = scoreIf + 1e2; end
        if ((strcmp(newStats.time{i},'FT') && strcmp(oldStats.time{idxOld},'FT')) || (~strcmp(newStats.time{i},'FT') && ~strcmp(oldStats.time{idxOld},'FT')))  scoreIf = scoreIf + 1e1; end
        if ((~isempty(strfind(newStats.time{i},'Starting')) && ~isempty(strfind(oldStats.time{idxOld},'Starting'))) || (isempty(strfind(newStats.time{i},'Starting')) && isempty(strfind(oldStats.time{idxOld},'Starting'))))  scoreIf = scoreIf + 1e0; end
        twYes.scoreIf(i,1) = scoreIf;
        if scoreIf == idxOld*1e7 + 1111111
            continue;
        % else update oldStats
        else
            oldStats.ts(idxOld)      = newStats.ts(i);
            oldStats.time{idxOld}    = newStats.time{i};
            oldStats.score(idxOld,:) = newStats.score(i,:);
            oldStats.result{idxOld}  = newStats.result{i};
            oldStats.prob(idxOld)    = newStats.prob(i);
        end
    % else append new team to oldStats
    else
        twYes.idxOld(i,1)       = 0;
        twYes.scoreIf(i,1)      = scoreIf;
        oldStats.ts(N+1,1)      = newStats.ts(i);
        oldStats.team{N+1,1}    = newStats.team{i};
        oldStats.vs{N+1,1}      = newStats.vs{i};
        oldStats.time{N+1,1}    = newStats.time{i};
        oldStats.score(N+1,:)   = newStats.score(i,:);
        oldStats.side{N+1,1}    = newStats.side{i};
        oldStats.hash{N+1,1}    = newStats.hash{i};
        oldStats.result{N+1,1}  = newStats.result{i};
        oldStats.prob(N+1,1)    = newStats.prob(i);
    end
    
    % convert prob to percentage
    if newStats.prob(i) < 0 || newStats.prob(i) > 1 
        prob = NaN;
    elseif newStats.prob(i) <= 0.5
        prob = ceil(100*newStats.prob(i));
    else
        prob = floor(100*newStats.prob(i));
    end
    
    % convert match time and result and emoticon
    time   = [newStats.time{i} ''''];
    result = [num2str(prob) '% likely to ' newStats.result{i}];
    emot   = u_getEmoticon(prob,newStats.result{i});
    if ~isempty(strfind(newStats.time{i},'Starting')) || ~isempty(strfind(newStats.time{i},':'))
        time   = 'Before KO';
        result = [num2str(prob) '% likely to beat ' newStats.vs{i}];
    elseif strcmp(newStats.time{i},'HT')
        time   = 'HT';
    elseif strcmp(newStats.time{i},'FT')
        time   = 'FT';
        if (strcmp(newStats.side{i},'h') && diff(newStats.score(i,:))<0)...
                || (strcmp(newStats.side{i},'a') && diff(newStats.score(i,:))>0)
            result = ['win against ' newStats.vs{i}];
            emot   = u_getEmoticon(100,'win');
        elseif (strcmp(newStats.side{i},'h') && diff(newStats.score(i,:))>0)...
                || (strcmp(newStats.side{i},'a') && diff(newStats.score(i,:))<0)
            result = ['lose to ' newStats.vs{i}];
            emot   = u_getEmoticon(0,'win');
        else
            result = ['draw against ' newStats.vs{i}];
            emot   = '';
        end
    end
    if isnan(prob)
        result = '';
        emot   = '';
    end

    % create twitter message
    twstr = [time ' ' ...
            '' num2str(newStats.score(i,1)) '-' num2str(newStats.score(i,2)) ' ' ...
            '(' newStats.side{i} ') ' newStats.team{i} ' ' ...
            result ' ' emot];
    
    if hashOn
        twstr = [twstr ' ' newStats.hash{i}];
    end
        
    % post to twitter and pause 
    twStatus = 'DID NOT TWEET';
    if tweetOn;
        try 
            tw.updateStatus(twstr);
            twStatus = 'TWEET OK';
        catch err
            twStatus = 'TWEET FAILED';
        end
    end
    tweets = [tweets ; {[datestr(now(),'HH:MM:SS') ' | ' twstr ' | ' twStatus]}];
    pause(cfgTweet.twBatchPause);

end

% log
u_log(twYes);
u_log(tweets);

end