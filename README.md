# 🏥 Hospital Readmissions & Resource Utilization – Executive Dashboard

## 📌 Project Overview
This project analyzes hospital patient data to identify key drivers of **readmissions**, **length of stay (LOS)**, and **treatment costs**.  
The objective is to support **hospital leadership and operations teams** with actionable insights that can improve patient outcomes, optimize resource utilization, and control costs.

The final output is a **one-page executive Power BI dashboard** designed for quick decision-making.

---

## 🎯 Business Objectives
- Identify departments with **high readmission risk**
- Analyze **length of stay trends** across time and diagnoses
- Understand the relationship between **LOS and treatment cost**
- Highlight **high-risk diagnoses** requiring intervention
- Benchmark performance against **industry standards**

---

## 🛠️ Tools & Technologies
- **SQL** – KPI calculations, aggregations, window functions  
- **Power BI** – Data modeling, DAX measures, interactive dashboard  
- **Excel** – Data cleaning and validation  
- **GitHub** – Version control and portfolio presentation  

---

## 📊 Key Metrics (KPIs)
- Total Admissions  
- Readmission Rate (%)  
- Average Length of Stay (Days)  
- Average Cost per Patient (CAD)  

**Benchmarks used:**
- Industry Average Readmission Rate: ~20–22%  
- Target Average LOS: < 8 days  

---

## 🗂️ Dataset
- **Type:** Simulated healthcare dataset (portfolio use)
- **Granularity:** Patient-level admissions data
- **Key Fields:**
  - Patient ID
  - Admission & Discharge Dates
  - Department
  - Diagnosis
  - Readmission Indicator
  - Treatment Cost

> ⚠️ Note: This dataset is simulated and does not contain real patient information.

---

## 🧮 SQL Analysis
SQL was used to calculate healthcare KPIs and uncover patterns such as:
- Readmission rates by department
- Average length of stay by diagnosis
- Monthly admissions trends
- Cost analysis by department
- Ranking patients by LOS using window functions

All SQL queries are available in the `/sql` folder.

---

## 📈 Power BI Dashboard
The dashboard provides an **executive overview** with:

### 1️⃣ KPI Summary
Quick snapshot of admissions, readmissions, LOS, and cost with benchmarks.

### 2️⃣ Department Performance
Bar chart highlighting departments with the **highest readmission risk**.

### 3️⃣ Monthly Trends
Time-series analysis of admissions, LOS, and readmissions to identify seasonality.

### 4️⃣ High-Risk Diagnoses
Table with conditional formatting to surface diagnoses with:
- Longer stays
- Higher readmission rates
- Higher treatment costs

### 5️⃣ Cost vs Length of Stay
Scatter plot illustrating the relationship between LOS and cost, with bubble size representing total admissions.

📸 Dashboard screenshots are available in the `/images` folder.

---

## 🔍 Key Insights
- **General Medicine and Neurology** show the highest readmission rates, indicating potential gaps in discharge planning.
- Certain diagnoses consistently result in **longer stays and higher costs**, representing opportunities for targeted care pathways.
- A positive relationship exists between **length of stay and treatment cost**, emphasizing the financial impact of extended admissions.

---

## 📁 Repository Structure

healthcare-readmissions-powerbi/
|
|-- data/

healthcare-readmissions-powerbi/
│
├── data/
│ └── hospital_patient_data.csv
│
├── sql/
│ └── healthcare_kpi_queries.sql
│
├── powerbi/
│ └── Hospital_Readmissions_Executive_Dashboard.pbix
│
├── images/
│ └── dashboard.png
│
└── README.md

---

## 🚀 How This Project Adds Value
- Demonstrates **end-to-end analytics workflow**
- Shows understanding of **healthcare domain KPIs**
- Focuses on **decision-making, not just visualization**
- Designed for **executive and operational stakeholders**

---

## 📌 Author
**Data Analyst | SQL • Power BI • Excel**  
Healthcare & Supply Chain Analytics  
(Portfolio Project)

---

## 📬 Feedback
Feedback and suggestions are welcome. This project is part of a professional analytics portfolio.

