package Judo::Clubmanager;
use Dancer ':syntax';
use Dancer::Plugin::Database;
use Dancer::Plugin::Auth::Extensible;

use Judo::Club qw( add_club get_clubs get_club );



our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};


get '/admin'  => require_role Admin => sub {
    template 'admin/home';
};


# Admin Clubs
get '/admin/clubs' => require_role Admin => sub {
    my @clubs = get_clubs();
	template 'admin/clubs/home',
	{
		clubs => @clubs,
	};
};

get '/admin/clubs/add' => require_role Admin => sub {
	template 'admin/clubs/add';
};

post '/admin/clubs/add' => require_role Admin => sub {
    my %args = params();
    my %club = add_club(%args);
    template 'admin/clubs/add',
    { club => \%club };
};


get '/admin/clubs/:club' => require_role Admin => sub {

    my $club = get_club(param('club'));

	template 'admin/clubs/view',
    {
        club => $club,
    };
};


get '/admin/initdb'  => require_role Admin => sub {
	template 'admin/initdb';
};

post '/admin/initdb'  => require_role Admin => sub {
	Judo::Database::init_db();
	template 'admin/initdb',
	{ msg => 'Database Initialised! <br /><a href="/admin">Return to admin page</a>'};
};



true;
