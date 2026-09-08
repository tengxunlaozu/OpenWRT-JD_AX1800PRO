# JDCloud AX1800 Pro Firmware Builder

This repository is intentionally limited to the JDCloud AX1800 Pro (JDCloud Arthur).
It builds the `jdcloud_re-ss-01` profile for the `qualcommax/ipq60xx` target from
[VIKINGYFY/immortalwrt](https://github.com/VIKINGYFY/immortalwrt), branch `main`.

## Build on GitHub

1. Create a GitHub repository and push this directory to its default branch.
2. Open the repository's **Actions** page.
3. Run **Cache-Clean** first when the Actions cache needs to be removed.
4. Select **QCA-ALL** and click **Run workflow** to build JDCloud AX1800 Pro.
5. After starting the job, GitHub runs it in the background and the browser may be closed.
6. Download the completed job's Artifact, or use the GitHub Release created by the workflow.

The release includes the firmware images for `jdcloud_re-ss-01`, `sha256sums`, and the
final OpenWrt `.config`. The fixed defaults are hostname and Wi-Fi SSID `JD-AX1800PRO`,
LAN address `192.168.10.1`, Wi-Fi password `12345678`, and no LuCI password by default.

## Repository layout

- `.github/workflows/Cache-Clean.yml`: manually removes GitHub Actions caches.
- `.github/workflows/QCA-ALL.yml`: manually builds JDCloud AX1800 Pro.
- `Config/IPQ60XX-WIFI-YES.txt`: target and JDCloud AX1800 Pro device selection.
- `Config/GENERAL.txt`: package selection shared by this one build.
- `Scripts/`: feed package additions and device-specific settings.
