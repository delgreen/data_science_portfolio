/*
======PROBLEM======
Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are .

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.
======PROBLEM======

SELECT
    contest_id, 
    hacker_id, 
    name,
        !!!!(per contest)!!!!
        sums of total_submissions, 
        total_accepted_submissions, 
        total_views, 
        total_unique_views 
FROM
    for each contest 
    
WHERE
    Exclude the contest from the result if all four sums are 0

ORDER BY
    sorted by contest_id. 

Note: 
    ~ but each college only holds 1 screening contest.
    ~ A specific contest can be used to screen candidates at more than one college,
    
    Contests --!!!!ONE-TO-MANY!!!!-->* Colleges

====TABLES========

Contests:
    ~ contest_id is the id of the contest, 
    ~ hacker_id is the id of the hacker who created the contest

Colleges: 
    ~ college_id is the id of the college, and 
    ~ contest_id is the id of the contest that Samantha used to screen candidates

Challenges: 
    ~ challenge_id is the id of the challenge that belongs to one of the contests whose contest_id 
        Samantha forgot, and 
    ~ college_id is the id of the college where the challenge was given to candidates.

View_Stats: 
    ~ challenge_id is the id of the challenge, 
    ~ total_views is the number of times the challenge was viewed by candidates, and 
    ~ total_unique_views is the number of times the challenge was viewed by unique candidates.
    
Submission_Stats: 
    ~ challenge_id is the id of the challenge, 
    ~ total_submissions is the number of submissions for the challenge, and 
    ~ total_accepted_submission is the number of submissions that achieved full scores.

*/

WITH
    SUBMISSION_AGGS AS (
        SELECT
            Submission_Stats.challenge_id                       AS challenge_id
            ,SUM(Submission_Stats.total_submissions)            AS total_submissions
            ,SUM(Submission_Stats.total_accepted_submissions)   AS total_accepted_submissions
        FROM
            Submission_Stats
        GROUP BY Submission_Stats.challenge_id       
    ),
    VIEW_AGGS AS (
        SELECT
            View_Stats.challenge_id                             AS challenge_id
            ,SUM(View_Stats.total_views)                        AS total_views
            ,SUM(View_Stats.total_unique_views)                 AS total_unique_views
        FROM
            View_Stats
        GROUP BY 
            View_Stats.challenge_id
    )
SELECT
    Contests.contest_id
    ,Contests.hacker_id
    ,Contests.name
    ,SUM(A.total_submissions)
    ,SUM(A.total_accepted_submissions)
    ,SUM(B.total_views)
    ,SUM(B.total_unique_views)
FROM 
    Contests
    JOIN Colleges
        ON Colleges.contest_id = Contests.contest_id
    JOIN Challenges
        ON Challenges.college_id = Colleges.college_id
    LEFT JOIN SUBMISSION_AGGS A
        ON A.challenge_id = Challenges.challenge_id
    LEFT JOIN VIEW_AGGS B
        ON B.challenge_id = Challenges.challenge_id
GROUP BY
    Contests.contest_id
    ,Contests.hacker_id
    ,Contests.name
HAVING
    (
        SUM(A.total_submissions)
        + SUM(A.total_accepted_submissions)
        + SUM(B.total_views)
        + SUM(B.total_unique_views)
    ) > 0
ORDER BY Contests.contest_id;