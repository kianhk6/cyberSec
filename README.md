1. **Data Exploration and Preparation**:
   - **Goal**: Understand basic data characteristics, such as trends, seasonality, and feature correlation.
   - **Data**: The Household Electricity Consumption Dataset, a multivariate time series describing power consumption behavior over time.
   - **Variables**: Global_active_power, Global_reactive_power, Voltage, Global_intensity, Submetering 1, Submetering 2, Submetering 3.

2. **Task 1: Detect Point Anomalies**:
   - **Method**: Use statistical methods for anomaly detection, specifically focusing on Z-scores.
   - **Steps**:
     - Apply linear interpolation to fill in missing (NA) values for each feature in the dataset.
     - Calculate the Z-score for each data point in each feature.
     - Identify point anomalies as data points where the Z-score is more than 3 standard deviations away from the mean.
     - Calculate the percentage of data points considered anomalies for each feature and the entire dataset.
   - **Output**: Insight into the proportion of data behaving unusually.

3. **Task 2: Correlation Analysis**:
   - **Method**: Compute Pearson’s sample correlation coefficient for each pair of the variables.
   - **Steps**:
     - Use the `cor()` function in R to calculate Pearson's correlation.
     - Represent results in a correlation matrix, using color-coding to indicate statistical significance.

4. **Task 3: Power Consumption Pattern Analysis**:
   - **Method**: Focus on Global_intensity to determine typical power consumption patterns during day and night hours.
   - **Steps**:
     - Determine representative time windows for day and night hours.
     - Compute the average Global_intensity value for each data point in these time windows over weekdays and weekends.
     - Perform linear and polynomial regression for each of the four time windows.
     - Represent the results graphically to illustrate Global_intensity behavior.

5. **Submission**:
   - Create a PDF describing your solutions.
   - Submit both the PDF and R code through the course page by end of day on February 18, 2024.

