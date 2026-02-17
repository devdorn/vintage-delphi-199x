# Research & Findings - Delphi 4 Archive

This document tracks technical discoveries and analysis results made during the preparation of the vintage Delphi 4 codebase archive.

## Delphi Code Rescue Plan (Bereinigungsplan)

**Status:** Completed (2026-02-17)

### Summary of Reorganization
The codebase was reorganized from a flat/miscellaneous structure into a standardized repository layout:
- **`src/faktur`**: A commercial invoicing application prototype (`fakt40.dpr`).
- **`src/monat`**: Data processing for monthly reports, utilizing Delphi DataModules (`DataMod1.pas`).
- **`src/beispiele`**: Placeholder for early code examples.
- **`src/test`**: UI experiments and scratchpad projects.
- **`external/easycash-backup`**: Third-party components and examples isolated from personal source code.

### Cleanup Actions
- All compiled units (`*.dcu`) and executables (`*.exe`) were removed from the source tree (or ignored via `.gitignore`).
- Temporary Delphi IDE backup files (`*.~*`) were purged to ensure only current source versions are archived.
- Resource files (`*.res`) and form definitions (`*.dfm`) were preserved as they are essential for Delphi project compilation.

---

## Technical Discoveries

### Character Encoding & Localization
**Analysis Date:** 2026-02-17
- **Findings:** Most source files (`.pas`) are stored in standard **US-ASCII** or **ISO-8859-1**. 
- **Observations:** German umlauts appear in comments (e.g., `{ Private-Deklarationen }`) and UI labels. Due to the ASCII-compatible nature of these files, they remain readable in modern UTF-8 environments.
- **Legacy Paths:** Hardcoded file paths like `c:\rchfrd.txt` were found in `fakt04.pas`, reflecting the local development environment of the late 90s.

### UI & Framework Versioning
- **Platform:** Borland Delphi 4.0.
- **Components:** Extensive use of standard VCL components (`TButton`, `TLabel`, `TTable`, `TBatchMove`).
- **Data Access:** The `monat` project reveals the use of the **Borland Database Engine (BDE)** via `TTable` and `TBatchMove` for automated data transfers.

---

## Third-Party Component Analysis

**Status:** Isolated to `external/`

### Easycash / Alexander Halser (1998)
- **Component:** `TBackupFile` (found in `backup.pas`).
- **Functionality:** High-speed compression and self-extracting archive (SFX) creation.
- **Algorithms:** Implementation of `LZRW1KH` (by Kurt Haenen, modified by Halser) and linking of **Zlib 1.0.4** C-objects.
- **Decision:** This code was moved to `external/easycash-backup` to distinguish it from the user's original work and respect the original author's copyright (Copyright 1998 Easycash Software).

---

## Known Issues & Historical Artifacts

### Binaries in Archive
The folder `external/easycash-backup` contains several `.OBJ` files (e.g., `DEFLATE.OBJ`). These are compiled C-code fragments required by the Pascal units at link-time. They are preserved here as "binary artifacts" because the original C source is not part of this specific collection.

### Missing Data Files
The application logic in `faktur` expects external text files (like `C:\rchfrd.txt`). These data files were not part of the recovered archive and are likely lost to time.

---

## Author Attribution

**Confirmed Personal Code:**
- All logic in `src/faktur`, `src/monat`, and `src/test`.
- UI Design and form layouts in the corresponding `.dfm` files.

**Third-Party Code:**
- `external/easycash-backup/*` (Alexander Halser / Kurt Haenen / Jean-loup Gailly / Mark Adler).
