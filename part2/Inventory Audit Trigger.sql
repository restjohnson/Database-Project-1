CREATE TABLE IF NOT EXISTS inventoryLog
(log_id int AUTO_INCREMENT PRIMARY KEY,
item_name varchar(255),
before_quantity int,
after_quantity int,
change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
DELIMITER $$

CREATE TRIGGER logInventory
BEFORE UPDATE
ON inventory
FOR EACH ROW
BEGIN
	INSERT INTO inventoryLog (item_name, before_quantity, after_quantity) 
    VALUES  (NEW.itemName, OLD.quantityAvailable, NEW.quantityAvailable);
END;$$

CREATE TRIGGER logInventoryInsert
BEFORE INSERT
ON inventory
FOR EACH ROW
BEGIN
	INSERT INTO inventoryLog (item_name, after_quantity) 
    VALUES  (itemName, quantityAvailable);
END;$$
DELIMITER ;