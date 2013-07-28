#!/usr/bin/perl -w
use strict;
use Data::Dumper;

my $file = shift @ARGV;
die "No file given, or file does not exist\n" unless ($file and -e $file);

my %nucs;
open my $in, '<', $file or die "cannot open '$file' for reading: $!'";
while (my $line = <$in>) {
	chomp $line;
	$nucs{$_}++ for (split //, $line);
}
print "Read $. rows from $file\n";
close $in;

print Dumper \%nucs;