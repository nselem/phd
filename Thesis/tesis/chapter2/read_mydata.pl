use strict;

my $file=$ARGV[0];
my %DATA;
open (FILE,$file) or die "Couldnt open file\n $!";

foreach my $line (<FILE>){
chomp $line;
my @st=split("\t",$line);
my $y=int(61-$st[2]+1); #Tengo 61 proteinas salen en orden inverso del heatplot
#print "$st[1] -> $y\n";
$DATA{$y}{$st[1]}=$st[0];
#print "$st[1],$st[2] -> $DATA{$st[1]}{$st[2]}=$st[0]\n";
}
#my $pause=<STDIN>;
foreach my $y(sort {$a<=>$b} keys %DATA){
	foreach my $x(sort {$a<=>$b} keys %{$DATA{$y}}){
		
		print "$DATA{$y}{$x}\t";
		}
		print "\n";
	}
