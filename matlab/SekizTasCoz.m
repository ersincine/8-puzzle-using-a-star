function SekizTasCoz( ilkSayilar )

	% Ersin Çine, Orhan Saðlam

    clc;

    % Ýlk durum oluþturulsun
    secili = BaslangicDurumunuOlustur( ilkSayilar );
    while ~CozulebilirMi(secili.sayilar) || HedefeVarildiMi(secili.sayilar)
        secili = BaslangicDurumunuOlustur( 0 );                             % Çözülemez ya da zaten çözülmüþ ise rastgele tekrar oluþtur
    end
    
    acikListe = {secili};                                                   % Aðacýn uç noktalarý
    kapaliListe = {};                                                       % Üzerinden geçilmiþ durumlar

    disp(secili.sayilar);
    
    while true

        % Seçili durumu açýk listeden sil
        secilininIndisi = IndisBul(acikListe, secili);
        acikListe(secilininIndisi) = [];

        % Seçili durumu kapalý listeye ekle            
        kapaliListe{length(kapaliListe)+1} = secili;

        % Komsu durumlarý aç
        komsular = KomsuDurumlariGetir(secili);
        for i = 1:length(komsular)
            if IndisBul(kapaliListe, komsular(i)) > 0                       % Kapalý listede aynýsý varsa pas geç
                continue;
            end

            benzerininIndisi = IndisBul(acikListe, komsular(i));
            if benzerininIndisi == -1                                       % Açýk listede aynýsý yoksa ekle
                acikListe{length(acikListe)+1} = komsular(i);
            elseif komsular(i).g < acikListe{benzerininIndisi}.g            % Açýk listede aynýsý varsa, g deðeri daha iyiyse ekle
                acikListe{benzerininIndisi} = komsular(i);

                % Açýk listede "ana" güncellemesi yap
                for a = 1:length(acikListe)
                    if ~isempty(acikListe{a}.ana) && isequal(acikListe{a}.ana.sayilar, komsular(i).sayilar)
                        acikListe{a}.ana = komsular(i);
                        acikListe{a}.g = komsular(i).g + 1;
                        acikListe{a}.f = acikListe{a}.g + acikListe{a}.h;
                    end                
                end

            end

        end

        if HedefeVarildiMi(secili.sayilar)
            break;
        end

        secili = YoluSec(acikListe);
    end

    % Yolu çýkar
    adimSayisi = secili.g + 1;
    for i = adimSayisi:-1:1
        adimlar(i) = secili;
        secili = secili.ana;
    end

    % Ekrana yaz
    disp('---------------------');
    disp('Adým sayýsý: ');
    disp(adimSayisi);
    for i = 1:adimSayisi
        disp('---------------------');
        disp(adimlar(i).sayilar);
    end

end

