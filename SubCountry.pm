=head1 NAME

Locale::SubCountry - convert state, province, county etc names to/from code  

=head1 SYNOPSIS

   use Locale::SubCountry;

   $australia = new Locale::SubCountry('Australia');

   print($australia->code('New South Wales ')); # NSW
   print($australia->full_name('S.A.'));        # South Australia
   
   $upper_case = 1;
   print($australia->full_name('Qld',$upper_case));     # QUEENSLAND
   
   %all_australian_states = $australia->full_name_code_hash;
   foreach $abbrev ( sort keys %australian_states )
   {
      printf("%-3s : %s\n",$abbrev,%all_australian_states{$abbrev});
   }
   
   %all_australian_states = $australia->code_full_name_hash;
   
   @australian_names = $australia->all_full_names;
   @australian_codes = $australia->all_codes;
   
   $UK_counties = new Locale::SubCountry('UK');
   print($UK_counties->full_name('DUMGAL'));  # Dumfries & Galloway
   

=head1 REQUIRES

Perl 5.005 or above



=head1 DESCRIPTION

This module allows you to convert the full name for a countries administrative
region to the code commonly used for postal addressing. The reverse conversion
can also be done.

Subcountry regions are defined as states in the US and Australia, provinces 
in Canada and counties in the UK.

Additionally, names and codes for all subcountry regions in a country can be 
returned as either a hash or an array. 

=head1 METHODS

=head2 new

The C<new> method creates an instance of a subcountry object. This must be 
called  before any of the following methods are invoked. The method takes a 
single argument, the name of the country that contains the subcountries 
 that you want to work with. These are currently:

   Australia
   Brazil
   Canada
   Netherlands
   UK
   USA
   
All forms of upper/lower case are acceptable in the country's spelling. If a 
country name is supplied that the module doesn't recognise, it will die.   


=head2 code

The C<code> method takes the full name of a subcountry in the currently
assigned country and returns the regions code. The full name can appear
in mixed case. All white space and non alphabetic characters are ignored, 
except the single space used to separate subcountries names such as 
"New South Wales".  The code is returned as a capitalised string, or 
"unknown" if  no match is found.

=head2 full_name

The C<name> method takes the code of a subcountry in the currently
assigned country and returns the subcountries full name. The code can appear
in mixed case. All white space and non alphabetic characters are ignored. The
full  name is returned as a title cased string, such as "South Australia".

If an optional argument is supplied and set to a true value, the full name is
returned as an upper cased string.


=head2 full_name_code_hash

Returns a hash of name/code pairs for the currently assigned country, 
keyed by subcountry name.

=head2 code_full_name_hash

Returns a hash of code/name pairs for the currently assigned country,
keyed by subcountry code.


=head2 all_full_names

Returns an array of subcountry names for the currently assigned country, 
sorted alphabetically. 

=head2 all_codes

Returns an array of subcountry codes for the currently assigned country, 
sorted alphabetically. 


=head1 SEE ALSO

ISO 3166-2:1998, Standard for naming sub country codes
Locale::Country
Geography::States


=head1 LIMITATIONS

If a regions full name contains the word 'and', it is represented by an
ampersand, as in 'Dumfries & Galloway'.

ISO 3166-2:1998 defines all subcountry codes as being 2 letters. This works
for USA, Canada etc. In Australia and the UK, this method of abbreviation is
not widely accepted.	 For example, the ISO code for 'New South Wales' is 'NS',
but 'NSW' is the only abbreviation that is actually used. I could add an
enforce ISO-3166 flag if  needed.



=head1 BUGS

  

=head1 COPYRIGHT


Copyright (c) 2000 Kim Ryan. All rights reserved.
This program is free software; you can redistribute it 
and/or modify it under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html).


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimaryan@ozemail.com.au> in 2000.

Terrence Brannon produced  Locale::US, which was the starting point for
this module. 

codes for Canadian, Netherlands and Brazilian regions were taken from 
Geography::States.

Mark Summerfield and Guy Fraser provided the list of UK counties.


=cut

#------------------------------------------------------------------------------

package Locale::SubCountry;

use strict;
require 5.005;  # Needed for use of the INIT subroutine


use Exporter;
use vars qw (@ISA $VERSION);

$VERSION   = '1.02';
@ISA       = qw(Exporter);

my %lookup;

#------------------------------------------------------------------------------
# Create new instance of a sub country object

sub new
{
   my $class = shift;
   my ($country) = @_;
   
   my %countries = 
   (
   	'AUSTRALIA'   => 1 ,
      'BRAZIL'      => 1,
      'CANADA'      => 1,
      'NETHERLANDS' => 1,
      'UK'          => 1,
      'USA'         => 1
   );
   
   $country = uc($country);
   unless ( exists $countries{$country} )
   {
      die "Invalid country name: $country chosen";
   }
   
   my $state = {};
   bless($state,$class);
   $state->{country} = $country;
   
   return($state);
}

#------------------------------------------------------------------------------
# Given the full name for a region, return the code

sub code
{
   my $state = shift;
   my ($name) = @_;
   
   $name = _clean($name);

   # Normalise 'and' as in UK County 'Dumfries & Galloway'
   $name =~ s/ and / & /i;
   
   # Upper case first letter, lower case the rest, for all words in string
   $name =~ s/(\w+)/\u\L$1/g;
   
   # Conjunctions such as 'of' and their non-english equivalents are normally
   # represented as all lower case
   $name =~ s/ Of / of /;
   $name =~ s/ De / de /;
   $name =~ s/ Do / do /;
   
   
   my $code = $lookup{$state->{country}}{full_name_keyed}{$name};
   if ( $code )
   {
      return($code); 
   }
   else
   {
      return('unknown');
   }
}
#------------------------------------------------------------------------------
# Given the code for a subcountry region, return the full name
# Parameters are the code and a flag, which if set to true will 
# cause the full name to be uppercased 

sub full_name
{
   my $state = shift;
   my ($code,$uc_name) = @_;
   
   $code = _clean($code);
   $code = uc($code);
   
   my $full_name = $lookup{$state->{country}}{code_keyed}{$code};
   if ( $uc_name )
   {
	   $full_name = uc($full_name);
   }
   
   if ( $full_name )
   {
      return($full_name); 
   }
   else
   {
      return('unknown');
   }
}
#------------------------------------------------------------------------------
sub code_full_name_hash
{
   my $state = shift;
   return( %{ $lookup{$state->{country}}{code_keyed} } );
}
#------------------------------------------------------------------------------
sub full_name_code_hash
{
   my $state = shift;
   return( %{ $lookup{$state->{country}}{full_name_keyed} } );
}
#------------------------------------------------------------------------------
sub all_full_names
{
   my $state = shift;
   my %hash = $state->full_name_code_hash;
   return( sort keys %hash );
}
#------------------------------------------------------------------------------
sub all_codes
{
   my $state = shift;
   my %hash = $state->code_full_name_hash;
   return( sort keys %hash );
}

#------------------------------------------------------------------------------
# INTERNAL FUNCTIONS
#------------------------------------------------------------------------------
# Read in the list of abbreivations and full names defined in the DATA block
# at the bottom of this file.
 
INIT 
{
   my ($country);
   
   while ( <DATA> )
   {
   	unless ( /^#/ or /^\s*$/ )	# ignore coomented and empty lines
      {
         chomp;
         if ( /^Country=(.*)/ )
         {
            $country = $1;
         }
         else
         {
            my ($code,$name) = split(/:/,$_);
            
            # Create two hashes, both grouped by country, one keyed by
            # abbrevaiton and one by full name. Although data is duplicated,
            # this provided the fastest lookup and simplest code.
            
            $lookup{$country}{code_keyed}{$code} = $name;
            $lookup{$country}{full_name_keyed}{$name} = $code;
         }
      }
   }
}
#------------------------------------------------------------------------------
sub _clean
{
   my ($input_string) = @_;

   # remove illegal characters, numbers, dots, dashes etc.
   $input_string =~ s/[^A-Za-z& ]//go;
   
   # remove repeating spaces
   $input_string =~ s/  +/ /go; 

   # remove any remaining leading or trailing space
   $input_string =~ s/^ //; 
   $input_string =~ s/ $//;
   
   return($input_string);
}
#------------------------------------------------------------------------------
return(1);

# Abbreivation/State data. Comments (lines starting with #) and blank lines
# are ignored. Read in at start up by INIT subroutine

__DATA__

Country=AUSTRALIA

AAT:Australian Antarctic Territory
ACT:Australian Capital Territory
NT:Northern Territory
NSW:New South Wales
QLD:Queensland
SA:South Australia
TAS:Tasmania
VIC:Victoria
WA:Western Australia

Country=BRAZIL

AC:Acre
AL:Alagoas
AM:Amazonas
AP:Amapa
BA:Baia
CE:Ceara
DF:Distrito Federal
ES:Espirito Santo
FN:Fernando de Noronha
GO:Goias
MA:Maranhao
MG:Minas Gerais
MS:Mato Grosso do Sul
MT:Mato Grosso
PA:Para
PB:Paraiba
PE:Pernambuco
PI:Piaui
PR:Parana
RJ:Rio de Janeiro
RN:Rio Grande do Norte
RO:Rondonia
RR:Roraima
RS:Rio Grande do Sul
SC:Santa Catarina
SE:Sergipe
SP:Sao Paulo
TO:Tocatins

Country=CANADA

AB:Alberta
BC:British Columbia
MB:Manitoba
NB:New Brunswick
NF:Newfoundland
NS:Nova Scotia
NT:Northwest Territories
NT:Nunavut
ON:Ontario
PE:Prince Edward Island
QC:Quebec
SK:Saskatchewan
YT:Yukon Territory


Country=NETHERLANDS

DR:Drente
FL:Flevoland
FR:Friesland
GL:Gelderland
GR:Groningen
LB:Limburg
NB:Noord Brabant
NH:Noord Holland
OV:Overijssel
UT:Utrecht
ZH:Zuid Holland
ZL:Zeeland

Country=UK

BEDS:Bedfordshire
BERKS:Berkshire
BORDER:Borders
BUCKS:Buckinghamshire
CAMBS:Cambridgeshire
CENT:Central
CI:Channel Islands
CHESH:Cheshire
CLEVE:Cleveland
CORN:Cornwall
CUMB:Cumbria
DERBY:Derbyshire
DEVON:Devonshire
DORSET:Dorsetshire
DUMGAL:Dumfries & Galloway
GLAM:Glamorganshire
GLOUS:Gloucestershire
GRAMP:Grampian
GWYNED:Gwynedd
HANTS:Hampshire 
HERWOR:Herefordshire & Worcestershire
HERTS:Hertfordshire
HIGHL:Highland
HUMBER:Humberside
HUNTS:Huntingdonshire
IOM:Isle of Man
IOW:Isle of White
LANARKS:Lanarkshire
LANCS:Lancashire
LEICS:Leicestershire
LINCS:Licolnshire
LOTH:Lothian
MIDDX:Middlesex
NORF:Norfolk
NHANTS:Northamptonshire
NTHUMB:Northumberland
NOTTS:Nottinghamshire
OXON:Oxfordshire
PEMBS:Pembrokeshire
RUTLAND:Rutlandshire
SHROPS:Shropshire
SOM:Somersetshire
STAFFS:Staffordshire
STRATH:Strathclyde
SUFF:Suffolk
SUSS:Sussex
TAYS:Tayside
TYNE:Tyne & Wear
WARKS:Warwickshire
WILTS:Wiltshire
WORCS:Worcestershire
YORK:Yorkshire

# Northern Ireland 

CO ANTRIM:County Antrim
CO ARMAGH:County Armagh
CO DOWN:County Down
CO DURHAM:County Durham
CO FERMANAgh:County Fermanagh
CO DERRY:County Londonderry
CO TYRONE:County Tyrone

Country=USA

AA:Armed Forces Americas        
AE:Armed Forces Europe, Middle East, & Canada 
AP:Armed Forces Pacific                          
AK:Alaska  
AL:Alabama  
AR:Arkansas     
AS:American Samoa     
AZ:Arizona  
CA:California         
CO:Colorado     
CT:Connecticut           
DC:District of Columbia     
DE:Delaware     
FL:Florida  
FM:Federated States of Micronesia  
GA:Georgia  
GU:Guam  
HI:Hawaii  
IA:Iowa  
ID:Idaho              
IL:Illinois          
IN:Indiana        
KS:Kansas         
KY:Kentucky     
LA:Louisiana                       
MA:Massachusetts                   
MD:Maryland     
ME:Maine     
MH:Marshall Islands                
MI:Michigan                           
MN:Minnesota
MO:Missouri
MP:Northern Mariana Islands
MS:Mississippi
MT:Montana
NC:North Carolina
ND:North Dakota
NE:Nebraska
NH:New Hampshire
NJ:New Jersey
NM:New Mexico
NV:Nevada
NY:New York
OH:Ohio
OK:Oklahoma
OR:Oregon
PA:Pennsylvania
PR:Puerto Rico
PW:Palau
RI:Rhode Island
SC:South Carolina
SD:South Dakota
TN:Tennessee
TX:Texas
UT:Utah
VA:Virginia
VI:Virgin Islands
VT:Vermont
WA:Washington
WI:Wisconsin
WY:Wyoming
