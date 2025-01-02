/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focus on roles with specified salaries, regardless of laocation
- Why? It reveals how different skills impact salary levels for Data Analysts and 
  helps identify the most financially rewarding skills to acquire or improve
*/
SELECT
    skills,
     ROUND (AVG(salary_year_avg), 0) AS average_sal,
    COUNT(skills_job_dim.job_id) AS demand_count 
FROM 
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
      salary_year_avg IS NOT NULL AND
      job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    average_sal DESC
LIMIT 25

/*
Based on the data, here are some key insights into the top-paying jobs for Data Analysts:
High-demand skills: Pandas (9 demand count) and Databricks (10 demand count) are the most in-demand skills among the top-paying jobs, suggesting a strong market for data manipulation and cloud-based analytics platforms.
Highest average salaries: PySpark ($208,172) and Bitbucket ($189,155) top the list, indicating that big data processing and version control skills are highly valued.
Emerging technologies: Skills like Watson, DataRobot, and Elasticsearch, while having lower demand counts, still command high average salaries (over $145,000), pointing to the value of AI and search technologies in data analysis.
Cloud and DevOps skills: Proficiency in tools like Gitlab, Kubernetes, and GCP are associated with high salaries, highlighting the importance of cloud computing and DevOps practices in data analytics.
Programming languages: Python-related libraries (Pandas, NumPy) and languages like Scala and Golang feature prominently, emphasizing the need for strong programming skills.
Data visualization: While not explicitly mentioned, tools like Jupyter (average salary $152,777) suggest that data visualization and presentation skills are valuable.
Big Data ecosystems: Skills related to big data processing (PySpark, Databricks, Airflow) consistently show high average salaries, indicating the continued importance of big data in analytics roles.
Machine Learning: Skills like scikit-learn, while not at the very top, still command high salaries ($125,781), showing the value of machine learning expertise in data analysis.
This data suggests that data analysts who combine big data processing skills, cloud platform knowledge, and expertise in specific tools like Databricks or PySpark are likely to command the highest salaries in the current market.