CREATE TABLE Members
(
MemberID INTEGER PRIMARY KEY,
ClubID INTEGER not null,
Firstname varchar(50) not null,
Surname varchar(50) not null,
DateOfBirth date,
PostalAddress varchar(50),
Postcode varchar(10),
MobileNumber varchar(25),
HomePhone varchar(25),
Email varchar(25),
NGBLicenseNumber varchar(25),
NGBLicenseExpiryDate date,
EmergencyContactName  varchar(50),
EmergencyContactPhone varchar(25),
EmergencyContactRelationship varchar(25)
);
