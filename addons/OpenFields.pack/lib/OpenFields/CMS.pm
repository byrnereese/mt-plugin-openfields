package OpenFields::CMS;

use strict;

sub cf_edit {
    my $app     = shift;
    my ($param) = @_;
    my $q       = $app->{query};
    my $blog    = $app->blog;

    $param ||= {};
    return $app->load_tmpl( 'edit.mtml', $param );
}

sub cf_list {
    my $app = shift;
    my ($params) = @_ || {};
    my $q        = $app->{query};
    my $blog     = $app->blog;

    $params->{field_saved} = $q->param('field_saved');
    $params->{screen_id}   = 'list-fields';

    my $code = sub {
        my ( $obj, $row ) = @_;

        $row->{id}         = $obj->id;
        $row->{blog_id}    = $obj->blog_id;
        $row->{label}      = $obj->label;

        my $ts              = $row->{created_on};
        my $datetime_format = MT::App::CMS::LISTING_DATETIME_FORMAT();
        my $time_formatted  = format_ts(
            $datetime_format,
            $ts,
            $app->blog || undef,
            (
                  $app->user
                ? $app->user->preferred_language
                : undef
            )
        );
        $row->{created_on_relative} =
          relative_date( $ts, time, $app->blog ? $app->blog : undef );
        $row->{created_on_formatted} = $time_formatted;
    };

    my $plugin = MT->component('OpenFields');

    $app->listing(
        {
            type  => 'field',
            terms => { blog_id => ( $app->blog ? $app->blog->id : 0 ), },
            args  => {
                sort      => 'created_on',
                direction => 'descend',
            },
            listing_screen => 1,
            code           => $code,
            template       => $plugin->load_tmpl('list.tmpl'),
            params         => $params,
        }
    );
}

1;
__END__
