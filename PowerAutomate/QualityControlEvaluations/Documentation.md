# Quality Control Feedback Email Flow - Power Automate Documentation  

## 📌 Overview  
This Power Automate Flow automatically sends an email to users with feedback submitted on a Quality Control Evaluation Power App.

## 📂 File Structure  
- **Raw Power Automate Flow Export:** `QualityControlEvaluation.zip`
- **Screenshots:** `/images/`
- **Exported JSON Definitions:** `/JSON/`
- **Documentation.md:** `This file`

## 🚀 Flow Details  
- **Trigger:** When an item is created or modified (Sharepoint)
- **Actions:**  
  - CInitialize array variable.
  - Checks if Score column value is less than 100.
  - If yes, gets the content of Feedback column value and sends an email to the employee with the feedback.

## 🔗 Connections  
- **Outlook**
- **Sharepoint List:** `QC Accuracy VODQC` 

## 🛠️ JSON Export Details  
For technical reference, the full **Flow Definition** can be found in `/JSON/FlowDefinition.json`.  