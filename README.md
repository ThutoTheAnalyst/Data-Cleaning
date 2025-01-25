# Nashville Housing Data Cleaning Project

This project focuses on cleaning and transforming the Nashville Housing dataset using SQL. The objective is to prepare the dataset for analysis by addressing data inconsistencies, standardizing formats, and removing redundancies. 

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset Description](#dataset-description)
- [Cleaning Steps](#cleaning-steps)
- [Technologies Used](#technologies-used)
- [How to Run](#how-to-run)
- [Project Outcomes](#project-outcomes)
- [Contributing](#contributing)
- [License](#license)

---

## Project Overview
The **Nashville Housing Data Cleaning Project** was developed to demonstrate proficiency in data cleaning and transformation using SQL. The dataset underwent a series of operations to address missing data, inconsistencies, and redundancies, ensuring it is accurate and ready for analytical purposes.

---

## Dataset Description
The dataset used in this project contains information about real estate transactions in Nashville. Key fields include:
- **Parcel ID**
- **Property Address**
- **Sale Date**
- **Sale Price**
- **Owner Address**
- **Tax District**

---

## Cleaning Steps
The data cleaning process involved the following steps:

1. **Standardizing Date Formats**  
   Converted the `SaleDate` column into a consistent `Date` format for uniformity.

2. **Populating Missing Data**  
   Filled in missing property addresses using `Parcel ID` as a reference.

3. **Splitting Composite Columns**  
   - Divided `Property Address` into `Address`, `City`, and `State`.  
   - Divided `Owner Address` into `Address`, `City`, and `State`.

4. **Normalizing Categorical Data**  
   Replaced binary indicators (`Y/N`) in the `SoldAsVacant` column with descriptive labels (`Yes/No`).

5. **Removing Duplicates**  
   Identified and removed duplicate rows based on key columns such as `Parcel ID`, `Property Address`, `Sale Price`, `Sale Date`, and `Legal Reference`.

6. **Dropping Unused Columns**  
   Removed unnecessary columns to optimize the dataset and improve usability.

---

## Technologies Used
- **SQL Server**: For executing data cleaning queries and managing the dataset.
- **Microsoft Excel**: For the initial review of the dataset structure and exploratory analysis.

---


