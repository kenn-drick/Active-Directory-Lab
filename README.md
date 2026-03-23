# Active Directory Homelab

This repository documents a comprehensive Active Directory homelab project. The goal is to build a fully functional Windows domain from scratch, covering essential administration tasks and advanced security features. It is designed as a learning resource for aspiring system administrators and IT professionals.

## 🎯 Project Scope

- ✅ **Initial Setup:** Install Windows Server, promote Domain Controller, configure DNS.
- ✅ **OU Design:** Create a logical, multi‑branch organizational unit structure.
- ✅ **User & Group Management:** Create users and groups manually and with PowerShell.
- 🔲 **Group Policy Management:** Implement and link GPOs for security and user settings.
- 🔲 **Service Accounts:** Create and manage dedicated service accounts.
- 🔲 **Windows File Sharing:** Set up SMB shares with appropriate permissions.
- 🔲 **Effective Permissions & Inheritance:** Understand and configure NTFS/share permissions.
- 🔲 **Access‑Based Enumeration:** Enable ABE to hide unallowed files/folders.
- 🔲 **Fine‑Grained Password Policies:** Implement PSOs for different user groups.
- 🔲 **Security Policies:** Additional hardening (e.g., account lockout, audit policies).

*Checked items are already completed and documented; unmarked items are in progress.*

## 🏗️ Lab Environment

- **Domain:** `ljipe.local`
- **Windows Server version:** Windows Server 2019
- **Domain Controllers:** 1
- **Client machines:** Windows 10 VMs joined to the domain
- **Virtualization:** VirtualBox 

## 📁 Active Directory Structure

The OU hierarchy is designed to support geographic branches and functional roles, making it easy to apply targeted Group Policies and delegate administration.

[diagram placeholder]

## 🛠️ Implemented Features

- **Domain Controller** with AD DS and DNS.
- **Custom OUs** for branches, departments, and servers.
- **User accounts** created manually and via PowerShell script.
- **Global and domain local groups** for permission management.
- **Basic GPOs:** password policy, drive mapping, account lockout policy and disable control panel access.
- **Security & File Services** 

The following areas will be covered in detail in the corresponding documentation:

| Topic | Description |
|-------|-------------|
| **Fine‑grained password policies** | Set different password requirements for privileged vs. regular users. |
| **Service accounts** | Create accounts for SQL, IIS, etc., with least privilege. |
| **File sharing** | Configure SMB shares, set NTFS and share permissions. |
| **Effective permissions & inheritance** | Understand how permissions combine and propagate. |
| **Access‑based enumeration** | Enable ABE so users see only what they can access. |
| **Advanced GPOs** | Deploy software, restrict USB, enforce auditing. |

## 📂 Repository Contents

- **`/docs`** – Step‑by‑step guides for each phase of the project.
- **`/scripts`** – PowerShell scripts to automate user creation, service account setup, and file share configuration.
- **`/policies`** – Exported GPO backups and notes on security settings.
- **`/diagrams`** – Visuals of the AD topology, OU structure, and file sharing design.

## 💼 Skills Acquired
- Windows Server installation and configuration
- Active Directory Domain Services (AD DS)
- OU design and delegation
- User and group management
- Group Policy Object (GPO) administration
- PowerShell scripting for automation
- File sharing and permissions (NTFS vs Share)
- Security policy implementation (fine‑grained passwords, audit)
- Technical documentation