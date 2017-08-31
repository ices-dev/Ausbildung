#!/bin/bash

# Telefonbuch
#
# Funktionen: Anzeigen
#             Suchen
#             Eintragen
#             Löschen
#
# Author    : Holger Wessel
# Datum     : 31.08.2017

# Variablen
EING=0                                                                          # Quit
VNAME=0                                                                         # (Vor)Name
NUMM=0                                                                          # Telefonnummer
ABBR="23"                                                                       # Zurück zum Menu
SUCH=0                                                                          # Suchvariable
LOSH=0                                                                          # Löschvariable

# Anzeigen
function f_anzeigen {
    while [[ $ABBR == 23 ]];do
        clear
        echo "Telefonbuchinhalt anzeigen"
        echo ""
        cat telefon.buch|sort -f                                                # Anzeige Telefonbuch A-Z
        echo ""
        sleep 1
        echo "Drücken sie eine Taste"
        read -sn1 ABBR 
    done
    ABBR="23"
}

# Suchen
function f_suchen {
    while [[ $ABBR == 23 ]];do
        clear
        echo "Telefonbuchinhalt suchen"
        echo ""
        read -p "Suchkriterium? " SUCH
        cat telefon.buch|grep -i "$SUCH"                                        # Suche ignoriert Case
        echo ""
        sleep 1
        echo "Drücken sie eine Taste"
        read -sn1 ABBR 
    done
    ABBR="23" 
}

# Eintragen
function f_eintragen {
    clear
    echo "Telefonbucheintrag hinzufügen"
    echo ""
    read -p "Name? " VNAME
    echo ""
    read -p "Nummer? " NUMM
    echo "$VNAME: $NUMM" >> telefon.buch
    echo ""
    echo "Eintrag erfolgreich! Vielen Dank."
    sleep 2
}

# Löschen
function f_loschen {
    while [[ $ABBR == 23 ]];do
        clear
        echo "Telefonbuchinhalt löschen"
        echo ""
        read -p "Suchkriterium? " LOSH
        cat telefon.buch|grep -i "$LOSH"                                        # Suche ignoriert Case
        echo ""
        echo "Wollen Sie >>`cat telefon.buch|grep -i "$LOSH"`<< löschen? (j/n)"
        echo ""
        read -sn1 DELL
        if [[ $DELL == j ]];then
            cat telefon.buch|grep -iv "$LOSH">telefon.neu                       # Ergebnis der Suche wird invertiert
            mv telefon.neu telefon.buch                                         # Telefon.buch aktualisieren
            echo "Erfolgreich gelöscht!"
        else
            echo "ABBRUCH!"
            echo ""
        fi    
        sleep 1
        echo "Drücken sie eine Taste"
        read -sn1 ABBR 
    done
    ABBR="23"     clear
    echo "löschen"
} 

# Menu
while [[ $EING != q ]];do
    clear
    echo "Telefonbuch"
    echo ""
    echo "Bitte wählen Sie:"
    echo "a - Anzeigen"
    echo "s - Suchen"
    echo "e - Eintragen"
    echo "l - Löschen"
    echo ""
    echo "q - Beenden"
    read -sn1 EING
    case "$EING" in
        a) f_anzeigen
        ;;
        s) f_suchen
        ;;
        e) f_eintragen
        ;;
        l) f_loschen
    esac
done  

