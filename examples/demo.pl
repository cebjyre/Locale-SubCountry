#!/usr/bin/perl

# demo script for Locale::SubCountry

use strict;
use Locale::SubCountry;

# For every country
#    list the country name
#    if any subcountries, list each code and full name on a new line

my $world = new Locale::SubCountry::World;
my @all_countries  = $world->all_full_names;

my %all_letters;
foreach my $country ( sort @all_countries )
{
    print "\n\n$country\n";    
    my $current_country = new Locale::SubCountry($country);
  
    # Are there any sub countires?
    if ( $current_country->has_sub_countries )
    {
        # Get a hash, key is sub country code, value is full anme, such as 
        # SA => 'South Australia', VIC => 'Victoria' ...
        my %sub_countries_keyed_by_code  = $current_country->code_full_name_hash;
        foreach my $code ( sort keys %sub_countries_keyed_by_code )
        {
            printf("%-3s : %s\n",$code,$sub_countries_keyed_by_code{$code});
        }
    }
}