#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <errno.h>
#include <stdarg.h>
#include "ordinacija.h"

void ispis_kartona(Mysql* s)
{
	sprintf(s->query, "select * from Karton;");
        printf("Upit je %s\n", s->query);
	if(mysql_query(s->connection, s->query)){
            printf("Nije uspeo upit.\n");
            exit(EXIT_FAILURE);
        }

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
        
        int br = mysql_field_count(s->connection);

        for (int i=0; i<br; i++) {
            printf ("%s\t\t", s->column[i].name);
        }
        printf ("\n\n");

        while ((s->row = mysql_fetch_row(s->result))) {
            for (int i=0; i<br; i++)
                printf ("%s\t\t", s->row[i]);
            printf ("\n");
        }
        printf ("\n\n");
        
}

void dodaj_karton(Mysql* s){
        printf ("Tabela Karton pre unosenja:\n\n");
        ispis_kartona(s);
    
        printf("Unesi:jmbg(13).\n");
        char* jmbg;
        scanf("%ms", &jmbg);
        
        printf("rbrPosete\n");
        int rbrPosete;
        scanf("%d", &rbrPosete);
        
	char* dijagnoza;
        size_t duzina = 32;
        
        dijagnoza = (char *)malloc(duzina * sizeof(char));
        if(dijagnoza == NULL){
            printf("Nije uspela alokacija memorije.");
            exit(EXIT_FAILURE);
        }
        printf("dijagnoza\n");
        getchar();
        getline(&dijagnoza, &duzina, stdin);
        
        printf("brTerapija\n");
	int brTerapija;
        scanf("%d", &brTerapija);
        
        printf("brUradjenih\n");
	int brUradjenih;
	scanf("%d", &brUradjenih);

	sprintf(s->query,"insert into Karton(jmbg, rbrPosete, dijagnoza, brTerapija, brUradjenih) values ('%s', %d, '%s', %d, %d);", jmbg, rbrPosete, dijagnoza, brTerapija, brUradjenih);   
	printf("Upit je %s\n",s->query);
	if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }

        printf ("Tabela Karton nakon unosenja:\n\n");
        ispis_kartona(s);
        printf("\n\n");  
        
  	free(jmbg);
  	free(dijagnoza);
}


void obrisi_karton(Mysql* s){
        printf ("Tabela Karton pre brisanja:\n\n");
        ispis_kartona(s);

        printf ("Unesite jmbg i rbrPosete pacijenta koga zelite da izbrisete iz tabele Karton:\n");

        char* jmbg;
        int rbrPosete;
        scanf("%ms%d", &jmbg, &rbrPosete);

        sprintf (s->query, "delete from Karton where jmbg='%s' and rbrPosete=%d;", jmbg, rbrPosete);

        if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit.\n");
            exit (EXIT_FAILURE);
        }

        printf ("Tabela Karton nakon brisanja:\n\n");
        ispis_kartona(s);
        printf("\n\n");
}

void ispis_pacijent(Mysql* s){
    	sprintf(s->query, "select * from Pacijent;");
        printf("Upit je %s\n", s->query);
	if(mysql_query(s->connection, s->query)){
            printf("Nije uspeo upit.\n");
            exit(EXIT_FAILURE);
        }

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
        
        int br = mysql_field_count(s->connection);

        for (int i=0; i<br; i++) {
            printf ("%s\t\t", s->column[i].name);
        }
        printf ("\n\n");

        while ((s->row = mysql_fetch_row(s->result))) {
            for (int i=0; i<br; i++)
                printf ("%s\t\t", s->row[i]);
            printf ("\n");
        }
        printf ("\n\n");
}

void dodaj_pacijent(Mysql* s){
        printf ("Tabela Pacijent pre unosenja:\n\n");
        ispis_pacijent(s);
        
        printf("Unesi:jmbg(13)\n");
        char* jmbg;
        scanf("%ms", &jmbg);
        
        printf("ime\n");
        char* ime;
        scanf("%ms", &ime);
        
        printf("prezime\n");
        char* prezime;
        scanf("%ms", &prezime);
        
        printf("datumRodjenja(GGGG-MM-DD)\n");
        char* datumRodjenja;
        scanf("%ms", &datumRodjenja);
        
        char* ulaz;
        char adresa[100];
        size_t duzina = 32;
        
        ulaz = (char *)malloc(duzina * sizeof(char));
        if(ulaz == NULL){
            printf("Nije uspela alokacija memorije.");
            exit(EXIT_FAILURE);
        }
        printf("adresa\n");
        getchar();
        getline(&ulaz, &duzina, stdin);
        
        for(int i=0; ulaz[i] != '\n'; i++)
            adresa[i] = ulaz[i];
        
        printf("telefon\n");
        char* telefon;
        scanf("%ms", &telefon);
        
        printf("email\n");
        char* email;
        scanf("%ms", &email);

	sprintf(s->query,"insert into Pacijent(jmbg, ime, prezime, datumRodjenja, adresa, telefon, email) values ('%s', '%s', '%s', '%s', '%s', '%s', '%s');", jmbg, ime, prezime, datumRodjenja, adresa, telefon, email);   
	printf("Upit je %s\n",s->query);
	if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }
        
        printf ("Tabela Pacijent nakon unosenja:\n\n");
        ispis_pacijent(s);
        printf("\n\n");  
        
  	free(jmbg);
  	free(ime);
        free(prezime);
        free(datumRodjenja);
        free(ulaz);
        free(email);
}

void obrisi_pacijent(Mysql* s){
        printf ("Tabela Pacijent pre brisanja:\n\n");
        ispis_pacijent(s);

        printf ("Unesite jmbg pacijenta koga zelite da izbrisete iz tabele Pacijent:\n");

        char* jmbg;
        scanf("%ms", &jmbg);

        sprintf (s->query, "delete from Pacijent where jmbg='%s';", jmbg);

        if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }

        printf ("Tabela Pacijent nakon brisanja:\n\n");
        ispis_pacijent(s);
        printf("\n\n");    
}

void ispis_rasporedjena(Mysql* s){
	sprintf(s->query, "select * from Rasporedjena;");
        printf("Upit je %s\n", s->query);
	if(mysql_query(s->connection, s->query)){
            printf("Nije uspeo upit.\n");
            exit(EXIT_FAILURE);
        }

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
        
        int br = mysql_field_count(s->connection);

        for (int i=0; i<br; i++) {
            printf ("%s\t\t", s->column[i].name);
        }
        printf ("\n\n");

        while ((s->row = mysql_fetch_row(s->result))) {
            for (int i=0; i<br; i++)
                printf ("%s\t\t", s->row[i]);
            printf ("\n");
        }
        printf ("\n\n");
      
}


void dodaj_rasporedjena(Mysql* s){
        printf ("Tabela Rasporedjena pre unosenja:\n\n");
        ispis_rasporedjena(s);
    
        printf("Unesi:vremePocetka(HH:MM)\n");
        char* vremePocetka;
        scanf("%ms", &vremePocetka);
        
        printf("vremeKraja(HH:MM)\n");
        char* vremeKraja;
        scanf("%ms", &vremeKraja);
        
        char* ulaz;
        char nazivTerapije[100];
        size_t duzina = 32;
        
        ulaz= (char *)malloc(duzina * sizeof(char));
        if(ulaz == NULL){
            printf("Nije uspela alokacija memorije.");
            exit(EXIT_FAILURE);
        }
        printf("nazivTerapije\n");
        getchar();
        getline(&ulaz, &duzina, stdin);
        
        for(int i=0; ulaz[i] != '\n'; i++)
            nazivTerapije[i] = ulaz[i];
        
        printf("brojSale\n");
        int brojSale;
        scanf("%d", &brojSale);

	sprintf(s->query,"insert into Rasporedjena(vremePocetka, vremeKraja, nazivTerapije, brojSale) values ('%s', '%s', '%s', %d);", vremePocetka, vremeKraja, nazivTerapije, brojSale);   
	printf("Upit je %s\n",s->query);
	if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }
        printf ("Tabela Rasporedjena nakon unosenja:\n\n");
        ispis_rasporedjena(s);
        printf("\n\n");  
        
        free(vremeKraja);
        free(vremePocetka);
        free(ulaz);
}



void obrisi_rasporedjena(Mysql* s){
        printf ("Tabela Rasporedjena pre brisanja:\n\n");
        ispis_rasporedjena(s);

        printf ("Unesite nazivTerapije i brojSale koge zelite da izbrisete iz tabele Rasporedjena.\n");

        char* ulaz;
        char nazivTerapije[100];
        size_t duzina = 32;
        
        ulaz= (char *)malloc(duzina * sizeof(char));
        if(ulaz == NULL){
            printf("Nije uspela alokacija memorije.");
            exit(EXIT_FAILURE);
        }
        printf("nazivTerapije\n");
        getchar();
        getline(&ulaz, &duzina, stdin);
        
        for(int i=0; ulaz[i] != '\n'; i++)
            nazivTerapije[i] = ulaz[i];
        
        printf("brojSale\n");
        int brojSale;
        scanf("%d", &brojSale);

        sprintf (s->query, "delete from Rasporedjena where brojSale = %d and nazivTerapije = '%s';", brojSale, nazivTerapije);

        if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }

        printf ("Tabela Pacijent nakon brisanja:\n\n");
        ispis_rasporedjena(s);
        printf("\n\n");      
}

void ispis_sadrzaj(Mysql* s){
	sprintf(s->query, "select * from Sadrzaj;");
        printf("Upit je %s\n", s->query);
	if(mysql_query(s->connection, s->query)){
            printf("Nije uspeo upit.\n");
            exit(EXIT_FAILURE);
        }

	s->result = mysql_use_result(s->connection);
	s->column = mysql_fetch_field(s->result);
        
        int br = mysql_field_count(s->connection);

        for (int i=0; i<br; i++) {
            printf ("%s\t\t", s->column[i].name);
        }
        printf ("\n\n");

        while ((s->row = mysql_fetch_row(s->result))) {
            for (int i=0; i<br; i++)
                printf ("%s\t\t", s->row[i]);
            printf ("\n");
        }
        printf ("\n\n");    
}

void dodaj_sadrzaj(Mysql* s){
        printf ("Tabela Sadrzaj pre unosenja:\n\n");
        ispis_sadrzaj(s);
    
        printf("Unesi:kolicina\n");
        int kolicina;
        scanf("%d", &kolicina);
        
        printf("brojSale\n");
        int brojSale;
        scanf("%d", &brojSale);
        
        printf("sifraSprava\n");
        int sifraSprava;
        scanf("%d", &sifraSprava);

	sprintf(s->query,"insert into Sadrzaj(kolicina, brojSale, sifraSprava) values (%d, %d, %d);", kolicina, brojSale, sifraSprava);   
	printf("Upit je %s\n",s->query);
	if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }
        printf ("Tabela Sadrzaj nakon unosenja:\n\n");
        ispis_sadrzaj(s);
        printf("\n\n");  
}


void obrisi_sadrzaj(Mysql* s){
        printf ("Tabela Sadrzaj pre brisanja:\n\n");
        ispis_sadrzaj(s);

        printf ("Unesite brojSale i sifraSprava koju zelite da izbrisete iz tabele Sadrzaj.\n");
        
        printf("brojSale\n");
        int brojSale;
        scanf("%d", &brojSale);

        printf("sifraSprava\n");
        int sifraSprava;
        scanf("%d", &sifraSprava);
        
        sprintf (s->query, "delete from Sadrzaj where brojSale = %d and sifraSprava = %d;", brojSale, sifraSprava);

        if (mysql_query(s->connection, s->query)) {
            printf ("Nije uspeo upit. %s\n", mysql_error(s->connection));
            exit (EXIT_FAILURE);
        }

        printf ("Tabela Sadrzaj nakon brisanja:\n\n");
        ispis_sadrzaj(s);
        printf("\n\n");      
    
}







