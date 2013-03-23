#!/usr/bin/perl

use warnings;
use Getopt::Long;
use FindBin qw($Bin);
use lib "$Bin/lib";
use Accessor;
use ProxyChecker;
use IP;

sub check_one_host{
    my ($proxy_ip_adr) = shift;
    my ($ssl_flag) = shift;

    my $initial_port = 1;
    my $current_port = $initial_port;
    my @hostmap_arr;

    my $checker = WWW::ProxyChecker->new(
        timeout       => 10,
        max_kids      => 20,
        check_sites   => [ qw(
                http://google.com
                http://microsoft.com
                http://yahoo.com
            )
        ],
        agent   => 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.12)'
                    .' Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12',
        debug => 1,
    );

    for($current_port=$initial_port; $current_port < 65535; $current_port++){
         push(@hostmap_arr, 'http://'.$proxy_ip_adr.':'.$current_port);

        if ($ssl_flag eq 1){
            push(@hostmap_arr, 'https://'.$proxy_ip_adr.':'.$current_port);
        }
    }
    my $hostmap_ref = \@hostmap_arr;
    my $working_ref= $checker->check($hostmap_ref);

    if (not @$working_ref){
        print "none\n";
    }
    else{
        open(my $fh, '>', $proxy_ip_adr.'.txt');
        print $fh "THESE ARE WORKING PROXY ADRESSES:\n\n";
        foreach my $entry (@$working_ref){
            print $fh $entry."\n";
        }
        close $fh;
    }
        
}

my $ip_range     = '127.0.0.1';
my $expl_ssl     = 0;

GetOptions(
    'range=s'    => \$ip_range,
    'ssl=i'      => \$expl_ssl,
) or die "usage: proxcheck -range 80.90.12/24 -ssl 0\n";

$ip = new Net::IP ($ip_range);
do {
    check_one_host($ip->ip(), $expl_ssl);
} while (++$ip);
