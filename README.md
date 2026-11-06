# Swiggy Restaurant Analysis using SQL

## Overview
SQL analysis of 148,000+ Swiggy restaurant listings across 800+ areas in India, covering restaurant distribution, cuisines, chains, ratings and pricing.

## Tools Used
- SQL (SQLite), DB Browser for SQLite
- Dataset: Swiggy Restaurants Dataset (Kaggle)

## Data Cleaning
- Kept the raw table (`swiggy`) untouched and created a cleaned table (`swiggy_clean`)
- Converted `cost` from text (e.g. "₹ 200") to numbers
- Converted `rating` to numbers; "--" (unrated) became NULL
- Converted `rating_count` ranges (e.g. "1K+ ratings") to numbers; "Too Few Ratings" became 0

## Questions Answered
1. How many restaurants are listed per area?
2. What are the most popular cuisines across India?
3. Which restaurant chains have the most branches?
4. Which areas have the highest average rating (50+ restaurants)?
5. What is the average cost for two across areas (50+ restaurants)?
6. Which cuisines have the highest average rating (100+ restaurants)?
7. Which restaurants have a 4.5+ rating and 1000+ ratings?
8. Which area offers the best value for money?

## Key Findings
See findings.md

## Limitations
- Cuisine combinations (e.g. "Sweets, Bakery") are treated as one category
- The `city` column contains areas as well as cities
- Rating counts are given as ranges, so exact counts are not available

## Files
- swiggy_analysis.sql: all queries with comments
- findings.md: summary of insights
