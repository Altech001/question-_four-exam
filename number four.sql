-- use farming_db;
-- Create the Farmer table
CREATE TABLE Farmer (
    farmer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Create the CropFarmer table (inherits from Farmer)
CREATE TABLE CropFarmer (
    farmer_id INT PRIMARY KEY,
    specialty VARCHAR(100) NOT NULL,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id)
);

-- Create the LivestockFarmer table (inherits from CropFarmer)
CREATE TABLE LivestockFarmer (
    farmer_id INT PRIMARY KEY,
    FOREIGN KEY (farmer_id) REFERENCES CropFarmer(farmer_id)
);

-- Create the Tractor table
CREATE TABLE Tractor (
    tractor_id INT PRIMARY KEY,
    model VARCHAR(100) NOT NULL
);

-- Create the Plow table
CREATE TABLE Plow (
    plow_id INT PRIMARY KEY,
    model VARCHAR(100) NOT NULL
);

-- Create the TractorOwnership table (CropFarmer owns Tractors)
CREATE TABLE TractorOwnership (
    farmer_id INT,
    tractor_id INT,
    purchase_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (farmer_id, tractor_id),
    FOREIGN KEY (farmer_id) REFERENCES CropFarmer(farmer_id),
    FOREIGN KEY (tractor_id) REFERENCES Tractor(tractor_id)
);

-- Create the PlowOwnership table (LivestockFarmer owns Plows)
CREATE TABLE PlowOwnership (
    farmer_id INT,
    plow_id INT,
    purchase_price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (farmer_id, plow_id),
    FOREIGN KEY (farmer_id) REFERENCES LivestockFarmer(farmer_id),
    FOREIGN KEY (plow_id) REFERENCES Plow(plow_id)
);

-- Create the Rental table (Farmers rent Tractors or Plows)
CREATE TABLE Rental (
    rental_id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT,
    equipment_id INT,
    equipment_type ENUM('Tractor', 'Plow') NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (farmer_id) REFERENCES Farmer(farmer_id),
    UNIQUE (farmer_id, start_date), -- Ensures a farmer cannot rent more than one equipment at the same time
    CHECK (equipment_type IN ('Tractor', 'Plow')) -- Ensures only Tractors or Plows can be rented
);
