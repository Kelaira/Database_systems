-- Vypíšte zoznam všetkıch letov :
select *
from Flights


-- Vypíšte zoznam všetkıch letov zaisovanıch spoloènosou CSA
select * 
from Flights
where Company = 'CSA'

-- Vypíšte zoznam všetkıch letov zaisovanıch spoloènosou CSA striedenı zostupne pod¾a poètov pasaierov
select *
from Flights
where Company = 'CSA'
order by Passengers DESC

-- Vypíšte zoznam letov spolu s lietadlami, ktoré majú dostatoènú kapacitu pre ich realizáciu
-- striedenı pod¾a èísla letu a následne pod¾a lietadla
select * 
from Flights, Planes 
where Flights.Passengers <= Planes.Capacity
order by Flights.Flight, Planes.Plane ASC

-- Vypíšte zoznam letov spolu s lietadlami, ktoré majú dostatoènú kapacitu pre ich realizáciu
-- striedenı pod¾a poètu sedadiel, ktoré budú za letu neobsadené, ïalej pod¾a èísla letu
select *
from Flights, Planes
where Flights.Passengers <= Planes.Capacity
order by (Planes.Capacity - Flights.Passengers), Planes.Plane ASC

-- Vypíšte lety s viac ako 150 pasaierov
select *
from Flights
where Passengers > 150

-- Vypíšte poèet letov s viac ako 150 pasaiermi
select count(*) as 'Nr_of_Flights'
from Flights
where Passengers > 150

-- Vypíšte zoznam všetkıch leteckıch spoloèností, ktoré zaisujú lety
select distinct Company
from Flights