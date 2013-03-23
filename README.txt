PROGRAM: proxcheck.pl
DESCRIPTION: ip range proxy scanner
AUTOR: jlacroix@igd.fraunhofer.de

CHANGELOG:
----------
2013-03-13 (0.01)
*initial release

USAGE:
------
proxcheck -range <ip-adress> -ssl <1|0>

For every host with an working proxy, an
<ip-adress>.txt file is created in the working directory.

OPTIONS:
--------
-range <ip-adress>
Accepts all Net::IP Style IP-Adresses/Ranges/Subnet:
http://search.cpan.org/dist/Net-IP/IP.pm#Object_Creation
e.g.: 195.114.80/24 for a class c subnet.

-ssl <1|0>
0 = only http check (65535 requests per ip adress)
1 = http + https check (131070 requests per ip adress!)

ADDITIONAL OPTIONS IN proxcheck.pl:
-----------------------------------
    my $checker_juicy = WWW::ProxyChecker->new(
        timeout       => 5,
        max_kids      => 20,
        max_working_per_child => 2,         #broken, dont use this
        check_sites   => [ qw(
                http://google.com
                http://microsoft.com
                http://yahoo.com
                http://digg.com
                http://facebook.com
                http://myspace.com
            )
        ],
        agent   => 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.12)'
                    .' Gecko/20080207 Ubuntu/7.10 (gutsy) Firefox/2.0.0.12',
        debug => 1,
    );
    
see also:
http://search.cpan.org/~zoffix/WWW-ProxyChecker-0.002/lib/WWW/ProxyChecker.pm#new