# JDCloud AX1800 Pro Firmware Builder

This repository is intentionally limited to the JDCloud AX1800 Pro (JDCloud Arthur).
It builds the `jdcloud_re-ss-01` profile for the `qualcommax/ipq60xx` target from
[VIKINGYFY/immortalwrt](https://github.com/VIKINGYFY/immortalwrt), branch `main`.

## Build on GitHub

1. Create a GitHub repository and push this directory to its default branch.
2. Open the repository's **Actions** page.
3. Select **Build JDCloud AX1800 Pro** and click **Run workflow**.
4. Set the hostname, LAN address, Wi-Fi SSID, and Wi-Fi password, then start the job.
5. Download the completed job's Artifact, or use the GitHub Release created by the workflow.

The release includes the firmware images for `jdcloud_re-ss-01`, `sha256sums`, and the
final OpenWrt `.config`. The generated firmware has no LuCI password by default.

## Repository layout

- `.github/workflows/JD-AX1800PRO.yml`: the only online build workflow.
- `Config/IPQ60XX-WIFI-YES.txt`: target and JDCloud AX1800 Pro device selection.
- `Config/GENERAL.txt`: package selection shared by this one build.
- `Scripts/`: feed package additions and device-specific settings.
