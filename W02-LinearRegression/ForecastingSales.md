#### FORECASTING ELANTRA SALES (Notes)

An important application of linear regression is understanding sales. Consider a company that produces and sells a product. In a given period, if the company produces more units than how many consumers will buy, the company will not earn money on the unsold units and will incur additional costs due to having to store those units in inventory before they can be sold. If it produces fewer units than how many consumers will buy, the company will earn less than it potentially could have earned. Being able to predict consumer sales, therefore, is of first order importance to the company.

In this problem, we will try to predict monthly sales of the Hyundai Elantra in the United States. The Hyundai Motor Company is a major automobile manufacturer based in South Korea. The Elantra is a car model that has been produced by Hyundai since 1990 and is sold all over the world, including the United States. We will build a linear regression model to predict monthly sales using economic indicators of the United States as well as Google search queries.

The file elantra.csv contains data for the problem. Each observation is a month, from January 2010 to February 2014. For each month, we have the following variables:

- Month = the month of the year for the observation (1 = January, 2 = February, 3 = March, ...).
- Year = the year of the observation.
- ElantraSales = the number of units of the Hyundai Elantra sold in the United States in the given month.
- Unemployment = the estimated unemployment percentage in the United States in the given month.
- Queries = a (normalized) approximation of the number of Google searches for "hyundai elantra" in the given month.
- CPI_energy = the monthly consumer price index (CPI) for energy for the given month.
- CPI_all = the consumer price index (CPI) for all products for the given month; this is a measure of the magnitude of the prices paid by consumer households for goods and services (e.g., food, clothing, electricity, etc.).
