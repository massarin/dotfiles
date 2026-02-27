# Activate .venv or path/to/venv
avenv() {
    local venv_dir="${1:-.venv}"
    if [ -d "$venv_dir" ]; then
        # shellcheck disable=SC1090
        source "$venv_dir/bin/activate"
        echo "Activated virtual environment: $(basename "$venv_dir")"
    else
        echo "Directory '$venv_dir' does not exist."
    fi
}

# Make a .venv with -ssp (optional)
mkvenv() {
    local venv_dir=".venv"
    local use_ssp=0

    for arg in "$@"; do
        case "$arg" in
            -ssp) use_ssp=1 ;;
            *)    venv_dir="$arg" ;;
        esac
    done

    if [ -d "$venv_dir" ]; then
        echo "Directory '$venv_dir' already exists."
        return 1
    fi

    local ssp_flag=""
    [ "$use_ssp" -eq 1 ] && ssp_flag="--system-site-packages"

    python3 -m venv $ssp_flag "$venv_dir" || { echo "Failed to create virtual environment."; return 1; }
    echo "Created virtual environment: $(basename "$venv_dir")"
}
