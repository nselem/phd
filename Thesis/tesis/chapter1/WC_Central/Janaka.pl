#!/usr/bin/perl
   
use strict;
use Data::Dumper;
use Try::Tiny;

my %proPegId;
my %genome;
my %gCheck;
my $flag =1;
my %count;
my $counter =0;

my $file1=$ARGV[0];
my $file2=$ARGV[1];
open INFILE, $file1 or die "couldn't open the file $!\n";


my %gNames;
my @gNameArr;
my $gArrRef;
my @pro;
=head
while ( my $ip = <INFILE>){
    chomp $ip;
    my @gN = split /\t/, $ip;
    $gNames{$gN[0]} = $gN[1];
    push (@gNameArr, $gN[0]);
    print "***@gN***\n";
    #$gArrRef = \@gNameArr;
}
=cut
close INFILE;
my $pre_index = 1;
my %masterPro;
        my $count=0;
my %fLPro;

open INFILEF, $file2 or die "couldn't open the file $!\n";

while (my $if = <INFILEF>){
        chomp $if;
        my($index, $proName, $pegFamId, $peg, $length, $sc1, $sc2, $sc3 ) = split(/\t/,$if);

        my @p = split /.peg/, $peg;
        $sc3 = abs($sc3);    
        my $proFam = $proName."_".$pegFamId."_".$peg."_".$length;    
        #my $mod_p = $proName."_".$pegFamId."_".$p[0];
        my $mod_p = $proName."_".$pegFamId;
        my $proID = $proName."_".$pegFamId;
        my $short_id = $peg."_".$length;

    if ($pre_index == $index){
         $count++;
       if (exists $gCheck{$mod_p}){
        
            if ( abs($gCheck{$mod_p}->[1]) >  abs ($sc3) ){
                $proPegId{$p[0]}->{$mod_p} = [$short_id,$proFam, $sc3];
                push (@{$masterPro{$p[0]}}, $mod_p);
                #push (@pro, $proID);
                $fLPro{$proID}=1;
            }   

       }  

        else{

          $gCheck{mod_p} = [$proName, $sc3, $p[0]]; 
          $proPegId{$p[0]}->{$mod_p} = [$short_id, $proFam, $sc3];
          push (@{$masterPro{$p[0]}}, $mod_p);
          #push (@pro, $proID);
          $fLPro{$proID}=1;

        }

    }
    else{
        $pre_index = $index;
        #my %gCheck;
        

    }

}
print "\t";
foreach my $p (sort keys( %fLPro)){

    push (@pro, $p);
    print "$p\t";

}




print "\n";




    foreach my $k (keys(%proPegId)){
            print "$k\t";
       # foreach my $k2 (keys(%{$proPegId{$k}})){
        #    my @pSp = split /_fig/, $k2;

            for(my $i =0; $i< @pro; $i++){
                my $each_item = $pro[$i];
                my $row = [];

                if (exists $proPegId{$k}->{$pro[$i]}){
                #if ($pSp[0] eq $pro[$i]){    
            
                    print "$proPegId{$k}->{$pro[$i]}->[0]\t";
                }
                else{
                    print "\t";
            
                }
            }
            print "\n";
        #}

#die;

    }

#print &Dumper (\%proPegId);
#die;



