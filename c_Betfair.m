function cfg = c_Betfair

%% setup
cfg = [];
cfg.name = 'Betfair';

%% source url
cfg.source.name = 'betfair'; cfg.source.url = 'http://www.betfair.com/exchange/inplay';

% log
u_log(cfg.source);

end
