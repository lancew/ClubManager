package Judo::Database;

use strict;
use warnings;

our ( @ISA, @EXPORT_OK );

BEGIN {
    require Exporter;
    @ISA       = qw(Exporter);
    @EXPORT_OK = qw(connect_db init_db);    # symbols to export on request
}

use DBI;
use DBIx::Migration;

sub connect_db {
    my $clubs_dbh
        = DBI->connect( "dbi:SQLite:dbname=data/clubmanager.db", "", "" );
}

sub insert {
    my %args = @_;
    my $db = connect_db();

    my @values = values %args;

    $db->do( 'INSERT INTO Clubs (ClubName,Address,City) VALUES (?,?,?)',
        undef, @values );

}

sub version {
    my $m = DBIx::Migration->new(
        {
            dsn => 'dbi:SQLite:data/clubmanager.db',
            dir => 'data/migrations'
        }
    );
    return $m->version;
}

sub migration {
    my $version = 1;
    my $m = DBIx::Migration->new(
        {
            dsn => 'dbi:SQLite:data/clubmanager.db',
            dir => 'data/migrations'
        }
    );

    $version = $m->version;
    $m->migrate(++$version);
    return $m->version;
}


1;
