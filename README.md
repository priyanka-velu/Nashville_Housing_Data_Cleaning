# Cleaning Nashville Housing Data Using SQL

Cleaning the Nashville Housing Dataset using Microsoft SQL Server Management Studio

## Standardize data format
challenge: not being able to convert it into a date format
alternate way to add a column and update it

## Populate Property Address data
the parcelID matches the PropertyAddress
if the parcelID has a NULL PropertyAddress, we can populate it by using an idenitical parcelID that has a propertyAddress
make sure that the unique IDs are different

use a self-join to perform this
ISNULL checks to see: if the first is NULL (a.PropertyAddress), what do we want to populate it with? (b.PropertyAddress)

## Breaking Up Addresses into Individual Columns

## Seperate with ParseName OwnerAddress
challenge: parsename looks for periods so use the replace function to replace the commas with periods and run the parsename command
challenge: also does it backwards so label 3, 2, 1 to get the address in order

## Change Y and N to Yes and No in "Sold As Vacant" Field
use case when

## Remove duplicates using CTEs
partition it on things that should be unique to each row
challenge: CANNOT perform row_num > 1 without CTE

# Delete unused columns
delete columns that are unusable
