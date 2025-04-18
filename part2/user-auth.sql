CREATE TABLE Roles (
	RoleID INT auto_increment	PRIMARY KEY,
    RoleName VARCHAR (100) UNIQUE NOT NULL
);
INSERT INTO Roles (RoleName) VALUES ('Practitioner'), ('Patient');

CREATE TABLE Users (
	UserID INT auto_increment PRIMARY KEY,
    Username VARCHAR(255) NOT NULL UNIQUE, 
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT,
    FOREIGN KEY (RoleID) References Roles(RoleID)
);


-- procedure for user login
DELIMITER $$

CREATE PROCEDURE LoginUser(
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    SELECT 
        u.UserID,
        u.Username,
        r.RoleName
    FROM Users u
    JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.Username = p_username
      AND u.PasswordHash = SHA2(p_password, 256);
END$$

DELIMITER ;



