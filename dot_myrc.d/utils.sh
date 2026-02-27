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
