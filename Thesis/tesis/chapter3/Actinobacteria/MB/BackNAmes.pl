use strict;

my $file=$ARGV[0]; ##bg2
my $tree=$ARGV[1]; ## tree to change names
open (TREE,$tree) or die "$!\n";
my %IDS;

get_names(\%IDS,$file);

foreach my $line (<TREE>){	
	foreach my $key (keys %IDS){
#		print "$key\n";
		if ($line=~/$key:/){
			$line=~s/$key:/$IDS{$key}:/g;
			}
		}
	print $line;
	}
close TREE;
################ Subs ########################
sub get_names{
	my $ref_IDS=shift;
	my $file=shift;

	open (FILE,$file) or die "$!\n";
	foreach my $line (<FILE>){
		chomp $line;
	 	if($line=~/>/){
			if($line=~/BGC/){
	#			print "$line=>$line\n";
				}	
			elsif($line=~/CENTRAL/){
	#			print "$line=>$line\n";
				}
			else{
				my @st=split(/\|/,$line);
				$line=~s/>//;
				$ref_IDS->{$st[1]}=$line;
	#			print"$st[1]=>$line\n";
				}
			}
		}
	close FILE;
	}

