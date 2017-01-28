    use strict;
    use warnings;

my $file=$ARGV[0]; ## Matrix from Janaka Script (After Janaka to families.all)
my $fileNames=$ARGV[1]; ##Names fromWhats change
my $frec=$ARGV[2]; ## Minimum frecuencie desired
my $COLS="232003"; ## Number of diferente familie on families.all
my %ORGS=read_ids($file);# OrgS Hash de arrayis
#my $pause=<STDIN>;
my %NAMES=read_names($fileNames);
#$pause=<STDIN>;
my @FUNCS;

my @OCURRENCIA=ocurrencia($COLS);
my @FRECUENT;

open (FUNC,">funciones_$frec") or die "Coul not open funcions file";
for (my $i=0;$i<$COLS;$i++){
# "$OCURRENCIA[$i]|"; Number of genomes in which a function i appears
	if($OCURRENCIA[$i]>$frec){
		$FRECUENT[$i]=1;
		print FUNC "$i\t$OCURRENCIA[$i]\t$FUNCS[$i]\n" ;
		}
	else{$FRECUENT[$i]=0;}
}

estados();

#############################################3
######  subs ########################################
sub read_names{
	my $file=shift;
	my %ORGS;

	open (FILE,$file) or die "Could not open file";
	foreach my $line (<FILE>){
		chomp $line;
		my @sp=split("\t",$line);
		$ORGS{$sp[0]}=$sp[1];		
#		print "$ORGS{$sp[0]}=$sp[1]\n";		
		}
	return %ORGS;
	}
#______________________________________________________________

sub estados{
for my $org(keys %ORGS){
	my $name=$NAMES{$org};
	#$name=~s/\./_/;
	#$name=~s/ /_/;
	if ($org ne ""){
		#print "\n>$org\n";# only print id
		print "\n>$org"."_$name\n"; # To print id and name
		for (my $i=0;$i<$COLS;$i++){
			if($FRECUENT[$i]==1){
				if($ORGS{$org}[$i]){
					print"$ORGS{$org}[$i]";
					}
				else {
					print "0";
					}
				}
			}
		print "\n";
		}
	}
}
#________________________________________________________________________
sub ocurrencia{
my $COLS=shift;
my @OCURRENCIA;
	for (my $i=0;$i<$COLS;$i++){
		$OCURRENCIA[$i]=0;
		for my $org(keys %ORGS){
			#print "\n>$org->$NAMES{$org}\n";
			if($ORGS{$org}[$i]){
				if($ORGS{$org}[$i]==0){
					#print"$ORGS{$org}[$i]";
					}
				else{ #print"1";
					$OCURRENCIA[$i]++;
					}
				}
			else {#print "0";
				}
			}
		}
	return @OCURRENCIA;
	}
#_____________________________________________________
sub read_ids{
	my $file=shift;
	my %ORGS;

	open (FILE,$file) or die "Could not open file";
	my $firstline=<FILE>;
	chomp $firstline;
	@FUNCS=split("\t",$firstline);

	foreach my $line (<FILE>){
		chomp $line;
		#print"\n";
		my @sp=split("\t",$line);
		foreach (my $i=1;$i<@sp;$i++){
			my $peg=$sp[$i];
			#print "¡$peg!";
			my $org=$peg;
			$org=~s/fig\|//;
			$org=~s/.peg.*[_\d]*//;
			#print"¡Org:$org:Peg:$peg\n";
			if($org ne "" and !exists$ORGS{$org}){
				$ORGS{$org}=();	
				}
			if($peg ne ""){
				my @sp2=split("_",$peg);
				my $size=scalar @sp2;
				$ORGS{$org}[$i]="$size";
			#	print "$org: $i :$ORGS{$org}[$i]=$size\n";
				
				}
			else{
				$ORGS{$org}[$i]="0";
				}
			if ($ORGS{$org}[$i]){
				#print "Num:$ORGS{$org}[$i]!\t";
				}			
			}	
#			print "\n$line\n";
		#$ORGS{$sp[0]}=$sp[1];		
		}
	return %ORGS;
	}


