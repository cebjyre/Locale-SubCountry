#------------------------------------------------------------------------------
# Test script for Locale::SubCountry.pm 
#                                            
# Author: Kim Ryan (kimaryan@ozemail.com.au) 
# Date  : April 2000                         
#------------------------------------------------------------------------------

use strict;
use Locale::SubCountry;

# We start with some black magic to print on failure.

BEGIN { print "1..4\n"; }

my $australia = new Locale::SubCountry('Australia');
print $australia->code('New South Wales ') eq 'NSW' ? "ok 1\n" : "not ok 1\n";
print $australia->full_name('S.A.') eq 'South Australia' ? "ok 2\n" : "not ok 2\n";

my $upper_case = 1;
print $australia->full_name('Qld',$upper_case) eq 'QUEENSLAND'	? "ok 3\n" : "not ok 3\n";

# Now loop through every country, get every code, convert it to full name,
# and then back to the origial code. Check that results are identical.

my @all_countries = 	&all_countries;
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
      # Indonesain province of Kalimantan Timur has two different codes, 
      # so it cannot be coverted	from full name back to it's original code
	   unless ( $full_name eq 'Kalimantan Timur' )
	   {
      	if ( $new_code ne $current_code )
      	{
		   	$mis_match++;
      	}
	   }
   }
}
print $mis_match == 0 ? "ok 4\n" : "not ok 4\n";


