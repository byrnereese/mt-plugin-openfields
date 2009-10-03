package OpenFields::Field;

use strict;
use base qw( MT::Object );

__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'blog_id' => 'integer not null',
        'label' => 'string(50)',
        'basename' => 'string(50)',
        'hint' => 'string(255)',
        'type' => 'string(30)',
    },
    indexes => {
#        foo => 1,
    },
    defaults => {
#        foo => 0,
    },
    audit => 1,
    meta => 1,
    datasource => 'field',
    primary_key => 'id',
    class_type => 'field',
});

1;
__END__
