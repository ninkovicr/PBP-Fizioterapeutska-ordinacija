#!/bin/sh

sudo mysql -u root -p < create.sql
sudo mysql -u root -p < insert.sql
