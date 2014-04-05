function emoticon = u_getEmoticon(prob,result)

emoticon = '';
switch result
    case 'win'
        if prob < 5
            emoticon = ':(';
        elseif prob < 30
            emoticon = '';
        elseif prob < 50
            emoticon = '';
        elseif prob < 75
            emoticon = ':)';
        elseif prob <= 100
            emoticon = ':D';
        end
end

end