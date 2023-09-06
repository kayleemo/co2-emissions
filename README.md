# CO2 Emissions Per Capita

## Background
We have all grown up hearing about climate change and the dangers it imposes on our society. Politicians continue to argue whether climate change exists and/or is a pressing issue, yet, the negative impacts of climate change are now getting harder to ignore. Growing up in Oregon, I saw the impacts climate change had on my state, including extreme wildfires that were once rare that now occur every summer and is the norm. I believe it is more important now than ever that we, as a society, learn about climate change and the tragic effects. I wanted to explore the issue on a global level, and that started with analysis on CO2 emissions for countries and regions across the world. 

## Data Source
I used a data source from Kaggle called CO2 Emissions Around the World. The data included 215 countries as well as the region they were in. The data also included CO2 emissions per capita for each year from 1990-2019. CO2 emissions were measured by metric tons per capita.

The link to the Kaggle dataset is here: <https://www.kaggle.com/datasets/koustavghosh149/co2-emission-around-the-world>

## Project
My project is published here: <https://kayleemo.shinyapps.io/final-app/>

Feel free to click around the tabs and play around with the interactive graphs.

My code for the project is here: <https://github.com/kayleemo/co2-emissions/blob/main/final-app/app.R>

## Findings
For this analysis, I looked at CO2 emissions from a world view, to a regional view, and to a country view. I wanted to develop 3 different graphics that would start from an over-arching and "wide" view and work itself in to become more "narrow" and specific to a country. 

The first graphic that is displayed is the 'World View' map. This visualization is a great initial insight into the dataset, as it is easy to compare the emissions of the regions included in the dataset. You can easily identify the regions that are top emitters (North America and Middle East & North Africa), and those that are the lowest (South Asia and Sub-Saharan Africa).

The next graphic is the next tab under 'Regional View'. This graphic goes from the world view to more specific, by visualizing a specific region. I animated this graph as rather than displaying 7 different graphs on one tab, the user can choose any region that they want to display at a time. This visualization is similar to the 'World View' map, but dives into the next 'level', which is 'regional'. The visualization compares the CO2 emissions for each country in a region, which the user chooses. Thus, the user can identify the top emitting and lowest emitting countries for each region. For instance, if an individual were to wonder who the top emitter for the Middle East & North Africa was (because that region had high CO2 emissions), they could see that Qatar was the highest emitting country for that region.

The last graph is under the tab 'Country View'. This allows for the 'narrowest' and most specific graph. This visualization allows a user to choose from any of the 183 countries used in this dataset and see how it's CO2 emissions have changed from 1990 to 2019. For instance, if the individual was curious about Qatar's emissions throughout the years, they could choose the country in the dropbox and see that Qatar's emissions peaked between 1990 and 2003 and have decreased since. To use the dataset to its full potential, it was necessary to animate this graph so that any of the 183 countries had the option to be visualized.
