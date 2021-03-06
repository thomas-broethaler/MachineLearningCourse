setwd("/data/projects/windturbine-identification/MachineLearningCourse")

source("scripts/windturbines/functions.R")

SOURCE<-"GOOGLE"
#SOURCE<-"SENTINEL"
RESOLUTIONS<-c(13,14,15,16,17,18,19)


url_source<-function(x,y,z,SOURCE){

  url<-""
  
  x<-format(x,scientific=FALSE)
  y<-format(y,scientific=FALSE)
  
  if(SOURCE=="GOOGLE"){
    url<-paste0("http://mt0.google.com/vt/lyrs=s&hl=en&x=",x,"&y=",y,"&z=",z,"")
    
    
  }
  
  
  if(SOURCE=="BASEMAP"){
    url<-paste0("https://maps2.wien.gv.at/basemap/bmaporthofoto30cm/normal/google3857/",z,"/",y,"/",x,".jpeg")
    
  }
  
  if(SOURCE=="MAPBOX"){
    url<-paste0("http://a.tiles.mapbox.com/v4/mapbox.satellite/",z,"/",x,"/",y,".jpg?access_token=pk.eyJ1Ijoiam9waCIsImEiOiJjanZnNXF0YXUwNDlkNDNvYzZnbXUzNnp6In0.RimB9gchYB7XlfyB5ACvXA")
  }
  
  if(SOURCE=="SENTINEL"){
  
    url<-paste0("https://c.s2maps-tiles.eu/wmts/?layer=s2cloudless&style=default&tilematrixset=WGS84&Service=WMTS&Request=GetTile&Version=1.0.0&Format=image%2Fjpeg&TileMatrix=",z,"&TileCol=",x,"&TileRow=",y)
    
  }
  
  return(url)
  
  
}



COUNTRY_LIST<-c("EG", "MA", "ZA", "CN", "IN", "JP", "KP", "PK", "PH", "TH", "CR", "TR", 
                "AT", "BE", "BG", "HR", "DK", "FI", "FR", "DE", "GR", "IE", "IT", "LT", 
                "NL", "NO", "PL", "PT", "RO", "ES", "SE", "GB", "UA", "CA", "MX", "US", "AU", "NZ", "BR", "CL", "UY", "MIX", "GLOBAL")


all_params<-list()

for(RESOLUTION in RESOLUTIONS){
for(COUNTRY in COUNTRY_LIST){
  FILTER_WINDTURBINES_KW<-0
  
  PATH_EXPERIMENT<-
    paste0(SOURCE,
           "/RESOLUTION",
           RESOLUTION,
           "/",
           COUNTRY,
           "/")
  
  PATH_TURBINE_LOCATIONS<-paste0(
    "data/turbineLocations",
    "/",
    COUNTRY,"/")
  
  FILE_TURBINE_LOCATIONS<-paste0(
    PATH_TURBINE_LOCATIONS,
    "windturbineLocations.csv")
  
  
  
  PATH_RAW_IMAGES_TURBINES<-paste0("data/aerialImages/",
                                   PATH_EXPERIMENT,
                                   "raw/Turbines/")
  
  PATH_RAW_IMAGES_NOTURBINES<-paste0("data/aerialImages/",
                                     PATH_EXPERIMENT,
                                     "raw/NoTurbines/")
  
  PATH_RAW_IMAGES_TURBINES_MACHINE_CLASSIFIED<-paste0("data/aerialImages/",
                                                      PATH_EXPERIMENT,
                                                      "classified/Turbines/")
  
  PATH_RAW_IMAGES_NOTURBINES_MACHINE_CLASSIFIED<-paste0("data/aerialImages/",
                                                        PATH_EXPERIMENT,
                                                        "classified/NoTurbines/")
  
  PATH_RAW_IMAGES_ASSESSMENT<-paste0("data/aerialImages/",
                                     PATH_EXPERIMENT,
                                     "assessment/")
  
  #PATH_RAW_IMAGES_ASSESSMENT_TURBINES<-paste0("data/aerialImages/",
  #                                   PATH_EXPERIMENT,
  #                                   "assessment/turbines/")
  
  
  
  PATH_WINDPARK_LOCATIONS<-paste0(
    "data/windParks",
    "/",
    COUNTRY,"/")
  
  
  
  PATH_TEMP<-"data/temp/"
  
  
  PATH_LOCAL_TEMP<-"/media/ramdisk/"
    #"temp/"
  #"
  
  
  PATH_QUALITYCHECK<-paste0(
    "qualityCheck/",
    PATH_EXPERIMENT)
  
  FILE_QUALITY_CHECK<-paste0(
    "qualityCheck/",
    PATH_EXPERIMENT,
    "qualityCheck.csv")
  
  PATH_ML_IMAGES_TRAIN<-paste0("data/aerialImages/",
                                        PATH_EXPERIMENT,
                                        "keras_/train/")
  
  PATH_ML_IMAGES_TEST<-paste0("data/aerialImages/",
                               PATH_EXPERIMENT,
                               "keras_/test/")

  
  PATH_ML_IMAGES_TURBINES_TRAIN<-paste0("data/aerialImages/",
                                        PATH_EXPERIMENT,
                                        "keras/train/Turbines/")
  
  PATH_ML_IMAGES_TURBINES_VALIDATION<-paste0("data/aerialImages/",
                                             PATH_EXPERIMENT,
                                             "keras/validation/Turbines/")
  
  
  PATH_ML_IMAGES_TURBINES_TEST<-paste0("data/aerialImages/",
                                       PATH_EXPERIMENT,
                                       "keras/test/Turbines/")
  
  
  PATH_ML_IMAGES_NOTURBINES_TRAIN<-paste0("data/aerialImages/",
                                          PATH_EXPERIMENT,
                                          "keras/train/NoTurbines/")
  
  PATH_ML_IMAGES_NOTURBINES_VALIDATION<-paste0("data/aerialImages/",
                                               PATH_EXPERIMENT,
                                               "keras/validation/NoTurbines/")
  
  
  PATH_ML_IMAGES_NOTURBINES_TEST<-paste0("data/aerialImages/",
                                         PATH_EXPERIMENT,
                                         "keras/test/NoTurbines/")
  
  PATH_ML_IMAGES_TYPE_SMALL_TRAIN<-paste0("data/aerialImages/",
                                         PATH_EXPERIMENT,
                                         "type_keras/train/Small/")
  
  
  PATH_ML_IMAGES_TYPE_MIDDLE_TRAIN<-paste0("data/aerialImages/",
                                           PATH_EXPERIMENT,
                                           "type_keras/train/Middle/")
  
  
  PATH_ML_IMAGES_TYPE_LARGE_TRAIN<-paste0("data/aerialImages/",
                                           PATH_EXPERIMENT,
                                           "type_keras/train/Large/")
  
  PATH_ML_IMAGES_TYPE_SMALL_TEST<-paste0("data/aerialImages/",
                                          PATH_EXPERIMENT,
                                          "type_keras/test/Small/")
  
  
  PATH_ML_IMAGES_TYPE_MIDDLE_TEST<-paste0("data/aerialImages/",
                                           PATH_EXPERIMENT,
                                           "type_keras/test/Middle/")
  
  
  PATH_ML_IMAGES_TYPE_LARGE_TEST<-paste0("data/aerialImages/",
                                          PATH_EXPERIMENT,
                                          "type_keras/test/Large/")
  
  
  PATH_ML_IMAGES_TYPE_SMALL_VALIDATION<-paste0("data/aerialImages/",
                                          PATH_EXPERIMENT,
                                          "type_keras/validation/Small/")
  
  
  PATH_ML_IMAGES_TYPE_MIDDLE_VALIDATION<-paste0("data/aerialImages/",
                                           PATH_EXPERIMENT,
                                           "type_keras/validation/Middle/")
  
  
  PATH_ML_IMAGES_TYPE_LARGE_VALIDATION<-paste0("data/aerialImages/",
                                          PATH_EXPERIMENT,
                                          "type_keras/validation/Large/")
  

  PATH_ML_IMAGES_TYPE_REGRESSION_TRAIN<-paste0("data/aerialImages/",
                                                    PATH_EXPERIMENT,
                                                    "type_keras_regression/train/")
  
  
  PATH_ML_IMAGES_TYPE_REGRESSION_TEST<-paste0("data/aerialImages/",
                                                    PATH_EXPERIMENT,
                                                    "type_keras_regression/test/")
  
  
  PATH_ML_IMAGES_TYPE_REGRESSION_VALIDATION<-paste0("data/aerialImages/",
                                               PATH_EXPERIMENT,
                                               "type_keras_regression/validation/")
  
  
  

  
  
  
  PATH_OSM<-paste0("data/osm/",COUNTRY)
  
  PATH_RAW_IMAGES_OSM<-paste0("data/aerialImages/",
                                     PATH_EXPERIMENT,
                                     "osm/")
  
  FILE_OSM_TURBINE_LOCATIONS<-paste0(
    PATH_OSM,
    "/windturbines.csv")
  
  
  
  
  dir.create("config",showWarnings = FALSE)
  
  
  
  params<-data.frame(SOURCE,
                     RESOLUTION,
                     COUNTRY,
                     PATH_EXPERIMENT,
                     FILTER_WINDTURBINES_KW)
  
  paths<-data.frame(
    PATH_TURBINE_LOCATIONS,
    PATH_RAW_IMAGES_TURBINES,
    PATH_RAW_IMAGES_NOTURBINES,
    PATH_WINDPARK_LOCATIONS,
    PATH_TEMP,
    PATH_LOCAL_TEMP,
    PATH_ML_IMAGES_TURBINES_TRAIN,
    PATH_ML_IMAGES_TURBINES_VALIDATION,
    PATH_ML_IMAGES_TURBINES_TEST,
    PATH_ML_IMAGES_NOTURBINES_TRAIN,
    PATH_ML_IMAGES_NOTURBINES_VALIDATION,
    PATH_ML_IMAGES_NOTURBINES_TEST,
    PATH_QUALITYCHECK,
    PATH_RAW_IMAGES_TURBINES_MACHINE_CLASSIFIED,
    PATH_RAW_IMAGES_NOTURBINES_MACHINE_CLASSIFIED,
    PATH_RAW_IMAGES_ASSESSMENT,
    PATH_OSM,
    PATH_RAW_IMAGES_OSM,
    PATH_ML_IMAGES_TYPE_SMALL_TRAIN,
    PATH_ML_IMAGES_TYPE_MIDDLE_TRAIN,
    PATH_ML_IMAGES_TYPE_LARGE_TRAIN,
    PATH_ML_IMAGES_TYPE_SMALL_TEST,
    PATH_ML_IMAGES_TYPE_MIDDLE_TEST,
    PATH_ML_IMAGES_TYPE_LARGE_TEST,
    PATH_ML_IMAGES_TYPE_SMALL_VALIDATION,
    PATH_ML_IMAGES_TYPE_MIDDLE_VALIDATION,
    PATH_ML_IMAGES_TYPE_LARGE_VALIDATION,
    PATH_ML_IMAGES_TYPE_REGRESSION_TRAIN,
    PATH_ML_IMAGES_TYPE_REGRESSION_TEST,
    PATH_ML_IMAGES_TYPE_REGRESSION_VALIDATION,
    PATH_ML_IMAGES_TRAIN,
    PATH_ML_IMAGES_TEST
    #,
    #PATH_RAW_IMAGES_ASSESSMENT_TURBINES
  )
  
  
  sapply(unlist(paths),
         function(x){
           print(as.character(x))
           dir.create(as.character(x),showWarnings=FALSE,recursive = TRUE)})
  
  
  files<-data.frame(FILE_QUALITY_CHECK,
                    FILE_TURBINE_LOCATIONS,
                    FILE_OSM_TURBINE_LOCATIONS)
  
  
  ####write config files
  params<-data.frame(params,
                     paths,
                     files)
  
  write_csv(params,paste0("config/params",COUNTRY,RESOLUTION,".csv"))
  all_params[[COUNTRY]][[RESOLUTION]]<-params
}
}
CURRENT_COUNTRY<-"BR"
