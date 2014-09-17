package Judo::Clubmanager;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Dancer::Plugin::Auth::Extensible;


our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};


get '/admin'  => require_role Admin => sub {
    template 'admin/home';
};




# Admin CLubs
get '/admin/clubs' => require_role Admin => sub {
	my $db = connect_db();
	my @clubs = $db->quick_select('Clubs', {});
	use Data::Dumper;
	template 'admin/clubs/home',
	{
		clubs => Dumper @clubs,
	};
};
get '/admin/clubs/add' => require_role Admin => sub {
	template 'admin/clubs/add';
};
get '/admin/club/:club' => require_role Admin => sub {
	template 'admin/clubs/view';
};


get '/admin/initdb'  => require_role Admin => sub {
	template 'admin/initdb';
};

post '/admin/initdb'  => require_role Admin => sub {
	init_db();
	template 'admin/initdb',
	{ msg => 'Database Initialised! <br /><a href="/admin">Return to admin page</a>'};
};



sub connect_db {
	my $users_dbh = database('users');
}

sub init_db {
  my $db = connect_db();
  #my $schema = read_file('./schema.sql');
$db->do('DROP TABLE Clubs');
$db->do('CREATE TABLE Clubs
(
ClubID int,
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


true;
