DELIMITER $$

CREATE PROCEDURE UpdateTreatmentPlan (
    IN p_userID INT,
    IN p_planID INT,
    IN p_procedure VARCHAR(255),
    IN p_notes TEXT
)
BEGIN
    DECLARE v_role VARCHAR(100);

    -- Get the user's role
    SELECT r.RoleName INTO v_role
    FROM Users u
    JOIN Roles r ON u.RoleID = r.RoleID
    WHERE u.UserID = p_userID;

    -- Role-based access control logic
    IF v_role = 'Practitioner' THEN
        UPDATE TreatmentPlans
        SET `Procedure` = p_procedure,
            Notes = p_notes,
            LastUpdatedBy = p_userID
        WHERE TreatmentPlanID = p_planID;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Unauthorized access: Only practitioners can update treatment plans.';
    END IF;
END$$

DELIMITER ;
