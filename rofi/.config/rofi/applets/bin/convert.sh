for img in ~/.config/wallpapers/*.{jpg,png}; do

    [ -f "$img" ] || continue
    filename=$(basename "$img")
    echo "$filename"
    convert "$img" -resize 48x48 /home/mo/.config/wallpapers/wal-icons/"$filename"
done
