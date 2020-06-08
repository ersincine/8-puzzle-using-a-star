function [ sonuc ] = CozulebilirMi( sayilar )

dizi = reshape(sayilar', 1, 9);

% Ters s�ral� eleman say�s�n�n bulunmas�
sayac = 0;
for i = 1:9                                     % 1'den 9'a
    if dizi(i) ~= 0                             % Bo�luk hesaba girmeyecek
        for j = i:9                             % i'den 9'a
            if dizi(j) ~= 0                     % Bo�luk hesaba girmeyecek
                if dizi(j) < dizi(i)            % Daha k���k say� daha sonra geldiyse
                    sayac = sayac + 1;
                end
            end
        end
    end
end

sonuc = mod(sayac,2) == 0;                      % �iftse ��z�lebilir.

end