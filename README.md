Amazon Sales Analysis 2025

End-to-end analysis of an Amazon product listings dataset — from raw, messy data to cleaned data, exploratory analysis in Python, SQL querying, and an interactive Power BI dashboard. The goal: understand what drives monthly purchase volume.

Project Structure

├── notebooks/

 │   ├── 01_data_understanding.ipynb   
│   ├── 02_data_cleaning.ipynb        
│   └── 03_eda_analysis.ipynb         
├── powerbi/

│   └── dashboard_screenshot.png   
├── sql/

│   └── amazon_analysis.sql       
├── README.md

└── requirements.txt

1. Data Cleaning (notebooks/01, notebooks/02)

The raw dataset stores several fields as messy text — e.g. prices as "$29.99", purchase volume as "500+ bought in past month", ratings as "4.5 out of 5 stars". 02_data_cleaning.ipynb parses these into proper numeric/typed columns (final_price, Rating_clean, Number_of_reviews_clean, bought_in_last_month_clean) and removes duplicate rows.

2. Exploratory Analysis (notebooks/03)

Python (pandas, matplotlib) analysis covering price, rating, and review distributions, and how monthly purchases relate to rating, reviews, discount level, Best Seller status, Sponsored status, coupons, Buy Box availability, and delivery speed.

3. Power BI Dashboard (powerbi/)

An interactive dashboard built on the cleaned dataset, with visuals for rating, Best Seller status, sponsorship, discount range, coupon status, delivery speed, and price — all against monthly purchase volume.

4. SQL (sql/amazon_analysis.sql)

The same core questions re-expressed as SQL — summary statistics, grouped aggregations, and a mean-vs-median check to catch outlier skew — for querying the cleaned dataset directly in a database.

Key Findings

* Rating alone is a weak predictor of monthly purchases (corr ≈ 0.125); review count is a stronger signal (corr ≈ 0.304)
* Best Seller status and Sponsored status are both strongly associated with higher monthly purchases and review volume
* Moderate discounts (10–20%) are associated with the highest average purchases — deeper discounts don't consistently perform better
* Coupons were not associated with higher purchases in this dataset
* Buy Box availability couldn't be evaluated — no variation in the column
* Delivery speed shows no clear linear relationship with purchase volume; the mean is skewed upward by a small number of very popular products

Dataset

Amazon product listings covering price, rating, review count, monthly purchases, discount, Best Seller / Sponsored / coupon flags, Buy Box availability, and delivery details.
The raw and cleaned CSV files are not included in this repository due to uncertainty around the original data source's redistribution terms. The full cleaning logic is documented step-by-step in notebooks/02_data_cleaning.ipynb, so the transformation from raw to cleaned data is fully reproducible if you supply your own copy of the dataset.

Tools

Python (pandas, matplotlib) · SQL · Power BI

Running Locally

To run the notebooks end-to-end, place your own copy of the raw dataset in a data/raw/ folder as amazon_sales_data_uncleaned.csv, then:
bash
pip install -r requirements.txt
jupyter notebook notebooks/01_data_understanding.ipynb
Run the notebooks in order (01 → 02 → 03); 02_data_cleaning.ipynb produces the cleaned CSV that 03_eda_analysis.ipynb and the SQL queries both depend on.

Author

Poornima
