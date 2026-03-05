# 📂 Project Workflow

The project was executed through three major stages:

**Raw Dataset → SQL Cleaning → Python ML Modeling → Power BI Dashboard**

---

## 🗄️ 1️⃣ Data Cleaning (SQL)

The dataset was initially processed in **MySQL** to prepare it for machine learning analysis.

### Tasks Performed
- Addressed missing values  
- Created new derived features  
- Calculated engagement metrics  
- Generated estimated views  
- Produced a clean dataset for modeling  

### Feature Engineering
Key engineered features included:

- **Estimated Views**  
  \[
  \text{estimated\_views} = \text{impressions} \cdot \left(\frac{\text{ctr\_percentage}}{100}\right)
  \]

- **Engagement Rate**  
  \[
  \text{engagement\_rate} = \frac{\text{likes} + \text{comments} + \text{shares}}{\text{impressions}}
  \]

These features provided measurable indicators of video performance.

---

## 🤖 2️⃣ Machine Learning (Python)

The cleaned dataset was used to build classification models predicting **high‑engagement videos**.

### Target Variable
- **High Engagement = 1** if engagement rate ≥ 70th percentile  
- **High Engagement = 0** otherwise  

This formulation created a balanced classification problem.

### Models Trained
1. **Logistic Regression** – baseline classifier  
2. **Random Forest** – captures nonlinear feature interactions  
3. **XGBoost** – advanced gradient boosting for improved accuracy  

### Model Evaluation
Models were assessed using:  
- Accuracy  
- Precision  
- Recall  
- ROC‑AUC Score  

| Model               | ROC‑AUC |
|----------------------|---------|
| Logistic Regression  | ~0.49   |
| Random Forest        | ~0.51   |
| XGBoost              | ~0.54   |

### Key Insight
Predictive performance was limited when relying solely on metadata features.  
This highlights that **video engagement is primarily driven by post‑publication user interactions** (likes, comments, shares), while pre‑video metadata (duration, CTR, category, traffic source) alone is insufficient for accurate prediction.

---

## 📊 3️⃣ Power BI Dashboard

An interactive **Power BI dashboard** was developed to visualize video performance and engagement trends.

### Dashboard Insights
The dashboard enables exploration of:  
- Best‑performing content categories  
- Traffic sources driving engagement  
- Relationship between impressions and likes  
- Subscriber growth by video category  

### Key Visualizations
- Engagement Rate by Content Category  
- Engagement by Traffic Source  
- Impressions vs Likes (Scatter Plot)  
- Subscribers Gained by Category  
- Traffic Source Distribution  
- Video Category Distribution  

---

## 📁 Dataset Features

The dataset includes:  
- post_id  
- video_duration_min  
- avg_view_duration_sec  
- avg_view_percentage  
- subscribers_gained  
- ctr_percentage  
- impressions  
- likes  
- comments  
- shares  
- engagement_rate  
- estimated_views  
- traffic_source  
- content_category  

---

## 📌 Project Structure

```
youtube-video-analysis/
│
├── data/
│   └── youtube_clean.csv
│
├── sql/
│   └── data_cleaning_queries.sql
│
├── notebooks/
│   └── engagement_prediction.ipynb
│
├── powerbi/
│   └── youtube_dashboard.pbix
│
└── README.md
```

---

## 🚀 Future Improvements
Potential enhancements include:  
- Incorporating time‑based features (upload date trends)  
- Leveraging early engagement metrics  
- Applying deep learning models  
- Conducting sentiment analysis on comments  

---
## 🎓 Learning Outcomes
This project demonstrates:  
- End‑to‑end data analytics pipeline development  
- SQL‑based data preparation  
- Machine learning model building in Python  
- Interactive visualization using Power BI  
- Interpretation of model results and business insights  
