
# MITTPP - Projekt - Matej Kuprešak

Projekt je napravljen unutar Xcode IDE-a, koristeći SwiftUI framework.
Sastoji se od od 3 Xcode Unit Testa kao i od 2 UI Testa.

Za pokretanje i testiranje samog projekta, potrebno je klonirati GitHub repozitorij, zatim otvoriti projekt u Xcode-u. Nakon što se projekt pokrenuo potrebno je sa lijeve strane u navigatoru pritisnuti na 6. ikonicu(mali dijamant sa kvačicom unutra) kako bi se došlo do ekrana gdje su prikazani svi testovi. Moguće je sa desne strane imena testa pokrenuti ih pojedinačno ili skroz na vrhu pokrenuti sve testove istovremeno.

Testiranje se obavlja na vlastitom projektu - završni projekt sa prakse(COBE internship).
     
## Informacije

Testovi će testirati razne stvari:

- inicijalizaciju samih view modela(MVVM struktura)
- označavanje serije kao favorita pomoću mock serije i mock servisa
- uspješnost dohvaćanja podataka o serijama unutar Home zaslona te tako i Search zaslona(uz fiksno postvaljeni query za pretraživanje)
- prvi UI test - navigirati će na Search zaslon, pritisnuti input field te unijeti tekst "drama" i provjeriti hoće li dobiti rezultate ispod input fielda
- drugi UI test - navigirati će na Favorites zaslon, uzeti broj serija koje su trenutno označene kao favoriti, vratiti se na Home zaslon, označiti još jednu, zatim će se vratiti ponovno na Favorites zaslon i provjeriti je li se broj favorita promijenio
