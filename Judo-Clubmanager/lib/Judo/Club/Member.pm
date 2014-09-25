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
    my $member_id = shift;
    my $db = connect_db();
    my $member = $db->selectrow_hashref(
        'SELECT * FROM Members WHERE MemberID=' . $db->quote($member_id) );

    return $member;
}

sub list {
    my $id = shift;
    my $db = connect_db();
    my @members = $db->selectall_hashref('SELECT * FROM Members WHERE ClubID='.$db->quote($id),'MemberID');

    return @members;
}


1;
