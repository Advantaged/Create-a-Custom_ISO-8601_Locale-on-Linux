# Create-a-Custom_ISO-8601_Locale-on-Linux-V02.md

* **Merit to:** [AI DeepSeek](https://chat.deepseek.com/), Tony Advantaged & [Gemini](https://gemini.google/about/)
* In my system i choose by the installation "American English" as Language and "Germany" as location but i want "date" to be represented following ISO-8601.

## Technical Architecture Overview
To eliminate environmental drift permanently, variables are mapped at the system boundary before any shell or desktop environment spawns.
```bash
                  [ Kernel Boot ]
                         │
              ┌──────────┴──────────┐
              ▼                     ▼
      /etc/locale.conf      /etc/environment
      (Read by systemd)     (Read by pam_env)
              │                     │
              └──────────┬──────────┘
                         ▼
            [ Unified Environment Matrix ]
            ├── CLI Shells (bash, zsh, fish)
            └── GUI Applications (Plasma, Dolphin)

```

## The Localization Matrix
| Variable | Target Value | Functional Objective |
|:---|:---|:---|
| `LANG` | `en_US.UTF-8` | Global fallback encoding framework |
| `LC_CTYPE` | `"en_US.UTF-8"` | Character classification and case conversion |
| `LC_NUMERIC` | `de_DE.UTF-8` | German decimal/comma formatting |
| `LC_TIME` | `en_ISO.UTF-8` | Enforces custom ISO-8601 timeline notation |
| `LC_COLLATE` | `"en_US.UTF-8"` | String collation and sorting order rules |
| `LC_MONETARY` | `de_DE.UTF-8` | German currency format (€) |
| `LC_MESSAGES` | `"en_US.UTF-8"` | System text, diagnostics, and CLI output language |
| `LC_PAPER` | `de_DE.UTF-8` | DIN A4 sizing standardization |
| `LC_NAME` | `de_DE.UTF-8` | Name formatting conventions |
| `LC_ADDRESS` | `de_DE.UTF-8` | Postal address structural rules |
| `LC_TELEPHONE` | `de_DE.UTF-8` | Telephone number conventions |
| `LC_MEASUREMENT`| `de_DE.UTF-8` | Metric system metrication |
| `LC_IDENTIFICATION`| `de_DE.UTF-8` | Metadata tracking metadata for the locale profile |
| `LC_ALL` | *Empty* | Intentionally unset to prevent sub-category masking |

## Alternative (much less work)
An alternative to own ISO-8601 TIME locales is the standard `en_DK`, but this's not present in every Distro. Some other Distros, like [BlueStar Linux](https://sourceforge.net/projects/bluestarlinux/) &| [Artix Linux](https://artixlinux.org/) let set the ISO-8601 TIME locales per mouse-click in the `systemsettings`. Fedora optimised the loacle settings, just adjust your prefences in `systemsettings` & the Disro will overtake everythings.

---

## Create a Custom ISO-8601 Locale on Linux

*Tested on CachyOS (Arch-based) | By: [tony advantaged]*

## Objective
Configure your system to display dates in ISO-8601 format (**YYYY-mm-dd HH:MM:SS**) while keeping other locale settings (e.g., language, currency) unchanged.

---

## Task 1: Create own Locales

### Step 1: Copy the Base Locale File
* **Copy the US English locale file** (this ensures the basic text mapping remains English framework):
```bash
sudo cp /usr/share/i18n/locales/en_US /usr/share/i18n/locales/en_ISO
```
*Why?* This preserves the original file and creates a modifiable copy.
* **If you want to change only the ISO-8601 Date-Time representation** copy your own locale `es_ES`, `fr_FR`, `it_IT`, etc., example:
```bash
sudo cp /usr/share/i18n/locales/es_ES /usr/share/i18n/locales/es_ISO
```

### Step 2: Modify the `LC_TIME` Section
* **Open the copied file**:
```bash
sudo nano /usr/share/i18n/locales/en_ISO
```

* **Replace the existing `LC_TIME` section with ISO-8601 formats**:
```bash
LC_TIME
abday	"Sun";"Mon";"Tue";"Wed";"Thu";"Fri";"Sat"
day	"Sunday";"Monday";"Tuesday";"Wednesday";/
	"Thursday";"Friday";"Saturday"
abmon	"Jan";"Feb";"Mar";"Apr";"May";"Jun";/
	"Jul";"Aug";"Sep";"Oct";"Nov";"Dec"
mon	"January";"February";"March";"April";/
  "May";"June";"July";"August";/
	"September";"October";"November";"December"
% date formats following ISO 8601-1988
d_t_fmt "%Y-%m-%d %H:%M:%S"   % ISO-8601 datetime
d_fmt   "%Y-%m-%d"            % ISO-8601 date
t_fmt   "%H:%M:%S"            % ISO-8601 time
am_pm   "";""
t_fmt_ampm ""
date_fmt "%Y-%m-%d %H:%M:%S %Z"
week     7;19971130;4        % This's valid for all EU-Countries
first_weekday 2              % This's valid for at least all EU-Countries
END LC_TIME
```
* **Replace only ISO-8601 Date-Time representation of `LC_TIME`**:
```bash
% date formats following ISO 8601-1988
d_t_fmt "%Y-%m-%d %H:%M:%S"   % ISO-8601 datetime
d_fmt   "%Y-%m-%d"            % ISO-8601 date
t_fmt   "%H:%M:%S"            % ISO-8601 time
am_pm   "";""
t_fmt_ampm ""
date_fmt "%Y-%m-%d %H:%M:%S %Z"
week     7;19971130;4        % This's valid for all EU-Countries
first_weekday 2              % This's valid for at least all EU-Countries
END LC_TIME
```
### Step 3: Compile the Locale
Generate the binary structure into system memory:
```bash
sudo localedef -i en_ISO -f UTF-8 en_ISO.UTF-8
```
* ***Why?*** This compiles the structural text profile file directly into a binary system-recognized layout format.

---

## Task 2: Update System Configuration

### Step 1: Add Locale to `/etc/locale.gen`
* Edit the file:
```bash
sudo nano /etc/locale.gen
```
* Append the entry manually at the bottom:
```ini
en_ISO.UTF-8 UTF-8
```
* Regenerate the system layout indices:
```bash
sudo locale-gen
```

### Step 2: Set the Matrix System-Wide
* Edit `/etc/locale.conf`:
```bash
sudo nano /etc/locale.conf
```
* Replace the complete contents with your explicit mapping schema to avoid fallback mismatches:
```ini
LANG=en_US.UTF-8
LC_CTYPE=en_US.UTF-8
LC_NUMERIC=de_DE.UTF-8
LC_TIME=en_ISO.UTF-8
LC_COLLATE=en_US.UTF-8
LC_MONETARY=de_DE.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
```

### Step 3: Clean and Harden Shell Configs
* ***IMPORTANT:*** Delete all manual `export LC_` or `set -gx LC_` overrides inside individual user shell configuration profiles. Doing so prevents terminal environments from drifting out of sync with GUI file managers like Dolphin.

* **Target Global Files for Cleanup:**
```text
/etc/bash.bashrc
/usr/share/cachyos-fish-config/cachyos-config.fish
/usr/share/cachyos-zsh-config/cachyos-config.zsh
```
* **Target User Account Files for Cleanup:**
```text
~/.bashrc
~ ~/.config/fish/config.fish
~/.zshrc
```

---

## Task 3: Activate "new" Locales on the fly

* ***NOTES:***
 * This is for administrators who want to apply settings immediately without executing a hard system reboot.
 * The `LANG` variable must be explicitly unset inside the terminal first, otherwise `locale.sh` will bypass changes.

### Step 1: Drop Active Environment Boundary
```bash
unset LANG
```

### Step 2: Source the Initialization Subsystem
```bash
source /etc/profile.d/locale.sh
```

### Step 3: Read & Check Locale
```bash
locale
```

### Step 4: Dry-Run Perl
```bash
perl -e 'print "System Integrity: Clear\n"'
```
---

## Task 4: Prevent Environment Modification (Hardening Phase)
This phase addresses rogue application installation routines, updates, or package hooks stripping or resetting environmental parameters dynamically.

### Step 1: Preserving Variables across Sudo boundaries
By default, `sudo` sanitizes and drops unknown environment values for security preservation. To maintain your environment profile state when running commands with root authorization privileges, you must retain the keys.

* Edit the sudo security parameters configuration:
```bash
sudo EDITOR=nano visudo
```
* Append the following single wildcard entry pattern to keep all translation parameters intact across execution boundaries:
```text
Defaults env_keep += "LANG LC_*"
```

### Step 2: Secure `/etc/locale.conf` on Storage
Lock the physical file to block applications, system scripts, or desktop desktop daemons from tracking custom values inside it.

* Apply the filesystem immutability attribute lock:
```bash
sudo chattr +i /etc/locale.conf
```
* Remove the lock when future intentional adjustments are required:
```bash
sudo chattr -i /etc/locale.conf
```

* **Desktop Note:** For Plasma integration, if manual definitions are preferred in the GUI layer, select `en_SE` (English Sweden) within `systemsettings` -> `Region & Language` to approximate ISO notation across Qt applications.

---

## Task 5: Verify the Setup

### Step 1: Check Locale Database Registries
```bash
locale -a | grep en_ISO
```
* **Expected Value:** `en_ISO.utf8`

### Step 2: Verify Active Time Layer Assignments
```bash
locale | grep LC_TIME
```
* **Expected Value:** `LC_TIME=en_ISO.UTF-8`

### Step 3: Run Format Flag Confirmations
Execute the formatting test via an inline shell request:
```bash
LC_TIME=en_ISO.UTF-8 date
```
* **Expected Value Format:** `YYYY-MM-DD HH:MM:SS` (e.g., `2026-05-20 17:18:38 CEST`)

### Step 4: Review Complete Local Mapping Configuration Output
```bash
❯ locale
LANG=en_US.UTF-8
LC_CTYPE="en_US.UTF-8"
LC_NUMERIC=de_DE.UTF-8
LC_TIME=en_ISO.UTF-8
LC_COLLATE="en_US.UTF-8"
LC_MONETARY=de_DE.UTF-8
LC_MESSAGES="en_US.UTF-8"
LC_PAPER=de_DE.UTF-8
LC_NAME=de_DE.UTF-8
LC_ADDRESS=de_DE.UTF-8
LC_TELEPHONE=de_DE.UTF-8
LC_MEASUREMENT=de_DE.UTF-8
LC_IDENTIFICATION=de_DE.UTF-8
LC_ALL=

❯ timedatectl                             
               Local time: Wed 2026-05-20 11:48:46 CEST
           Universal time: Wed 2026-05-20 09:48:46 UTC
                 RTC time: Wed 2026-05-20 09:48:46
                Time zone: Europe/Berlin (CEST, +0200)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no
```

### Step 2: System Integrity / Hook Validation Check
Verify that the Perl validation interpreter processes transaction runs cleanly without triggering language fallback warning blocks:
```bash
❯ perl -e 'print "System Integrity: Clear\n"'
System Integrity: Clear
```

## Troubleshooting
* **Locale not found?**
    * Verify that the manual string line inside `/etc/locale.gen` matches the name schema exactly, and execute `sudo locale-gen` again.
* **Date format unchanged?**
    * Verify file integrity or ensure environment variables are passing over `sudo` boundaries via the `visudo` validation parameters.

✅ **Done** 👍 **& Enjoy** ISO-8601 dates system-wide❗️ In Attachment some [pictures](Pictures/) with results, e.g. Dolphin, Konsole, ZFS, etc..

.
