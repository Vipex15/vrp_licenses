Features:

Inventory-based license checking: Users can be checked for possession of specific items representing vehicle licenses.
Database-based license checking: Users' license statuses are stored in the database for persistence and accessibility.
Usage:

Ensure the necessary database alterations have been made to include the license_boat, license_heli, and license_plane columns in the vrp_character_identities table.
Configure the script options in vpx_licenses.cfg according to your server's needs.
Use the CheckLicense(vehicleType) method to verify whether a user has the required license for a specific vehicle type.

DON`T FORGET 

 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_boat` int(50) NOT NULL DEFAULT 0
 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_heli` int(50) NOT NULL DEFAULT 0
 ALTER TABLE vrp_character_identities ADD IF NOT EXISTS `license_plane`int(50) NOT NULL DEFAULT 0

IF YOU USE DATABASE LICENSE

