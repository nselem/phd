use strict;

my $file=$ARGV[0];
my %DATA;
open (FILE,$file) or die "Couldnt open file\n $!";

foreach my $line (<FILE>){
chomp $line;
my @st=split("\t",$line);
$DATA{$st[2]}{$st[1]}=$st[0];
#print "$st[1],$st[2] -> $DATA{$st[1]}{$st[2]}=$st[0]\n";
}

foreach my $x(sort {$a<=>$b} keys %DATA){
	foreach my $y(sort {$a<=>$b} keys %{$DATA{$x}}){
		print "$DATA{$x}{$y}\t";
		}
		print "\n";
	}
