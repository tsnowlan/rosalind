#!/usr/bin/perl -w
use strict;

my %tab = (
	UUU => 'F' ,      CUU => 'L' ,      AUU => 'I' ,      GUU => 'V' ,
	UUC => 'F' ,      CUC => 'L' ,      AUC => 'I' ,      GUC => 'V' ,
	UUA => 'L' ,      CUA => 'L' ,      AUA => 'I' ,      GUA => 'V' ,
	UUG => 'L' ,      CUG => 'L' ,      AUG => 'M' ,      GUG => 'V' ,
	UCU => 'S' ,      CCU => 'P' ,      ACU => 'T' ,      GCU => 'A' ,
	UCC => 'S' ,      CCC => 'P' ,      ACC => 'T' ,      GCC => 'A' ,
	UCA => 'S' ,      CCA => 'P' ,      ACA => 'T' ,      GCA => 'A' ,
	UCG => 'S' ,      CCG => 'P' ,      ACG => 'T' ,      GCG => 'A' ,
	UAU => 'Y' ,      CAU => 'H' ,      AAU => 'N' ,      GAU => 'D' ,
	UAC => 'Y' ,      CAC => 'H' ,      AAC => 'N' ,      GAC => 'D' ,
	UAA => ''  ,	  CAA => 'Q' ,      AAA => 'K' ,      GAA => 'E' ,
	UAG => ''  ,	  CAG => 'Q' ,      AAG => 'K' ,      GAG => 'E' ,
	UGU => 'C' ,      CGU => 'R' ,      AGU => 'S' ,      GGU => 'G' ,
	UGC => 'C' ,      CGC => 'R' ,      AGC => 'S' ,      GGC => 'G' ,
	UGA => ''  ,	  CGA => 'R' ,      AGA => 'R' ,      GGA => 'G' ,
	UGG => 'W' ,      CGG => 'R' ,      AGG => 'R' ,      GGG => 'G'
);

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my ($dna, @introns) = <$in>;
close $in;
$dna =~ s/[ \r\n]+$//;
my $intron_str = join '|', @introns;
$intron_str =~ s/\s//gs;
(my $exons = $dna) =~ s/$intron_str//g;
$exons =~ tr/T/U/;
my $prot = r2p($exons);
print "$prot\n";

sub r2p {
	my $rna = shift;
	return join ('', map { $tab{$_} } $rna =~ m/([A-Z]{3})/g);
}