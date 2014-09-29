package Judo::Club::Event;

use strict;
use warnings;

use Judo::Database 'connect_db';

sub list {
    my $id = shift;
    my $db = connect_db();
    my $events = $db->selectall_hashref('SELECT * FROM Events WHERE ClubID='.$db->quote($id),'EventID');

    return $events;
}

sub list_training_sessions {
    my $id = shift;
    my $db = connect_db();
    my $events = $db->selectall_hashref('SELECT * FROM Events WHERE Type=1 AND ClubID='.$db->quote($id),'EventID');

    return $events;
}

sub add {
    my %args = @_;
    $args{ClubID} = delete $args{club};

    Judo::Database::insert(
        table    => 'events',
        data => \%args
    );

    return %args;
}

sub get {
    my $event_id = shift;
    my $db = connect_db();
    my $member = $db->selectrow_hashref(
        'SELECT * FROM Events WHERE EventID=' . $db->quote($event_id) );

    return $member;
}

1;
