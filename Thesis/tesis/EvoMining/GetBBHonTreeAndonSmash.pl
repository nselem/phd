use strict;
## ids in bbh.tree
# that are also on antiSMASH


my $fileCENTRAL=$ARGV[0];
open (FILE,$fileCENTRAL) or die;

my $fasta;
my$central;

##############################################
foreach my $line (<FILE>){
	chomp $line;
	my @st=split(/\t/,$line);
	 $fasta=$st[0].".concat.fasta.line.SMASH";
	 $central=$st[1].".bbh.tree";
		print "$fasta\t$central";
		getCentralTreeonSMASH($central,$fasta);
		}

##########################################

sub getCentralTreeonSMASH{
	my $fileBBH=shift;
	my $fileSMASH=shift;
	#buscar los Elementos de BBH que estan en SMASH

	my  @BBH;
	my @FASTA;
	open (FILE,">$central\.smash");
	#Read BBBH file
	open (BBH,$fileBBH) or die;

	foreach my $line (<BBH>){
		chomp $line;
		push(@BBH,$line);
		#print "$line\n";
		}	

	#Read fasta file
	open (SMASH,$fileSMASH) or die "Couldn open $fileSMASH";
	my $Count=0;

	foreach my $line (<SMASH>){
		chomp $line;
#		print "$line\n";
		my @st=split('#',$line);
#		print "$st[1]\n";
		if(!($st[1]~~@FASTA)){
			push(@FASTA,$st[1]);
			if($st[1]~~@BBH){
				$Count++;
#				print FILE "$st[1]\n";
				}
			}
	}
close FILE;
print "\t$Count\n";
#elements on BBH also on fatsa
}
