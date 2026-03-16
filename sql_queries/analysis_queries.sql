USE transport_system;

CREATE TABLE commuters (
    commuter_id INT PRIMARY KEY,
    commuter_name VARCHAR(100),
    age INT,
    gender VARCHAR(10),
    city_zone VARCHAR(50),
    card_type VARCHAR(50)
);

SELECT * FROM commuters;

CREATE TABLE stations (
    station_id INT PRIMARY KEY,
    station_name VARCHAR(100),
    zone VARCHAR(50),
    station_type VARCHAR(50)
);

SELECT * FROM stations;

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    vehicle_type VARCHAR(50),
    capacity INT,
    manufacture_year YEAR
);

SELECT * FROM vehicles;

CREATE TABLE routes (
    route_id INT PRIMARY KEY,
    source_station INT,
    destination_station INT,
    distance_km INT,
    route_type VARCHAR(20),

    FOREIGN KEY (source_station) REFERENCES stations(station_id),
    FOREIGN KEY (destination_station) REFERENCES stations(station_id)
);

SELECT * FROM routes;

CREATE TABLE routes_assignment (
    assignment_id INT PRIMARY KEY,
    route_id INT,
    vehicle_id INT,

    FOREIGN KEY (route_id) REFERENCES routes(route_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

SELECT * FROM routes_assignment;

CREATE TABLE trips (
    trip_id INT PRIMARY KEY,
    commuter_id INT,
    route_id INT,
    trip_date DATE,
    start_time TIME,
    end_time TIME,
    fare INT,

    FOREIGN KEY (commuter_id) REFERENCES commuters(commuter_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);

SELECT * FROM trips;

CREATE TABLE maintenance (
    maintenance_id INT PRIMARY KEY,
    vehicle_id INT,
    maintenance_date DATE,
    cost INT,
    issue_type VARCHAR(100),

    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

SELECT * FROM maintenance;

-- 3.	Restrict route_type to Metro/Bus.
ALTER TABLE routes
ADD CONSTRAINT chk_route_type
CHECK (route_type IN ('Metro','Bus'));

-- 4.	Ensure fare > 0.
ALTER TABLE trips
ADD CONSTRAINT chk_fare
CHECK (fare > 0);  

-- 5.	Add index on trip_date. 
DROP INDEX idx_trip_date ON trips;

CREATE INDEX idx_trip_date
ON trips(trip_date);

SHOW INDEX FROM trips;

-- 6.	Insert 20 new commuters.
INSERT INTO commuters (commuter_id, commuter_name, age, gender, city_zone, card_type) VALUES
(6, 'Mahesh Sharma', 61, 'M', 'North', 'Monthly Pass'),
(7, 'Savitri Desai', 65, 'F', 'Central', 'Pay Per Ride'),
(8, 'Ramesh Patel', 58, 'M', 'West', 'Monthly Pass'),
(9, 'Kamla Joshi', 63, 'F', 'East', 'Student Pass'),
(10, 'Harish Mehta', 70, 'M', 'South', 'Pay Per Ride'),
(11, 'Riya Kapoor', 23, 'F', 'North', 'Student Pass'),
(12, 'Vikas Verma', 36, 'M', 'Central', 'Monthly Pass'),
(13, 'Anita Nair', 28, 'F', 'West', 'Pay Per Ride'),
(14, 'Suresh Kumar', 45, 'M', 'East', 'Senior Citizen'),
(15, 'Meena Iyer', 39, 'F', 'South', 'Monthly Pass'),
(16, 'Arjun Singh', 30, 'M', 'North', 'Pay Per Ride'),
(17, 'Pooja Shah', 22, 'F', 'Central', 'Student Pass'),
(18, 'Rohit Jain', 34, 'M', 'West', 'Monthly Pass'),
(19, 'Sneha Desai', 29, 'F', 'East', 'Pay Per Ride'),
(20, 'Deepak Patel', 40, 'M', 'South', 'Monthly Pass'),
(21, 'Kavita Mehta', 27, 'F', 'North', 'Student Pass'),
(22, 'Manish Gupta', 38, 'M', 'Central', 'Monthly Pass'),
(23, 'Asha Nair', 25, 'F', 'West', 'Pay Per Ride'),
(24, 'Nikhil Sharma', 32, 'M', 'East', 'Monthly Pass'),
(25, 'Divya Kapoor', 26, 'F', 'South', 'Student Pass');

SELECT * FROM commuters;

-- 7.	Update vehicle capacity by +10%.
SET sql_safe_updates = False;
UPDATE vehicles
SET capacity = capacity * 1.10;

SELECT * FROM vehicles;

-- 8.	Delete trips before 2023. 
SELECT * FROM trips;

DELETE FROM trips
WHERE trip_date < '2023-01-01';

-- 9.	Change card_type of senior citizens. 
SELECT * FROM commuters;

UPDATE commuters
SET card_type = 'Senior Citizen'
WHERE age >= 55;

-- 10.	Add new station "Kurla".

SELECT * FROM stations;

INSERT INTO stations (station_id, station_name, zone, station_type)
VALUES (106, 'Kurla', 'Central', 'Metro');

-- 11.	List all metro stations.

SELECT * FROM stations
WHERE station_type = "Metro";

-- 12.	Show commuters using Monthly Pass.

SELECT * FROM commuters
WHERE card_type = "Monthly Pass";

-- 13.	Find total trips.   
SELECT * FROM trips;
SELECT COUNT(*) AS total_trips
FROM trips;

-- 14.	Show distinct city zones.
SELECT DISTINCT city_zone
FROM commuters;

-- 15.	Average fare. 
SELECT AVG(fare) AS average_fare
FROM trips;

-- 16.	Total revenue per day.
SELECT trip_date, SUM(fare) AS total_revenue
FROM trips
GROUP BY trip_date;

-- 17.	Revenue per route.
SELECT route_id, SUM(fare) AS total_revenue
FROM trips
GROUP BY route_id;

-- 18.	Average trip duration. 
SELECT AVG(TIMESTAMPDIFF(MINUTE, start_time, end_time)) AS avg_trip_duration_minutes
FROM trips;

-- 19.	Total maintenance cost.
SELECT * FROM maintenance;
SELECT SUM(cost) AS total_maintenance_cost
FROM maintenance;

-- 20.	Most used route.
SELECT route_id, COUNT(*) AS trip_count
FROM trips
GROUP BY route_id
ORDER BY trip_count DESC
LIMIT 1;

-- 21.	Show commuter with route info.
SELECT * FROM commuters;
SELECT * FROM routes;
SELECT * FROM trips;

SELECT c.commuter_name,c.city_zone,r.route_id,r.route_type,r.distance_km
FROM commuters AS C
JOIN trips AS t ON c.commuter_id = t.commuter_id
JOIN routes AS r ON r.route_id = t.route_id;

-- 22.	Route with station names.
SELECT * FROM routes;
SELECT * FROM stations;

SELECT r.route_id,
r.source_station AS source_station,
r.destination_station AS destination_station,
r.route_type,
r.distance_km
FROM routes AS r
JOIN stations AS s1 ON r.source_station = s1.station_id 
JOIN stations AS s2 ON r.destination_station = s2.station_id;

SELECT r.route_id,
s1.station_name AS source_station,
s2.station_name AS destination_station,
r.route_type,
r.distance_km
FROM routes AS r
JOIN stations AS s1 ON r.source_station = s1.station_id 
JOIN stations AS s2 ON r.destination_station = s2.station_id;

-- 23.	Vehicle assigned to each route.
SELECT * FROM vehicles;
SELECT * FROM routes_assignment;
SELECT * FROM routes; 

SELECT r.route_id,r.route_type,v.vehicle_id,v.vehicle_type
FROM routes AS r
JOIN routes_assignment AS ra ON r.route_id = ra.route_id
JOIN vehicles AS v ON v.vehicle_id = ra.vehicle_id;

-- 24.	Trips with vehicle type.
SELECT * FROM trips;
SELECT * FROM vehicles; 
SELECT * FROM routes_assignment;
SELECT * FROM commuters;

SELECT t.trip_id,c.commuter_name,v.vehicle_type,t.trip_date,t.fare
FROM trips AS t
JOIN commuters AS c ON t.commuter_id = c.commuter_id
JOIN routes_assignment AS ra ON t.route_id = ra.route_id
JOIN vehicles AS v ON v.vehicle_id = ra.vehicle_id;

-- 25.	Vehicles never used.
SELECT * FROM vehicles;
SELECT * FROM routes_assignment;

INSERT INTO vehicles (vehicle_id, vehicle_type, capacity, manufacture_year)
VALUES (404, 'Electric Bus', 55, '2022');

SELECT v.vehicle_id,v.vehicle_type 
FROM vehicles AS v
LEFT JOIN routes_assignment AS ra ON v.vehicle_id = ra.vehicle_id
WHERE ra.vehicle_id IS NULL;

-- 26.	Routes with revenue above average.
SELECT route_id, SUM(fare) AS total_revenue
FROM trips
GROUP BY route_id
HAVING SUM(fare) > (
    SELECT AVG(fare)
    FROM trips
);

SELECT route_id, SUM(fare) AS total_revenue
FROM trips
GROUP BY route_id
HAVING SUM(fare) > (
    SELECT AVG(route_revenue)
    FROM (
        SELECT SUM(fare) AS route_revenue
        FROM trips
        GROUP BY route_id
    ) AS temp
);

-- 27.	Commuters spending more than average.
SELECT commuter_id, SUM(fare) AS total_spent
FROM trips
GROUP BY commuter_id
HAVING SUM(fare) > (
    SELECT AVG(total_spent)
    FROM (
        SELECT SUM(fare) AS total_spent
        FROM trips
        GROUP BY commuter_id
    ) AS temp
); 

-- 28.	Most expensive maintenance vehicle.
SELECT vehicle_id, SUM(cost) AS total_maintenance_cost
FROM maintenance
GROUP BY vehicle_id
ORDER BY total_maintenance_cost DESC
LIMIT 1; -- Gives only one output when vehicle have same cost

SELECT vehicle_id,SUM(cost) AS total_maintenance_cost
FROM maintenance
GROUP BY vehicle_id
HAVING SUM(cost) = (
			SELECT MAX(total_cost) 
            FROM (
				SELECT SUM(cost) AS total_cost
                FROM maintenance
                GROUP BY vehicle_id
            ) AS temp
); -- Gives mutiple output when vehicle have same cost


--  29.	Stations with highest traffic.
SELECT * FROM routes;
SELECT * FROM stations;
SELECT * FROM trips;

SELECT s.station_name, COUNT(t.trip_id) AS total_trips
FROM trips t
JOIN routes r ON t.route_id = r.route_id
JOIN stations s ON r.source_station IN (r.source_station, r.destination_station)
GROUP BY s.station_name
ORDER BY total_trips DESC
LIMIT 1;

-- 30.	Routes longer than city average. 
SELECT route_id, distance_km
FROM routes
WHERE distance_km > (
    SELECT AVG(distance_km)
    FROM routes
); 

-- 31.	Fare category:
-- •	< 30 → Cheap
-- •	30–50 → Normal
-- •	50 → Expensive

SELECT trip_id, fare,
CASE
    WHEN fare < 30 THEN 'Cheap'
    WHEN fare BETWEEN 30 AND 50 THEN 'Normal'
    ELSE 'Expensive'
END AS fare_category
FROM trips;

-- 32.	Trip duration:
-- •	< 30 min → Short
-- •	30–60 → Medium
-- •	60 → Long

SELECT 
trip_id,
TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration_minutes,
CASE
    WHEN TIMESTAMPDIFF(MINUTE, start_time, end_time) < 30 THEN 'Short'
    WHEN TIMESTAMPDIFF(MINUTE, start_time, end_time) BETWEEN 30 AND 60 THEN 'Medium'
    ELSE 'Long'
END AS trip_duration_category
FROM trips;

-- 33.	vw_commuter_profile
-- (name, total_trips, total_spent)
CREATE VIEW vw_commuter_profile AS
SELECT 
    c.commuter_name AS name,
    COUNT(t.trip_id) AS total_trips,
    SUM(t.fare) AS total_spent
FROM commuters c
LEFT JOIN trips t 
ON c.commuter_id = t.commuter_id
GROUP BY c.commuter_id, c.commuter_name;

SELECT * FROM vw_commuter_profile;

-- 34.	vw_route_performance
-- (route_id, total_trips, revenue)
CREATE VIEW vw_route_performance AS
SELECT 
    route_id,
    COUNT(trip_id) AS total_trips,
    SUM(fare) AS revenue
FROM trips
GROUP BY route_id;

SELECT * FROM vw_route_performance;

-- 35.	Rank routes by revenue.
SELECT route_id,SUM(fare) AS total_revenue, RANK() OVER(ORDER BY SUM(fare) DESC) AS rank_Of_route
FROM trips
GROUP BY route_id; 

-- 36.	Top 5 commuters by spending.
SELECT 
    c.commuter_id,
    c.commuter_name,
    SUM(t.fare) AS total_spent
FROM commuters c
JOIN trips t 
ON c.commuter_id = t.commuter_id
GROUP BY c.commuter_id, c.commuter_name
ORDER BY total_spent DESC
LIMIT 5;

-- 37.	Maintenance cost ranking.
SELECT 
    vehicle_id,
    SUM(cost) AS total_maintenance_cost,
    RANK() OVER (ORDER BY SUM(cost) DESC) AS cost_rank
FROM maintenance
GROUP BY vehicle_id;  

-- 38.	Which zone generates max revenue?
SELECT * FROM trips;
SELECT * FROM commuters;

SELECT 
    c.city_zone,
    SUM(t.fare) AS total_revenue
FROM commuters c
JOIN trips t 
ON c.commuter_id = t.commuter_id
GROUP BY c.city_zone
ORDER BY total_revenue DESC
LIMIT 1;

-- 39.	Which vehicle type is most cost efficient?
SELECT * FROM vehicles;
SELECT * FROM trips;
SELECT * FROM routes_assignment;
SELECT * FROM maintenance;

SELECT 
    v.vehicle_type,
    SUM(t.fare) AS total_revenue,
    SUM(m.cost) AS total_maintenance_cost,
    (SUM(t.fare) - SUM(m.cost)) AS profit
FROM vehicles v
JOIN routes_assignment ra ON v.vehicle_id = ra.vehicle_id
JOIN trips t ON ra.route_id = t.route_id
LEFT JOIN maintenance m ON v.vehicle_id = m.vehicle_id
GROUP BY v.vehicle_type
ORDER BY profit DESC
LIMIT 1; 

-- 40.	Which route needs more vehicles?
SELECT r.route_id, r.route_type, COUNT(t.trip_id) AS total_trips
FROM routes r
JOIN trips t 
ON r.route_id = t.route_id
GROUP BY r.route_id, r.route_type
ORDER BY total_trips DESC
LIMIT 1; 
