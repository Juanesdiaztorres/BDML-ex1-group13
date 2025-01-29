"

                                       Impute 1 - Missing values that are not missing values
                                       -----------------------------------------------------
                    
Instrucciones: The team should split the work to do the following task: Impute missing values to variable y_salary_m 
using two methods from this notebook and implement them in the dedicated scripts impute1.R and impute2.R.
"


"
---------------------------
Alistar ambiente de trabajo:
---------------------------
"
cat("\014")
rm(list = ls())

if(!require(pacman)) install.packages("pacman") ; require(pacman)

#Cargar paquetes:
#---------------
p_load(rio, # import/export data
       tidyverse, # tidy-data
       skimr, # summary data
       visdat, # visualizing missing data
       corrplot, # Correlation Plots 
       stargazer) # tables/output to TEX. 


#Cargar datos: 
#------------

df <- import("https://github.com/ignaciomsarmiento/datasets/blob/main/GEIH_sample1.Rds?raw=true")
db <- as_tibble(df) ## from dataframe to tibble
rm(df)


"
---------------------------------------------------
Visualizar Missing Values de la variable y_salary_m:
---------------------------------------------------
"
#i) Se seleccionan algunas variables para visualizar los missing values: 
db<- db %>% select( directorio, secuencia_p, orden, estrato1, sex, age, ocu, oficio, orden, totalHoursWorked,
                    dsi, ie , formal, informal, sizeFirm , regSalud, maxEducLevel, ingtot,
                    ingtotes,ingtotob, y_salary_m, y_total_m)

#ii) Visualizar los valores para cada variable que si son o no son Missing values: 
vis_miss(db)


"
------------------------------------------------------------------
Impute Missing values - Missing values that are not missing values:
------------------------------------------------------------------

La lógica detras del procedimiento es que si las personas estan desocupasdas y por ende desempleadas no devengan un salario. Por lo tanto, 
su ganancias salariales son cero. 

*Nota: la varible paso de 2286 NA A 634 
"

db  <- db %>% 
        select(ocu, y_salary_m) %>% 
        mutate(y_salary_m = ifelse(test = (ocu == 0 & is.na(y_salary_m) == T) == T, yes = 0, no = y_salary_m))
# Include here your code for your first chosen imputation method
