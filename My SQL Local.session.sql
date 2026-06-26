CREATE TABLE telecom_tower1(
    Tower_ID INT,
    Region VARCHAR(100),
    uptime_percent FLOAT,
    Downtime_Hours FLOAT,
    signal_strength FLOAT,
    Data_Traffic_GB FLOAT,
    maintenance_cost FLOAT,
    Fault_Count INT,
    );
    

SELECT VERSION();

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:/Users/Madan Kumar/OneDrive/Desktop/Projects/Telecom Tower Performance/Data/telecom_tower.csv'
IGNORE -- This tells MySQL to skip duplicate keys without failing
INTO TABLE telecom_tower1
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Tower_ID, Region, uptime_percent, Downtime_Hours, signal_strength, Data_Traffic_GB, maintenance_cost, Fault_Count); -- Explicitly list your CSV column headers here

SELECT Tower_ID,
SUM(Fault_Count) TotalFaults
FROM telecom_tower1
GROUP BY Tower_ID
ORDER BY TotalFaults DESC
LIMIT 10;

SELECT Region,
SUM(Downtime_Hours)
FROM telecom_tower1
GROUP BY Region;

SELECT AVG(Signal_Strength)
FROM telecom_tower1;
