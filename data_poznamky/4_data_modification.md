### Ako vkladať nové dáta do tabuľky ?

---

```sql
-- ak je v tabuľke 5 stĺpcov vložia sa do nich hodnoty val1..val5
insert into table_name values(val1,val2,val3,val4,val5)

-- môžem vkladať len do niektorých stĺpcov
-- ostatné budú doplnené defaultnými hodnotami(ak boli špecifikované, ináč NULL)
insert into table_name (col1,col3,col5) values (val1,val3,val5)

-- môžem vkladať hodnoty z celej tabuľky
-- takto vkladáme viac riadkov naraz
insert into table_name (select col1, col2, col3 from other_table ...)
```



### Ako aktualizovať dáta v tabuľke ?

---

```sql
update table_name set expression where condition

-- napríklad :
update table1 set column1 = column1 * 50 where column3 < 10
```



### Ako mazať z tabuľky ?

---

```sql
delete from table_name -- bez argumentov sa zmaže celá tabuľka
delete from table_name where condition
```

