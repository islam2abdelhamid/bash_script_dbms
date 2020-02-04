#!/bin/bash
db_absolute_path="$(dirname `realpath $0`)/Databases/"
#db_path="Databases/"
echo "🅆🄴🄻🄲🄾🄼🄴 🅃🄾 🄱🄰🅂🄷 🄳🄱🄼🅂"
mkdir -p Databases #create folder if not exists
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
        ls $db_absolute_path
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
    exit|q)
        exit
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

    if [ -d "${db_absolute_path}${dbname}" ]; then
        echo "Database Already Exists, plz enter another name"
        createDatabase
    else
        mkdir "${db_absolute_path}${dbname}"
        cd "${db_absolute_path}${dbname}"
        clear
        echo "Database ${dbname} Created Successfully"
    fi
}

showTableMenu(){
    clear
    echo "Connected to  ${dbname}"
    echo ">>>>> Tables <<<<<<"
    echo `ls`
    echo "================"
    echo "Select "
    echo " 1- Select"
    echo " 2- Delete"
    echo " 3- Insert"
    echo " 4- Create Table"
}

createTable(){
    echo `pwd`
    declare -a carr=("_id")
    read -p "Enter Table Name: " tbname
    while ! [[ "$tbname" =~ ^[A-Za-z0-9]+$ ]] #validate string only
    do
        read -p "Enter valid string: " tbname
    done

    if [ -f "$tbname" ]; then
        echo "Table exists! "
        createTable
    fi

    read -p "Enter no. of columns: " cols
    #validate integer
    while ! [[ "$cols" =~ ^[0-9]+$ ]]
    do
        read -p "Enter valid number: " cols
    done

    for i in $(seq $cols)
    do
        read -p "enter column $i name: " cname
        while ! [[ "$cname" =~ ^[A-Za-z0-9]+$ ]] #validate string only
        do
            read -p "Enter valid string: " cname
        done

        read -p "enter column $i datatype int/string (default: string): " ctype
        if [ "${ctype}" = "int" ]; then
            ctype="|int|"
        else
            ctype="|string|"
        fi
        carr[$i]="$cname$ctype"
        if [ $cols -eq 1 ]; then
            break
        fi
    done
    echo ${carr[@]} | tr " " "," > $tbname

}

readTableInput() {
    showTableMenu
    read input
    case $input in
    1)
        selectTable
        ;;
    2)
        deleteTable
        ;;

    3)
        insertTable
        ;;
    4)
        createTable
        ;;
    exit|q)
        exit
        ;;
    *)
        printf "Invalid Input, Try Again\n"
        readTableInput
        ;;
    esac
}


connectToDatabase() {
    printf "PLZ Enter Database Name\n"
    read dbname

    if [ -d "${db_absolute_path}${dbname}" ]; then
        cd "${db_absolute_path}${dbname}"
        readTableInput
    else
        echo "${dbname} not found"
        connectToDatabase
    fi
}

showMainMenu
