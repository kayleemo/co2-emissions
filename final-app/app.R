# Load necessary libraries
library(shiny)
library(tidyverse)




#Load and clean data
emissions <- read_csv("data/CO2_emission.csv") %>% 
  drop_na() #There are 32 countries with missing data, dropping any country with NA

#Cleaning data to keep only the necessary columns (Country name, region, and years 1990-2019)
emissions <- emissions[, -35] #Dropping last column because of duplicate 2019 columns
emissions <- emissions[, -2] #Dropping "country_code" column
emissions <- emissions[, -3] #Dropping "Indicator Name" column

#Cleaning column names
colnames(emissions)[32]  <- "2019" #Renaming last column to "2019"
colnames(emissions)[1]  <- "country_name" #Renaming name column to "country_name"
emissions$mean <-apply(emissions[, 3:32],1,mean) #Adding a mean column for mean CO2 emissions of each country from 1990-2019


# unique region names
region_names <- unique(emissions$Region) #Getting all unique regions in Emissions data
  # 7 total regions in the data

# unique country names
country_names <- unique(emissions$country_name) #Getting all unique countries in Emissions data
  # 183 total countries used 




# UI (Setting up layout of website)
ui <- fluidPage(
  #Set title of entire website
  titlePanel("CO2 Emissions Per Capita"), 
  
  # First tab on website - Comparing CO2 emissions across regions
  tabsetPanel(
    tabPanel("World View", #Set title of first tab
             br(), 
             br(),
             br(), 
             br(),
             plotOutput("world"), #Inputting static graph "world"
             br(),
             br(), 
             #Below inputs helper paragraph for the tab to understand graph shown
             fluidPage(column(4, #Setting grid width of column for text
                              "The graph above compares the mean CO2 emissions per capita of regions in the world.
                              As we can see, North America and the Middle East & North Africa regions have the 
                              highest mean CO2 emissions per capita.",
                              offset = 4))), #Offsetting text column by 4 columns

    #Second tab on website - Comparing CO2 emissions of countries within a specific region
    tabPanel("Regional View", #Set title of second tab
             br(),
             #Creating dropdown menu to choose region to display
             selectInput("regions", #Title of dropdown menu 
                         label = "Choose a region to display", #Text displayed in dropdown menu
                         choices = region_names, #Choices in dropdown menu are from unique list of regions
                         selected = "North America"), #Automatic selection is North America
             br(),
             plotOutput("region"), #Inputting dynamic graph "region"
             br(),
             br(),
             #Below inputs helper paragraph for the tab to understand graph shown
             fluidPage(column(4, 
                              "The graph above visualizes the mean CO2 emissions per capita for each country in the region 
                              you select. From the drop box above, click on one of the seven regions to compare the
                              CO2 emissions of countries in that region!",
                              offset = 4))), 
    
    #Third tab on website - Comparing one country's CO2 emissions from 1990-2019
    tabPanel("Country View", #Set title of third tab
             br(),
             #Creating dropdown menu to choose region to display
             selectInput("countries", #Title of dropdown menu
                         label = "Choose a country to display", #Text displayed in dropdown menu
                         choices = country_names, #Choices of dropdown menu are from unique list of countries
                         selected = "United States"), #Automatic selection is United States
             br(),
             plotOutput("country"), #Inputting dynamic graph "country"
             br(),
             br(),
             #Below inputs helper paragraph for the tab to understand graph shown
             fluidPage(column(4, 
                              "The graph above visualizes a country's CO2 emissions per capita from 1990-2019.
                              Choose any country from the many in the dropbox above and see how a specific 
                              country's CO2 emissions change over time!",
                              offset = 4))),
    
    # Last tab - Text to provide insights into the data and what the graphs communicate
    tabPanel("Additional Information", #Title of last tab
             br(),
             br(),
             br(),
             fluidPage(column(10,
                              "Because this dataset included so much data, including 200 countries, CO2 emissions per capita for each country 
                              from 1990-2019, as well as the region each country is in, I wanted to develop 3 graphics that would start from a over-arching
                              and 'wide' view and work itself in to become more 'narrow' and specific.",
                              offset = 1)),
             br(),
             fluidPage(column(10,
                             "The first graphic that is displayed is the 'World View' map. This visualization is a great initial
                              insight into the dataset, as it is easy to compare the emissions of the regions included in the dataset. 
                              You can easily identify the regions that are top emitters (North America and Middle East & North Africa), and those 
                              that are the lowest (South Asia and Sub-Saharan Africa).",
                              offset = 1)),
            br(),
            fluidPage(column(10,
                             "The next graphic is the next tab under 'Regional View'. This graphic goes from the world view to more specific, by 
                              visualizing a specific region. I animated this graph as rather than displaying 7 different graphs on one tab, the
                              user can choose any region that they want to display at a time. This visualization is similar to the 'World View' map, 
                              but dives into the next 'level', which is 'regional'. The visualization compares the CO2 emissions 
                              for each country in a region, which the user chooses. Thus, the user can identify the top emitting and lowest emitting
                              countries for each region. For instance, if an individual were to wonder who the top emitter for the Middle East & North Africa
                              was (because that region had high CO2 emissions), they could see that Qatar was the highest emitting country for that region.",
                             offset = 1)),
            br(),
            fluidPage(column(10,
                             "The last graph is under the tab 'Country View'. This allows for the 'narrowest' and most specific graph. This visualization
                              allows a user to choose from any of the 200 countries included in this dataset and see how it's CO2 emissions have changed
                              from 1990 to 2019. For instance, if the individual was curious about Qatar's emissions throughout the years, they could choose
                              the country in the dropbox and see that Qatar's emissions peaked between 1990 and 2003 and have decreased since. To use the
                              dataset to its full potential, it was necessary to animate this graph so that any of the 200 countries have the option to be visualized.",
                             offset = 1)))))
                              
                        


# Server (Creating the graphs to be called above)
server <- function(input, output) {
 
# Creating graph for 1st tab - Comparing CO2 emissions across regions
  output$world <- renderPlot({ 
    
    #South Asia
    #Creating a subset table for each region
    SA_region <- emissions %>% 
      filter(Region == "South Asia") 
    #Calculating the mean CO2 emissions of each region 
    SA_mean <- mean(SA_region$mean)
    
    #Sub-Saharan Africa
    SSA_region <- emissions %>% 
      filter(Region == "Sub-Saharan Africa") 
    SSA_mean <- mean(SSA_region$mean)
    
    #Europe & Central Asia
    ECA_region <- emissions %>% 
      filter(Region == "Europe & Central Asia") 
    ECA_mean <- mean(ECA_region$mean)
    
    #Middle East & North Africa
    MENA_region <- emissions %>% 
      filter(Region == "Middle East & North Africa") 
    MENA_mean <- mean(MENA_region$mean)
    
    #Latin America & Caribbean
    LAC_region <- emissions %>% 
      filter(Region == "Latin America & Caribbean") 
    LAC_mean <- mean(LAC_region$mean)
    
    #East Asia & Pacific
    EAP_region <- emissions %>% 
      filter(Region == "East Asia & Pacific") 
    EAP_mean <- mean(EAP_region$mean)
    
    #North America
    NA_region <- emissions %>% 
      filter(Region == "North America") 
    NA_mean <- mean(NA_region$mean)
    
    #Creating a list of values for means of regions calculated
    region_means <- c(SA_mean, SSA_mean, ECA_mean, MENA_mean, 
                      LAC_mean, EAP_mean, NA_mean)
    
    #Creating a data table to include only region names and the mean of that region
    df1 <- data.frame(region_names, region_means)
    
    #Creating a static graph from df1
    ggplot(df1, aes(x = regions, y = region_means)) +
      geom_col(fill = "#008080") + #Bar graph with blue fill
      scale_y_continuous(labels = scales::label_number(prefix = "", suffix = " metric tons")) + #Adding labels to y-axis
      scale_x_discrete(labels = scales::wrap_format(10)) + #Wrapping x-axis text to avoid overlapping of country names
      theme_minimal() + 
      labs(x = "Regions", y = "Mean CO2 Emissions Per Capita", #Adding axes titles
           title = "Mean CO2 Emissions Per Capita Per Region", #Adding title of graph
           subtitle = " ", #Adding space between title and graph
           caption = "Source: Ghosh, Koustav. “CO2 Emissions around the World.”") + #Adding source of data
      theme(axis.text.x = element_text(size = 10), #Setting text sizes and placements for all elements of graph
            axis.text.y = element_text(size = 10),
            axis.title = element_text(size = 15),
            plot.caption = element_text(size = 10),
            plot.title = element_text(hjust = 0.5, size = 20),
            plot.background = element_rect(colour = "grey70", linewidth = 2),
            plot.margin = margin(20, 10, 20, 10),
            panel.grid.major.x = element_blank()) #Removing x-axis lines
  })
  
  
# Creating graph for 2nd tab - Comparing CO2 emissions of countries within a specific region
  output$region <- renderPlot({
    
    #Creating a subset table to only include region chosen in dropdown menu
    reg <- emissions %>% 
      filter(Region == input$regions) 
    
    #Creating a graph from subset table
    ggplot(reg, aes(x = country_name, y = mean)) + 
      geom_col(fill = "#AF7AC5") + #Making a bar graph filled in a purple color
      scale_x_discrete(labels = scales::wrap_format(5)) + #Wrapping x-axis text to avoid overlapping of country names
      scale_y_continuous(expand = c(0,NA),
                         labels = scales::label_number(prefix = "", suffix = " metric tons")) + #Adding labels to y-axis
      theme_minimal() + 
      labs(x = "Country", y = "Mean CO2 Emissions Per Capita", #Adding axes titles
           title = "Mean CO2 Emissions Per Capita Per Country", #Adding title of graph
           subtitle = input$regions, #Adding dynamic subtitle to display what region is being shown
           caption = "Source: Ghosh, Koustav. “CO2 Emissions around the World.”") + #Adding source of data
      theme(axis.text.x = element_text(size = 5), #Setting text sizes and placements for all elements of graph
            axis.text.y = element_text(size = 10),
            plot.caption = element_text(size = 10),
            axis.title = element_text(size = 12),
            plot.title = element_text(hjust = 0.5, size = 20),
            plot.subtitle = element_text(hjust = 0.5, size = 18),
            plot.background = element_rect(colour = "grey70", linewidth = 2),
            plot.margin = margin(20, 10, 20, 10),
            panel.grid.major.x = element_blank()) #Removing x axis lines
    })
  
   
# Creating graph for 3rd tab - Comparing one country's CO2 emissions from 1990-2019
  output$country <- renderPlot({
    without_mean <- emissions[, -2] #Dropping region column
    without_mean <- without_mean[, -32] #Dropping mean column
  
    #Creating a pivoted table with years in a column rather than as rows
    country_data <- without_mean %>% 
        pivot_longer(cols = !country_name,
                 names_to = "year",
                 values_to = "emissions")
    
    #Creating a subset table to only include country chosen in dropdown menu
    random <-country_data %>% 
        filter(country_name == input$countries) 
  
    #Creating graph from subset table
    ggplot(random, aes(year, emissions, group = 1)) + 
      geom_line() + #This graph is a line graph
      scale_y_continuous(limits = c(0, NA), #All countries with lower bound of 0 on y-axis to create easy comparisons
                        labels = scales::label_number(prefix = "", suffix = " metric tons")) + #Adding labels to y-axis
      theme_minimal() +
      labs(x = "Year", y = "CO2 Emissions Per Capita", #Adding axes titles
           title = "CO2 Emissions Per Capita From 1990-2019", #Adding title of graph
           subtitle = input$countries, #Adding dynamic subtitle to display what country is being shown
           caption = "Source: Ghosh, Koustav. “CO2 Emissions around the World.”") + #Adding source of data
      theme(axis.text.x = element_text(size = 10), #Setting text sizes and placements for all elements of graph
          axis.title = element_text(size = 13),
          plot.caption = element_text(size = 10),
          plot.title = element_text(hjust = 0.5, size = 20),
          plot.subtitle = element_text(hjust = 0.5, size = 18),
          plot.background = element_rect(colour = "grey70", linewidth = 2),
          plot.margin = margin(20, 10, 20, 10))
  })

}


# Run the application 
shinyApp(ui = ui, server = server)
