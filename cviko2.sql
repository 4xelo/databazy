desc priklad_db2.os_udaje;

select meno, priezvisko -- projekcia 
 from priklad_db2.os_udaje
  where lower(meno)='peter'
    and length(priezvisko)<10; -- selekcia


select upper(substr(text, 1,1)) || substr(text, 2) 
 from (select lower('DATAbazoVE SYStemY') as text
        from dual
      )  ; 

select meno, priezvisko -- projekcia 
 from priklad_db2.os_udaje
  where substr(meno, 1,1)='P'
    and length(meno)=5;
    
select meno, priezvisko -- projekcia 
 from priklad_db2.os_udaje
  where meno like 'P____';
 -- _ - prave 1 znak
 -- % - lubovolny pocet znakov
 
select table_name, owner
 from all_tables 
  where table_name like 'P\_OSOBA' escape '\';
  
select meno, priezvisko, decode(substr(rod_cislo, 3,1), 0, 'muz', 
                                                        1, 'muz', 
                                                        5, 'zena', 
                                                        6, 'zena', '---')
                                                            as pohlavie
 from priklad_db2.os_udaje;
 
select meno, priezvisko, case to_number(substr(rod_cislo, 3,1))
                            when 1 then 'muz'
                            when 0 then 'muz'
                            when null then 'neviem'
                            else 'zena'
                         end as pohlavie
 from priklad_db2.os_udaje
  where substr(rod_cislo,3,1)=5 or substr(rod_cislo,3,1)=6; 

select meno, priezvisko, case to_number(substr(rod_cislo, 3,1))
                            when 1 then 'muz'
                            when 0 then 'muz'
                            when null then 'neviem'
                            else 'zena'
                         end as pohlavie
 from priklad_db2.os_udaje
  where substr(rod_cislo,3,1) in (5,6); 

select * 
from
(
  select meno, priezvisko, case 
                              when to_number(substr(rod_cislo, 3,1))='1' then 'muz'
                              when to_number(substr(rod_cislo, 3,1))='0' then 'muz'
                              when to_number(substr(rod_cislo, 3,1)) IS null then 'neviem'
                              else 'zena'
                           end as "Pohlavie osoby"
 from priklad_db2.os_udaje
 ) 
  where "Pohlavie osoby"='muz';  
  
--------------------------------------------------------
select meno, priezvisko, rod_cislo
 from os_udaje
  where rod_cislo NOT IN ('841106/3456', '840312/7845');


select meno, priezvisko, rod_cislo
 from os_udaje
  where rod_cislo IN (select rod_cislo 
                        from student); 

select meno, priezvisko, rod_cislo
 from os_udaje
  where rod_cislo NOT IN (select rod_cislo 
                           from student); 

select meno, priezvisko, rod_cislo
 from os_udaje
  where NOT EXISTS (select 'x'
                      from student
                       where os_udaje.rod_cislo=student.rod_cislo);

select * 
 from st_odbory sto
  where NOT EXISTS (select 'x'
                     from student s
                      where s.st_odbor=sto.st_odbor
                        and s.st_zameranie=sto.st_zameranie);
                        
select *
 from os_udaje
  where rod_cislo NOT IN (select rod_cislo from priklad_db2.os_udaje);
  
select meno, priezvisko, rod_cislo, os_cislo, rocnik, ukoncenie
 from student JOIN os_udaje USING(rod_cislo)
  order by ukoncenie ASC nulls LAST, rocnik DESC;
  
  
select meno, priezvisko, student.rod_cislo RC_S, os_udaje.rod_cislo RC_OU, os_cislo, rocnik, ukoncenie
 from student JOIN os_udaje ON (student.rod_cislo=os_udaje.rod_cislo);
 
select *
 from student join st_odbory using(st_odbor, st_zameranie);
 
select *
 from student s join st_odbory sto on(s.st_odbor=sto.st_odbor
                                      AND s.st_zameranie=sto.st_zameranie); -- 37

select * from student; -- 37           

select *
 from student s join st_odbory sto on(s.st_odbor=sto.st_odbor); -- 88 
 
select o.meno, o.priezvisko, student.os_cislo, cis_predm, ucitel.meno, ucitel.priezvisko
 from os_udaje o join student using(rod_cislo)
                 join zap_predmety on (student.os_cislo=zap_predmety.os_cislo)
                 join ucitel on (ucitel.os_cislo=prednasajuci);
                 
select to_char(sysdate, 'HH24:MI:SS') from dual;    

select to_char(sysdate, 'DAY D') from dual;  

select * from os_udaje;

select 'Dobrý deò '|| case substr(rod_cislo, 3,1)
                        when '1' then 'pán'
                        when '0' then 'pán'
                        else 'pani'
                       end || ' ' || priezvisko
 from os_udaje;
 
select 'Dobrý deò '|| case 
                        when substr(rod_cislo, 3,1) in ('0','1') then 'pán'
                        else 'pani'
                       end || ' ' || priezvisko
 from os_udaje; 