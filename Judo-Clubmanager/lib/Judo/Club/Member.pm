package Judo::Club::Member;

use strict;
use warnings;

use Judo::Database 'connect_db';

our $club;
our @clubs;

sub add {
    my %args = @_;
    $args{ClubID} = delete $args{club};


    Judo::Database::insert(
        table    => 'members',
        data => \%args
    );

    return %args;
}

sub get {
    my $id = shift;
    my $db = connect_db();
    $club = $db->selectrow_hashref(
        'SELECT * FROM Members WHERE MemberID=' . $db->quote($id) );

    return $club;
}

sub list {
    my $id = shift;
    my $db = connect_db();
    my @members = $db->selectall_hashref('SELECT * FROM Members WHERE ClubID='.$db->quote($id),'MemberID');

    return @members;
}


1;
