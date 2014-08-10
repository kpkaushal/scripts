#! /usr/bin/perl
use strict;

my $sWordFile = '/usr/share/dict/words'; # they are all unique 
my $sAnagramOutFile = './out_perl.txt';
my %hAnagrams;

sub parseWordSortComponents
{
    my $sWordToParse = lc shift;
    my @aWordToParse = split (//, $sWordToParse);
    my $sWordSorted = join ("", (sort {$a cmp $b} @aWordToParse));
    return $sWordSorted;
}

sub initVar
{
    if (-e $sWordFile)
    {
        open (WORDFILE, '<', $sWordFile);
        foreach my $sDictWord (<WORDFILE>)
        {
            chomp $sDictWord;
            if ($sDictWord !~ /\W+/)
            {
                my $sAnagramWordSorted = &parseWordSortComponents($sDictWord);
                push (@{$hAnagrams{$sAnagramWordSorted}},  $sDictWord);
            }
        }
        close (WORDFILE);
    }
    else
    {
        print "dictionary file does not exist: $sWordFile\n";
        exit;
    }
    return 1;
}

if (&initVar)
{
    open (my $OUTFILE, '>', $sAnagramOutFile);
    for my $sSortedKey (reverse sort{@{$hAnagrams{$a}} <=> @{$hAnagrams{$b}} || $hAnagrams{$a}[0] cmp $hAnagrams{$b}[0]} keys %hAnagrams)
    {
        if (scalar @{$hAnagrams{$sSortedKey}} > 1) { print $OUTFILE join (",", @{$hAnagrams{$sSortedKey}}), "\n"; }
    }
    close ($OUTFILE);
    print "wrote to: $sAnagramOutFile\n";
}
