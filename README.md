# SDM_Bufonidae

Este repositorio contiene todo el código desarrollado para la realización del Trabajo Fin de Master (TFM) del Máster en Data Science y Business Analytics impartido por IFM. 

EL objetivo principal de este proyecto es analizar los patrones de distribución de especies europeas de la Familia Bufonidae (Gray, 1825) en Europa. A partir de este objetivo se pretende seleccionar 3 especies para las cuales se desarrollarán modelos de distribución de especies (SDM), mediante Random Forest,comparando la probabilidad de presencia en tres escenarios temporales diferentes a nivel europeo:

1. Escenario presente. Probabilidad de presencia actual (año 2010).
2. Escenario a futuro RCP_2_6. Proyección para el año 2050 con bajas emisiones y desarrollo sostenible.
3. Escenario a futuro RCP_8_5. Proyección para el año 2050 con altas emisiones y desarrollo no sostenible.

Para la realización de los SDM se tienen en cuenta variables bioclimaticas descargadas desde el portal *Climatologies at High resolution for the Earth's Land Surface Areas* (CHELSA). También se tienen en cuenta datos de disponibilidad de habitat obtenidos desde el portal de GLOBIO.
Los datos de ocurrencias de especies se han descargado desde *Global Biodiversity Information Facility* (GBIF), mediante el script de R *00_Download_GBIF.r*.

Todo el procesamieto, depuración y desarrollo del algoritmo se ha realizado mediante programación en Python. En este repositorio se encuentran todos los Jupyter Notebook desarrollados durante este proyecto.

Para **acceder a los datos utilizados** en cada script, es necesario acceder al siguiente enlace, descargar y descomprimir la carpeta "Data". https://drive.google.com/file/d/1zJ1mmGZGsKcD-xp0wV1YUJ524g06T2Aj/view?usp=drive_link
