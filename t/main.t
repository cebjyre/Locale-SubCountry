#------------------------------------------------------------------------------
# Test script for Locale::SubCountry.pm 
#                                            
# Author: Kim Ryan 
# Date  : April 2000                         
#------------------------------------------------------------------------------

use strict;
use Locale::SubCountry;

# We start with some black magic to print on failure.

BEGIN { print "1..16\n"; }

my $australia = new Locale::SubCountry('Australia');
print $australia->code('New South Wales ') eq 'NSW' ? "ok 1\n" : "not ok 1\n";
print $australia->full_name('S.A.') eq 'South Australia' ? "ok 2\n" : "not ok 2\n";

my $upper_case = 1;
print $australia->full_name('Qld',$upper_case) eq 'QUEENSLAND'  ? "ok 3\n" : "not ok 3\n";

print $australia->country_code eq 'AU' ? "ok 4\n" : "not ok 4\n";

print $australia->sub_country_type eq 'State' ? "ok 5\n" : "not ok 5\n";

print $australia->ISO3166_2_code('01') eq 'ACT' ? "ok 6\n" : "not ok 6\n";

print $australia->FIPS10_4_code('ACT') eq '01' ? "ok 7\n" : "not ok 7\n";

my %states =  $australia->full_name_code_hash;
print $states{'Tasmania'} eq 'TAS' ? "ok 8\n" : "not ok 8\n";

%states =  $australia->code_full_name_hash;
print $states{'SA'} eq 'South Australia' ? "ok 9\n" : "not ok 9\n";

my @states = $australia->all_codes;
print @states == 8 ? "ok 10\n" : "not ok 10\n";

my @all_names = $australia->all_full_names;
print $all_names[1] eq 'New South Wales' ? "ok 11\n" : "not ok 11\n";

# Now loop through every country, get every sub country code, convert it to 
# full name, and then back to the origial code. Check that results are 
# identical.

my $world = new Locale::SubCountry::World;
my @all_countries = $world->all_full_names;

my $country;
my $mis_match = 0;
foreach $country ( @all_countries )
{
    my $current_country = new Locale::SubCountry($country);
    my @all_codes = $current_country->all_codes;
    my $current_code;
    foreach $current_code ( @all_codes )
    {
        my $full_name = $current_country->full_name($current_code);
        my $new_code = $current_country->code($full_name);
        if ( $new_code ne $current_code )
        {
            $mis_match++;
        }
   }
}

# There are 12 sub countries with duplicate codes 
print $mis_match == 12 ? "ok 12\n" : "not ok 12\n";

my %countries =  $world->full_name_code_hash;
print $countries{'NEW ZEALAND'} eq 'NZ' ? "ok 13\n" : "not ok 13\n";

%countries =  $world->code_full_name_hash;
print $countries{'GB'} eq 'UNITED KINGDOM' ? "ok 14\n" : "not ok 14\n";

my @all_country_codes = $world->all_codes;
print $all_country_codes[0] eq 'AE' ? "ok 15\n" : "not ok 15\n";

my @all_country_names = $world->all_full_names;
print $all_country_names[1] eq 'ALBANIA' ? "ok 16\n" : "not ok 16\n";



