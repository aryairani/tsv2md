#!/usr/bin/env perl

# $bullet will match optional spaces followed by non-spaces
my $bullet = qr/^\s*\S+/;
my $strikeout = qr/\~\~(.*?)\~\~/;

sub getLine { scalar(<STDIN>); }

sub mc {
  my @answers; # temporary array
  while (my $line = getLine) { # defined above
    last unless $line =~ /\S/; # exit the loop if it got only whitespace
    if ($line =~ /$bullet $strikeout/) {
      push @answers, ($1, "incorrect");
    }
    elsif ($line =~ /$bullet (.*)$/) {
      push @answers, ($1, "correct");
    }
  }
  return @answers;
}

sub tf {
  getLine =~ /$bullet (.+)$/;
  return $1;
}

sub order {
  my @answers;
  while (my $line = getLine) {
    last unless $line =~ /\S/;
    push @answers, ($1) if $line =~ /$bullet (.+)$/;
  }
  return @answers;
}

sub sr {}

%converters = (
  TF => \&tf,
  MC => \&mc,
  MA => \&mc,
  SR => \&sr,
  ORD => \&order,
);

while (my $line = getLine) {
  ## look for a question type in bold, followed by a question
  if ($line =~ /^\s*\*\*(\S+)\*\* (.+)$/) {
    my ($type, $question) = ($1, $2);
    print join("\t", $type, $question, $converters{$type}->());
    print "\n";
  }
}
