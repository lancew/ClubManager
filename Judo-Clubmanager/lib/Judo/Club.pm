package Judo::Club;

use strict;
use warnings;

use Judo::Database 'connect_db';

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw( add_club get_clubs get_club);

our $club;
our @clubs;

sub add_club {
    my %args = @_;
    my $db = connect_db();

    my @values = values %args;

    $db->do('INSERT INTO Clubs (ClubName,Address,City) VALUES (?,?,?)', undef, @values);

    return %args;
}

sub get_clubs {
    my $db = connect_db();
    @clubs = $db->selectall_arrayref('SELECT * FROM Clubs');

    return @clubs;
}

sub get_club {
    my $id = shift;
    my $db = connect_db();
    $club = $db->selectrow_hashref('SELECT * FROM Clubs WHERE ClubID=' . $db->quote($id));

    return $club;
}



1;
