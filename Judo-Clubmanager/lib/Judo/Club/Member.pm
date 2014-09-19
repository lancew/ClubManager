package Judo::Club::Member;

use strict;
use warnings;

use Judo::Database 'connect_db';

our $club;
our @clubs;

sub add {
    my %args = @_;


    #Judo::Database::insert_member(
#        Clubname => $args{Clubname},
#        Address  => $args{Address},
#        City     => $args{City},
#    );

    return %args;
}

sub get_clubs {
    my $db = connect_db();
    @clubs = $db->selectall_arrayref('SELECT * FROM Clubs');

    return @clubs;
}

sub get {
    my $id = shift;
    my $db = connect_db();
    $club = $db->selectrow_hashref(
        'SELECT * FROM Clubs WHERE ClubID=' . $db->quote($id) );

    return $club;
}

1;
