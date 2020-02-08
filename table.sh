#!/bin/bash

showTableOptions() {
    echo ">>>>> Table ${selectedTable} <<<<<<"
    echo "================"
    echo " 1- Show All"
    echo " 2- Select Record"
    echo " 3- Insert New Record"
    echo " 4- Delete Record"
    echo " 5- Go Back"
}

deletetRecord() {
    typeset -i recordno
    read -p "Enter Record no.: " recordno
    while ! [[ "$recordno" =~ ^[0-9]+$ ]]; do
                read -p "Enter valid number: " recordno
    done
    recordno=$recordno+1
    if [ $recordno -eq 1 ]; then
        echo "Can't delete record 0"
    else
        sed -i "${recordno}d" ${selectedTable}
    fi


}

insertRecord() {
    declare -a record
    typeset -i index=0
    for i in $(head -1 $selectedTable | tr "|," "| "); do
        dtype=$(echo $i | grep -o -P '(?<=\|).*(?=\|)')
        cname=$(echo $i | grep -o -P '^[^\|]*')

        read -p "Enter $cname as $dtype: " validate

        if [ "${dtype}" = "int" ]; then
            while ! [[ "$validate" =~ ^[0-9]+$ ]]; do
                read -p "Enter valid number: " validate
            done
        else
            while ! [[ "$validate" =~ ^[A-Za-z0-9]+$ ]]; do #validate string only
                read -p "Enter valid string: " validate
            done
        fi
        record[$index]=$validate
        index=$index+1
    done
    echo ${record[@]} | tr " " "," >>$selectedTable

}

readTableOptions() {
    selectedTable=$1
    showTableOptions
    read input
    case $input in
    1)
        clear
        cat $selectedTable | column -t -s ","
        readTableOptions $selectedTable
        ;;

    2)
        read -p "PLZ Enter Line Number : " ln
        let "ln=$ln+1"
        clear
        sed -n $ln"p" <$selectedTable
        printf "\n"
        readTableOptions $selectedTable
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
