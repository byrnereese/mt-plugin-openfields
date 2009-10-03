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

1;
__END__
