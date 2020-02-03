#!/bin/bash

db_path="Databases/"
echo "🅆🄴🄻🄲🄾🄼🄴 🅃🄾 🄱🄰🅂🄷 🄳🄱🄼🅂"

showMainMenu() {
    echo "Select "
    echo " 1- List Databases"
    echo " 2- Create New Database"
    echo " 3- Connect To Database"

    getMainMenuInput

}

getMainMenuInput() {
    read input
    case $input in

    1)
        clear
        echo "All Databases"
        echo "------------------------"
        ls $db_path
        echo "------------------------"
        showMainMenu
        getMainMenuInput
        ;;

    2)

        createDatabase

        showMainMenu
        ;;

    3)
        connectToDatabase
        ;;
    *)
        printf "Invalid Input, Try Again\n"
        getMainMenuInput
        ;;
    esac

}

createDatabase() {
    printf "PLZ Enter Database Name\n"
    read dbname

    if [ -d "${db_path}${dbname}" ]; then
        echo "Database Already Exists, plz enter another name"
        createDatabase
    else
        mkdir "${db_path}${dbname}"
        cd "${db_path}${dbname}"
        clear
        echo "Database ${dbname} Created Successfully"
    fi
}

connectToDatabase() {
    printf "PLZ Enter Database Name\n"
    read dbname

    if [ -d "${db_path}${dbname}" ]; then
        cd "${db_path}${dbname}"
        echo "Connected to  ${dbname}"
    else
        echo "${dbname} not found"
        connectToDatabase
    fi
}

showMainMenu
