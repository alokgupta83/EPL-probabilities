%v0.m
clear; clc;

%% setup

creds = c_twCredentials;
tw    = twitty(creds);

%% load data

cfgTeams  = c_EPL;
cfgSource = c_Betfair;
cfgTweet  = c_tweet;

%% loop over web data and tweet

clc;

tweetOn = true; %so can switch between testing modes
hashOn  = true; %so can switch on/off hashtagging

oldStats = [];
for i = 1 : cfgTweet.numCalls
    try
        games             = f_getGames(cfgSource);
        newStats          = f_getStats(cfgTeams,games);
        [tweets,oldStats] = f_tweet(cfgTweet,oldStats,newStats,tw,tweetOn,hashOn);
        [{[num2str(i) ' | ' datestr(now(),'HH:MM:SS')]} ; tweets]
    catch err
        [num2str(i) ' | ' datestr(now(),'HH:MM:SS')]
    end
    pause(cfgTweet.freqSecs)
end

