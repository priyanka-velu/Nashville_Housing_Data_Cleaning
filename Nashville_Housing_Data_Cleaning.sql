/*

CLEANING DATA IN SQL QUERIES

*/

--------------------------------------------------------------------------------------------------------------------------------------

-- STANDARDIZE DATA FORMAT

SELECT SaleDate
FROM [PortfolioProject].[dbo].[NashvilleHousing] 

SELECT SaleDate, CONVERT(Date, SaleDate)
FROM [PortfolioProject].[dbo].[NashvilleHousing]

-- CHALLENGE - DID NOT CONVERT SALEDATE INTO DATE FORMAT AS EXPECTED
	
UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

-- ADDITIONAL WAY: SUCCESS

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)

SELECT SaleDateConverted
FROM [PortfolioProject].[dbo].[NashvilleHousing] 

--------------------------------------------------------------------------------------------------------------------------------------

-- POPULATE PROPERTY ADDRESS DATA

-- CHECK WHAT IS NULL
	
SELECT PropertyAddress
FROM [PortfolioProject].[dbo].[NashvilleHousing]
WHERE PropertyAddress is NULL

SELECT *
FROM [PortfolioProject].[dbo].[NashvilleHousing]
ORDER BY ParcelID

-- IF ParcelIDs ARE SAME AND IF UniqueIDs ARE DIFFERENT, POPULATE PropertyAddress DATA
	
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [PortfolioProject].[dbo].[NashvilleHousing] a
JOIN [PortfolioProject].[dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [PortfolioProject].[dbo].[NashvilleHousing] a
JOIN [PortfolioProject].[dbo].[NashvilleHousing] b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL

--------------------------------------------------------------------------------------------------------------------------------------

-- BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS, CITY, STATE)

SELECT PropertyAddress
FROM [PortfolioProject].[dbo].[NashvilleHousing]
--WHERE PropertyAddress is NULL
--ORDER BY ParcelID

-- SEPERATE WITH SUBSTRINGS
	
SELECT
	SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)) AS Address
	-- CHARINDEX(',', PropertyAddress) get rid of comma -1
FROM [PortfolioProject].[dbo].[NashvilleHousing]

-- ADD ADDRESS COLUMN
	
ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) - 1)

SELECT PropertySplitAddress
FROM [PortfolioProject].[dbo].[NashvilleHousing]

-- ADD CITY COLUMN
	
ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))

SELECT PropertySplitCity
FROM [PortfolioProject].[dbo].[NashvilleHousing]

-- SEPERATE OwnerAddress WITH PARSENAME

SELECT OwnerAddress
FROM [PortfolioProject].[dbo].[NashvilleHousing]

-- PARSENAME check for periods, not commas
--SELECT
--	PARSENAME(OwnerAddress, 1)
--FROM [PortfolioProject].[dbo].[NashvilleHousing]

SELECT
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
	PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM [PortfolioProject].[dbo].[NashvilleHousing]

ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

SELECT OwnerSplitAddress, OwnerSplitCity, OwnerSplitState
FROM [PortfolioProject].[dbo].[NashvilleHousing]

--------------------------------------------------------------------------------------------------------------------------------------

-- CHANGE Y AND N TO YES AND NO IN SoldAsVacant FIELD

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM [PortfolioProject].[dbo].[NashvilleHousing]
GROUP BY SoldAsVacant
ORDER BY 2

SELECT SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	     WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
FROM [PortfolioProject].[dbo].[NashvilleHousing]


UPDATE [PortfolioProject].[dbo].[NashvilleHousing]
SET SoldAsVacant = 
		CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	    WHEN SoldAsVacant = 'N' THEN 'No'
		ELSE SoldAsVacant
		END

--------------------------------------------------------------------------------------------------------------------------------------

-- REMOVE DUPLICATES

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) AS row_num

FROM [PortfolioProject].[dbo].[NashvilleHousing]
--ORDER BY ParcelID
)
--DELETE
SELECT *
FROM RowNumCTE
WHERE row_num > 1 
--ORDER BY PropertyAddress

--------------------------------------------------------------------------------------------------------------------------------------

-- DELETE UNUSED COLUMNS

SELECT *
FROM [PortfolioProject].[dbo].[NashvilleHousing]

ALTER TABLE [PortfolioProject].[dbo].[NashvilleHousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

--------------------------------------------------------------------------------------------------------------------------------------
