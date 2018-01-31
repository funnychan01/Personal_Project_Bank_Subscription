# Personal_Project_Bank_Subscription

## Background of this project
The data is about direct marketing campaigns (phone calls) of a Portuguese banking institution from May 2008 to November 2010. The clients were contacted more than once in order to access if the product (bank term deposit) would be ('yes') or not ('no') subscribed. 

## The goal of this project:
* to classify and predict whether the client will subscribe (yes/no) a term deposit
* to improve the stragegy for the next market campaign
* to draw business insights from the data

## Variable description:
### Bank client data:
* Age (numeric)
* JobType : type of job
* Marital : marital status
* Education
* CreditDefault: has credit in default? ("yes","no")
* AvgYearlyBbalance: average yearly balance, in euros 
* HousingLoan: has housing loan? ("yes","no")
* PersonalLoan: has personal loan? "yes","no")

### Related with the last contact of the current campaign:
* ContactType: contact communication type
* Day: last contact day of the month
* Month: last contact month of year
* Duration: last contact duration, in seconds (numeric)

### Other variables:
* NumOfContacts: number of contacts performed during this campaign and for this client
* PassedDays: number of days that passed by after the client was last contacted from a previous campaign (-1 means client was not previously contacted)
* Previous: number of contacts performed before this campaign and for this client 
* PreviousOutcome: outcome of the previous marketing campaign

### Output variable (desired target):
* Subscription - has the client subscribed a term deposit? ("yes","no")
