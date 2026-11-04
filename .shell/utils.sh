# Print info of .fits/.parquet/.bin
file_info() {
    if [[ -z "$1" ]]; then
        echo "Error: Please provide a file as an argument"
        return 1
    fi

    local file="$1"
    local ext="${file##*.}"

    case "$ext" in
        fits)
            python3 -c "
from astropy.io import fits
hdul = fits.open('$file')
hdul.info()
for i, hdu in enumerate(hdul):
    if hasattr(hdu, 'columns') and hdu.columns:
        print(f'\nHDU {i} columns:', [c.name for c in hdu.columns])
hdul.close()
"
            ;;
        parquet)
            python3 -c "
import pandas as pd
df = pd.read_parquet('$file')
print(df.info())
print('\nShape:', df.shape)
print('Columns:', df.columns.tolist())
"
            ;;
        bin)
            echo "Binary file: $file"
            file "$file"
            hexdump -C "$file" | head -20
            ;;
        csv)
            python3 -c "import pandas as pd; df = pd.read_csv('$file'); print(df.info()); print('\nShape:', df.shape)"
            ;;
        json)
            python3 -c "import json; data = json.load(open('$file')); print(json.dumps(data, indent=2)[:500])"
            ;;
        *)
            echo "Unsupported file type: .$ext"
            return 1
            ;;
    esac
}

# add, commit and push everything
lazygit() { git add . && git commit -m "$1" && git push; }

# download URL [NAME] as NAME.pdf (default: last path segment)
wgetpdf() {
  local url=$1
  local name=${2:-$(basename "${url%%\?*}")}   # strip query string, take basename
  wget -O "${name%.pdf}.pdf" "$url"            # %.pdf avoids double extension
}

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
