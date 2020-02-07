showTableMenu() {
    echo ">>>>> Tables <<<<<<"
    echo $(ls)
    echo "================"
    echo "Select "
    echo " 1- Select Table"
    echo " 2- Create New Table"
    echo " 3- Delete Table"
    echo " 4- Show All Tables"
    echo " 5- Go Back"
}

createTable() {
#    declare -a carr=("_id|int|")
    declare -a carr
    read -p "Enter Table Name: " tbname
    while ! [[ "$tbname" =~ ^[A-Za-z0-9]+$ ]]; do #validate string only
        read -p "Enter valid string: " tbname
    done

    if [ -f "$tbname" ]; then
        echo "Table exists! "
        createTable
    fi

    read -p "Enter no. of columns: " cols
    #validate integer
    while ! [[ "$cols" =~ ^[0-9]+$ ]]; do
        read -p "Enter valid number: " cols
    done

    for i in $(seq $cols); do
        read -p "enter column $i name: " cname
        while ! [[ "$cname" =~ ^[A-Za-z0-9]+$ ]]; do #validate string only
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
    echo ${carr[@]} | tr " " "," >$tbname

    echo "Table ${tbname} created successfully"
    readTableInput

}

readTableInput() {
    showTableMenu
    read input
    case $input in
    1)
        selectTable
        ;;
    2)
        createTable
        ;;
    3)
        deleteTable
        ;;
    4)
        clear
        ls
        readTableInput
        ;;
    5)
        cd ..
        clear
        showMainMenu
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

selectTable() {
    read -p "PLZ Enter Table Name " tbname
    if [ -f "$tbname" ]; then
        readTableOptions "$tbname"
    else
        echo "Table Not Found!"
        selectTable
    fi

}