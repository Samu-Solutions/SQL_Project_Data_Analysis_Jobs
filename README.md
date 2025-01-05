# Introdution 
Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

SQL queries? check them out here: [project_sql_folder](/Project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions i wamted to answer through my SQL query were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:**The chosen database management system, ideal for handeling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, esuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how i approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name

-- SELECT *
FROM job_postings_fact
LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
WHERE job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 Paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specilizations within data analytics.
![Top Paying Roles](assets\Top_Paying_Data_Analyst_Jobs_2023.JPG)
*Bar graph visualizing the salary for the top 10 salaries for data analyst; Antropic Claude generated this graph from my SQL query results*

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing inshights into what employers value for high-compensation roles. 

``` sql
WITH top_paying_jobs AS (
SELECT *,
    job_id AS jobz,
    job_title AS jt,
    salary_year_avg AS sya
    FROM job_postings_fact
LEFT JOIN company_dim on company_dim.company_id = job_postings_fact.company_id
WHERE job_title_short = 'Data Analyst' AND
--    job_work_from_home = TRUE AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
```
Here is the breakdown of the most in demand skills for the top 10 highest paying data analyst jobs in 2023:
- SQL is the most required skill, mentioned in 8 out of 8 job listings
- Python and Tableau are tied for second place, each appearing in 7 job listings
- R programming language appears in 4 job listings
- Excel is mentioned in 3 job listing

![Most In-demand Skills](assets\Highly_Paid_Most_In_Demand_Skills.JPG)
*Bar graph visualizing the salary for the most in demand skills for the top 10 highest paying data analyst jobs; Antropic Claude generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to areas with hhigh demand.
``` sql
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count 
FROM 
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Scientist' 
      --job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
Here are the breakdown of the most in demand skills for Data Analyst
1. **Programming Languages:**
    - Python is the most in-demand skill, with the highest demand count.
    - R is also highly sought after, ranking third in demand.
2. **Database Skills:**
    - SQL remains crucial, being the second most in-demand skill.
3. **Statistical Software:**
    - SAS, while less popular than Python and R, still shows significant demand.
4. **Data Visualization:**
    - Tableau is among the top 5 skills, highlighting the importance of data visualization and storytelling.


| Skills   | Demand Count |
|----------|--------------|
| Python   | 114,016      |
| SQL      | 79,174       |
| R        | 59,754       |
| SAS      | 29,642       |
| Tableau  | 29,513       |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills reveal which skills are the highest paying.
```sql
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
```
1. **Big Data Technologies:** PySpark tops the list, indicating the high value placed on big data processing skills.
2. **Version Control and Collaboration:** Bitbucket and GitLab are among the highest-paying skills, highlighting the importance of collaborative development practices.
3. **Machine Learning and AI:** Skills like Watson, DataRobot, and Jupyter suggest a strong demand for machine learning and AI capabilities.
4. **Data Manipulation:** Pandas ranks high, emphasizing the importance of data manipulation skills in Python.
5. **Cloud and DevOps:** Skills like Kubernetes, GCP, and Jenkins indicate the growing importance of cloud computing and DevOps practices in data analysis.
6. **Database Technologies:** PostgreSQL and Elasticsearch showcase the value of both traditional and NoSQL database expertise.

| Rank | Skills        | Average Salary |
|------|---------------|----------------|
| 1    | PySpark       | $208,172       |
| 2    | Bitbucket     | $189,155       |
| 3    | Couchbase     | $160,515       |
| 4    | Watson        | $160,515       |
| 5    | DataRobot     | $155,486       |
| 6    | GitLab        | $154,500       |
| 7    | Swift         | $153,750       |
| 8    | Jupyter       | $152,777       |
| 9    | Pandas        | $151,821       |
| 10   | Elasticsearch | $145,000       |

*Table of the top 10 highest paying skills for data analyst job postings*

### 5. Most Optimal Skills to Learn
Combining insights from demand and slary data, this query aimed to pinpoint skills that are both in high demand and have hgh salaries, offering a strategic focus for skill development.

```sql
/*
Answer: What are the most optimal skills to learn (high demand and high demand and high paying skill)?
- Identify skills in high demand and associated with high average salaries for  Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/

    SELECT
        skills_dim.skill_id AS "Skill ID",
        skills_dim.skills AS skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id
        --skills_dim.skills
    HAVING
        COUNT(skills_job_dim.job_id) > 10
    ORDER BY 
        avg_salary DESC,
        demand_count DESC
    LIMIT 25
```
Here is a break down of the most optimal skills to learn as a data analyst in 2023:

1. **Programming Languages:** Python and R are highly sought after, offering a balance of high demand and competitive salaries.
2. **Data Visualization:** Tableau is in high demand, indicating the importance of data visualization skills.
3. **Cloud Platforms:** Azure and AWS show good demand and high salaries, highlighting the value of cloud computing skills.
4. **Big Data Technologies:** Hadoop and Spark, while not as high in demand, offer above-average salaries.
5. **Database Skills:** SQL Server and Oracle have good demand and competitive salaries.
6. **Business Intelligence Tools:** Looker and Qlik show moderate demand with good salaries.

| Rank | Skills      | Demand Count | Average Salary |
|------|-------------|--------------|----------------|
| 1    | Go          | 27           | $115,320       |
| 2    | Confluence  | 11           | $114,210       |
| 3    | Hadoop      | 22           | $113,193       |
| 4    | Snowflake   | 37           | $112,948       |
| 5    | Azure       | 34           | $111,225       |
| 6    | BigQuery    | 13           | $109,654       |
| 7    | AWS         | 32           | $108,317       |
| 8    | Java        | 17           | $106,906       |
| 9    | SSIS        | 12           | $106,683       |
| 10   | Jira        | 20           | $104,918       |

*Table of the top 10 most optimal skills for data analyst sorted by salary*

# What I Learned
Throughout this journey, I significantly enhanced my SQL skills, equipping myself with powerful tools to tackle complex data challenges:
- **Advanced Query Crafting:** I honed my expertise in writing sophisticated SQL queries, mastering techniques like CTEs (Common Table Expressions) and leveraging WITH clauses for efficient temporary table operations.
- **Data Aggregation:** I became proficient in summarizing and analyzing data using GROUP BY along with aggregate functions like COUNT() and AVG(), transforming raw data into meaningful insights.
- **Analytical Problem-Solving:** I sharpened my ability to solve real-world problems by translating complex questions into actionable and insightful SQL queries, delivering impactful results.

# Conclusions

### Insights
1. **Top paying Data Analyst Jobs:** the highest pay jobs for data analyst that allow remote work offer a wide range of salaries the highest being at $650,000!
2. **Skills for top paying jobs:** high paying data analyst jobs require advanced proficiency in SQL, suggesting it is acritical skill for earning a top salary
3. **Most in demand skills:** SQL is also the most in demand skill in the data analyst job market, thus making it essential for jobseekers.
4. **Skills with higher salaries:** specialized skills, such as SVN and solidity, our associated with the highest average salaries, indicating of premium on niche expertise
5. **Optimal skills for job market value:** SQL leads in demand and offers for a high average salary, position in each as one of the most optimal skills for data analyst to learn to maximize the market value.

### Closing Thoughts
This project significantly enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings serve as a guide for prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive market by focusing on high-demand, high-salary skills like SQL, Python, Tableau, cloud technologies, and machine learning. Ultimately, this exploration underscores the importance of continuous learning and adapting to emerging trends in the field of data analytics.
