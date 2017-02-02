#avoid scientific notation
options(scipen=999)
#read data and clean the Area codes
a <-read.csv("Stranieri_per_sesso_e_et_.csv")

# clean the data. Sometimes the area district code is abbreviated, sometimes is not...
a$Provincia[a$Provincia == "LC"] <- "LECCO"
a$Provincia[a$Provincia == "BS"] <- "BRESCIA"
a$Provincia[a$Provincia == "SO"] <- "SONDRIO"
a$Provincia[a$Provincia == "CR"] <- "CREMONA"
a$Provincia[a$Provincia == "MI"] <- "MILANO"
a$Provincia[a$Provincia == "VA"] <- "VARESE"
a$Provincia[a$Provincia == "BG"] <- "BERGAMO"
a$Provincia[a$Provincia == "MN"] <- "MANTOVA"
a$Provincia[a$Provincia == "LO"] <- "LODI"
a$Provincia[a$Provincia == "MB"] <- "MONZA E DELLA BRIANZA"
a$Provincia[a$Provincia == "PV"] <- "PAVIA"
a$Provincia[a$Provincia == "CO"] <- "COMO"