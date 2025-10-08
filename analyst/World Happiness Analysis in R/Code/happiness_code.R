getwd()
setwd('/Users/admin/Documents/Project/Data') #paste your path 
install.packages("ggcorrplot")
install.packages('fuzzyjoin')
install.packages('hrbrthemes')
library('ggplot2')
library('tidyverse')
library('dplyr')
library('plotly')
library('ggcorrplot')
library('stringr')
library('fuzzyjoin')
install.packages("heatmaply")
install.packages('zoo')
library('heatmaply')
library('hrbrthemes')
library('zoo')


happiness_2015 <- read.csv('2015.csv')
happiness_2016 <- read.csv('2016.csv')
happiness_2017 <- read.csv('2017.csv')
happiness_2018 <- read.csv('2018.csv')
happiness_2019 <- read.csv('2019.csv')
country_data <- read.csv('Country.csv')

happiness_2015$Year <- 2015
happiness_2016$Year <- 2016
happiness_2017$Year <- 2017
happiness_2018$Year <- 2018
happiness_2019$Year <- 2019

#happiness_2015 <- happiness_2015 %>% select(-c(year))

#joined_15_16 <- left_join(happiness_2015, happiness_2016, by= 'Country'
#                        ,suffix = c(".2015", ".2016"))

#Important and overlapping variables for creating main df-
#Happiness.score, Economy /GDP per capita, Family, Health, Freedom, 
#Trust, Generosity, Dystopia_residual
#Common between all the years- 
#Happiness score, Economy/GDP, Health/healthy life expectancy, Freedom, 
#Generosity, Trust/corruption, Family/Social support 


#2015
df_2015_filtered <- happiness_2015 %>%
  select (Country , Region, Happiness.Rank, Happiness.Score,
          Economy..GDP.per.Capita.,Health..Life.Expectancy.,
          Freedom, Trust..Government.Corruption., Family, Year )

df_2015_filtered <- rename_with(df_2015_filtered, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

df_2015_filtered <- df_2015_filtered %>% rename(economy_or_gdp = economy__gdp_per_capita_,
                                                health = health__life_expectancy_,
                                                perception_of_govt_corruption= trust__government_corruption_,
                                                family_or_social_support = family
                                                )



#2016
df_2016_filtered <- happiness_2016 %>%
  select (Country , Region, Happiness.Rank, Happiness.Score,
          Economy..GDP.per.Capita.,Health..Life.Expectancy.,
          Freedom, Trust..Government.Corruption.,Family, Year )

df_2016_filtered <- rename_with(df_2016_filtered, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

df_2016_filtered <- df_2016_filtered %>% rename(economy_or_gdp = economy__gdp_per_capita_,
                                                health = health__life_expectancy_,
                                                perception_of_govt_corruption= trust__government_corruption_,
                                                family_or_social_support = family
)

#2017

df_2017_filtered <- happiness_2017 %>%
  select (Country , Happiness.Rank, Happiness.Score,
          Economy..GDP.per.Capita.,Health..Life.Expectancy.,
          Freedom, Trust..Government.Corruption.,Family, Year)

#region missing in the 2017 table 
df_2017_filtered <- rename_with(df_2017_filtered, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

df_2017_filtered <- df_2017_filtered %>% rename(economy_or_gdp = economy__gdp_per_capita_,
                                                health = health__life_expectancy_,
                                                perception_of_govt_corruption= trust__government_corruption_,
                                                family_or_social_support = family
)


#adding the region for the 2017 data
#Using regex inner join instead of inner join to help with partial string match and reduce data loss
# For example the Country Cyprus has the name as 'Cyprus' for a few years and 'North Cyprus' for few years 

df_2017_filtered <- df_2017_filtered %>% regex_inner_join(select(df_2015_filtered , country, region),  by=c(country = "country")) 
df_2017_filtered <- select(df_2017_filtered, -country.y) %>% rename(country= country.x)

#validating and checking for null values
colSums(is.na(df_2017_filtered))



#2018

df_2018_filtered <- happiness_2018 %>%
  select (Country.or.region , Overall.rank, Score,
          GDP.per.capita,Healthy.life.expectancy, Freedom.to.make.life.choices
          , Perceptions.of.corruption, Social.support, Year)

df_2018_filtered <- rename_with(df_2018_filtered, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

df_2018_filtered <- df_2018_filtered %>% rename(country = country_or_region,economy_or_gdp = gdp_per_capita,
                                                health = healthy_life_expectancy,
                                                perception_of_govt_corruption= perceptions_of_corruption ,
                                                family_or_social_support = social_support, happiness_score = score ,
                                                happiness_rank = overall_rank, freedom = freedom_to_make_life_choices
                                                )

#adding region to 2018 data by joining on country 

#df_2018_filtered <- df_2018_filtered %>% fuzzy_inner_join(select(df_2015_filtered , country, region),  by= "country", match_fun = str_detect)
df_2018_filtered <- df_2018_filtered %>% regex_inner_join(select(df_2015_filtered , country, region),  by=c(country = "country")) 
df_2018_filtered <- select(df_2018_filtered, -country.y) %>% rename(country= country.x)



#2019

df_2019_filtered <- happiness_2019 %>%
  select (Country.or.region , Overall.rank, Score,
          GDP.per.capita,Healthy.life.expectancy, Freedom.to.make.life.choices
          , Perceptions.of.corruption, Social.support, Year)

df_2019_filtered <- rename_with(df_2019_filtered, ~ tolower(gsub(".", "_", .x, fixed = TRUE)))

df_2019_filtered <- df_2019_filtered %>% rename(country = country_or_region,economy_or_gdp = gdp_per_capita,
                                                health = healthy_life_expectancy,
                                                perception_of_govt_corruption= perceptions_of_corruption ,
                                                family_or_social_support = social_support, happiness_score = score ,
                                                happiness_rank = overall_rank, freedom = freedom_to_make_life_choices
)

#df_2019_filtered <- df_2019_filtered %>% left_join(select(df_2015_filtered , country, region),  by= "country")
df_2019_filtered <- df_2019_filtered %>% regex_inner_join(select(df_2015_filtered , country, region),  by=c(country = "country")) 
df_2019_filtered <- select(df_2019_filtered, -country.y) %>% rename(country= country.x)


#Combining the data for all the years using union all 
df_15_16 <- union_all(df_2015_filtered, df_2016_filtered)
df_15_16_17 <- union_all(df_15_16,df_2017_filtered)


df_2018_filtered$perception_of_govt_corruption <- as.double(df_2018_filtered$perception_of_govt_corruption) 


df_15_16_17_18 <- union_all(df_15_16_17, df_2018_filtered)
df_final <- union_all(df_15_16_17_18, df_2019_filtered)

#removing the temporary tables created for union all
remove(df_15_16)
remove(df_15_16_17)
remove(df_15_16_17_18)

#checking for NA values in the final data after merging data from all the data sources 
colSums(is.na(df_final))


#Finding the records with NA values 

NA_df <- df_final[rowSums(is.na(df_final)) > 0,]

#There is an NA value for perception of govt_corruption for United Arab emirates
#validating the replaced values and checking for NAs
colSums(is.na(df_final))

NA_df <- df_final[rowSums(is.na(df_final)) > 0,]
# ---- Ensure output folder ----
if (!dir.exists("visuals")) dir.create("visuals")

# ---- Fix UAE NA properly (keep numeric scale) ----
# If the column is character, make it numeric safely
if (!is.numeric(df_final$perception_of_govt_corruption)) {
  suppressWarnings({
    df_final$perception_of_govt_corruption <- as.numeric(df_final$perception_of_govt_corruption)
  })
}
u_vals <- df_final %>% dplyr::filter(country == "United Arab Emirates") %>% dplyr::pull(perception_of_govt_corruption)
u_mean <- mean(u_vals, na.rm = TRUE)
df_final <- df_final %>%
  dplyr::mutate(perception_of_govt_corruption = ifelse(
    is.na(perception_of_govt_corruption) & country == "United Arab Emirates",
    u_mean, perception_of_govt_corruption
  ))

# ---- REGIONAL BOXPLOT (save) ----
p_box <- ggplot(df_final, aes(x = region, y = happiness_score)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  labs(title="Happiness by Region", x=NULL, y="Happiness score") +
  theme_minimal()
ggsave("visuals/box_plot_regional.png", p_box, width = 11, height = 7, dpi = 300)

# ---- CORRELATION HEATMAP (2019) ----
df_2019 <- df_final %>% dplyr::filter(Year == 2019)
corr_df <- df_2019 %>%
  dplyr::select(happiness_score, economy_or_gdp, health, family_or_social_support,
                freedom, perception_of_govt_corruption) %>%
  tidyr::drop_na()
corr <- round(cor(corr_df), 2)

# ggcorrplot
p_corr <- ggcorrplot::ggcorrplot(
  corr, hc.order = TRUE, type = "lower", lab = TRUE,
  outline.col = "white", lab_size = 3
) + ggtitle("Correlation of Happiness Factors (2019)")
ggsave("visuals/heatmap_factors.png", p_corr, width = 9, height = 7, dpi = 300)

# ---- FACTOR CONTRIBUTION (2019 snapshot) ----
means_2019 <- df_2019 %>%
  dplyr::summarise(
    GDP = mean(economy_or_gdp, na.rm=TRUE),
    Social = mean(family_or_social_support, na.rm=TRUE),
    Health = mean(health, na.rm=TRUE),
    Freedom = mean(freedom, na.rm=TRUE),
    Corruption = mean(perception_of_govt_corruption, na.rm=TRUE)
  ) %>% tidyr::pivot_longer(everything(), names_to="factor", values_to="mean")

# Bar (README-friendly)
p_fac_bar <- ggplot(means_2019, aes(x = reorder(factor, mean), y = mean, fill = factor)) +
  geom_col() + coord_flip() +
  labs(title="Average Factor Levels Across Countries (2019)", x=NULL, y="Mean (scaled units)") +
  theme_minimal() + theme(legend.position = "none")
ggsave("visuals/global_factor_contribution_bar.png", p_fac_bar, width = 8, height = 5, dpi = 300)

# Pie (distinct colors)
pie_cols <- scales::hue_pal()(nrow(means_2019))
png("visuals/global_factor_contribution_pie_colored.png", width=1600, height=1600, res=300)
pie(means_2019$mean, labels = paste0(means_2019$factor, " (", scales::percent(means_2019$mean/sum(means_2019$mean)),")"),
    col = pie_cols, main = "Average Contribution of Factors to Happiness (2019)")
dev.off()

# ---- GDP vs HAPPINESS SCATTER (2019) ----
p_scatter <- ggplot(df_2019, aes(economy_or_gdp, happiness_score, color = region)) +
  geom_point(alpha = 0.75) +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Relationship Between GDP and Happiness (2019)",
       x = "GDP per capita (scaled)", y = "Happiness score") +
  theme_minimal()
ggsave("visuals/gdp_vs_happiness_scatter.png", p_scatter, width = 7, height = 5, dpi = 300)

# ---- TOP 5 COUNTRIES FACTOR BREAKDOWN ----
top5_2019 <- df_2019 %>% dplyr::arrange(happiness_rank) %>% dplyr::slice_head(n = 5)
top5_long <- top5_2019 %>%
  dplyr::select(country, economy_or_gdp, health, family_or_social_support, freedom) %>%
  tidyr::pivot_longer(-country, names_to = "factor", values_to = "value")

p_top5 <- ggplot(top5_long, aes(x = country, y = value, fill = factor)) +
  geom_col(position = "stack") +
  labs(title="Top 5 Countries: Factor Breakdown (2019)", x=NULL, y="Scaled value") +
  theme_minimal()
ggsave("visuals/top5_countries_factors_breakdown.png", p_top5, width = 9, height = 6, dpi = 300)

# ---- INCOME GROUP vs HAPPINESS (bar) ----
df_country <- df_final %>%
  dplyr::inner_join(country_data %>% dplyr::select(ShortName, IncomeGroup),
                    by = c("country" = "ShortName"))

p_income <- df_country %>%
  dplyr::filter(Year == 2019) %>%
  dplyr::group_by(IncomeGroup) %>%
  dplyr::summarise(avg_happiness = mean(happiness_score, na.rm=TRUE), .groups="drop") %>%
  ggplot(aes(IncomeGroup, avg_happiness, fill = IncomeGroup)) +
  geom_col() + theme_minimal() +
  labs(title = "Average Happiness by Income Group (2019)", x=NULL, y="Average happiness")
ggsave("visuals/income_difference.png", p_income, width = 8, height = 5, dpi = 300)

# ---- TOP COUNTRIES LINE PLOT (save) ----
countries_top_5 <- df_final %>% dplyr::filter(happiness_rank %in% 1:5)
p_lines <- ggplot(countries_top_5, aes(x = factor(Year), y = happiness_score, colour = country, group = country)) +
  geom_line() + geom_point() +
  ggtitle("Happiness score over the years (Top 5 ranks)") +
  labs(x=NULL, y="Happiness score") + theme_minimal()
ggsave("visuals/line_plot.png", p_lines, width = 9, height = 5, dpi = 300)


#boxplot for checking the happiness levels in different regions 
ggplot(data = df_final, aes(x = region, y = happiness_score)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato")

#ggplot(data = df_final, aes(x = country, y = happiness_score)) +
#  geom_boxplot(alpha = 0) +
# geom_jitter(alpha = 0.3, color = "tomato")

p <- df_final %>%
 # filter(year==1977) %>%
  ggplot( aes(happiness_score, health, size = freedom, color=region)) +
  geom_point() +
  theme_bw()

#Which country is the happiest in the world?
#Checking the happiest countries over the all the years based on the happiness score
top_country_list <- df_final %>% 
  group_by(country) %>% 
  summarise(happiness_score= sum(happiness_score)) %>%
  arrange(desc(happiness_score)) %>% slice(1:10) 

head(top_country_list,5)


#How did the happiest country result vary over the years?
countries_rank_1 <- df_final %>% dplyr::filter(happiness_rank == 1) %>% select(country, Year, happiness_score)

head(countries_rank_1, 5,)


#Was there any country with a significant hike in happiness over the years?
countries_top_5 <- df_final %>% dplyr::filter(happiness_rank == 1 |
                                                 happiness_rank == 2 |
                                                 happiness_rank == 3 |
                                                 happiness_rank == 4 |
                                                 happiness_rank == 5) 
#select(country, year, happiness_score)
#Checking the variation of scpres over the years for the top 5 countries in all years
ggplot(countries_top_5, aes(x = factor(year), y = happiness_score, colour = country, group = country)) +
  geom_line() +
  ggtitle("Happiness score over the years")

#
#Refer the correlation plot

correlation_df <- df_final %>% select(happiness_score, economy_or_gdp,health
                                      ,freedom, perception_of_govt_corruption,
                                      family_or_social_support)

#checking for NAs in the correlation plot 
NA_df_corr <- correlation_df[rowSums(is.na(correlation_df)) > 0,]

corr <- round(cor(correlation_df), 1)
head(corr[, 1:6])

corr



#What were the significant factors influencing happiness? Was there any relation between these factors already? 
#economy_or_gdp is the most contributing factor towards the happiness score with a 
# correlation coefficient of 0.8 followed by health and social_support/family
# with a coefficient of 0.7 


#How were the external factors around people impacting their happiness?
#economy and health seem to have a very strong correlation amongst them 


#8 Countries with higher income tend to be more happier than the countries with 
#lower income

df_country <- df_final %>% inner_join(select(country_data , ShortName, IncomeGroup),  by= c("country"="ShortName"))

colSums(is.na(df_country))

q<-ggplot(df_country, aes(x=IncomeGroup, y=happiness_score, fill=IncomeGroup)) +
  geom_bar(stat="identity")+theme_minimal()
q<- q + scale_fill_grey()
q


countries_top_5 %>% group_by(country) %>%
  summarise(n=n(),
            economy_avg = mean(economy_or_gdp),
            health_avg = mean(health),
            family_avg = mean(family_or_social_support),
            freedom_avg = mean(freedom),) %>% 
  gather("key", "happiness_score", - c(country, n)) %>%
  ggplot(aes(x = country, y = happiness_score , group = key, fill = key)) + geom_col()
