# Policies 

This folder contains backups and documentation related to Group Policy Objects (GPOs) created in the Active Directory homelab.

## 📋 GPOs Created

The following GPOs have been created :

| GPO  | Type | Description |
|----------|------|-------------|
| Password Policy | Domain | Custom password settings (length, complexity, history). |
| Account Lockout Policy | Domain | Defines account lockout threshold, duration, and reset counter. |
| Drive Mapping | User | Maps network drives for users (e.g., home folders, shared drives). |
| Disable USB Devices | Computer | Prevents use of removable storage on domain computers. |
| Restrict Access to Control Panel | User | Limits or blocks user access to Control Panel and system settings. |

## 📁 Contents

- **GPO-Descriptions.md** – Detailed notes on each GPO’s settings (to be created).
- **Password-Settings.txt** – Notes on password policies and fine‑grained password considerations.


## 📝 Documentation

For each GPO, record its settings in `GPO-Descriptions.md`. Example:

### `Drive Mapping`
- **Linked to:** (TBD)
- **Settings:**
  - User Configuration → Preferences → Windows Settings → Drive Maps
    - Action: Create
    - Location: `\\fileserver\share`
    - Drive Letter: E:
    - Label: Home Folder

