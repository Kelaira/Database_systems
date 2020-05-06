### Ako funguje inner join ?
- INNER JOIN priraďuje každý riadok v jednej tabuľke ku každému
riadku v druhej tabuľke a umožňuje dotazovať riadky, ktoré obsahujú 
stĺpce z oboch tabuliek

- píšeme ho hneď za ```FROM``` 

- za tabuľkami v ```INNER JOIN```E následuje podmienka ```ON```, ktorá 
špecifikuje ktoré riadky sa majú spojiť (do výslednej tabuľky sú zahrnuté len tie
riadky, ktoré spĺňajú podmienku)

![inner_join](data_poznamky/inner_join_1.png)

```sql
select Program.*
from Program
inner join Cinemas
on Cinemas.Capacity = Program.Tickets
order by Program.Name, Program.Day
```

