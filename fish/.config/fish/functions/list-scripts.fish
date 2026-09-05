function list-scripts --description "List custom scripts (Rust first, fallback to shell)"
    # 1. Point directly to the Rust binary in your folder
    set -l rust_bin /home/gnbhavithran/Repos/Projects/rust_files/table-test/target/release/table-test

    # 2. Check if the Rust program exists and is executable
    if test -x "$rust_bin"
        $rust_bin
    else
        # 3. Fallback: Your original pure shell logic
        set -l width (math $COLUMNS - 4)
        for f in ~/.local/bin/*
            if test -L $f
                set -l target (readlink -f $f)
                set -l desc (grep -m1 '^# desc:' $target 2>/dev/null | string replace -r '^# desc:\s*' '')
                set -l usage (grep -m1 '^# usage:' $target 2>/dev/null | string replace -r '^# usage:\s*' '')

                set_color yellow
                echo (basename $f)
                set_color normal

                if test -n "$desc"
                    echo "$desc" | fold -s -w $width | sed 's/^/  /'
                end
                if test -n "$usage"
                    set_color cyan
                    echo "$usage" | fold -s -w $width | sed 's/^/  /'
                    set_color normal
                end
                echo ""
            end
        end
    end
end
