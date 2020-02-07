#!/bin/bash
source main_menu.sh
source database.sh
source table.sh
clear

db_absolute_path="$(dirname "$(realpath $0)")/Databases/"
#db_path="Databases/"
echo "🅆🄴🄻🄲🄾🄼🄴 🅃🄾 🄱🄰🅂🄷 🄳🄱🄼🅂"
mkdir -p Databases #create folder if not exists

showMainMenu
