#!/usr/bin/perl

use lib qw(Net/Intermapper/lib);
use Net::Intermapper;
use Data::Dumper;

my $intermapper = Net::Intermapper->new(hostname=>"10.0.0.1", username=>"admin", password=>"nmsadmin");
my %vertices = % { $intermapper->vertices };
my @verticenames = keys %vertices;
my $header = 0;
for $vertice (@verticenames)
{ print $vertices{$vertice}->header unless $header;
  print $vertices{$vertice}->toCSV;
  $header++;
}