function [ durum ] = BaslangicDurumunuOlustur( ilkSayilar )

    if ilkSayilar == 0
        ilkSayilar = reshape(randperm(9)-1, 3, 3);
    else
       if ~CozulebilirMi(ilkSayilar)
           disp('Girdi�iniz problem ��z�lemez.');
           disp('Rastgele bir problem olu�turulacak.');
       end
    end
    
    durum = struct('sayilar', ilkSayilar, 'f', 0, 'g', 0, 'h', 0, 'ana', struct([]));
    durum.h = UzaklikOlc(durum.sayilar);
    durum.f = durum.h;
    
    % Not: isempty(durum.ana) ise durum ba�lang�� durumudur.
    
end