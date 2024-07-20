# Cleaning Nashville Housing Data Using SQL

Cleaning the Nashville Housing Dataset using Microsoft SQL Server Management Studio

## Standardize data format
challenge: not being able to convert it into a date format
alternate way to add a column and update it

![Screenshot 2024-07-19 152219](https://github.com/user-attachments/assets/70aed479-35ef-4553-b222-2f7254adc784)
![Screenshot 2024-07-19 152004](https://github.com/user-attachments/assets/2a2cdc92-6f01-452f-a372-88c167fb73da)
![Screenshot 2024-07-19 151641](https://github.com/user-attachments/assets/59cdcc5a-022b-4560-8a9f-fce36678ae5b)
![Screenshot 2024-07-19 151607](https://github.com/user-attachments/assets/55142b84-dd2f-4a56-b33b-f0fd2b2cae48)

## Populate Property Address data
the parcelID matches the PropertyAddress
if the parcelID has a NULL PropertyAddress, we can populate it by using an idenitical parcelID that has a propertyAddress
make sure that the unique IDs are different
use a self-join to perform this
ISNULL checks to see: if the first is NULL (a.PropertyAddress), what do we want to populate it with? (b.PropertyAddress)
![Screenshot 2024-07-19 155258](https://github.com/user-attachments/assets/40eb9586-1b08-468f-8151-3ed5ac8a0d26)
![Screenshot 2024-07-19 154121](https://github.com/user-attachments/assets/88f3904c-cd76-4d8e-b7d4-c085bcb7f4d7)
![Screenshot 2024-07-19 153309](https://github.com/user-attachments/assets/832ae0a8-0988-493f-916c-9cbacd960c1f)


## Breaking Up Addresses into Individual Columns

![Screenshot 2024-07-19 160246](https://github.com/user-attachments/assets/f5f03439-52a9-4452-b5e3-729a5126dce0)
![Screenshot 2024-07-19 155846](https://github.com/user-attachments/assets/c0e2c0f5-5d55-4af7-b649-f47c8c37f446)
![Screenshot 2024-07-19 155544](https://github.com/user-attachments/assets/45ce36ac-2ca7-48d4-bd62-6b598bd726a2)
![Screenshot 2024-07-19 160447](https://github.com/user-attachments/assets/02ff0535-441d-43b9-b2f4-34ebb855aa09)

## Seperate with ParseName OwnerAddress
challenge: parsename looks for periods so use the replace function to replace the commas with periods and run the parsename command
challenge: also does it backwards so label 3, 2, 1 to get the address in order

![Screenshot 2024-07-19 161403](https://github.com/user-attachments/assets/525630a1-1173-45e7-8c87-4bd54970a357)
![Screenshot 2024-07-19 161220](https://github.com/user-attachments/assets/03dace5a-92ba-4064-bc7d-688d57a98d35)
![Screenshot 2024-07-19 161108](https://github.com/user-attachments/assets/38406856-2fc2-4e79-b40f-c464c4e853c5)
![Screenshot 2024-07-19 161020](https://github.com/user-attachments/assets/8f207551-f5f6-43c0-a918-edece542787e)


## Change Y and N to Yes and No in "Sold As Vacant" Field
use case when
![Screenshot 2024-07-19 163948](https://github.com/user-attachments/assets/c76ebde5-e016-4fc3-95c8-fe9b6908fdcd)
![Screenshot 2024-07-19 161509](https://github.com/user-attachments/assets/4a3700ed-ace9-4744-97bf-98b690390f85)
![Screenshot 2024-07-19 164538](https://github.com/user-attachments/assets/3788eb5e-a744-42a1-a573-e8fda93843c2)

## Remove duplicates using CTEs
partition it on things that should be unique to each row
challenge: CANNOT perform row_num > 1 without CTE
![Screenshot 2024-07-19 165132](https://github.com/user-attachments/assets/a3528e36-5229-4ef5-a078-5ad034a312a6)
![Screenshot 2024-07-19 165932](https://github.com/user-attachments/assets/50ba81b8-ecb3-49f7-8931-cc54a73f2f6e)
![Screenshot 2024-07-19 165842](https://github.com/user-attachments/assets/7cbebdca-defb-48b0-9787-4bfa0dd0bde0)
![Screenshot 2024-07-19 165550](https://github.com/user-attachments/assets/fd194df8-5abe-43c5-8193-d3678f249e35)


# Delete unused columns
delete columns that are unusable
![Screenshot 2024-07-19 170214](https://github.com/user-attachments/assets/86ed2eac-b044-4480-a613-34998661b6a6)
![Screenshot 2024-07-19 170003](https://github.com/user-attachments/assets/d3af896c-a1a7-469b-a691-be71a15d5bee)

