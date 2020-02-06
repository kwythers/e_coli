library(tidyverse)
library(ggplot2)
library(fiftystater)
library(editData)

##### editing text files
# write.csv(e_coli, '~/R_code/e_coli/e_coli_cases.csv')

# load e_coli_cases with 'Import Dataset', use base text

data("fifty_states") 

rownames(e_coli_outbreak) <- c('California','Texas','Florida','New York','Illinois',
                            'Pennsylvania','Ohio','Georgia','North Carolina',
                            'Michigan','New Jersey','Virginia','Washington','Arizona',
                            'Massachusetts','Tennessee','Indiana','Missouri','Maryland',
                            'Wisconsin','Colorado','Minnesota','South Carolina','Alabama',
                            'Louisiana','Kentucky','Oregon','Oklahoma','Connecticut',
                            'Iowa','Utah','Mississippi','Arkansas','Nevada',
                            'Kansas','New Mexico','Nebraska','West Virginia','Idaho','Hawaii',
                            'New Hampshire','Maine','Rhode Island','Montana','Delaware',
                            'South Dakota','North Dakota','Alaska',
                            'Vermont','Wyoming')
# e_coli_outbreak$state <- tolower(e_coli_outbreak$state)
e_coli <- e_coli_cases

#december$statelower <- tolower(december$state)

# map_id creates the aesthetic mapping to the state name column in your dat
p <- ggplot(e_coli_cases, aes(map_id = state)) + 
  # map points to the fifty_states shape data
  geom_map(aes(fill = Scaled_cases), map = fifty_states) + 
  scale_fill_gradient2(low = '#559999', mid = 'grey90', high = '#BB650B',
                      midpoint = median(e_coli$Scaled_cases)) +
  expand_limits(x = fifty_states$long, y = fifty_states$lat) +
  coord_map() +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(title = 'E. coli O157:H7 by state of residence,\nas of May 1, 2018 (n=121)', 
       subtitle = 'source: https://www.cdc.gov/ecoli/2018/o157h7-04-18/map.html', 
       x = "", y = "", fill = 'Cases \nper million \nresidents') +
  theme(legend.position = 'left', 
        panel.background = element_blank())

p
# add border boxes to AK/HI
p + fifty_states_inset_boxes() 
