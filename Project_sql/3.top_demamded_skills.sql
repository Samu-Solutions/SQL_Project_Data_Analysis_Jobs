/* Question: What are the most in demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand on the job market,
 providing insights into  the most valuable skills for job seekers 

*/
-- WITH remote_job_skills AS (
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
/*WHERE job_title_short = 'Data Analyst' AND
--    job_work_from_home = TRUE AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10
)