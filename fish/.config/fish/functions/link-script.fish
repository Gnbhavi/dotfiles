function link-script --description "Symlink a script into ~/.local/bin"
    set -l src (realpath $argv[1])
    if not test -f $src
        echo "File not found: $src"
        return 1
    end
    chmod +x $src
    set -l name (basename $src | string replace -r '\.sh$' '')
    ln -sf $src ~/.local/bin/$name
    echo "Linked: $name -> $src"
end
