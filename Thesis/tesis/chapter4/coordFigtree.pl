use strict;

my $file= $ARGV[0];
open (FILE,$file) or die $!;

my %COORDS;

foreach my $line (<FILE>){
chomp $line;
#print $line;
	my $y;
	my $name;
	if ($line=~/matrix/ and $line=~/190/){  ## la coordenada x de la transformacion
		#print "Line: $line\n";
		$line=~s/190,(\d*\.*\d*)//;
	 	$y=$1;
		print "$y\t";
		}
	if ($line=~/\/text/){
		$line=~s/>(\w*)<\/text//;
		$name=$1;
		print "$name\n";
		}
}
