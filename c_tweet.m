function cfg = c_tweet

cfg.twBatchPause = 2;    %so wait 2 sec for tweeting next message
cfg.freqSecs     = 30;  %so 300 is every 5 mins
cfg.throttleProb = 0.03; %so tweet whenever prob changes by at least 3%
cfg.throttleSecs = 600; %so tweet whenever 10 mins go by
cfg.numCalls     = 10*60*2;    %so six hours e.g. 1200 -1800 GMT

% log
u_log(cfg);

end