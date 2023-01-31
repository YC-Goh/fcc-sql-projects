#!/bin/bash
USER=freecodecamp
if [[ $USER ]]
then
  PSQL="psql --username=$USER --dbname=salon -tc"
  TRIM() {
    echo $1|sed -E 's/^\s+|\s+$//g'
  }
  MENU() {
    if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
    echo -e "\nWe offer the following services:"
    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id")
    echo "$SERVICES" | while read SERVICE_ID BAR SERVICE
    do
      echo -e "$SERVICE_ID) $SERVICE"
    done
    echo -e "\nWhich service would you like? Enter the corresponding number or enter 'q' to quit:"
    read SERVICE_ID_SELECTED
    SERVICE_ID_SELECTED=$(TRIM $SERVICE_ID_SELECTED)
    if [[ $SERVICE_ID_SELECTED ]]
    then
      if [[ $SERVICE_ID_SELECTED =~ ^\s*[0-9]+\s*$ ]]
      then
        SERVICE=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
        SERVICE=$(TRIM $SERVICE)
        if [[ -z $SERVICE ]]
        then
          MENU "That service is not recognised."
        else
          GET_PHONE
        fi
      else
        if [[ $SERVICE_ID_SELECTED = q ]]
        then
          EXIT
        else
          MENU "Please enter a valid number."
        fi
      fi
    else
      MENU "No option entered."
    fi
  }
  GET_PHONE() {
    if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
    echo -e "\nMaking Appointment for $SERVICE."
    echo -e "\nPlease enter your phone number, or 'b' to re-select an option, or 'q' to stop booking:"
    read CUSTOMER_PHONE
    if [[ $CUSTOMER_PHONE ]]
    then
      CUSTOMER_PHONE=$(TRIM $CUSTOMER_PHONE)
      if [[ $CUSTOMER_PHONE = q ]]
      then
        EXIT
      else
        if [[ $CUSTOMER_PHONE = b ]]
        then
          MENU "You have requested to stop booking a $SERVICE."
        else
          if [[ $CUSTOMER_PHONE =~ ^[0-9]+[0-9\(\)\s\-]+[0-9]+$ ]]
          then
            CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
            if [[ -z $CUSTOMER_NAME ]]
            then
              GET_NAME
            else
              GET_TIME
            fi
          else
            GET_PHONE "Invalid phone number submitted."
          fi
        fi
      fi
    else
      GET_PHONE "No phone number entered."
    fi
  }
  GET_NAME() {
    if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
    echo -e "\nYou are not in our records."
    echo -e "\nPlease provide your name, or enter 'b' to stop booking, or enter 'q' to stop booking:"
    read CUSTOMER_NAME
    CUSTOMER_NAME=$(TRIM $CUSTOMER_NAME)
    if [[ -z $CUSTOMER_NAME ]]
    then
      GET_NAME "No name entered."
    else
      if [[ $CUSTOMER_NAME = q ]]
      then
        EXIT
      else
        if [[ $CUSTOMER_NAME = b ]]
        then
          MENU "You have requested to stop booking a $SERVICE."
        else
          ADD_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
          if [[ $ADD_CUSTOMER_RESULT = "INSERT 0 1" ]]
          then
            CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
          fi
          GET_TIME
        fi
      fi
    fi
  }
  GET_TIME() {
    if [[ $1 ]]
    then
      echo -e "\n$1"
    fi
    echo -e "\nWhen would you like your appointment to be? Enter a time in HH:MM (24-hour format) or HH:MM AM/PM (12-hour format), or 'b' to stop booking, or 'q' to stop booking:"
    read SERVICE_TIME
    SERVICE_TIME=$(TRIM $SERVICE_TIME)
    if [[ -z $SERVICE_TIME ]]
    then
      GET_TIME "No time entered."
    else
      if [[ $SERVICE_TIME = q ]]
      then
        EXIT
      else
        if [[ $SERVICE_TIME = b ]]
        then
          MENU "You have requested to stop booking a $SERVICE."
        else
          ADD_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
          echo $ADD_APPOINTMENT_RESULT
          if [[ $ADD_APPOINTMENT_RESULT = "INSERT 0 1" ]]
          then
            APPOINTMENT_ID=$($PSQL "SELECT appointment_id FROM appointments WHERE customer_id=$CUSTOMER_ID AND service_id=$SERVICE_ID_SELECTED AND time='$SERVICE_TIME' ORDER BY appointment_id DESC LIMIT 1")
            echo $APPOINTMENT_ID
          fi
          MAKE_BOOKING
        fi
      fi
    fi
  }
  MAKE_BOOKING() {
    if [[ -z $CUSTOMER_ID ]]
    then
      echo -e "\nThere has been a problem adding your details to our data."
    else
      if [[ -z $APPOINTMENT_ID ]]
      then
        echo -e "\nThere has been a problem creating the appointment."
      else
        echo -e "\nI have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
      fi
    fi
  }
  EXIT() {
    echo "Thank you for your patronage."
  }
  echo -e "\nSalon Appointment Booker CLI"
  MENU
else
  psql -l
fi