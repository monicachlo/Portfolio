# Data Sources Used in EmployeeTimeLog

## 1. SharePoint List: Employee Time Tracking
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `Clock-In` (DateTime)
  - `Clock-Out` (DateTime)
  - `Total Work Hours` (Calculated)
  - `Lunch Start Time` (DateTime)
  - `Lunch End Time` (DateTime)
  - `Lunch Duration` (Calculated)

## 2. SharePoint List: Breaks Log
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `Break Start Time` (DateTime)
  - `Break End Time` (DateTime)
  - `Break Duration` (Calculated)
  - `Total Break Duration` (Number)

## 3. SharePoint List: Meetings Log
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `Meeting Start Time` (DateTime)
  - `Meeting End Time` (DateTime)
  - `Meeting Duration` (Calculated)

## 4. SharePoint List: System Issues Log
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `System Issues Start Time` (DateTime)
  - `System Issues End Time` (DateTime)
  - `System Issues Duration` (Calculated)
  - `Total System Issues Duration` (Number)

## 5. SharePoint List: Other Log
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `Other Start Time` (DateTime)
  - `Other End Time` (DateTime)
  - `Other Duration` (Calculated)
  - `Total Other Duration` (Number)

## 6. SharePoint List: OT Log
- **Columns:**
  - `Agent` (Lookup)
  - `User` (Lookup)
  - `EmailAddress` (Lookup)
  - `Date` (DateTime)
  - `OT Start Time` (DateTime)
  - `OT End Time` (DateTime)
  - `OT Duration` (Calculated)
