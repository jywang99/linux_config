#!/bin/bash

# Example:
# chromium mpris:artUrl file:///tmp/.com.google.Chrome.lET32K
# chromium mpris:length 172081000
# chromium mpris:trackid '/org/chromium/MediaPlayer2/TrackList/Track9F5006760AEF606B418205C40C5F9229'
# chromium xesam:album
# chromium xesam:artist
# chromium xesam:title

reset_all() {
    artUrl=""
    length=""
    trackid=""
    album=""
    artist=""
    title=""
}
reset_all

print_label() {
    echo "$title"
}

print_tooltip() {
    # One day I'll get this to show
    echo "<img src=\"$artUrl\"/><br/>$title<br/>$artist<br/>$album"
}

playerctl -F metadata 2>/dev/null | while read -r line; do
    # blank line: reset all variables
    if [[ -z "$line" ]]; then
        reset_all
        continue
    fi

    # everything after ':' in the 2nd column
    field=$(echo "$line" | awk '{print $2}' | awk -F ':' '{print $2}')
    # $3 til end
    value=$(echo "$line" | awk '{for(i=3;i<=NF;++i) printf "%s ", $i}')

    label_updated=0

    case $field in
        "artUrl")
            artUrl="$value"
            ;;
        "length")
            length="$value"
            ;;
        "trackid")
            trackid="$value"
            ;;
        "album")
            album="$value"
            ;;
        "artist")
            artist="$value"
            ;;
        "title")
            title="$value"
            label_updated=1
            ;;
        *)
            continue
            ;;
    esac

    if [[ $label_updated -eq 1 ]]; then
        print_label
    fi
    # print_tooltip
done

