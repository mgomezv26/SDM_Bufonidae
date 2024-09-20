library(rgbif)

# Definir directorio de trabajo
setwd("")


# Hay que establecer las credenciales de la cuenta de GBIF en el archivo .Renviron

install.packages("usethis")
usethis::edit_r_environ()

#Se debe copiar lo siguiente en el archivo que se abre al ejecutar lo anterior, una vez modificado deberá reiniciarse r:
#GBIF_USER="my_user"
#GBIF_PWD="password"
#GBIF_EMAIL="email"

# Función para obtener el taxon key de una familia
get_family_key <- function(family_name) {
  backbone <- name_backbone(family_name)
  if (!is.null(backbone)) {
    return(backbone$usageKey)
  } else {
    return(NULL)
  }
}

# Obtener los taxon keys de las familias
Bufonidae_key <- sapply('Bufonidae', get_family_key)
Bufonidae_key

# realizar la consulta a la api
gbif_download <- occ_download(
  pred("occurrenceStatus", "PRESENT"), 
  pred("taxonKey", 6727),
  format = "SIMPLE_CSV")

occ_download_wait(gbif_download)

Bufonidae <- occ_download_get(gbif_download) %>%
  occ_download_import()

################################################################################
####     PREPROCESADO PREVIO PARA SELECCIONAR AREA DE INTERES EN QGIS       ####
################################################################################


# Seleccionar campos de interes

fields <- c("gbifID", "family", "genus", "species", "infraspecificEpithet", 
            "taxonRank", "scientificName",
            "countryCode", "locality", "stateProvince", 
            "decimalLatitude",	"decimalLongitude", "coordinatePrecision",
            "eventDate", "day", "month", "year", 
            "occurrenceStatus", "basisOfRecord", "recordedBy", "issue")

Bufonidae <- Bufonidae[ , fields, with = FALSE]

# Conocer el numero de registros iniciales
num_filas_iniciales <- nrow(Bufonidae)
num_filas_iniciales #1544071


# Eliminar filas donde decimalLatitude o decimalLongitude es igual a cero
Bufonidae <- Bufonidae[Bufonidae$decimalLatitude != 0 & Bufonidae$decimalLongitude != 0, ]

# Filtrar filas donde decimalLatitude es diferente de decimalLongitude
Bufonidae <- Bufonidae[Bufonidae$decimalLatitude != Bufonidae$decimalLongitude, ]

# Conocer el número de registros tras eliminar coordenadas incorrectas
num_filas_coord_limpias <- nrow(Bufonidae)
num_filas_coord_limpias #1543831

#Diferencia del numero de filas
dif_filas = num_filas_iniciales - num_filas_coord_limpias
dif_filas #240

#Exportar el dataframe en formato CSV y RData

write.csv(Bufonidae, "Bufonidae.csv", row.names = FALSE)
save(Bufonidae, file = "BufonidaeRData")
