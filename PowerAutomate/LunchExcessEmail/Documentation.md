# Lunch Excess Email Flow - Power Automate Documentation  

## 📌 Overview  
This Power Automate Flow automatically sends an email when an employee exceeds their allotted lunch time.

## 📂 File Structure  
- **Raw Power Automate Flow Export:** `LunchExcessEmail.zip`
- **Screenshots:** `/images/`
- **Exported JSON Definitions:** `/JSON/`
- **Documentation:** `This file`

## 🚀 Flow Details  
- **Trigger:** When an item is created or modified (Sharepoint)  
- **Actions:**  
  - Condition check to see if a column value is greater than 1.017
  - If yes, send an email address to the employee with the total exceeded time and reminding them what the permitted time is.

## 🔗 Connections  
- **Outlook**
- **Sharepoint List:** `Employee Time Tracking`  

## 🛠️ JSON Export Details  
For technical reference, the full **Flow Definition** can be found in `/JSON/FlowDefinition.json`.  