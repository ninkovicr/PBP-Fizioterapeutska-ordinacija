#ifndef DBHEADER_H
#define DBHEADER_H

#include <mysql/mysql.h>

#define MAX_QUERY_LENGTH 1024
#define BUFFER_SIZE 100
typedef struct {
	MYSQL *connection;
	MYSQL_RES *result;
	MYSQL_ROW row;
	MYSQL_FIELD *column;
	char query[MAX_QUERY_LENGTH];
}Mysql;

void ispis_kartona(Mysql* s);
void dodaj_karton(Mysql* s);
void obrisi_karton(Mysql* s);

void dodaj_pacijent(Mysql* s);
void ispis_pacijent(Mysql* s);
void obrisi_pacijent(Mysql* s);

void ispis_rasporedjena(Mysql* s);
void dodaj_rasporedjena(Mysql* s);
void obrisi_rasporedjena(Mysql* s);

void ispis_sadrzaj(Mysql* s);
void dodaj_sadrzaj(Mysql* s);
void obrisi_sadrzaj(Mysql* s);
							
#endif