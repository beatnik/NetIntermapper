#!/usr/bin/perl

use lib qw(Net/Intermapper/lib);
use Net::Intermapper;
use Data::Dumper;

my $intermapper = Net::Intermapper->new(hostname=>"10.132.96.100", username=>"hendrikvb", password=>"L33sb03k3n","format"=>"csv");
$intermapper->devices;
