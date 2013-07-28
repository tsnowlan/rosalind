#!/usr/bin/perl -w
use strict;
use Math::Round;

print "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
my @data = <$in>;
close $in;

my (%gc, $max);
while (my $line = shift @data) {
	$line =~ s/[ \r\n]$//;
	my $id = substr($line, 1);
	my $dna = '';
	
	do { $dna .= shift @data } while (@data and $data[0] !~ /^>/);
	$dna =~ s/\s//gs;
	my $gc = 0;
	$gc++ while $dna =~ /[GC]/g;
	my $gc_len = nearest( 0.01, $gc / length($dna) * 100 );
	$gc{$id} = $gc_len;

	if (!defined $max or  $gc_len > $gc{$max}) {
		$max = $id;
	}
}

print "$max\n";
print "$gc{$max}%\n";