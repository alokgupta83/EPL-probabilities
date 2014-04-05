function out = u_odds2prob(a,b)

if a~=0 && b~=0 && abs(b-a)>10*min(a,b)
	out = -1;
elseif b == 0
    if a == 0
        out = -1;
    else
        out = a;
    end
else
    if a == 0
        out = b;
    else
        out = (a + b)/2;
    end
end

out = 1 / out;

end