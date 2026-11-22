# Patois Canary Wharf — Temp Log

Fridge and freezer temperature log for Patois Canary Wharf. Opens straight onto the log from the link — no password.

- 3 fridges and 1 freezer, numbered 1–4
- Opening / Midday / Closing service, logged by name
- Out-of-range readings require a corrective action before they can be saved
- Probe calibration log (ice water 0°C ±1, boiling water 100°C ±1)
- History by date range, showing days with no readings

Built the same way as the Chip Shop BXTN ops hub: one `index.html`, Supabase for storage, hosted on GitHub Pages.

## Setup
1. Run `setup.sql` once in the Supabase SQL editor (Chip Shop project). It creates `patois_cw_temperature_logs` and `patois_cw_probe_calibration_logs`, separate from Chip Shop's tables.
2. Settings > Pages > Deploy from branch `main`, folder `/`.

## Changing units
Edit the `UNITS` list at the top of `index.html`. Never reuse an `id`; to remove a unit, add `retired:true` so its old readings still show in History.
