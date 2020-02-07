#!/bin/bash

showTableOptions() {
    clear
    echo ">>>>> Table ${1} <<<<<<"
    echo "================"
    echo " 1- Show All"
    echo " 2- Select Record"
    echo " 3- Insert New Record"
    echo " 4- Delete Record"
    echo " 5- Go Back"
}

readTableOptions() {
    showTableOptions $1
    read input
    case $input in
    1)
        column -t $1
        ;;

    2)
        selectRecord
        ;;

    3)
        insertRecord
        ;;
    4)
        deletetRecord
        ;;
    5)
        clear
        readTableInput
        ;;
    exit | q)
        exit
        ;;
    *)
        printf "Invalid Input, Try Again\n"
        readTableInput
        ;;
    esac
}
