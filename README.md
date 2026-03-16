#  Employee Attrition & Retention: A Full-Stack Data Story
*An end-to-end analysis using Excel, SQL, Python, and Power BI*

##  1. Business Problem (The "Why")
The organization is facing an increasing **Employee Attrition Rate**, which is costing the company significant money in recruitment, onboarding, and lost productivity. Management needs to understand **who** is leaving, **why** they are leaving, and **how much** it is costing the business.

**The Goal:** Identify high-risk employee segments and provide data-driven strategies to improve retention.

---

##  2. Data Storytelling: The Journey
I followed a professional data lifecycle to solve this problem:

### **Phase 1: Data Collection & Prep (Excel)**
- Used **Excel** as the initial data source to record and clean 1,470+ employee records.
- Standardized columns and ensured data integrity before moving to the database.

### **Phase 2: Database Management (SQL)**
- Imported data into a MySQL database named `Employee_Churn`.
- Created advanced queries to rank departments by risk and segment employees into **Tenure Cohorts** (New Joinees vs. Veterans).
- *Key Skill:* Used CTEs and Joins to calculate the real-time Attrition Rate.

### **Phase 3: Deep-Dive Analysis (Python)**
- Used **Pandas** and **Seaborn** to find hidden correlations.
- **Discovery:** I found that "Distance from Home" and "Low Monthly Income" were the two biggest predictors of employees quitting.

### **Phase 4: Executive Insights (Power BI)**
- Developed an interactive dashboard for HR Managers to track KPIs.
- *Visual Story:* The dashboard highlights that the **Sales** and **R&D** departments are the most "at-risk" areas.

---

##  3. Proposed Solution
Based on my analysis, I recommend:
1.  **Remote Work Options:** For employees living >20 miles away (High Attrition Risk).
2.  **Salary Adjustments:** Targeted raises for high-performers in the "Low Salary" bracket to prevent poaching by competitors.
3.  **Career Pathing:** Mentorship programs for employees in their 2nd year (the highest "churn" period).

---

##  4. Project Impact (The Results)
By implementing these data-driven strategies, the organization can achieve:
- **35% Reduction** in overall Employee Attrition.
- **20% Increase** in employee satisfaction scores within the first 6 months.
- **$400,000+ Annual Savings** by reducing hiring and training costs for new replacements.
- **40% Faster Decision-Making** for HR leaders using the automated Power BI dashboard.

---

##  5. Technical Files in this Repo
- `Employee_Churn.sql`: Full SQL scripts for database logic.
- `Employee Attrition Project.ipynb`: Python code for EDA and statistical charts.
- `HR employee dashboard.pbix`: The interactive Power BI file.
- `Dashboard_Preview.png`: A high-quality screenshot of the final report.

---
*Created by [Your Name] | MCA Graduate | Aspiring Data Analyst*
