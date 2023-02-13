-- 2.1.1
select last_name, first_name as F_name from student;
select last_name as lname, first_name as fname from student;
select concat(last_name , '_' , first_name) as name from student;
select concat(last_name,' ',first_name) as name, (year_result * 10) as result from student;

-- 2.1.2
select last_name,birth_date,login,year_result from student;

--2.1.3
select concat(last_name,' ',first_name) as name, student_id as id, birth_date as ddn from student;
select (last_name + ' ' + first_name) as name, student_id as id, birth_date as ddn from student;

--2.1.4
select concat(first_name,' ',last_name,' ', birth_date,' ',login,' ',section_id,' ',year_result,' ',course_id) as "Info Etudiant" from student;

--concat_ws

--2.2.1
select login,year_result from student where year_result > 16

--2.2.2
select last_name, section_id from student where first_name like 'Georges'

--2.2.3
select last_name,year_result from student where year_result between 12 and 16

--2.2.4
select last_name,section_id,year_result from student where section_id not in(1010,1020,1110)

--2.2.5
select last_name,section_id,year_result from student where last_name like '%r'

--2.2.6
select last_name,year_result from student where last_name like '__n%' and year_result > 10

--2.2.7
select last_name, year_result from student where year_result <= 3 order by year_result desc

--2.2.8
select last_name +' '+first_name as 'Nom Complet', year_result 
from student 
where section_id = 1010
order by last_name asc

--2.2.9
select last_name,section_id,year_result 
from student
where section_id in(1010,1020) and (year_result < 12 or year_result >18)
order by section_id 

--2.2.10
select last_name,section_id,year_result *5 as 'Résultat sur 100'
from student
where section_id like '13%' and year_result*5 <= 60
order by year_result*10 desc

--2.2.11

--2.3.6
select count(*) from student;
select count(student_id) from student;
select MIN(year_result), max(birth_date) from student where year_result>12;

--2.3.7

select avg(year_result) from student;
--2.3.8

select max(year_result) from student

--Exercice 2.3.9 – Donner la somme des résultats annuels
select sum(year_result) from student
--Exercice 2.3.10 – Donner le résultat annuel le plus faible
select min(year_result) from student
--Exercice 2.3.11 – Donner le nombre de lignes qui composent la table « STUDENT »
select count(*) from student
--Exercice 2.3.12 – Donner la liste des étudiants (login et année de naissance) nés après 1970
select login, year(birth_date) from student where year(birth_date) > 1970

--2.3.13
select login,last_name from student where len(last_name) >= 8
--2.3.14
select upper(last_name) as 'Nom de famille', first_name,birth_date from student
where year_result >= 16
order by year_result desc

--2.3.15
select first_name,last_name,login,lower(SUBSTRING(first_name,1,2)+SUBSTRING(last_name,1,4)) as 'Nouveua login' from student
--2.3.16
select first_name,last_name,login,SUBSTRING(first_name,len(first_name)-2,3)+convert(varchar,(year(SYSDATETIME())-year(birth_date))) as 'Nouveua login'
from student
where year_result in(10,12,14)
--2.3.17
select last_name,login,year_result from student
where last_name like 'D%' or last_name like 'M%' or last_name like 'S%' 
order by birth_date asc
--2.3.18
select last_name,login,year_result from student
where (year_result % 2<> 0 and year_result >= 10)
order by year_result desc
--2.3.19

select count(*) from student where len(replace(last_name,' ','')) >= 7;

--2.3.20
select last_name,year_result ,
CASE
	WHEN year_result >= 12 THEN 'OK'
	when year_result < 12 then 'KO'
	END AS 'Statut'
from student
where year(birth_date) < 1955
--2.3.21
select last_name,year_result,
case
	when year_result < 10 then 'Inférieur'
	when year_result = 10 then 'Neutre'
	when year_result >10 then 'Supérieur'
end as 'Catégorie'
from student
where year(birth_date) between 1955 and 1965

--2.3.22
select last_name,year_result,FORMAT(birth_date, 'd MMMM yyyy', 'fr-FR')
from student

--2.3.23

select last_name,month(birth_date) as 'Mois de naissance', year(birth_date),year_result,nullif(year_result, 4) as 'Nouveau résultat'
from student
where month(birth_date) not in (12,1,2,3) and year_result < 7

--2.4.7
select section_id,max(year_result) from student group by section_id
--2.4.8
select section_id,avg(convert(float,year_result)) from student where section_id like '10%' group by section_id
--2.4.9
select month(birth_date) as 'Mois de naissance', avg(year_result) as 'moyenne' from student
where year(birth_date) between 1970 and 1985
group by month(birth_date)
--2.4.10
select  section_id,avg(convert(float,year_result)) as 'Moyenne' from student 
group by section_id
having count(section_id) > 3
--2.4.11
select section_id,avg(year_result) as 'Moyenne',max(year_result) as 'Résultat maximum'
from student
group by section_id
having avg(year_result) > 8

--2.6.1
select c.course_name,section_name,professor_name from professor p
join section s on p.section_id = s.section_id
join course c on p.professor_id = c.professor_id

--2.6.2
select se.section_id,se.section_name,st.last_name from section se
join student st on st.student_id = se.delegate_id
order by  se.section_id desc

--2.6.3
select se.section_id,se.section_name,p.professor_name
from section se
full outer join professor p on p.section_id = se.section_id
order by  se.section_id desc

--2.6.4
select se.section_id,se.section_name,p.professor_name
from section se
join professor p on p.section_id = se.section_id
order by  se.section_id desc

--2.6.5 -- A FAIRE
select distinct s.last_name,s.year_result, g.grade
from student s,grade g
where s.year_result >= 12 and s.year_result between g.lower_bound and g.upper_bound
order by g.grade


--2.6.6
select p.professor_name,s.section_name,c.course_name,c.course_ects
from professor p
join section s on s.section_id=p.section_id
full outer join course c on c.professor_id = p.professor_id
order by c.course_ects desc

--2.6.7
select p.professor_id,sum(c.course_ects) as 'ECTS_TOT'
from professor p
full outer join course c on c.professor_id = p.professor_id
group by p.professor_id
order by sum(c.course_ects) desc

--2.6.8 -- alias sur les colones
select p.professor_surname as first_name ,p.professor_name as last_name, 'P' as 'Catégorie'
from professor p
where len(p.professor_name) > 8
UNION
select s.first_name,s.last_name, 'S' as 'Catégorie'
from student s
where len(s.last_name) > 8

--2.6.9
select s.section_id from section s
except
select p.section_id from professor p 

--2.7.1
select s.last_name,s.first_name,s.section_id from student s
where s.section_id = (select section_id from student where last_name like 'Roberts') and s.last_name <> 'Roberts'
order by s.last_name 
--2.7.2
select s.last_name,s.first_name,s.year_result from student s
where s.year_result > (select AVG(year_result)*2 from student)

--2.7.3
select s.section_id,s.section_name from section s
where s.section_id not in (select p.section_id from professor p)
---------------------------

--2.7.4
select s.last_name,s.first_name,s.section_id,s.birth_date,s.year_result from student s
where month(s.birth_date) = (select month(professor_hire_date) from professor where professor_name like 'Giot')
--2.7.5
select s.last_name,s.first_name,s.year_result from student s
where s.year_result between (select lower_bound from grade where grade like 'tb')
and
(select upper_bound from grade where grade like 'tb')
--2.7.6
select s.last_name,s.first_name,s.section_id from student s
where s.section_id in (select s.section_id from section s join student st on s.section_id = st.section_id where s.delegate_id = student_id and st.last_name like 'Marceau')
 
--2.7.7

select s.section_id,s.section_name from section s
where section_id in ((select section_id
 from student
 group by section_id
 having count(*)>4))
 
 --2.7.8
 select last_name,first_name,section_id from student
 where section_id not in( select se.section_id from section se
 join student st on st.section_id = se.section_id
 group by se.section_id
 having AVG(st.year_result) < 10)
 and
 year_result in (select max(year_result)from student st
join section se on se.section_id = st.section_id
group by st.section_id)
order by section_id desc

--2.7.9
with moyenne(Average)
as
(
select avg(year_result) from student group by section_id

)
select section_id,avg(year_result) from student
group by section_id,year_result
having avg(year_result) = (select max(Average) from moyenne)