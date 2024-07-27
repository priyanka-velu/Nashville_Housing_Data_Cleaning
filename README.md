# SQL Data Cleaning: Nashville Housing

## Project Overview

This project involves cleaning the Nashville Housing Dataset using Microsoft SQL Server Management Studio (SSMS). The goal is to ensure the data is standardized, accurate, and ready for analysis by performing various data cleaning tasks, including standardizing date formats, populating missing property addresses, breaking up addresses into individual columns, and removing duplicates.

## Resources

1. **Data Source**:
   - [NashvilleHousing.xlsx](NashvilleHousing.xlsx)

2. **Software**:
   - Microsoft SQL Server Management Studio

## Project Highlights

### 1. Data Transformation and Cleaning
- **Standardization**: Successfully standardized date formats and address fields, ensuring consistent and accurate data.
- **Imputation**: Employed advanced SQL techniques like self-joins and CASE WHEN statements to fill in missing values and convert binary fields to more readable formats.
- **Deduplication**: Utilized Common Table Expressions (CTEs) to identify and remove duplicate records, enhancing data quality.

### 2. Data Usability and Organization
- **Splitting Address Fields**: Broke down combined address fields into individual components (street, city, state, zip code) for better granularity and usability in analyses.
- **Logical Field Transformation**: Converted binary 'Y' and 'N' values to 'Yes' and 'No', making the dataset more user-friendly and easier to interpret.

## Data Cleaning Steps

### 1. Standardize Data Format
- **Code 1**: Shows original SaleDate column with a data-time format. We want to solely have the date.
  ![Example 3](https://github.com/user-attachments/assets/55142b84-dd2f-4a56-b33b-f0fd2b2cae48)
- **Code 2**: Select the SaleDate column. Create another column that converts the SaleDate column into a date format.
  ![Example 2](https://github.com/user-attachments/assets/59cdcc5a-022b-4560-8a9f-fce36678ae5b)
- **Code 3**: The Update function did not convert the original SaleDate column into a date format. The date-time format is still observed.
  ![Example 1](https://github.com/user-attachments/assets/2a2cdc92-6f01-452f-a372-88c167fb73da)
- **Code 4**: Added a column by altering the table, naming the newly added column SaleDateConverted. Used the Update function to include the date format of the Saledate column. Successfully obtained the date format. 
  ![Standardize Data Format](https://github.com/user-attachments/assets/70aed479-35ef-4553-b222-2f7254adc784)
- **Challenge**: The date format in the dataset cannot be converted directly.
- **Solution**: Added a new column and updated it with standardized date values.

### 2. Populate Property Address Data
- **Code 1**: Check WHERE PropertyAddress is NULL. We observe that there is missing data and we need to populate these cells with accurate information.
  ![Example 2](https://github.com/user-attachments/assets/832ae0a8-0988-493f-916c-9cbacd960c1f)
- **Code 2**: We notice that the ParcelID matches the property address. We can use the same ParcelID to populate property addresses that are NULL. However, we need to ensure that the UniqueIDs are different. Let's perform a self-join to join on ParcelID and ensure that the UniqueID is not equal to one another. An ISNULL function checks to see if the first value is NULL. If it is, it populates it with the second value. The new column is created.
  ![Example 1](https://github.com/user-attachments/assets/88f3904c-cd76-4d8e-b7d4-c085bcb7f4d7)
- **Code 3**: Update the first table by setting the PropertyAddress to the ISNULL function, populating the NULL values with the property addresses. 
  ![Populate Property Address](https://github.com/user-attachments/assets/40eb9586-1b08-468f-8151-3ed5ac8a0d26)
- **Methods**: Used a self-join to populate missing PropertyAddress values based on matching ParcelID. Checked for NULL PropertyAddress and populated it using another record with the same ParcelID. Ensured unique IDs were different.

### 3. Break Up Addresses into Individual Columns
- **Code 1**: Shows the current PropertyAddress syntax and we notice that the address and city are seperated by a comma, which can be used in a SUBSTRING function.
  ![Example 2](https://github.com/user-attachments/assets/45ce36ac-2ca7-48d4-bd62-6b598bd726a2)
- **Code 2**: Seperate PropertyAddress with SUBSTRING based using a character index on each comma. Observed that the result successfully split the address from the city
  ![Example 1](https://github.com/user-attachments/assets/c0e2c0f5-5d55-4af7-b649-f47c8c37f446)
- **Code 3**: Add a column called PropertySplitAddress and update it with the address SUBSTRING
  ![Break Up Addresses](https://github.com/user-attachments/assets/f5f03439-52a9-4452-b5e3-729a5126dce0)
- **Code 4**: Add a column called PropertySplitCity and update it with the city SUBSTRING
  ![Example 3](https://github.com/user-attachments/assets/02ff0535-441d-43b9-b2f4-34ebb855aa09)
- **Methods**: Split combined address fields into separate columns for street, city, state, and zip code.

### 4. Separate with PARSENAME OwnerAddress
- **Code 1**: We notice that PARSENAME did not parse through OwnerAddress since the functions parses using periods. Therfore, we need to replace the comma with a period to use the PARSENAME function.
  ![Example 2](https://github.com/user-attachments/assets/38406856-2fc2-4e79-b40f-c464c4e853c5)
- **Code 2**: We use the REPLACE function to replace the comma with a period and PARSENAME the result. We do this 3 times since there are 2 commas, seperating the result into 3 columns. We notice that the columns occur in reverse order. Let's fix this. 
  ![Example 1](https://github.com/user-attachments/assets/03dace5a-92ba-4064-bc7d-688d57a98d35)
- **Code 3**: Change the order of each PARSENAME in the opposite order so that the address is shown in the correct order. 
  ![Example 3](https://github.com/user-attachments/assets/8f207551-f5f6-43c0-a918-edece542787e)
- **Code 4**: Add the columns OwnerSplitAddress, OwnerSplitCity, and OwnerSplitState. Then, UPDATE the table and SET each column with the correct PARSENAME function. 
  ![Separate with PARSENAME](https://github.com/user-attachments/assets/525630a1-1173-45e7-8c87-4bd54970a357)
- **Challenge**: PARSENAME function looks for periods, so commas were replaced with periods.
- **Solution**: Used REPLACE function and labeled parts of the address in reverse order to ensure correct parsing.

### 5. Change 'Y' and 'N' to 'Yes' and 'No' in "Sold As Vacant" Field
- **Code 1**: Observe the number of DISTINCT answers in SoldAsVacant and obtain a COUNT of it. Let's convert the number of 'Y' and 'N' to 'Yes' and 'No' respectively.
  ![Example 1](https://github.com/user-attachments/assets/4a3700ed-ace9-4744-97bf-98b690390f85)
- **Code 2**: Perform a CASE WHEN to convert 'Y' and 'N' to 'Yes' and 'No' respectively.
  ![Change Y and N to Yes and No](https://github.com/user-attachments/assets/c76ebde5-e016-4fc3-95c8-fe9b6908fdcd)
- **Code 3**: Confirmation that the conversion was successfully.
  ![Example 2](https://github.com/user-attachments/assets/3788eb5e-a744-42a1-a573-e8fda93843c2)
- **Method**: Used CASE WHEN statements to convert 'Y' and 'N' values to 'Yes' and 'No' respectively.

### 6. Remove Duplicates Using CTEs
- **Code 1**: Select all columns and row_num by paritioning ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference and order them by the UniqueID. This allows us to find any duplicates in case if those columns match. 
  ![Remove Duplicates](https://github.com/user-attachments/assets/a3528e36-5229-4ef5-a078-5ad034a312a6)
- **Code 3**: Delete these rows using the DELETE function. 
  ![Example 1](https://github.com/user-attachments/assets/50ba81b8-ecb3-49f7-8931-cc54a73f2f6e)
- **Code 2**: We cannot perform WHERE row_num > 1 because the SELECT function is performing the partition function. Therefore we make a CTE to perform WHERE row_num > 1 in order to find any duplicates. We find that there are many duplicates since the row_num > 1.
  ![Example 2](https://github.com/user-attachments/assets/7cbebdca-defb-48b0-9787-4bfa0dd0bde0)
- **Code ?**:
  ![Example 3](https://github.com/user-attachments/assets/fd194df8-5abe-43c5-8193-d3678f249e35)
- **Code 4**: There are no duplicates remaining. 
  ![Example 1](https://github.com/user-attachments/assets/d3af896c-a1a7-469b-a691-be71a15d5bee)
- **Challenge**: Could not perform row_num > 1 without using Common Table Expressions (CTEs).
- **Solution**: Partitioned data on unique columns to identify and remove duplicates.

### 7. Delete Unused Columns
- **Code**: Use DROP to delete unnecessary columns such as OwnerAddress, TaxDistrict, PropertyAddress, and SaleDate
  ![Delete Unused Columns](https://github.com/user-attachments/assets/86ed2eac-b044-4480-a613-34998661b6a6)
- **Method**: Deleted columns that were deemed unusable or irrelevant for the analysis.

By following these steps, the Nashville Housing Dataset was thoroughly cleaned and prepared for further analysis and reporting.

## Questions Answered

### 1. How can we ensure accurate time-based analysis for property transactions?
- **Solution**: By standardizing date formats, we ensure that all date entries are consistent and accurate, enabling reliable time-based analysis of property transactions.

### 2. How can we handle missing property address information to maintain data integrity?
- **Solution**: By using self-joins to populate missing PropertyAddress values based on matching ParcelID, we ensure that no properties are left with missing address information, maintaining data completeness and integrity.

### 3. How can breaking down addresses into individual components improve our analysis?
- **Solution**: By splitting combined address fields into separate columns for street, city, state, and zip code, we enable more granular and detailed analyses, such as geospatial analysis or demographic studies.

### 4. How can transforming binary fields enhance data readability and user experience?
- **Solution**: By converting binary 'Y' and 'N' values to 'Yes' and 'No', we make the dataset more user-friendly and easier to interpret, improving the overall user experience and facilitating clearer communication of data insights.

### 5. How can removing duplicate records improve data quality and reliability?
- **Solution**: By utilizing Common Table Expressions (CTEs) to identify and remove duplicate records, we enhance the overall quality and reliability of the dataset, ensuring that each record is unique and accurate.
