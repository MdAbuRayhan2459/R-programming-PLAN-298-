library(datasets)
mtcars
library(ggplot2)
library(ggthemes)
ggplot(mtcars,aes(x=mpg,y=hp,alpha = 1,stroke=1))+geom_point(color="brown")+labs(title ="mpg vs hp of mtcars")+theme_light()+facet_wrap(~cyl)+geom_smooth()+theme(axis.text.x = 
                                                                                                                                     element_text(face="bold", angle = 0, color= 
                                                                                                                                                    "black", hjust = 1))+theme(axis.text.y = 
                                                                                                                                                                                 element_text(face="bold.italic", angle = 20, 
                                                                                                                                                                                              size= 8, color= "black", hjust = 1))






