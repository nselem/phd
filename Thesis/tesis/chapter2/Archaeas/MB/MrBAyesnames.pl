use strict;

my $file=$ARGV[0];

open (FILE,$file) or die "$!\n";

foreach my $line (<FILE>){
	chomp $line;
 	if($line=~/>/){
		my @st=split(/\|/,$line);
		print">$st[1]\n";

		}
	else{print "$line\n";
		}
}

