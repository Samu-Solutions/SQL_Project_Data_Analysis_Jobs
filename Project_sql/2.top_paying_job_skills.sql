/*
Question: what skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop that align with top salary
*/

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


/*

Skills Frequency Analysis:
1. SQL: Appears in all job postings (100%)
2. Python: Found in 8/10 job postings (80%)
3. Tableau: Present in 5/10 job postings (50%)
4. R: Mentioned in 3/10 job postings (30%)


Key Observations:
1. SQL is an absolute must-have skill for data analysts
2. Python is becoming increasingly important, appearing in 80% of postings
3. Data visualization skills (Tableau, Power BI) are highly valued
4. Cloud and DevOps knowledge is increasingly relevant
5. Familiarity with multiple tools and languages is preferred

Would you like me to dive deeper into any specific aspect of these skill insights?
*/

