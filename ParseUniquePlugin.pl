#!/usr/local/bin/perl
use warnings;
use strict;
use Getopt::Long; 


my ($inputfilename1,$outputfilename, $base,$col, $delim,$printdelim, $printCols,$headerRowFile1,$headerRowFile2,$headerRowFile1toPrint,$term); 



if(@ARGV<1){
	die "Usage: perl parseUniques.pl inputfile\n";
}
# perl parseUniques.pl Bacteria.txt


#GetOptions( 'input=s' => \$inputfilename ,
#	   'output=s' => \$outputfilename,
#	   'col=i'=>\$col,
#	   'delimiter=s'=> \$delim,
#	   'hasHeader=i'=> \$hasHeader);
#
#print "Unprocessed by Getopt::Long\n" if $ARGV[0]; foreach (@ARGV) { print "$_\n"; }
#if ($ARGV[0]) {exit()};

sub input {
$inputfilename1=@_[0];
#$inputfilename1=$ARGV[0];
}

sub run{}

sub output{
$outputfilename=@_[0];#"uniqueBacteria.txt";

open (INFILE1, $inputfilename1 )|| die "Can't open $inputfilename1 \n";


open (OUTFILE, ">$outputfilename")|| die "Can't open $outputfilename\n";

#print "Delims: $delim, $delim2, $printdelim\n";

$delim=mydelim("tab",0);

$printdelim=mydelim("tab",1);
#print "Delims: $delim, $delim2, $printdelim\n";



my $ct=0;
my $termct=0;



$headerRowFile1=1;
$headerRowFile1toPrint=0;
my %hash;
my $extractCol=1;
my @tokens;

while (<INFILE1>) { #Biom File with OTU ID
	if($ct<$headerRowFile1){

		$ct++;
		next;
	}
	else{
		@tokens=split(/$delim/,$_);
		my $lineage=$tokens[0]; # OTU ID
		if (!exists $hash{$lineage}){
			$hash{$lineage}=1;
		}
		else{
			$hash{$lineage}++;
		}


		$ct++;
	}


}

$ct--;
print "count $ct\n";
print "term count $termct\n";
close (INFILE1);

print OUTFILE "Lineage\tCount\n";
while ( (my $k,my $v) = each %hash ) {
    print OUTFILE "$k\t$v\n";
}

close (OUTFILE);
}

 sub mydelim {
my($delim1, $opt) = @_;
my $printdelim1;
if($delim1 eq "tab"){
	$delim1='\t';
	$printdelim1="\t";
}
elsif($delim1 eq "comma"){
	$delim1='\,';
	$printdelim1=",";
}
elsif($delim1 eq "semicolon"){
	$delim1='\;';
	$printdelim1=";";
}
elsif($delim1 eq "pipe"){
	$delim1='\|';
	$printdelim1="\|";
}
elsif($delim1 eq "space"){
	$delim1=" ";
	$printdelim1=$delim;
}else{
	$delim1="-";#detect flag
}
if($opt==1){
	$delim1=$printdelim1;
}

return $delim1;

}
