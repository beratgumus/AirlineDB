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

## SELECT

1) Yarım saatten fazla rotar yapan ucusları bulan SQL
2) ~~Adı verilen havaalanına inebilen uçakların listesi~~
3) Planlanan yerden farklı yere iniş yapan uçuşlar
4) Kalkış yapmış fakat iniş yapmamış uçakların şirketi (2 tablo)
5) Kalkış yapmış fakat iniş yapmamış uçakların sayısı
6) leg_instance da tamamlanmış uçuşların available seats sayısı %50den fazla olanları bulan sql + sabah1)akşam
7) şehirlere göre yoğunlu|uçuş sayısını gösteren sql
8) verilen bir şehirdeki, verilen tarihler arasında 10'den az uçuş gerçekleşmiş havaalanına
9) verilen bir havaalanında verilen tarihler arasında 5'den az uçuz yapmış şirketlerin isimleri
10) verilan havaalanına inebilecek uçaklar arasından en fazla yolcu alabileni bulan sql
11) verilen havaalanında 700 TLden pahallıya bilet satan havayolu şirketlerinin adı (exist, nested)
12) verilen bir havayolu şirketinin, rötarlı uçuşlarında uçan yolcularının listesi(neden: hediye göndereceğiz :) )
13) verilen havayollarının pazartesi günü, öğlenden önce gerçekleştirdiği uçuşlar
14) verilen bir havayolu şirketinin 5den fazla uçuş yapmış yolcuların listesi
15) Flight_number, Leg_number ve Date'i verilen uçuştaki adı "X" olan yolcunun telefon numarası
16) İzmirdeki havalimanlarından 400tlden fazla ödeyerek uçuş yapmış yolcuların telefon numaraları
17) ~~Uluslar arası uçuş gerçekleştiren havayolları listesi~~
18) ~~Aktarmalı uçuşların listesi~~
19) ~~izmirde 5den fazla uçuş yapmış şirketlerin listesi~~
20) havalimanını en çok kullanan şirketlerin listesi ( ORDER BY )
21) planlanan iniş havalimanından farklı havalimanına inen fakat inmesi normalde mümkün olmayan uçuşlar
22) Kalktığı havalimanına geri dönen uçuşlar
23) Planlanan havada kalma suresinden daha az/fazla surede ucusu tamamlayan ucuslar

## Yeniliklerimiz
1) Arrival_airport_code NULL olabilir > uçak kalkış yapmış ama havaalanına inmemiş (kaza yapma durumu) ;)
2) FLIGHT_LEG tablosuna kilometre eklemek. (select 2)

## SELECT Yeniliklerimiz
1) Daha önce hiç kaza yapmamış havayolu şirketleri (NOT EXIST, arrival_airport_code = null, bkz. model 1)
2) 10000 km'den fazla uçmuş yolcuları bulan sql (yenilik 2)
