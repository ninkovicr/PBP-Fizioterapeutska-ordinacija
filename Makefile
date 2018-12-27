DIR	= mysql-C
CC = gcc
PROGS	= src/main.c src/ordinacija.c
OUTPUT = ordinacija
CFLAGS	= -g -Wall `mysql_config --cflags --libs`

.PHONY: all create trigger insert beauty dist progs

all: create trigger insert progs

progs:
	$(CC) -o $(OUTPUT) $(PROGS) $(CFLAGS)

create:
	mysql -u root -p < sql/create.sql

trigger:
	mysql -u root -p < sql/triger.sql

insert:
	mysql -u root -p < sql/inserti.sql
	
beauty:
	-indent $(PROGS)

clean:
	-rm -f *~ $(OUTPUT)
	
dist: beauty clean
	-tar -zcvf $(DIR).tar.gz $(DIR)

