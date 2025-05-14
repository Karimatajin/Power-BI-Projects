--HR request to data analysis team: 

-- Provide a list of healthy individuals & low absenteeism for our healthy bonus program -- total budget $1000


-- Create a join table: 
select * 
from [dbo].[Absenteeism_at_work] a
left join [dbo].[compensation] c
on a.ID = c.ID
left join [dbo].[Reasons] r
on a.[Reason_for_absence] = r.Number;

-- Find the healthiest employees for the bonus: 
select * 
from [dbo].[Absenteeism_at_work] 
where social_drinker = 0  and social_smoker = 0 
and Body_mass_index <25
and Absenteeism_time_in_hours < ( select AVG([Absenteeism_time_in_hours]) from [dbo].[Absenteeism_at_work]) 

-- compenstation rate increase for non-smokers/ budget $983,221 so .68 increase per hour/ $1414. per year 
select count(*) as nonsomkers 
from Absenteeism_at_work
where Social_smoker = 0 


-- optimize the query: by indicating the columns we need instead of all. 
select 
a.ID,
r.Reason, 
Month_of_absence,
body_mass_index,
CASE WHEN body_mass_index < 18.5 then 'underweight'
	 WHEN body_mass_index between 18.5 and 25  then 'healthy weight'
	 WHEN body_mass_index between 25 and 30 then 'overweight'
	 WHEN body_mass_index > 30 then 'obese'
	 ELSE 'Unknown'
	 END as BMI_category,
CASE WHEN Month_of_absence in (12,1,2) then 'Winter' 
     WHEN Month_of_absence in (3,4,5) then 'Spring'
	 WHEN Month_of_absence in (6,7,8) then 'Summer'
	 WHEN Month_of_absence in (9,10,11) then 'Fall'
	 ELSE 'Unknown' 
	 END as seaons_name, 
Day_of_the_week,
[Transportation_expense],
[Distance_from_Residence_to_Work],
[Service_time],
[Age],
[Work_load_Average_day],
[Hit_target],
[Education],
[Pet],
[Height],
[Absenteeism_time_in_hours],
[Social_drinker],
[Social_smoker],
[Reason_for_absence]
from [dbo].[Absenteeism_at_work] a
left join [dbo].[compensation] c
on a.ID = c.ID
left join [dbo].[Reasons] r
on a.[Reason_for_absence] = r.Number;