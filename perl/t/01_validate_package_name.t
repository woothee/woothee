use strict;
use warnings;
use Test::More;
use Path::Class;
use File::Basename;

sub walker {
    my $dir = shift;
    for my $path ($dir->children) {
       if (-d $path) {
           walker($path);
           next;
       }

       # ignore vim's swap files and emacs's backups
       next if basename($path) =~ m{^\..+(\.sw[po]|\~)$};

       # there are only normal files and symbolic links
       unless (-f $path || -l $path) {
           ok 0, "$path is not a plain file";
           next;
       }

       # expects filename matches 'lib/.+\.pm'
       my($name) = $path =~ m{^lib/(.+)\.pm$};
       unless ($name) {
           ok 0, "$path is not a package file?";
           next;
       }
       $name =~ s{/}{::}g;
       like $path->slurp, qr/(?:^|\n)package $name;/, "$path -> $name";
    }
}

walker dir('lib');

done_testing;
