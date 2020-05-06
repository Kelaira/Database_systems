[Časť prednášky od 26:00 dokonca](https://tirpitz.ms.mff.cuni.cz/contactless/lecture03b_CZ_web.mp4)
### Ako fungujú nested queries ?

- jednotlivé dotazy môžeme vnárať do seba

```sql
-- vráť súčet pasažierov a lietadlových kapacít pre všetky
-- spoločnosti, ktoré vlastnia lietadlo
select Flights.Company, sum(Flights.Passengers), MIN(Q1.TotalCapacity)
from Flights, (select sum(Capacity) as TotalCapacity, Company 
                    from Planes
                    group by Company) as Q1
where Q1.company = Flights.Company
```

![nested](data_poznamky/nested_query.png)

- vnárať sa môžem v ```FROM``` aj v ```JOIN```och a v ich podmienkach

