-- Vyp�te zoznam v�etk�ch k�n v New Yorku, strieden� zostupne pod�a kapacity
select *
from Cinemas
where City = 'New York'
order by Capacity DESC

-- Vyp�te zoznam v�etk�ch filmov, ktor� nenato�il Cameron
-- strieden� pod�a re��s�ra a �alej zostupne pod�a ��nru
select *
from Movies
where Director <> 'Cameron'
order by Director, Genre desc

-- Vyp�te zoznam v�etk�ch premietan� filmu Titanic vo febru�ri 2019 s aspo�
-- 100 predan�mi vstupenkami. Strie�te v�sledok pod�a d�tumu premietania
select *
from Program
where Title = 'Titanic' and
	Tickets >= 100 and 
	-- Month(Day) = 02  - m��eme pou��va� tak�to funkcie jazyka ?
	Day like '%-02-%'
order by Day

-- Vyp�te zoznam k�n, ktor� premietali aspo� jeden film od Spielberga, 
-- strie�te v�sledok pod�a mesta a �alej n�zvu kina
-- bez pou�itia spojen� pod�a normy SQL-92
select *
from Cinemas
where Name in (
	select Name
	from Program 
	where Title in (
		select Title 
		from Movies
		where Director = 'Spielberg'
	)
)
order by City, Name

-- Vyp�te zoznam k�n, ktor� premietali aspo� jeden film od Spielberga,
-- strie�te v�sledok pod�a mesta a �alej n�zvu kina
-- ale s pou�it�m spojenia pod�a normy SQL-92
select distinct Cinemas.*
from Cinemas
inner join Program on -- ot�zka, viem pou�i� inner join aj na viacero tabuliek ? je na to nejak� inteligentn� sp�sob ?
	(Program.Name = Cinemas.Name)
where Program.Title in (
	select Title
	from Movies
	where Director = 'Spielberg'
)
order by City, Name

-- znova to ist� zadanie, vypl� len �as� where ...
select * 
from Cinemas as C 
where C.Name in (
	select Name
	from Program 
	where Title in (
		select Title 
		from Movies
		where Director = 'Spielberg'
	)
)
order by C.City, C.Name; 

-- Vyp�te zoznam v�etk�ch premietan�, ke� bolo kino vypredan�.
-- Strie�te v�sledok pod�a mena, kina a �alej pod�a d�tumu premietania
select Program.*
from Program, Cinemas 
where Program.Tickets = Cinemas.Capacity
order by Program.Name, Program.Day

-- Vyp�te zoznam v�etk�ch premietan�, ke� bolo kino vypredan�.
-- Strie�te v�sledok pod�a mena kina a �alej pod�a d�tumu premietania
select Program.*
from Program
inner join Cinemas
on Cinemas.Capacity = Program.Tickets
order by Program.Name, Program.Day;

select *
from Program
 