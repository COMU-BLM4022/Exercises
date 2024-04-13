---
  title: "R Notebook"
output:
  html_document:
  df_print: paged
---
  
 # T.C. Çevre Şehircilik ve İklim Değişikliği bakanlığının ülke genelinde yaptığı hava kalitesi
#ölçümleri [https://sim.csb.gov.tr/Services/AirQuality](https://sim.csb.gov.tr/Services/AirQuality) adresinde bulunan web uygulamasında istasyon bazında görsellenebilmektedir. 

#Ham veriler ise [https://sim.csb.gov.tr/STN/STN_Report/StationDataDownloadNew](https://sim.csb.gov.tr/STN/STN_Report/StationDataDownloadNew) adresinden *Excel* formatında indirlebilmektedir. 

## Egzersiz 1 - Veri ithali

#*Doğduğunuz şehre** ait olan **saatlik** hava kalitesi parametrelerini *Excel* formatında **doğduğunuz ay** için indirin. Tam bir aylık veri indirmeniz gerekmektedir.

#Örnek :
  
#  - Mart ayında doğduysanız Mart 2023 verisi (Çünkü Mart 2024 bitmedi)
#- Aralık ayında doğduysanız Aralık 2023 verisi
#- Şubat ayında doğduysanız Şubat 2024 verisi

#Yaratacağınız data.frame nesnesinin sütun isimleri Excel'de bulunan değişken sütun isimlerini içermelidir. *havaK* nesnesinin ilk 10 satırının raporda gözükmesini sağlayın.

#```{r}
# Excel dosyasındaki ham verileri data.frame formatında R'a ithal edin
# havaK <- <kodu tamamla>
#```
library(readxl)
df <- read_excel("C:/Users/suley/Downloads/veri.xlsx")
class(df)
df <- df[-1,]
df[2,2]
for(i in 1:697){
  for (j in 2:8) {
    if(df[i,j] == "-"){
      df[i,j] = "0"
    }
  }
}

q<- gsub(",", ".", df$canakkale)
q[1]
for(i in 1:697){
  df[i,2] = q[i]
}

q<- gsub(",", ".", df$...3)
q[1]
for(i in 1:697){
  df[i,3] = q[i]
}

q<- gsub(",", ".", df$...4)
q[1]
for(i in 1:697){
  df[i,4] = q[i]
}

q<- gsub(",", ".", df$...5)
q[1]
for(i in 1:697){
  df[i,5] = q[i]
}

q<- gsub(",", ".", df$...6)
q[1]
for(i in 1:697){
  df[i,6] = q[i]
}

q<- gsub(",", ".", df$...7)
q[1]
for(i in 1:697){
  df[i,7] = q[i]
}


q<- gsub(",", ".", df$...8)
q[1]
for(i in 1:697){
  df[i,8] = q[i]
}


df$canakkale <- as.double(df$canakkale)
df$...3 <- as.double(df$...3)
df$...4 <- as.double(df$...4)
df$...5 <- as.double(df$...5)
df$...6 <- as.double(df$...6)
df$...7 <- as.double(df$...7)
df$...8 <- as.double(df$...8)


havaK <- data.frame("Tarih"=df$Tarih,
                    "PM10(µg/m3)"=df$canakkale,
                    "PM 2.5(µg/m3)"=df$...3,
                    "SO2(µg/m3)"=df$...4,
                    "NO2(µg/m3)"=df$...5,
                    "NOX(µg/m3)"=df$...6,
                    "NO(µg/m3)"=df$...7,
                    "O3(µg/m3)"=df$...8)



## Egzersiz 2 - Veri Kalite Kontrolü

### Zaman sütunu
#Zaman değerlerini içeren sütunun isminin **Time** olmasını sağlayın
#```{r}
#  <kodu tamamla>
#```
havaK <- data.frame("Time"=df$Tarih,
                    "PM10(µg/m3)"=df$canakkale,
                    "PM 2.5(µg/m3)"=df$...3,
                    "SO2(µg/m3)"=df$...4,
                    "NO2(µg/m3)"=df$...5,
                    "NOX(µg/m3)"=df$...6,
                    "NO(µg/m3)"=df$...7,
                    "O3(µg/m3)"=df$...8)


#*havaK$Time* adlı değişkendeki bütün verilerin **POSIXct** tipinde olmasını sağlayın. 

#```{r}
# <kodu tamamla>
#```
havaK$Time <- as.POSIXct(havaK$Time)

#*Time* sütunu dışındaki bütün sütunların tipinin **numeric** olmasını sağlayın. *havaK* nesnesinin ilk 10 satırının raporda gözükmesini sağlayın.
head(havaK,10)
#```{r}
# <kodu tamamla>
#```

## Egzersiz 3 - Veri Görselleme
#*dygraphs* paketini kullanarak veri setinizde bulunan iki farklı parametreyi aynı grafik üzerinde iki değişik aks kullanarak (bkz örnek) çizin.

#![](graphic_example.png "İki akslı grafik örneği")


#```{r}
library(dygraphs)
visual <- data.frame("deger"=c(1:697),
                     "3"=df$...3,
                     "4"=df$...4)
visual$X3 <- sort(visual$X3)
visual$X4 <- sort(visual$X4)


# Çizgi grafiğini çiz
dygraph(visual, main = "İki Ayrı Deger Cizimi") %>%
  dySeries("X3", label = "Deger1") %>%
  dySeries("X4", label = "Deger2")
library(DBI)

con <- dbConnect(RSQLite::SQLite(),dbname = ":memory:")
#yukarı da ki komut sayesinde library RSQLite yapmadan DBI paketini kurduğumuzda otomatik geliyor.

con; class(con)
dbListTables(con)
dbWriteTable(con, "mtcars",mtcars)
?mtcars
View(mtcars)
df <- dbReadTable(con,"mtcars")
class(df)

res <- dbSendQuery(con, "SELECT * FROM mtcars WHERE cyl=4")
res
class(res)
dbFetch(res)

dbClearResult(res)
while(!dbHasCompleted(res)){
  chunk <- dbFetch(res,n=5)
  print(nrow(chunk))
}
dbDisconnect(con)  
con

 
