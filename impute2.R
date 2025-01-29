"

                                       Impute 2 - Mean/Median
                                       ----------------------
                    
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


#Imputar los valores usando el método de Impute1.R: (para conseguir la mayor información posible)
#-------------------------------------------------
db  <- db %>% 
  select(ocu, y_salary_m) %>% 
  mutate(y_salary_m = ifelse(test = (ocu == 0 & is.na(y_salary_m) == T) == T, yes = 0, no = y_salary_m))

"
--------------------------------------------------
Visualizar Missing Values de la variable y_salary_m:
---------------------------------------------------
"

#i) Ver la distribución de la variable para ver si es mejor usar la media o la mediana


ggplot(db, aes(y_salary_m)) +
  geom_histogram(color = "#000000", fill = "#0099F8") +
  geom_vline(xintercept = median(db$ingtot, na.rm = TRUE), linetype = "dashed", color = "red") +
  geom_vline(xintercept = mean(db$ingtot, na.rm = TRUE), linetype = "dashed", color = "blue") +  
  ggtitle(" Distribución salario") +
  theme_classic() +
  theme(plot.title = element_text(size = 18))

#La distribución tiene una gran cola izquierda con mucha masa y una cola derecha muy larga. Para que los valores 
#extremos no afecten el valor se decide usar la mediana 



"
------------------------------------------------------------------
Impute Missing values - Mean/Median:
------------------------------------------------------------------
"

db <- db  %>%
  mutate(y_salary_m = ifelse(is.na(y_salary_m) == TRUE, median(db$y_salary_m, na.rm = TRUE) , ingtot))

# Include your code here for you second imputation method
