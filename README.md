# Opay-Transaction-Intelligence-Analysis-Using-SQL

**Project Overview**
----

I downloaded my personal transaction history and treated it as a real world analytical dataset.

Instead of using a public dataset, I worked with raw financial records containing debit transactions, credit inflows, transaction channels, and destination types.

The goal was simple but powerful:

Transform raw transaction logs into structured financial intelligence using SQL.

This project demonstrates how everyday transactional data can be converted into measurable insights that inform financial and operational decisions.

----

**Data Preparation and Processing Workflow**

This project did not start in SQL.
It started with raw exported transaction history.

Step 1: Data Extraction

Transaction history was downloaded directly from the financial platform in CSV format covering 2025 to present.

The raw file contained:

Incorrect Data Types

Inconsistent categorical labels

Irregular formatting

Before analysis, the dataset required structured cleaning.

----

Step 2: Data Cleaning Using Power Query in Excel

Power Query was used to transform the raw transactional file into an analysis ready dataset.

Cleaning steps included:

Removing unnecessary columns

Standardizing date formats

Extracting month and year into a structured time column

Handling null and blank values

Renaming columns for clarity and consistency

Ensuring numeric columns were properly typed

Power Query enabled reproducible transformation without manual editing, ensuring clean and structured data before database import.

The cleaned dataset was then exported for SQL analysis.

----

**SQL Data Structuring and Aggregation**

After cleaning, the dataset was imported into SQL for structured querying and analysis.

SQL was used to:

Aggregate total monthly debit and credit

Calculate transaction frequency per month

Compute average debit values

Generate monthly breakdown by Destination Type

Generate monthly breakdown by Channel

Identify high concentration categories

Analyze time based patterns using GROUP BY and aggregation functions

Core SQL techniques applied:

GROUP BY

SUM

COUNT

AVG

Conditional aggregation

Pivot style transformations

Time based grouping

This step converted transactional level data into month level analytical summaries.

-----

**Key Insights**

Spending behavior shows structural patterns rather than randomness

Certain destination types consistently dominate outflows

Channel usage reveals behavioral preferences

Monthly aggregation exposes trend direction and volatility

Transaction logs contain hidden strategic signals when properly structured

**Conclusion**

Data sitting in transaction logs is not just historical record.
It is untapped intelligence.

By structuring and aggregating the dataset using SQL, raw activity was transformed into measurable financial behavior.

-----

**This project demonstrates:**

The ability to work with real world messy data

Strong SQL transformation and aggregation skills

Analytical thinking applied to operational datasets

Conversion of transactional data into strategic insight

If your business generates transactional data, it already contains answers about customer behavior, revenue structure, channel efficiency, and growth patterns.

The value lies in extracting those answers.


-----

Author

Tijani Rofiat Feyishara
Data Scientist

Transforming raw data into decision ready intelligence.

<img width="1920" height="1080" alt="Screenshot (473)" src="https://github.com/user-attachments/assets/83fc2ff2-3914-469c-aa25-abd43cdd2d5c" />
<img width="1920" height="1080" alt="Screenshot (474)" src="https://github.com/user-attachments/assets/ad405d1d-85d1-4153-9c02-af6b6c335470" />
<img width="1920" height="1080" alt="Screenshot (475)" src="https://github.com/user-attachments/assets/298eb30e-a45e-456d-a913-d312636192a8" />
<img width="1920" height="1080" alt="Screenshot (476)" src="https://github.com/user-attachments/assets/b46f66d5-52c4-420a-b087-400842e49d8d" />




