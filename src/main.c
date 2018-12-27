#include <stdio.h>
#include <stdlib.h>
#include "ordinacija.h"

int main(int argc, char** argv)
{
	Mysql s;
	s.connection = mysql_init(NULL);

	if (mysql_real_connect(s.connection, "localhost", "root", "rada", "mydb",  0, NULL, 0) == NULL)
		printf ("Konektovanje na bazu nije uspelo!\n");

        int izlaz = 1;
	while(izlaz) {
		printf("Izaberi:\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n", 
			"1. Ispis tabele Karton",
                        "2. Ispis tabele Pacijent",
			"3. Dodaj u tabelu Pacijent",
			"4. Dodaj u tabelu Karton",
			"5. Obrisi iz tabele Karton",
			"6. Obrisi iz tabele Pacijent",	
                        "7. Ispis tabele Rasporedjena",
                        "8. Dodaj u tabelu Rasporedjena",
                        "9. Obrisi iz tabele Rasporedjena",
                        "10. Ispis tabele Sadrzaj",
                        "11. Dodaj u tabelu Sadrzaj",
                        "12. Obrisi iz tabele Sadrzaj",
			"0. Izadji iz programa");

		int opcija;
		scanf("%d", &opcija);

		switch(opcija) {
			case 1:
				ispis_kartona(&s);
				break;
                        case 2:
                                ispis_pacijent(&s);
                                break;
			case 3:
				dodaj_pacijent(&s);	
				break;
			case 4:
				dodaj_karton(&s);
				break;
			case 5:
				obrisi_karton(&s);
				break;
			case 6:
				obrisi_pacijent(&s);
				break;
			case 7:
				ispis_rasporedjena(&s);
				break;
			case 8:
				dodaj_rasporedjena(&s);
				break;
			case 9:
				obrisi_rasporedjena(&s);
				break;
			case 10:
				ispis_sadrzaj(&s);
				break;
			case 11:
				dodaj_sadrzaj(&s);
				break;
			case 12:
				obrisi_sadrzaj(&s);
				break;
			case 0:
				izlaz = 0;
				break;
			default:
				printf("Pogresna opcija\n");
				break;
		}

		printf("\n");
	}

	mysql_close(s.connection);
	exit(EXIT_SUCCESS);
}