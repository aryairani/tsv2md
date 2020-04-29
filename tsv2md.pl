#!/usr/bin/env perl

sub printMC {
  while (my $choice = shift) {
    chomp $choice;
    for (shift) {
      if (/^correct/) { print "- $choice\n"; }
      if (/^incorrect/) { print "- ~~$choice~~\n"; }
    }
  }
}

sub printORD {
  foreach (@_) { chomp; print "1. $_\n"; }
}

sub printTF {
  foreach (@_) { chomp; print "- $_\n";}
}

sub printSR {}

my %renderer = (
  TF => \&printTF,
  MC => \&printMC,
  MA => \&printMC,
  ORD => \&printORD,
  SR => \&printSR,
);

while (my $line = <STDIN>) {
  my ($type, $question, @answers) = split /\t/, $line;
  if ($type =~ /\S+/) {
    print "**$type** $question\n";
    $renderer{$type}->(@answers);
    print "\n";
  }
}
