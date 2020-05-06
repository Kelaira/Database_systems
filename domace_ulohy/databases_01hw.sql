-- Vyp�te zoznam v�etk�ch letov :
select *
from Flights


-- Vyp�te zoznam v�etk�ch letov zais�ovan�ch spolo�nos�ou CSA
select * 
from Flights
where Company = 'CSA'

-- Vyp�te zoznam v�etk�ch letov zais�ovan�ch spolo�nos�ou CSA strieden� zostupne pod�a po�tov pasa�ierov
select *
from Flights
where Company = 'CSA'
order by Passengers DESC

-- Vyp�te zoznam letov spolu s lietadlami, ktor� maj� dostato�n� kapacitu pre ich realiz�ciu
-- strieden� pod�a ��sla letu a n�sledne pod�a lietadla
select * 
from Flights, Planes 
where Flights.Passengers <= Planes.Capacity
order by Flights.Flight, Planes.Plane ASC

-- Vyp�te zoznam letov spolu s lietadlami, ktor� maj� dostato�n� kapacitu pre ich realiz�ciu
-- strieden� pod�a po�tu sedadiel, ktor� bud� za letu neobsaden�, �alej pod�a ��sla letu
select *
from Flights, Planes
where Flights.Passengers <= Planes.Capacity
order by (Planes.Capacity - Flights.Passengers), Planes.Plane ASC

-- Vyp�te lety s viac ako 150 pasa�ierov
select *
from Flights
where Passengers > 150

-- Vyp�te po�et letov s viac ako 150 pasa�iermi
select count(*) as 'Nr_of_Flights'
from Flights
where Passengers > 150

-- Vyp�te zoznam v�etk�ch leteck�ch spolo�nost�, ktor� zais�uj� lety
select distinct Company
from Flights