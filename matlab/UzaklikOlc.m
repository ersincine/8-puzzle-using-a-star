function [ mesafe ] = UzaklikOlc( kaynak )

    hedef = [1 2 3 ; 4 5 6 ; 7 8 0];
    mesafe = 0;
    for i = 1:8                                                             % Di�erleri do�ru olunca 0 da do�ru olacak.
        [kSat, kSut] = find(kaynak == i);
        [hSat, hSut] = find(hedef == i);
        mesafe = mesafe + abs(kSat - hSat) + abs(kSut - hSut);              % Manhattan mesafesi.
    end

end