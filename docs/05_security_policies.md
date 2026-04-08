# Security Policies

This document outlines the security policies implemented in the Active Directory homelab to strengthen authentication, control user privileges, and protect against brute‑force attacks.

## 🔐 Password Policy

A strong password policy is the first line of defence against unauthorised access. I configured the following settings via Group Policy (applied domain‑wide).

| Setting | Value | Purpose |
|---------|-------|---------|
| **Enforce password history** | 24 passwords remembered | Prevents reuse of recent passwords. |
| **Maximum password age** | 42 days | Forces regular password changes. |
| **Minimum password age** | 1 day | Prevents users from changing password multiple times to bypass history. |
| **Minimum password length** | 14 characters | Increases resistance against brute‑force and dictionary attacks. |
| **Password must meet complexity requirements** | Enabled | Requires a mix of uppercase, lowercase, numbers, and non‑alphanumeric characters. |
| **Store passwords using reversible encryption** | Disabled | Keeps passwords stored in a secure (non‑reversible) hash. |

These settings align with Microsoft’s security baseline and industry best practices (e.g., NIST, CIS). They apply to all domain user accounts.

To test the policy enforcement, I created an account and tried to set a non-compiant password.
![Password Policy Check](../Images/pass_policy.png)

## 🔒 Account Lockout Policy

To mitigate brute‑force and password‑spraying attacks, I configured an account lockout policy that temporarily disables an account after repeated failed logon attempts.

| Setting | Value | Purpose |
|---------|-------|---------|
| **Account lockout duration** | 10 minutes | How long the account remains locked. A short duration reduces administrative overhead while still deterring attacks. |
| **Account lockout threshold** | 5 invalid logon attempts | Locks the account after 5 failed attempts. This stops automated guessing without locking out legitimate users who mistype. |
| **Reset account lockout counter after** | 10 minutes | Resets the failed attempt counter after 10 minutes, so an attacker cannot slowly guess over hours. |

These settings balance security with usability. For privileged accounts, a lower threshold (e.g., 3 attempts) could be applied using **Fine‑Grained Password Policies** (not yet implemented).

I then tested this policy with incorrect passwords on an account
![Account lockout policy](../Images/acc_lockout_policy.png)

## 👥 User Rights Policy

User rights (also known as *privileges*) control what actions users and groups can perform on a system, such as logging on locally, accessing the computer from the network, or shutting down the server. I reviewed and hardened the default user rights assignments using the **Default Domain Controllers Policy** and the **Default Domain Policy**.

Key changes and reviewed settings:

| User Right | Applied Setting | Rationale |
|------------|----------------|-----------|
| **Allow log on locally** | Administrators, IT_Global (domain group) | Only administrators and the IT department can log on directly to servers and domain controllers. Regular users are prevented from local logon. |
| **Deny log on locally** | (Not configured – used default) | No additional explicit denials needed because only the allowed groups have local logon permission. |
| **Access this computer from the network** | Administrators, Authenticated Users, ENTERPRISE DOMAIN CONTROLLERS | Standard network access for all authenticated users. |
| **Deny access to this computer from the network** | Non-IT_Global (custom domain group containing all non‑IT staff) | This setting explicitly blocks non‑IT users from accessing domain controllers and critical servers over the network. It complements the “Allow log on locally” restriction. |
| **Shut down the system** | Administrators, IT_Global | Only administrators and IT staff can shut down or restart domain controllers and member servers. Prevents accidental or unauthorised shutdowns. |
| **Take ownership of files or other objects** | Administrators | Only administrators can take ownership, preventing users from bypassing permissions. |
| **Back up files and directories** | Administrators, Backup Operators | Limits backup privileges to trusted roles. |

I did **not** modify user rights for standard domain users on member servers or workstations – the default settings (e.g., “Authenticated Users” can log on locally) are appropriate for most environments.

## 📝 Summary of Implemented Policies

| Policy Area | Key Configuration | GPO Location |
|-------------|-------------------|---------------|
| Password | 14 char length, complexity, 42‑day max age, 24 history | `Default Domain Policy` (or custom `Password Policy` GPO) |
| Account Lockout | 5 attempts, 10 min lockout, 10 min reset counter | `Default Domain Policy` (or custom `Account Lockout Policy` GPO) |
| User Rights | Hardened logon and privilege assignments on domain controllers | `Default Domain Controllers Policy` |

These policies are actively enforced in the lab and have been verified using `gpresult` and the **Group Policy Results** wizard.

---

## 🔜 Next Steps

With core security policies in place, future enhancements include:

- **Fine‑Grained Password Policies (PSOs)** to apply different password/lockout settings for administrators vs. regular users.
- **Kerberos policies** (ticket lifetime, renewal) for advanced authentication security.
- **Audit policy configuration** to log critical security events (logon, account changes, policy modifications).

