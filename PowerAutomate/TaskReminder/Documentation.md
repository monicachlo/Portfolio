# Task Reminder Flow - Power Automate Documentation  

## 📌 Overview  
This Power Automate Flow automatically sends daily reminder emails for upcoming tasks stored in an Excel file.

## 📂 File Structure  
- **Raw Power Automate Flow Export:** `TaskReminderEmail.zip`
- **Screenshots:** `/images/`
- **Exported JSON Definitions:** `/JSON/`
- **Sample Data:** `/sampledata/TaskList.xlsx`
- **Documentation:** `This file`

## 🚀 Flow Details  
- **Trigger:** Recurrence (Runs at 8:00 every day)
- **Actions:**  
  - Check the list of tasks.
  - Filters tasks that are due in 3 days.
  - Sends email reminder that task is due soon.

## 🔗 Connections  
- **Outlook**
- **OneDrive For Business**

## 🛠️ JSON Export Details  
For technical reference, the full **Flow Definition** can be found in `/JSON/FlowDefinition.json`.  