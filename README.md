# DataWarehousing with MSBI <img src="logo.png" align="right" style="width: 25%;"/>
Demo of data warehousing solutions with MSBI, by utilizing SSIS, SSAS, and SSRS for multiple business projects.

## Setup
1. Clone this repo to your local system with following command:
  `git clone git@github.com:berserkhmdvhb/DWH_MSBI.git`

3. Install SQL Server, SSMS, Visual Studio (VS). For VS, install extensions SSIS, SSRS, SSAS.
4. Setup three SQL Server instances, for three environments: dev, uat, prod. I called the instances the following names:
SQL011P, SQL011U, SQL011D.
5. Add the aliases prod, uat, and dev for each server respecitvely. Follow steps in DBAdmin images in directory [Init](https://github.com/berserkhmdvhb/DWH_MSBI/tree/main/Projects/CustomerData/source/Scripts/DB/Init)

6. Create the data warehouse (DWH) database named `CustomerDWH` in SSMS and follow the steps to create the required objects therein:
   - Create [schemas](https://github.com/berserkhmdvhb/DWH_MSBI/blob/main/Projects/CustomerData/source/Scripts/DB/Init/SchemasCreation.sql)
   - Create [stored procedures (SPs)](https://github.com/berserkhmdvhb/DWH_MSBI/tree/main/Projects/CustomerData/source/Scripts/DB/SP) 
   - Create tables using [CREATE scrips](https://github.com/berserkhmdvhb/DWH_MSBI/tree/main/Projects/CustomerData/source/Scripts/DB/Tables/CREATE) and populate them using [LOAD scripts](https://github.com/berserkhmdvhb/DWH_MSBI/tree/main/Projects/CustomerData/source/Scripts/DB/Tables/LOAD)
   - Create [views](https://github.com/berserkhmdvhb/DWH_MSBI/tree/main/Projects/CustomerData/source/Scripts/DB/Views)
  
7. Create an "Integration Services Catalog".

8. Ideally, i'm still reseaerching to make this solution reproducible and whether docker and MSBI can be integrated. Notwishtanding, If you want to test running solution's packages on Visual Studio before deploying on SSMS server, then adjust the project parameters and connection managers. if you prefer to deploy and test there, adjusting environment variables on server should suffice.
