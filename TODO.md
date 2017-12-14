# TODO List

## check, tirgger, assertion
1) ~~Total_number_of_seats , max_seatsdan fazla olamaz.~~
2) number_of_available_seats , total_number_of_seatsden büyük olmamalı
3) LEG_INSTANCE'ye veri eklerken eklenen uçağın varış havaalanına inip inemeyeceğini kontrol etmeliyiz (3tablo)
4) LEG_INSTANCE'ye veri eklerken Departure_time FLIGHT_LEG'deki Scheduled_departure_time'dan küçük olmamalı
5) ~~Koltuk rezervasyonu yapıldıgı zaman,Leg Instance ta bulunan number of available seats sahasının degerını azalt~~
6) ~~Seat Reservation yapmadan önce available seatsin 0 dan büyük olup olmadıgını kontrol et~~
7) Aktarmalı uçuşlar arasında, önceki uçuşun iniş tarihi ve saatinden önce diğer aktarmalı uçak kalkış yapmamalı
8) AIRPLANE tablosundaki Total_number_of_seats AIRPLANE_TYPE tablosundaki Max_seats den büyük olmamalı

## Views
1) ~~Aktarmali ve aktarmasiz tum ucuslarin, ilk aktarmasinin kalkis tarihi ve saati ile son aktarmasinin inis tarihi ve saatinin musterilere gostermek amaciyla view olusturma~~
2) ~~Tamamlanmis uçuslarin bos koltuk sayisi %50den fazla olanlari bulan view~~

## SELECT

1) ~~Havayolu şirketlerinin,yarım saatten fazla rotar yapan ucuslarında uçan yolcularının listesi~~(neden: hediye göndereceğiz :) )
2) ~~Adı verilen havaalanına inebilen uçakların listesi~~
3) ~~Planlanan yerden farklı yere iniş yapan uçuşlar~~
4) ~~Kalkış yapmış fakat iniş yapmamış uçakların şirketi (2 tablo)~~
5) ~~Kalkış yapmış fakat iniş yapmamış uçakların sayısı~~
6) leg_instance da tamamlanmış uçuşların available seats sayısı %50den fazla olanları bulan sql + sabah1)akşam
7) şehirlere göre yoğunlu|uçuş sayısını gösteren sql
8) verilen bir şehirdeki, verilen tarihler arasında 10'den az uçuş gerçekleşmiş havaalanına
9) ~~verilen bir havaalanında verilen tarihler arasında 5'den az uçuz yapmış şirketlerin isimleri~~
10) ~~verilen bir havaalanına inebilecek uçakları alabildiği yolcu sayısına göre sıralayan sql~~
11) verilen havaalanında 700 TLden pahallıya bilet satan havayolu şirketlerinin adı (exist, nested)
12) ~~1.query ile birlestirildi~~
13) verilen havayollarının pazartesi günü, öğlenden önce gerçekleştirdiği uçuşlar
14) verilen bir havayolu şirketinin 5den fazla uçuş yapmış yolcuların listesi
15) Flight_number, Leg_number ve Date'i verilen uçuştaki adı "X" olan yolcunun telefon numarası
16) İzmirdeki havalimanlarından 400tlden fazla ödeyerek uçuş yapmış yolcuların telefon numaraları
17) ~~Uluslar arası uçuş gerçekleştiren havayolları listesi~~
18) ~~Aktarmalı uçuşların listesi~~
19) ~~izmirde 5den fazla uçuş yapmış şirketlerin listesi~~
20) ~~havalimanını en çok kullanan şirketlerin listesi ( ORDER BY )~~
21) ~~planlanan iniş havalimanından farklı havalimanına inen fakat inmesi normalde mümkün olmayan uçuşlar~~
22) Kalktığı havalimanına geri dönen uçuşlar
23) ~~Planlanan havada kalma suresinden daha az/fazla surede ucusu tamamlayan ucuslar~~
24) ~~istanbul-japonya arası aktarmasız uçuşlardaki aynı telefon numarasına sahip müşterilerin adı~~
25) ~~Kaza yapmis ucuslarin listesi~~
## Yeniliklerimiz
1) Arrival_airport_code NULL olabilir > uçak kalkış yapmış ama havaalanına inmemiş (kaza yapma durumu) ;)
2) FLIGHT_LEG tablosuna kilometre eklemek. (select 2)

## SELECT Yeniliklerimiz
1) ~~Daha önce hiç kaza yapmamış havayolu şirketleri (NOT EXIST, arrival_airport_code = null, bkz. model 1)~~
2) 10000 km'den fazla uçmuş yolcuları bulan sql (yenilik 2)

# What is left ?
1) ~~Write down the appropriate SQL scripts (DDL statements) for creating the database and its
relational model. You can select any of the DBMS you wish.~~
2) ~~Populate the database you just created again using SQL script file loaded with sample tuples.
(The tables should have enough number of tuples for the SELECT statements, asked in the
5th step, to be run accordingly.)~~
3) ~~Write down 3 triggers for 3 different tables. Triggers should be meaningful.~~ <strong> => we have 1 extra trigger, count it for assertion ??? !</strong>
4) ~~Write down 3 check constraints and~~ 3 assertions. ~~Check constraints and~~ assertions should be
meaningful.
5) Write down the following SQL statements:
  a. Write sample ~~INSERT,~~ DELETE and ~~UPDATE~~ statements for 3 of the tables you have
  chosen.<br>
  ~~b. Write 10 SELECT statements for the database you have implemented.~~<br>
    i. ~~3 of them should use minimum 2 tables.~~         <strong> => 3,18,23 </strong> <br> 
    ii. ~~4 of them should use minimum 3 tables.~~       <strong>=> 9,10,17,19 </strong><br> 
    iii. ~~3 of them should use minimum 4 tables.~~      <strong> => 1,2,24   </strong><br>
  c. ~~Write 4 SELECT statements to exemplify nested and/or correlated nested queries.~~  <strong> =>20,21,25,4+5   </strong><br><br>
  d. ~~Write 2 SELECT statements to exemplify EXISTS and NOT EXISTS statements.~~<br>
  e. Write 3 SELECT statements to exemplify ~~LEFT~~, RIGHT and ~~FULL OUTER JOIN~~
  statements.
6) ~~Create 3 views that are reasonable.~~







