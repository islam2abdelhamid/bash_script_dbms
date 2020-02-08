showMainMenu() {
    echo "------------------------"
    echo "Select "
    echo " 1- List Databases"
    echo " 2- Create New Database"
    echo " 3- Connect To Database"
    echo "------------------------"

    getMainMenuInput

}

getMainMenuInput() {
    read -p ">>" input
    case $input in

    1)
        clear
        echo "------------------------"

        if [ -z "$(ls -A ${db_absolute_path})" ]; then
            echo "No Database!"
        else
            echo "All Databases"
            ls "$db_absolute_path"
        fi

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
    exit | q)
        exit
        ;;
    *)
        printf "Invalid Input, Try Again\n"
        getMainMenuInput
        ;;
    esac

}

createDatabase() {

    read -p "PLZ Enter Database Name : " dbname

    while ! [[ "$dbname" =~ ^[A-Za-z0]+$ ]]; do #validate string only
        read -p "Enter valid string: " dbname
    done

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

connectToDatabase() {
    read -p "PLZ Enter Database Name:" dbname

    if [ -d "${db_absolute_path}${dbname}" ]; then
        clear
        cd "${db_absolute_path}${dbname}"
        echo "Connected to ${dbname}"
        readTableInput
    else
        echo "${dbname} not found"
        connectToDatabase
    fi
}
