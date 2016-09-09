#!/usr/bin/perl

use lib qw(Net/Intermapper/lib);
use Net::Intermapper;
use Data::Dumper;

my $intermapper = Net::Intermapper->new(hostname=>"10.0.0.1", username=>"admin", password=>"nmsadmin");
my %interfaces = % { $intermapper->interfaces };
my @interfacenames = keys %interfaces;
my $header = 0;
for $interface (@interfacenames)
{ print $interfaces{$interface}->header unless $header;
  print $interfaces{$interface}->toCSV;
  $header++;
}
