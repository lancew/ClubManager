package Judo::Clubmanager;
use Dancer ':syntax';

use Dancer::Plugin::Auth::Extensible;

use Judo::Club;
use Judo::Club::Member;

our $VERSION = '0.1';

get '/' => sub {
    template 'index';
};

get '/admin' => require_role Admin => sub {
    template 'admin/home';
};

# Admin Clubs
get '/admin/clubs' => require_role Admin => sub {
    my @clubs = Judo::Club::list();
    template 'admin/clubs/home', { clubs => @clubs, };
};

get '/admin/clubs/add' => require_role Admin => sub {
    template 'admin/clubs/add';
};

post '/admin/clubs/add' => require_role Admin => sub {
    my %args = params();
    my %club = Judo::Club::add(%args);
    template 'admin/clubs/add', { club => \%club };
};

get '/admin/clubs/:club' => require_role Admin => sub {

    my $club = Judo::Club::get( param('club') );

    template 'admin/clubs/view', { club => $club, };
};

# Members
get '/admin/clubs/:club/members' => require_role Admin => sub {
    my @members = Judo::Club::Member::list( param('club') );
    template 'admin/clubs/members/list',
    { club_id => param('club'), members => @members };
};

get '/admin/clubs/:club/members/add' => require_role Admin => sub {
    template 'admin/clubs/members/add',
    { club_id => param('club') };
};


post '/admin/clubs/:club/members/add' => require_role Admin => sub {
    my %args = params();
    my %club = Judo::Club::Member::add(%args);
    template 'admin/clubs/members/add', { %args };
};


# Database
get '/admin/migration' => require_role Admin => sub {
    my $version = Judo::Database::version();
    template 'admin/migration', { version => $version };
};

post '/admin/migration' => require_role Admin => sub {
    my $version = Judo::Database::migration();
    template 'admin/migration',
        { msg =>
            "Database migration complete! <br />
            Version: $version <br />
            <a href='/admin'>Return to admin page</a>",
          version => $version,
        };
};



true;
