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

open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while (my $line = <$in>) {
	$line =~ s/[ \r\n]+$//;
	$line =~ s/T/U/g;
	my $rev = reverse $line;
	$rev =~ tr/ACGU/UGCA/;

	my %orfs;
	foreach my $dna ($line, $rev) {
		(my $rna = $dna) =~ s/T/U/g;
		my $offset = 0;
		while ($offset < length $rna) {
			my $start = index $rna, 'AUG', $offset;
			last if ($start < $offset);

			my $orf = substr($rna, $start);
			if ($orf =~ /AUG(?:[ACGU]{3})*?(UAA|UAG|UGA)/) {
				my $end = $-[1];
				$orf = substr($orf, 0, $end);
				$orfs{$orf}++;
				$offset = $start + 3;
				# print "Found: $orf -> ",r2p($orf)," from $start to ",$start+$end,"\n";
			} else {
				# No stop codon
				last;
			}
		}
	}

	print r2p($_),"\n" for (keys %orfs);
}
close $in;

sub r2p {
	my $orf = shift;
	return join ('', map { $tab{$_} } $orf =~ m/([A-Z]{3})/g);
}