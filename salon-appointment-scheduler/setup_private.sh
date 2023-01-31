#!/bin/bash
USER=$1
if [[ $USER ]]
then
  sudo -u postgres createdb --owner=$USER salon
  PSQL="psql --username=$USER --dbname=salon -c"
  CREATE_SERVICES=$($PSQL "CREATE TABLE services (service_id SERIAL PRIMARY KEY, name VARCHAR(32) UNIQUE NOT NULL)")
  CREATE_CUSTOMERS=$($PSQL "CREATE TABLE customers (customer_id SERIAL PRIMARY KEY, name VARCHAR(64) NOT NULL, phone VARCHAR(16) UNIQUE NOT NULL)")
  CREATE_APPOINTMENTS=$($PSQL "CREATE TABLE appointments (appointment_id SERIAL PRIMARY KEY, customer_id INT NOT NULL REFERENCES customers (customer_id), service_id INT NOT NULL REFERENCES services (service_id), time VARCHAR(8) NOT NULL)")
  ADD_SERVICES=$($PSQL "INSERT INTO services (name) VALUES ('Cut'), ('Cut+Shave'), ('Cut+Wash'), ('Style'), ('Cut+Wash+Style'), ('Ladies Cut')")
else
  psql -l
fi