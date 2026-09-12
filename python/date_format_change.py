########################################################################
#File:    date_format_change.py
#Author:  Maksym Yakushev
#Date:    2026-12-09
#Purpose: change date format in CSV file from DD-MM-YYYY to YYYY-MM-DD
########################################################################


import pandas as pd

input_file = "/Users/maksymyakushev/Documents/Career Practice/GitHub Projects/metabase-nike-sales/data/raw/Nike Dataset.csv"
output_file = "/Users/maksymyakushev/Documents/Career Practice/GitHub Projects/metabase-nike-sales/data/processed/Nike Dataset_clean.csv"


df = pd.read_csv(input_file)

# DD-MM-YYYY → YYYY-MM-DD
df["Invoice Date"] = pd.to_datetime(
    df["Invoice Date"],
    format="%d-%m-%Y"
).dt.strftime("%Y-%m-%d")

df.to_csv(output_file, index=False)

print("Date format changed!")
print(f"New file: {output_file}")
print()
print("First 5 dates:")
print(df["Invoice Date"].head())