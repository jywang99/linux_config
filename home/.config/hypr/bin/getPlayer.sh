#!/bin/bash

# Example:
# chromium mpris:artUrl file:///tmp/.com.google.Chrome.lET32K
# chromium mpris:length 172081000
# chromium mpris:trackid '/org/chromium/MediaPlayer2/TrackList/Track9F5006760AEF606B418205C40C5F9229'
# chromium xesam:album
# chromium xesam:artist
# chromium xesam:title

print_label() {
    echo "$title"
}

render() {
    if [[ -z "$title" ]]; then
        echo ""
        return
    fi
    # echo "{\"text\": \"$title\", \"tooltip\": \"<img src=\"$artUrl\"/>$title\n$artist\n$album\"}"
    echo "{\"text\": \"$title\", \"tooltip\": \"Title: $title\nArtist: $artist\nAlbum: $album\"}"
}

reset_all() {
    artUrl=""
    length=""
    trackid=""
    album=""
    artist=""
    title=""
    render
}
reset_all

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
            ;;
        *)
            continue
            ;;
    esac

    render
done

