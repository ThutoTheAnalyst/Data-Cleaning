--CLEANING DATA IN SQL QUERIES

SELECT *
FROM PortfolioProjcet..NashvilleHousing


--- STANDARDIZING DATE FORMAT

SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM PortfolioProjcet..NashvilleHousing

Update NashvilleHousing 
SET SaleDateConverted = CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;


-------POPULATING PROPERTY ADDRESS DATA

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProjcet..NashvilleHousing a
JOIN PortfolioProjcet..NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProjcet..NashvilleHousing a
JOIN PortfolioProjcet..NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL


----------BREAKING OUT THE ADDRESS INTO INDIVIDUAL COLUMNS (Address, city, state)

SELECT PropertyAddress
FROM PortfolioProjcet..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) as Address
FROM PortfolioProjcet.dbo.NashvilleHousing 

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)


ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))
 



SELECT *
FROM PortfolioProjcet..NashvilleHousing


----KNOW WE ARE SPLITING THE OWNERS ADDRESS INTO 3 COLUMNS


SELECT OwnerAddress
FROM PortfolioProjcet..NashvilleHousing

SELECT 
PARSENAME (REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME (REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME (REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProjcet..NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME (REPLACE(OwnerAddress, ',', '.'), 3)


ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME (REPLACE(OwnerAddress, ',', '.'), 2)


ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME (REPLACE(OwnerAddress, ',', '.'), 1)


SELECT *
FROM PortfolioProjcet..NashvilleHousing




-----KNOWING WE ARE CHANGE Y AND N TO YES AND NO in "SOLD AS VACANT"

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
FROM PortfolioProjcet..NashvilleHousing

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	   WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


SELECT Distinct (SoldAsVacant), COUNT (SoldAsVacant)
FROM PortfolioProjcet..NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2



-----NOW WE ARE GOING TO REMOVE DUPLICATES
WITH RowNumCTE AS (
 SELECT *,
 ROW_NUMBER () OVER (
 PARTITION BY ParcelID,
			  PropertyAddress,
			  SalePrice,
			  SaleDate,
			  LegalReference
			  ORDER BY 
				UniqueID) RowNum


FROM PortfolioProjcet..NashvilleHousing
)
DELETE  
FROM RowNumCTE
WHERE  RowNum > 1
--ORDER BY PropertyAddress


WITH RowNumCTE AS (
 SELECT *,
 ROW_NUMBER () OVER (
 PARTITION BY ParcelID,
			  PropertyAddress,
			  SalePrice,
			  SaleDate,
			  LegalReference
			  ORDER BY 
				UniqueID) RowNum


FROM PortfolioProjcet..NashvilleHousing
)
SELECT *  
FROM RowNumCTE
WHERE  RowNum > 1
ORDER BY PropertyAddress



--------NOW WE ARE DELETING COLUMNS THAT ARE UNUSED.

SELECT *
FROM PortfolioProjcet..NashvilleHousing

ALTER TABLE PortfolioProjcet..NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
