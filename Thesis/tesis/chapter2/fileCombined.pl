#!/usr/bin/perl -w
use strict;
use IO::File;


#interleave files, first argument is line count, rest are files.

my $lc = `wc -l $ARGV[0] | cut -f1 -d' '`;
my @fhs;

foreach (@ARGV) {
  my $fh = new IO::File;
  open ($fh, "<$_");
  push @fhs, $fh;
}

while (--$lc) {
  foreach (@fhs) {
    print scalar(<$_>);
  }
}
