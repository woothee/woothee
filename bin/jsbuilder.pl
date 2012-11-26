#!/usr/bin/env perl

use strict;
use warnings;
use File::Basename;

my $TEMPLATE = <<'EOF';
  var %s = {};
  (function(){
    var exports = %s;
    /* CODE: %s.js */
%s
  })();
EOF
my @IMPORT_LIST = qw(dataset util browser os mobilephone crawler appliance misc woothee);
my $jslibdir = dirname(__FILE__) . '/../js/lib/';
my $targetpath = dirname(__FILE__) . '/../js/release/woothee.js';

open(my $dfh, '-|', 'env', 'LANG=C', 'date');
my $generated_timestamp = <$dfh>;
chomp $generated_timestamp;
close($dfh);
open(my $ufh, '-|', 'env', 'LANG=C', 'whoami');
my $generated_username = <$ufh>;
chomp $generated_username;
close($ufh);

my @defs = (<<"EOI"
// GENERATED at $generated_timestamp by $generated_username
EOI
        );

foreach my $name (@IMPORT_LIST) {
    open(my $jsfh, $jslibdir . $name . '.js');
    my @rawlines = <$jsfh>;
    my @lines = ();
    my $header = 0;
    foreach my $rawline (@rawlines) {
        if ($rawline =~ m!/\* HEADER BEGIN \*/!) {
            $header = 1;
            next;
        } elsif ($rawline =~ m!/\* HEADER END \*/!) {
            $header = 0;
            next;
        } elsif ($header) {
            next;
        }
        push @lines, (' ' x 4) . $rawline;
    }
    push @defs, sprintf($TEMPLATE, $name, $name, $name, join('', @lines));
}

open(my $fh, '>', $targetpath)
    or die "failed to open $targetpath";
while (my $line = <DATA>) {
    if ($line =~ m!/\* EXTRACT \*/!) {
        print $fh @defs;
    } else {
        print $fh $line;
    }
}
close($fh);
exit(0);

__DATA__
(function (){
  var root = this;
  // embed: dataset, util, browser, mobilephone, crawler, appliance, misc, woothee

  /* EXTRACT */

  var updateMap = util.updateMap,
      updateCategory = util.updateCategory,
      updateOs = util.updateOs,
      updateVersion = util.updateVersion;

  // AMD / RequireJS
  if (typeof define !== 'undefined' && define.amd) {
    define('woothee', [], function () {
      return woothee;
    });
  }
  // Node.js
  else if (typeof module !== 'undefined' && module.exports) {
    module.exports = woothee;
  }
  // included directly via <script> tag
  else {
    root.woothee = woothee;
  }
})();
