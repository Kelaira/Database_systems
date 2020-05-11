-- 01
-- vypíšte zoznam kín, ktoré nepremietali žiadny film od Camerona,
-- strieďte výsledok podľa mesta a ďalej podľa názvu kina

-- formát:
-- Cinemas(*Name*, City, Capacity)
-- Movies(*Title*, Country, Genre, Director)
-- Program(Name, Title, *Day*, Tickets)
--		Name in Cinemas.Name
--		Title in Movies.Title


-- čo by sme chceli urobiť ?
-- vybrať všetky filmy, ktoré točil Cameron z Program, Movies
-- urobiť right outer join s Cinemas
-- zostane nám zoznam kín, ktoré majú v položkách Movies a Program
-- hodnoty NULL
select Cinemas.*
from Program
inner join Movies
	on Movies.Title = Program.Title and Movies.Director = 'Cameron'
right outer join Cinemas
	on Program.Name = Cinemas.Name
group by Cinemas.Name, Cinemas.City, Cinemas.Capacity
having count(Program.Title) = 0
order by Cinemas.City, Cinemas.Name


-- 02
-- vypíšte zoznam kín, ktoré premietali práve tri filmy od 
-- Camerona (filmy, nie premietania), strieďte výsledok
-- podľa mesta a ďalej názvu kina
select Cinemas.*
from Cinemas
inner join( 
		select Program.Name, Program.Title
		from Program
		inner join(
				select *
				from Movies
				where Director = 'Cameron'
			) as T2
			on Program.Title = T2.Title
		group by Program.Name, Program.Title
		) as T1
	on T1.Name = Cinemas.Name
group by 
	Cinemas.Name, Cinemas.City, Cinemas.Capacity
having
	count(T1.Title) = 3
order by
	Cinemas.City, Cinemas.Name

-- 03
-- Vypíšte zoznam kín, ktoré premietali len filmy od Camerona
-- Strieďte výsledok podľa mesta a ďalej podľa názvu kina

-- idea : vylúčime všetky kiná, ktoré premietali aj niekoho 
-- iného

select Cinemas.*
from Cinemas
left outer join( 
	select Program.Name
	from Movies, Program
	where Movies.Director <> 'Cameron' 
		and Movies.Title = Program.Title
	group by Program.Name
	) as T2
	on Cinemas.Name = T2.Name
where T2.Name is null

order by Cinemas.City, Cinemas.Name

-- 04
-- Vypíšte zoznam kín, ktoré premietali všetky
-- filmy od Camerona. Strieďte výsledok podľa
-- mesta a ďalej podľa názvu kina

select Cinemas.*
from Cinemas
inner join (
	select Program.Name, count(distinct Program.Title) as CameronCount
	from Program
	inner join(
			select Movies.Title
			from Movies 
			where Director = 'Cameron') as T1
		on T1.Title = Program.Title 
	group by Program.Name
	having count(distinct Program.Title) = (
			select count(Movies.Title)
			from Movies 
			where Director = 'Cameron')
		) as T2
	on T2.Name = Cinemas.Name

order by Cinemas.City, Cinemas.Name

-- iný prístup
select Cinemas.*
from Cinemas 
where ( select count(Movies.Title) 
		from Movies	
		where Director = 'Cameron') 
	=
	(	select count(distinct Program.Title)
		from Program 
		inner join Movies 
			on Movies.Title = Program.Title
			and Movies.Director = 'Cameron'
			and Program.Name = Cinemas.Name
		group by Program.Name
	)

order by City, Name

-- prístup bez počítania
select *
from Cinemas 
where not exists(
	select *
	from Movies 
	where 
		Movies.Director='Cameron'
		and not exists(
			select *
			from Program
			where 
				Program.Name = Cinemas.Name
				and Program.Title = Movies.Title 
		)
	)

order by City, Name


-- 05
-- vypíšte zoznam dvojíc kín, ktoré premietali rovnaké filmy

-- takto dostaneme všetky možné dvojice
select C1.Name, C2.Name, P1.Title, P2.Title
from Cinemas as C1, Cinemas as C2, Program as P1, Program as P2
where 
	C1.Name < C2.Name
	and 
	P1.Name = C1.Name 
	and 
	P2.Name = C2.Name
order by C1.Name



	-- chceme, nájsť filmy, ktoré sa premietali
	-- v jednom kine, ale nepremietali sa v druhom

-- super neefektívne prvé funkčné riešenie
-- zisťujem, či je počet rôznych filmov premietaných
-- v obidvoch kinách zároveň rovnaký ako počet rôznych filmov
-- premietaných v jednom kine samostatne
-- potrebujem to navyše robiť na obe strany
select C1.Name, C2.Name
from Cinemas as C1, Cinemas as C2
where
	C1.Name < C2.Name 
	and(
		-- počet filmov premietaných v C1.Name a v C2.Name
		select count(distinct P1.Title)
		from Program as P1
		where
			P1.Name = C1.Name 
			and 
			exists(
				select *
				from Program as P2
				where
					P2.Name = C2.Name 
					and 
					P2.Title = P1.Title 
			)
		) = (
		select count(distinct Program.Title)
		from Program 
		where
			Program.Name = C1.Name
		)
	and(
		select count(distinct P1.Title)
		from Program as P1
		where
			P1.Name = C2.Name 
			and 
			exists(
				select *
				from Program as P2
				where
					P2.Name = C1.Name 
					and 
					P2.Title = P1.Title 
			)
		) = (
		select count(distinct Program.Title)
		from Program 
		where
			Program.Name = C2.Name
		)
		
-- druhý prístup, zrejme rýchlejší, ktorý 
-- počíta počet filmov, ktoré sa nepremietajú
-- v druhom kine
select C1.Name, C2.Name
from Cinemas as C1, Cinemas as C2
where
	C1.Name < C2.Name 
	and(
		select count(distinct P1.Title)
		from Program as P1
		where
			P1.Name = C1.Name 
			and 
			not exists(
				select *
				from Program as P2
				where
					P2.Name = C2.Name 
					and 
					P2.Title = P1.Title 
			)
		) = 0
	and(
		select count(distinct P1.Title)
		from Program as P1
		where
			P1.Name = C2.Name 
			and 
			not exists(
				select *
				from Program as P2
				where
					P2.Name = C1.Name 
					and 
					P2.Title = P1.Title 
			)
		) = 0

-- tento prístup je asi zhodný s týmto
select C1.Name, C2.Name
from Cinemas as C1, Cinemas as C2
where
	C1.Name < C2.Name 
	and not exists(
		select *
		from Program as P1
		where
			P1.Name = C1.Name 
			and 
			not exists(
				select *
				from Program as P2
				where
					P2.Name = C2.Name 
					and 
					P2.Title = P1.Title 
			)
		)
	and not exists (
		select *
		from Program as P1
		where
			P1.Name = C2.Name 
			and 
			not exists(
				select *
				from Program as P2
				where
					P2.Name = C1.Name 
					and 
					P2.Title = P1.Title 
			)
		)