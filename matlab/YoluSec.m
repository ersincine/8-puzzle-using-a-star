function [ secili ] = YoluSec( liste )

    secili = liste{1};
    boyut = length(liste);
    for i = 2:boyut
        if liste{i}.f < secili.f
           secili = liste{i};
        elseif liste{i}.f == secili.f && liste{i}.h < secili.h
           secili = liste{i}; 
        end
    end

end