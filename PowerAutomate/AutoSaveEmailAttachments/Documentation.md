# Auto-Save Email Attachments Flow - Power Automate Documentation  

## 📌 Overview  
This Power Automate Flow automatically saves email attachments to a user's OneDrive.

## 📂 File Structure  
- **Raw Power Automate Flow Export:** `AutoSaveEmailAttachments.zip`
- **Screenshots:** `/images/`
- **Exported JSON Definitions:** `/JSON/`
- **Documentation:** `This file`

## 🚀 Flow Details  
- **Trigger:** When a new email arrives (V3) (Outlook)  
- **Actions:**  
  - Condition check to see if the email has attachments
  - If yes, save attachment with its name and content in an OneDrive folder called /Saved Attachments

## 🔗 Connections  
- **Outlook**
- **OneDrive For Business**

## 🛠️ JSON Export Details  
For technical reference, the full **Flow Definition** can be found in `/JSON/FlowDefinition.json`.  