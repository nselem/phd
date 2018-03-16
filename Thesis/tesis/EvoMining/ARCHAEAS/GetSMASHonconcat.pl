use strict;
###############################
####

my $fileCENTRAL=$ARGV[0]; ##Central.numbers
## tab separated family_number  family_Name

my $fileSMASH=$ARGV[1]; ##SMASH file


open (FILE,$fileCENTRAL) or die;

my @SMASH=getSMASH($fileSMASH);
print "SMASH load finished";
my $pause=<STDIN>;

my $fasta;

foreach my $line (<FILE>){
	chomp $line;
	my @st=split(/\t/,$line);
	 $fasta=$st[0].".concat.fasta";
	print"$st[1]\t";
	getSMASHonTree($fasta,@SMASH);
		}

sub getSMASH{
	my $fileSMASH=shift;
	my  @SMASH;

	open (FSMASH,$fileSMASH) or die;

	foreach my $line (<FSMASH>){
		chomp $line;
		my@parts=split(/\t/,$line);
		##print "#$parts[1]#\n";
		#my $pause=<STDIN>;
		if(!($parts[1]~~@SMASH)){
			push(@SMASH,$line);
			}
		}	
	close FSMASH;
	return @SMASH;

}


sub getSMASHonTree{
	my $fileFasta=shift;

	my @SMASH=@_;

	#buscar los Elementos de BBH que estan en fasta

	my @FASTA;
	open (FILE,">$fileFasta\.smash");
	#Read BBBH file

	#Read fasta file
	open (FASTA,$fileFasta) or die;
	my $Count=0;

	foreach my $line (<FASTA>){
		chomp $line;
		if ($line=~/>/ and $line=~/gi/ ){
		my @st=split(/\|/,$line);
		#print "$st[1]\n";
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
