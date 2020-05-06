-- Vypíšte zoznam všetkıch kín v New Yorku, striedenı zostupne pod¾a kapacity
select *
from Cinemas
where City = 'New York'
order by Capacity DESC

-- Vypíšte zoznam všetkıch filmov, ktoré nenatoèil Cameron
-- striedenı pod¾a reíséra a ïalej zostupne pod¾a ánru
select *
from Movies
where Director <> 'Cameron'
order by Director, Genre desc

-- Vypíšte zoznam všetkıch premietaní filmu Titanic vo februári 2019 s aspoò
-- 100 predanımi vstupenkami. Strieïte vısledok pod¾a dátumu premietania
select *
from Program
where Title = 'Titanic' and
	Tickets >= 100 and 
	-- Month(Day) = 02  - môeme pouíva takéto funkcie jazyka ?
	Day like '%-02-%'
order by Day

-- Vypíšte zoznam kín, ktoré premietali aspoò jeden film od Spielberga, 
-- strieïte vısledok pod¾a mesta a ïalej názvu kina
-- bez pouitia spojení pod¾a normy SQL-92
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

-- Vypíšte zoznam kín, ktoré premietali aspoò jeden film od Spielberga,
-- strieïte vısledok pod¾a mesta a ïalej názvu kina
-- ale s pouitím spojenia pod¾a normy SQL-92
select distinct Cinemas.*
from Cinemas
inner join Program on -- otázka, viem poui inner join aj na viacero tabuliek ? je na to nejakı inteligentnı spôsob ?
	(Program.Name = Cinemas.Name)
where Program.Title in (
	select Title
	from Movies
	where Director = 'Spielberg'
)
order by City, Name

-- znova to isté zadanie, vyplò len èas where ...
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

-- Vypíšte zoznam všetkıch premietaní, keï bolo kino vypredané.
-- Strieïte vısledok pod¾a mena, kina a ïalej pod¾a dátumu premietania
select Program.*
from Program, Cinemas 
where Program.Tickets = Cinemas.Capacity
order by Program.Name, Program.Day

-- Vypíšte zoznam všetkıch premietaní, keï bolo kino vypredané.
-- Strieïte vısledok pod¾a mena kina a ïalej pod¾a dátumu premietania
select Program.*
from Program
inner join Cinemas
on Cinemas.Capacity = Program.Tickets
order by Program.Name, Program.Day;

select *
from Program
 