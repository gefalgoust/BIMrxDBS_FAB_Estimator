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
