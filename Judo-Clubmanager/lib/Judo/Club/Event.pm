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

sub attendees {
    my $event_id = shift;
    my $db = connect_db();
    my $attendees = $db->selectall_hashref(
        'SELECT MemberID from attendance WHERE EventID=' . $db->quote($event_id), 'MemberID'
    );
    return $attendees;
}

sub get {
    my $event_id = shift;
    my $db = connect_db();
    my $event = $db->selectrow_hashref(
        'SELECT * FROM Events WHERE EventID=' . $db->quote($event_id) );

    return $event;
}

1;
