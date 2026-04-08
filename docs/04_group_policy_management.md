# Group Policy Management

This document covers the creation, configuration, and linking of Group Policy Objects (GPOs) domain. It explains each policy’s purpose, the settings applied, and the intended scope.

## 🎯 Why Group Policy Matters

Group Policy is a central way to manage user and computer settings in a Windows domain. It allows you to:

- **Enforce security settings** (password complexity, account lockout, USB restrictions)
- **Deploy configurations** (drive mappings, software, folder redirection)
- **Standardize environments** across many machines

GPOs are linked to OUs, so settings can be targeted at specific groups of users or computers.

## 📋 GPOs Created

I created the following GPOs (all saved under **Group Policy Objects** in GPMC). The table lists each GPO, its intended purpose, and the settings I configured.

| GPO Name | Type | Purpose | Key Settings |
|----------|------|---------|--------------|
| **Password Policy** | Domain | Enforce strong passwords | Minimum password length: 14 characters; complexity enabled; password history: 24; maximum age: 42 days |
| **Account Lockout Policy** | Domain | Prevent brute‑force attacks | Lockout threshold: 5 invalid attempts; lockout duration: 10 minutes; reset counter after: 10 minutes |
| **Drive Mapping** | User | Map network drives for users | Maps `H:` drive to home folder, `S:` drive to shared department folder (example) |
| **Disable USB Devices** | Computer | Block removable storage | Computer Configuration → Administrative Templates → System → Removable Storage Access → "All Removable Storage classes: Deny all access" = Enabled |
| **Restrict Access to Control Panel** | User | Limit user access to system settings | User Configuration → Administrative Templates → Control Panel → "Prohibit access to Control Panel and PC settings" = Enabled |

>The **Password Policy** and **Account Lockout Policy** could also be set directly in the **Default Domain Policy**. I created them as separate GPOs for modularity, but they must be linked at the domain root and have higher precedence than the default policy to take effect.

## 🛠️ Creating and Configuring a GPO

I created all GPOs using the **Group Policy Management Console** (GPMC). The steps for creating a GPO are:

1. Open **Group Policy Management** from Server Manager → Tools.
2. Expand **Forest** → **Domains** → `Ijipe.local`.
3. Right‑click **Group Policy Objects** → **New**.
4. Enter a descriptive name (e.g., `Disable USB Devices`) and click **OK**.
5. Right‑click the new GPO → **Edit**.
6. Navigate to the appropriate policy path (e.g., Computer Configuration → Administrative Templates → System → Removable Storage Access).
7. Enable or configure the desired setting.
8. Close the editor.

### 🔧 Understanding Computer vs. User Settings in GPOs

When editing a `Group Policy Object (GPO)`, you will see two main sections:

- **Computer Configuration** – Settings that apply to computers, regardless of which user logs on.  
  *Examples:* Windows Firewall rules, USB device restrictions, BitLocker, startup scripts, software installation.

- **User Configuration** – Settings that apply to users, regardless of which computer they log on to.  
  *Examples:* Drive mappings, Control Panel restrictions, folder redirection, logon scripts, Internet Explorer settings.

**Rule of thumb:**  
- Choose **Computer Configuration** if the setting affects the machine itself (security, hardware, system services).  
- Choose **User Configuration** if the setting affects the user experience (desktop, applications, personalization).

> **Note:** Some settings appear in both sections (e.g., registry policies) but are applied based on the target – computer policies apply to the computer object, user policies to the user object.

## 🔗 Linking GPOs to OUs

A GPO does nothing until it is linked to an OU. The link determines which users/computers receive the policy.

### Planned GPO Links (After Fixing)

| GPO | Link to OU | Notes |
|-----|------------|-------|
| **Password Policy** | `Ijipe.local` (domain root) | Domain‑wide password rules; ensure it has highest link order if custom |
| **Account Lockout Policy** | `Ijipe.local` (domain root) | Same as above |
| **Drive Mapping** | `Corporate\Users` and branch‑level `Users` OUs | Applies to all corporate users and branch‑specific users |
| **Disable USB Devices** | `Corporate\Computers` (and any branch computer OUs) | Affects all corporate workstations |
| **Restrict Access to Control Panel** | `Corporate\Users` and branch‑level `Users` OUs | Applied to regular users, not administrators |


>Creating a GPO by right‑clicking the domain automatically links it. To create a GPO without linking, right‑click **Group Policy Objects** and choose **New**.

## 🧪 Testing GPO Application

After linking GPOs, I verified they apply correctly using `gpresult` and by checking the client’s behavior, like trying to access the `Control Panel` showing that the **Policies** have been effected.
![Restriction](../Images/restrictions.png)

### On a domain‑joined computer (as a user), run:

```cmd
gpresult /r
```
This shows which GPOs are applied.
Usually, policies are updated in the whole domain within 90 minutes by default. To force an update on a domain-joined computer, run:
```cmd
gpupdate /force
```