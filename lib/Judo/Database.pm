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

    my $table = $args{table};
    my %data =  %{ $args{data} };

    my @fields = keys %data;
    my @values = values %data;

    my $sql = sprintf "insert into %s (%s) values (%s)",
        $table, join(",", @fields), join(",", ("?")x@fields);

    my $db = connect_db();
    my $sth = $db->do($sql,undef,@values);

    return %args;
}

sub remove {
    my %args = @_;
    my $table = $args{table};
    my %data =  %{ $args{data} };

    my @fields = keys %data;
    my @values = values %data;

    if ($data{MemberID}) 
    {
        my $sql = sprintf "DELETE FROM %s WHERE %s = %s",
            $table, 'MemberID', $data{MemberID};

        my $db = connect_db();
        my $sth = $db->do($sql);
    }

    return %args;
}


sub insert_club {
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
