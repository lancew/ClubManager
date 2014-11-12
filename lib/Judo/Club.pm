package Judo::Club;

use strict;
use warnings;

use Judo::Database 'connect_db';

our $club;
our @clubs;

sub add {
    my %args = @_;

    Judo::Database::insert(
        table    => 'clubs',
        data => \%args
    );

    return %args;
}

sub list {
    my $db = connect_db();
    my $clubs = $db->selectall_hashref('SELECT * FROM Clubs', 'ClubID');

    return $clubs;
}

sub get {
    my $id = shift;
    my $db = connect_db();
    my $club = $db->selectrow_hashref(
        'SELECT * FROM Clubs WHERE ClubID=' . $db->quote($id) );
    my $members = $db->selectrow_array(
        'SELECT count(*) FROM members WHERE  ClubID=' . $db->quote($id)
    );
    my $events = $db->selectrow_array(
        'SELECT count(*) FROM Events WHERE ClubID=' . $db->quote($id)
    );
    my $sessions_week = $db->selectrow_array(
        'SELECT count(*) FROM Events
                        WHERE Type=1
                          AND Active=1
                          AND strftime("%W",EventDate)=strftime("%W","now")
                          AND ClubID=' . $db->quote($id)
    );

    return (club => $club,
            members => $members,
            events => $events,
            sessions_week => $sessions_week,
            );
}

1;
