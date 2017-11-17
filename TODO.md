# TODO List

## check, tirgger, assertion
- Total_number_of_seats , max_seatsdan fazla olamaz.
- number_of_available_seats , total_number_of_seatsden büyük olmamalı
- LEG_INSTANCE'ye veri eklerken eklenen uçağın varış havaalanına inip inemeyeceğini kontrol etmeliyiz (3tablo)
- LEG_INSTANCE'ye veri eklerken Departure_time FLIGHT_LEG'deki Scheduled_departure_time'dan küçük olmamalı
- Koltuk rezervasyonu yapıldıgı zaman,Leg Instance ta bulunan number of available seats sahasının degerını azalt
- Seat Reservation yapmadan önce available seatsin 0 dan büyük olup olmadıgını kontrol et
- Aktarmalı uçuşlar arasında, önceki uçuşun iniş tarihi ve saatinden önce diğer aktarmalı uçak kalkış yapmamalı

## SELECT

- Yarım saatten fazla rotar yapan ucusları bulan SQL
- Havaalanına inebilen uçakları lıstele (ek: verilen bir şirket)
- Planlanan yerden farklı yere iniş yapan uçuşlar
- Kalkış yapmış fakat iniş yapmamış uçakların şirketi (2 tablo)
- Kalkış yapmış fakat iniş yapmamış uçakların sayısı
- leg_instance da tamamlanmış uçuşların available seats sayısı %50den fazla olanları bulan sql + sabah-akşam
- şehirlere göre yoğunlu|uçuş sayısını gösteren sql
- verilen bir şehirdeki, verilen tarihler arasında 10'den az uçuş gerçekleşmiş havaalanına
- verilen bir havaalanında verilen tarihler arasında 5'den az uçuz yapmış şirketlerin isimleri
- verilan havaalanına inebilecek uçaklar arasından en fazla yolcu alabileni bulan sql
- verilen havaalanında 700 TLden pahallıya bilet satan havayolu şirketlerinin adı (exist, nested)
- verilen bir havayolu şirketinin, rötarlı uçuşlarında uçan yolcularının listesi(neden: hediye göndereceğiz :) )
- verilen havayollarının pazartesi günü, öğlenden önce gerçekleştirdiği uçuşlar
- verilen bir havayolu şirketinin 5den fazla uçuş yapmış yolcuların listesi
- Flight_number, Leg_number ve Date'i verilen uçuştaki adı "X" olan yolcunun telefon numarası
- İzmirdeki havalimanlarından 400tlden fazla ödeyerek uçuş yapmış yolcuların telefon numaraları
- Uluslar arası uçuş gerçekleştiren havayolları listesi 
- Aktarmalı uçuşların listesi
- izmirde 5den fazla uçuş yapmış şirketlerin listesi
- havalimanını en çok kullanan şirketlerin listesi ( ORDER BY )
- planlanan iniş havalimanından farklı havalimanına inen fakat inmesi normalde mümkün olmayan uçuşlar
- Kalktığı havalimanına geri dönen uçuşlar

## Yeniliklerimiz
- 1) Arrival_airport_code NULL olabilir -> uçak kalkış yapmış ama havaalanına inmemiş (kaza yapma durumu) ;)
- 2) FLIGHT_LEG tablosuna kilometre eklemek. (select 2)

## SELECT Yeniliklerimiz
- Daha önce hiç kaza yapmamış havayolu şirketleri (NOT EXIST, arrival_airport_code = null, bkz. model 1)
- 10000 km'den fazla uçmuş yolcuları bulan sql (yenilik 2)
