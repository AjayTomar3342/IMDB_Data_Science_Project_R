# IMDB Data Science Project-Python
Data Science project based on IMDB Data for Data Analysis and Prediction(Movie Score) using Python. 

A personal project made for practising and learning Data Analysis and Data Science Techniques. 


### Requirements to run and test the project:

To run this project, you will need Python3+, pip and Git installed on the system. 

The reference links are provided below.

> **Python:**
  https://www.python.org/downloads/
  
> **pip:**
  https://pypi.org/project/pip/

> **Git:**
  https://git-scm.com/downloads
	
The necessary libraries and packages are specified in the **requirements.txt** file and will be validated in the below steps


## Process for acquiring the results: 

  * **Step 1:**
  Create a local directory in your machine where you want to pull the git project and clone the project by running the below command from cmd 
  (Make sure that you are in the newly created directory first!):
  
  	```git clone https://github.com/AjayTomar3342/IMDB_Data_Science_Project_Python```

  * **Step 2:**
  From cmd, move into the main folder of the cloned project
  
 	 ```cd IMDB_Data_Science_Project_Python```

  * **Step 3:**
  Execute the below commands to meet the pre-requisites to execute the code
  
  ```  	
      Unix/macOS
      python -m pip install -r requirements.txt

      Windows
      py -m pip install -r requirements.txt
  ```

  
  * **Step 4:**
  Execute the below commands to run the code from cmd
  
  ``` 
      Unix/macOS
      python main.py

      Windows
      %run main.py
  ```
  
  
## Alternative Process for acquiring the results(Backup):

For quick running of program, PyCharm use is suggested as it has good controls for removing manual steps to pull a repository and get it running.

Steps are:

  * **Step 1:**
  Make sure one is signed in on Github in Pycharm
  
  * **Step 2:**
  Open a new project
  
  * **Step 3:**
  Go to VCS Option on the Top Horizontal Options Bar
  
  * **Step 4:**
  Select Enable Version Control Integration Control inside VCS if not done already
  
  * **Step 5:**
  After checking the previous option on, select Checkout from Version Control and select Git
  
  * **Step 6:**
  In the new pop up window, include the link of the github repository you are trying to pull.
  Subsequently in the same pop up window, select an appropriate directory where the  project will be pulled.
  
  * **Step 7:**
  Select clone option to start the pulling process.
  
  * **Step 8:**
  Select option to start the pulled project in New Window or This window as per your personal preference.
  
  * **Step 9:**
  After this the project will be up and running and requirements.txt file will automatically install required libraries. Run the file main.py from Root Folder to get the results

This is a quick process to start the testing of GitHub project taken from the Official Jet Brains Website. We have tried this with several PC’s and are confident that this will not give any errors.

> **Link to Above Process Video:**
  https://www.youtube.com/watch?v=ukbvdF5wqPQ&feature=emb_title
  
  
  **NOTE:** 
Since, the libraries used in the project are updated by the original developers regularly, some function/functions may not run as expected. This project will be regularly updated as per the updated libraries requirement, but if project does not run at any give time when you pull the project, it may be due to the library change, rather than a coding issue. 

## Procedure followed in the Project:

   * **Step 1:**
   Data Scraping using Beautiful Soup using Genre Based Movie Links of IMDB. Scraping results are appended   	into Pre-cleaned-file.csv for further processing. 
   
   * **Step 2:**
   Data Cleaning is followed then as the data scraped is pretty dirty and needs to be molded into a suitable 	form for Data Analysis. This step takes in Pre-cleaned-file.csv and produces a cleaner Python-cleaned-	    file.csv for Data Analysis. 
  
   * **Step 3:**
   Taking in Python-cleaned-file.csv, data is analysed on basis of various parameters(mentioned in the 	        Results section below). Using matplotlib, the analysis results are analysed too. Data Visualization is 	    also done using a Visualization Tool(Power BI) which is done using IMDB_Data_Power_BI_file.pbix.
   
   * **Step 4:**
   In the last step, various regression models such as Multiple Linear Regression, Lasso Regression,         	K-Nearest Neighbor and Random Forest Regression. These models are tested upon parameters like R2 Score,      Mean Squared Error and Model Score to evaluate model performance. 

  **NOTE:** 
All csv files mentioned in the above steps are present in the Data_Files folder. Power BI file is present in the Root Folder. 

## Results:

Results are present in two forms: Analysis Results(Graphical) and Regression Results(Numerical). 

### Analysis Results: 

Cleaned Data is analyzed on the following parameters: 

1. Movie title proportion as per Starting Character.
2. Decade Wise Movie Count.
3. Most successful Primary Actor with at least 30 movies. 
4. Most successful Supporting Actor with at least 15 movies.
5. Most successful Directors with at least 20 movies.
6. Most successful Secondary Supporting Actor with at least 10 movies.
7. Movie proportion according to different genres.
8. User votes by consecutive years in the last century.
9. Average runtime of movies year wise in the last century.
10. Year Wise count of movies. 
11. Genre Popularity over the last century.

All these analysis are done using both Python and Power BI. Some of the visuals are shown below: 

<img src="Results/Visual_Result_1.PNG"> 
<img src="Results/Visual_Result_2.PNG"> 
<img src="Results/Visual_Result_3.PNG"> 

Above visuals are taken from Power BI Visualization tool which provides better clarity when compared to Python's Matplotlib library.

### Regression Results:

Metric Scores for Models | Multiple Linear Regression | Lasso Regression | K-Nearest Neighbor | Random Forest Regression
---                      | --- | --- | --- | ---
R2 Score                 | 44.7 | 45.3 | 43.4 | 69.6
Mean Squared Error	 | 60 | 59.3 | 61.4 | 32.9
Model Score 		 | 44.2 | 44.7 | 52.7 | 95.7

These scores are calculated on the basis of usage of Python's scikit-learn library. 

To explain the Metrics and their relevance here, the metrics are explained below:

a.) R2 Score/Coefficient of Determination:  Means the % of variation of dependent variable which can be explained by independent variable. More the merrier. 

b.) Mean Squared Error(MSE): MSE measures the average of error squares i.e the average squared difference between the estimated values and true value. Less the better. 

c.) Model Score: Comparing the model predicted values to the actual values which we got by test data. More the number of matching values, the better

  **NOTE:** 
Please note that these figures and visuals have been taken on 27/8/2021. These may differ from the ones you get once you run this project again as data is scraped again and the whole procedure provides similar yet different results.  




