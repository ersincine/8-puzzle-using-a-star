function SekizTasCoz( ilkSayilar )

	% Ersin �ine, Orhan Sa�lam

    clc;

    % �lk durum olu�turulsun
    secili = BaslangicDurumunuOlustur( ilkSayilar );
    while ~CozulebilirMi(secili.sayilar) || HedefeVarildiMi(secili.sayilar)
        secili = BaslangicDurumunuOlustur( 0 );                             % ��z�lemez ya da zaten ��z�lm�� ise rastgele tekrar olu�tur
    end
    
    acikListe = {secili};                                                   % A�ac�n u� noktalar�
    kapaliListe = {};                                                       % �zerinden ge�ilmi� durumlar

    disp(secili.sayilar);
    
    while true

        % Se�ili durumu a��k listeden sil
        secilininIndisi = IndisBul(acikListe, secili);
        acikListe(secilininIndisi) = [];

        % Se�ili durumu kapal� listeye ekle            
        kapaliListe{length(kapaliListe)+1} = secili;

        % Komsu durumlar� a�
        komsular = KomsuDurumlariGetir(secili);
        for i = 1:length(komsular)
            if IndisBul(kapaliListe, komsular(i)) > 0                       % Kapal� listede ayn�s� varsa pas ge�
                continue;
            end

            benzerininIndisi = IndisBul(acikListe, komsular(i));
            if benzerininIndisi == -1                                       % A��k listede ayn�s� yoksa ekle
                acikListe{length(acikListe)+1} = komsular(i);
            elseif komsular(i).g < acikListe{benzerininIndisi}.g            % A��k listede ayn�s� varsa, g de�eri daha iyiyse ekle
                acikListe{benzerininIndisi} = komsular(i);

                % A��k listede "ana" g�ncellemesi yap
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

    % Yolu ��kar
    adimSayisi = secili.g + 1;
    for i = adimSayisi:-1:1
        adimlar(i) = secili;
        secili = secili.ana;
    end

    % Ekrana yaz
    disp('---------------------');
    disp('Ad�m say�s�: ');
    disp(adimSayisi);
    for i = 1:adimSayisi
        disp('---------------------');
        disp(adimlar(i).sayilar);
    end

end

