package Judo::Database;

use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(connect_db init_db);

use Dancer ':syntax';
use Dancer::Plugin::Database;



sub connect_db {
    my $clubs_dbh = database('clubs');
}


sub init_db {
  my $db = connect_db();
  #my $schema = read_file('./schema.sql');
$db->do('DROP TABLE Clubs');
$db->do('CREATE TABLE Clubs
(
ClubID INTEGER PRIMARY KEY,
ClubName varchar(255),
Address varchar(255),
City varchar(255)
);
') or die $db->errstr;

$db->do("
INSERT INTO Clubs (ClubID,ClubName,Address,City)
VALUES (1,'Team Solent Judo','St Marys Leisure Centre','Southampton');
" ) or die $db->errstr;

}


1;
