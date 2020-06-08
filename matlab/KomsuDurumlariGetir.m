function [ komsuDurumlar ] = KomsuDurumlariGetir( merkezDurum )
    
    bos = find(merkezDurum.sayilar' == 0); % Transpoz var dikkat!!! Bos: 0'�n bulundu�u yer.

	% K��e i�in 2; kenar i�in 3; merkez i�in 4 kom�u durum var.
    komsuDurumlar(1) = struct('sayilar', merkezDurum.sayilar, 'f', 0, 'g', merkezDurum.g+1, 'h', 0, 'ana', merkezDurum);
    komsuDurumlar(2) = struct('sayilar', merkezDurum.sayilar, 'f', 0, 'g', merkezDurum.g+1, 'h', 0, 'ana', merkezDurum);
    if mod(bos, 2) == 0                                                                                                     % Bo�, �ift numarada. Yani kenarda.
        komsuDurumlar(3) = struct('sayilar', merkezDurum.sayilar, 'f', 0, 'g', merkezDurum.g+1, 'h', 0, 'ana', merkezDurum);
    elseif bos == 5                                                                                                         % Bo� merkezde.
        komsuDurumlar(3) = struct('sayilar', merkezDurum.sayilar, 'f', 0, 'g', merkezDurum.g+1, 'h', 0, 'ana', merkezDurum);
        komsuDurumlar(4) = struct('sayilar', merkezDurum.sayilar, 'f', 0, 'g', merkezDurum.g+1, 'h', 0, 'ana', merkezDurum);
    end
    
    switch bos % Sanki break varm�� gibi.
        case 1 % - - - K��E - - -
            % (1,1) <--> (2,1)
            komsuDurumlar(1).sayilar(1,1) = komsuDurumlar(1).sayilar(2,1);
            komsuDurumlar(1).sayilar(2,1) = 0;
           
            % (1,1) <--> (1,2)
            komsuDurumlar(2).sayilar(1,1) = komsuDurumlar(2).sayilar(1,2);
            komsuDurumlar(2).sayilar(1,2) = 0;
        case 2 % ---KENAR---
            % (1,2) <--> (1,1)
            komsuDurumlar(1).sayilar(1,2) = komsuDurumlar(1).sayilar(1,1);
            komsuDurumlar(1).sayilar(1,1) = 0;
           
            % (1,2) <--> (1,3)
            komsuDurumlar(2).sayilar(1,2) = komsuDurumlar(2).sayilar(1,3);
            komsuDurumlar(2).sayilar(1,3) = 0;
            
            % (1,2) <--> (2,2)
            komsuDurumlar(3).sayilar(1,2) = komsuDurumlar(3).sayilar(2,2);
            komsuDurumlar(3).sayilar(2,2) = 0;
        case 3 % - - - K��E - - -
            % (1,3) <--> (2,3)
            komsuDurumlar(1).sayilar(1,3) = komsuDurumlar(1).sayilar(2,3);
            komsuDurumlar(1).sayilar(2,3) = 0;
           
            % (1,3) <--> (1,2)
            komsuDurumlar(2).sayilar(1,3) = komsuDurumlar(2).sayilar(1,2);
            komsuDurumlar(2).sayilar(1,2) = 0;
        case 4 % ---KENAR---
            % (2,1) <--> (1,1)
            komsuDurumlar(1).sayilar(2,1) = komsuDurumlar(1).sayilar(1,1);
            komsuDurumlar(1).sayilar(1,1) = 0;
           
            % (2,1) <--> (2,2)
            komsuDurumlar(2).sayilar(2,1) = komsuDurumlar(2).sayilar(2,2);
            komsuDurumlar(2).sayilar(2,2) = 0;
            
            % (2,1) <--> (3,1)
            komsuDurumlar(3).sayilar(2,1) = komsuDurumlar(3).sayilar(3,1);
            komsuDurumlar(3).sayilar(3,1) = 0;
        case 5 % ---M E R K E Z---
            % (2,2) <--> (1,2)
            komsuDurumlar(1).sayilar(2,2) = komsuDurumlar(1).sayilar(1,2);
            komsuDurumlar(1).sayilar(1,2) = 0;
           
            % (2,2) <--> (2,1)
            komsuDurumlar(2).sayilar(2,2) = komsuDurumlar(2).sayilar(2,1);
            komsuDurumlar(2).sayilar(2,1) = 0;
            
            % (2,2) <--> (2,3)
            komsuDurumlar(3).sayilar(2,2) = komsuDurumlar(3).sayilar(2,3);
            komsuDurumlar(3).sayilar(2,3) = 0;
           
            % (2,2) <--> (3,2)
            komsuDurumlar(4).sayilar(2,2) = komsuDurumlar(4).sayilar(3,2);
            komsuDurumlar(4).sayilar(3,2) = 0;
        case 6 % ---KENAR---
            % (2,3) <--> (1,3)
            komsuDurumlar(1).sayilar(2,3) = komsuDurumlar(1).sayilar(1,3);
            komsuDurumlar(1).sayilar(1,3) = 0;
           
            % (2,3) <--> (3,3)
            komsuDurumlar(2).sayilar(2,3) = komsuDurumlar(2).sayilar(3,3);
            komsuDurumlar(2).sayilar(3,3) = 0;
            
            % (2,3) <--> (2,2)
            komsuDurumlar(3).sayilar(2,3) = komsuDurumlar(3).sayilar(2,2);
            komsuDurumlar(3).sayilar(2,2) = 0;
        case 7 % - - - K��E - - -
            % (3,1) <--> (2,1)
            komsuDurumlar(1).sayilar(3,1) = komsuDurumlar(1).sayilar(2,1);
            komsuDurumlar(1).sayilar(2,1) = 0;
           
            % (3,1) <--> (3,2)
            komsuDurumlar(2).sayilar(3,1) = komsuDurumlar(2).sayilar(3,2);
            komsuDurumlar(2).sayilar(3,2) = 0;
        case 8 % ---KENAR---
            % (3,2) <--> (3,1)
            komsuDurumlar(1).sayilar(3,2) = komsuDurumlar(1).sayilar(3,1);
            komsuDurumlar(1).sayilar(3,1) = 0;
           
            % (3,2) <--> (2,2)
            komsuDurumlar(2).sayilar(3,2) = komsuDurumlar(2).sayilar(2,2);
            komsuDurumlar(2).sayilar(2,2) = 0;
            
            % (3,2) <--> (3,3)
            komsuDurumlar(3).sayilar(3,2) = komsuDurumlar(3).sayilar(3,3);
            komsuDurumlar(3).sayilar(3,3) = 0;
        case 9 % - - - K��E - - -
            % (3,3) <--> (2,3)
            komsuDurumlar(1).sayilar(3,3) = komsuDurumlar(1).sayilar(2,3);
            komsuDurumlar(1).sayilar(2,3) = 0;
           
            % (3,3) <--> (3,2)
            komsuDurumlar(2).sayilar(3,3) = komsuDurumlar(2).sayilar(3,2);
            komsuDurumlar(2).sayilar(3,2) = 0;
    end

    % f ve h'yi hesapla
    for i = 1:length(komsuDurumlar)
        komsuDurumlar(i).h = UzaklikOlc(komsuDurumlar(i).sayilar);
        komsuDurumlar(i).f = komsuDurumlar(i).g + komsuDurumlar(i).h;
    end

end