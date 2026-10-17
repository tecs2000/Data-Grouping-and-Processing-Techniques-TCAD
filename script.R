
# read dataset
setwd("~/Documents/Uni/Masters/TCAD/Trab")
data = read.csv("star_classification.csv", sep=",", dec=".", header=T)

#proof rerun_ID only has one value (301 appears 100000 times)
rerun_IDS = table(data$rerun_ID)
#rerun_IDS

#remove unnecessary columns
# obj_ID, spec_obj_ID, etc. -> just nominal IDs with no data value
# rerun_ID -> always has the same value
# MJD may need to be removed too, it should offer no useful data for predictions
data <- subset(data, select = -c(obj_ID, rerun_ID, spec_obj_ID, run_ID, field_ID, plate, fiber_ID))

#remove class with the least members
classes = table(data$class)
classes
data <- subset(data, (class != "QSO"))
data$class <- droplevels(as.factor(data$class))


#cam_col only has 6 values and doesn't make sense to keep it numerical
data$cam_col <- as.factor(data$cam_col)

#change redshift to be categorical
#ignore if the celestial object is approaching or not since that will leave the 
#data inbalanced (expansion of the universe)
data$redshift <- cut(data$redshift, 
                     breaks = quantile(data$redshift, probs = c(0, 0.33, 0.66, 1)), 
                     labels = c("Slow", "Moderate", "Fast"), 
                     include.lowest = TRUE)
table(data$redshift) # check distribution




