# Concordance for a book/paragraph/passage -- the number of 
# times each word appears -- and then print the top N occurring words and how many
# times they occur. N can be either hardcoded or a parameter.
 
#! /usr/bin/perl -w
use strict;
 
my $file = './theHungerGames.txt';
my $maxPrint = 10;
my %wordDict;
 
if (-e $file)
{
    open (FILEHD, '<', $file) or die $!;
    foreach my $line (<FILEHD>)
    {
        chomp($line);
        my @tempArr = split(/ /, $line);
        foreach my $arrElement (@tempArr)
        {
            my $lowerWord = lc $arrElement;
            if (defined $wordDict{$lowerWord})
            {
                $wordDict{$lowerWord} += 1;
            }
            else
            {
                $wordDict{$lowerWord} = 1;
            }
        }
    }

    my @sortedKeys = reverse sort {$wordDict{$a} <=> $wordDict{$b}} keys %wordDict; 
    
    for (my $i = 0; $i < $maxPrint; $i++)
    {
        if (defined $sortedKeys[$i])
        {
            my $tempKey = $sortedKeys[$i];
            print "word $tempKey occurred $wordDict{$tempKey} times\n";
        }
    }
}
