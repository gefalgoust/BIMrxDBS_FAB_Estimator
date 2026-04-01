# FAB Estimator – `.fest` Bundle (v4 – silent, Option C implemented)

**Highlights**
- Handler copies the batch to **%TEMP%** and launches **locally** (avoids network security prompt).
- Batch uses **Strategy C → D only**: open local template copy; fallback to **Excel COM** helper.
- Windows stay hidden by default (silent flow). Use AssociationCheck.bat for quick diagnostics.

## Files
- `OpenFest.ps1` – resolves sibling `.csv`, runs local temp copy of the batch (Hidden).
- `BIMrxDBS Shop Order.bat` – copies CSV then opens template via Strategy C → D.
- `OpenExcelFromTemplate.ps1` – COM helper fallback.
- `RegisterFESTFileType.bat` / `UnregisterFESTFileType.bat`
- `AssociationCheck.bat` – dumps `.fest` association to `%TEMP%\FEST_Association.txt`.

## Active Folder Layout
Keep these in the project root:
- `OpenFest.ps1`
- `BIMrxDBS Shop Order.bat`
- `OpenExcelFromTemplate.ps1`
- `RegisterFESTFileType.bat`
- `UnregisterFESTFileType.bat`
- `AssociationCheck.bat`
- `BIMrxDBS Shop Order.csv`

Keep this template in:
- `Programming ONLY\2025_FAB-Estimator.xltm`

Legacy shell-integration files are archived under:
- `10 Archive\Legacy Shell Integration`

Additional non-runtime items are archived under:
- `10 Archive\Optional Tools\OpenwithExcel`
- `10 Archive\Samples\01_Test`
- `10 Archive\Samples\Blank CSV`
- `10 Archive\Workbook Copies`
- `10 Archive\Legacy Assets`

## Setup
1) Place all files together in your tools folder.
2) Run **RegisterFESTFileType.bat** once (per user).
3) Optional: `Unblock-File -LiteralPath "...\OpenFest.ps1"` if Windows flags it.

## Use
- Ensure a `.fest` has a same-name `.csv` in the same folder.
- Double‑click the `.fest` → the CSV is copied → Excel opens the template from `%TEMP%` (or COM fallback).

## Troubleshooting
- Temporarily make the handler visible by changing `-WindowStyle Hidden` → `Normal` in `OpenFest.ps1`.
- Check `%TEMP%\OpenFest_Log.txt` for errors.
