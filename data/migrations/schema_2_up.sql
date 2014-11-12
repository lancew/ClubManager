CREATE TABLE Members
(
MemberID INTEGER PRIMARY KEY,
ClubID INTEGER not null,
Firstname varchar(50) not null,
Surname varchar(50) not null,
DateOfBirth date,
PostalAddress varchar(50) not null,
Postcode varchar(10) not null,
MobileNumber varchar(25) not null,
HomePhone varchar(25) not null,
Email varchar(25) not null,
NGBLicenseNumber varchar(25) not null,
NGBLicenseExpiryDate date,
EmergencyContactName  varchar(50) not null,
EmergencyContactPhone varchar(25) not null,
EmergencyContactRelationship varchar(25) not null
);
