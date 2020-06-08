function [ indis ] = IndisBul( liste, durum )

    indis = -1;
    boyut = length(liste);

    for i = 1:boyut
        if isequal(liste{i}.sayilar, durum.sayilar)
            indis = i;
            break;
        end
    end

end