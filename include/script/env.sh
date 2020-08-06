import_module() {
    file="$HOME/.include/script/$1.sh"

    if test -f "$file"; then
        . "$file"
    else
        >&2 echo "import_module: File \"$file\" doesn't exists."
        exit 1
    fi
}
