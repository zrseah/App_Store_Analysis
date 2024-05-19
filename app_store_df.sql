# rename column names
ALTER TABLE app_store.applestore RENAME COLUMN track_name TO application_name;
ALTER TABLE app_store.applestore RENAME COLUMN rating_count_tot TO total_rating_count;
ALTER TABLE app_store.applestore RENAME COLUMN rating_count_ver TO version_rating_count;
ALTER TABLE app_store.applestore RENAME COLUMN user_rating_ver TO user_rating_version;
ALTER TABLE app_store.applestore RENAME COLUMN ver TO version;
ALTER TABLE app_store.applestore DROP COLUMN language_count;
ALTER TABLE app_store.applestore RENAME COLUMN `lang.num` TO language_count;

# select relevant data 
WITH app_store_df AS (
	SELECT 
		distinct(id),  # ensure no duplicates 
        application_name, 
        size_bytes, 
        price, 
        total_rating_count, 
        version_rating_count, 
        user_rating, 
        user_rating_version, 
        version, 
        prime_genre, 
        language_count
	FROM 
		app_store.applestore) 
SELECT 
	id, 
	application_name, 
	size_bytes, 
	price, 
	total_rating_count, 
	version_rating_count, 
    user_rating, 
	user_rating_version, 
    round((user_rating - user_rating_version), 1) AS rating_difference,
    version, 
	prime_genre, 
	language_count
FROM app_store_df 
WHERE # ensure null values not included 
	id IS NOT NULL AND  
	application_name IS NOT NULL AND
	size_bytes IS NOT NULL AND 
	price IS NOT NULL AND
	total_rating_count IS NOT NULL AND
	version_rating_count IS NOT NULL AND
    language_count IS NOT NULL AND
    user_rating IS NOT NULL AND 
	user_rating_version IS NOT NULL; 
    
