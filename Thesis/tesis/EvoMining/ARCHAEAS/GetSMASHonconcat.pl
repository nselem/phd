use strict;
###############################
####

my $fileCENTRAL=$ARGV[0]; ##Central.numbers
## tab separated family_number  family_Name

my $fileSMASH=$ARGV[1]; ##Central.numbers


open (FILE,$fileCENTRAL) or die;

my $fasta;

foreach my $line (<FILE>){
	chomp $line;
	my @st=split(/\t/,$line);
	 $fasta=$st[0].".concat.fasta";
	getSMASHonTree($fasta,$fileSMASH);
		}

sub getSMASHonTree{
	my $fileFasta=shift;
	my $fileSMASH=shift;
	#buscar los Elementos de BBH que estan en fasta

	my  @SMASH;
	my @FASTA;
	open (FILE,">$fasta\.smash");
	#Read BBBH file
	open (SMASH,$fileSMASH) or die;

	foreach my $line (<SMASH>){
		chomp $line;
		my@parts=split(/\t/,$line);
#		print "#$parts[1]#\n";
#		my $pause=<STDIN>;
		if(!($parts[1]~~@SMASH)){
			push(@SMASH,$line);
			}
		}	

	#Read fasta file
	open (FASTA,$fileFasta) or die;
	my $Count=0;

	foreach my $line (<FASTA>){
		chomp $line;
		if ($line=~/>/ and $line=~/gi/ ){
		my @st=split(/\|/,$line);
		if($st[1]~~@SMASH){
			$Count++;
			print FILE "$st[1]\n";
			}
		}
	}
close FILE;
print "\t$Count\n";
#elements on BBH also on fatsa
}
