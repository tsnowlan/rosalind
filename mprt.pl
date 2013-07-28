#!/usr/bin/perl
use strict;
use warnings;
use LWP::Simple;

die "No file given\n" unless (@ARGV);
open my $in, '<', $ARGV[0] or die "$ARGV[0]: $!";
while ($_ = <$in>) {
	chomp;
	my $id = $_;
	my $url = "http://www.uniprot.org/uniprot/$id.fasta";
	my $fasta = join '', grep { ! /^>/ } split /\n/, get($url);
	my $motif = qr/(N[^P][ST][^P])/;
	my $motif_len = 4;
	my @locs;

	for my $i (0..length($fasta)) {
		next unless (substr($fasta, $i, $motif_len) =~ /$motif/i);
		push @locs, $i+1;
	}
    print "$id\n@locs\n" if (@locs);
}
close $in;