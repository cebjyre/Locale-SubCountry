=head1 NAME

Locale::SubCountry - convert state, province, county etc. names to/from code

=head1 SYNOPSIS

   use Locale::SubCountry;
   
   $UK_counties = new Locale::SubCountry('GB');
   print($UK_counties->full_name('DUMGAL'));  # Dumfries & Galloway
   
   $country = 'AUSTRALIA';
   @all_countries = &all_country_names;
   if ( grep(/$country/, @all_countries) )
   {
      $australia = new Locale::SubCountry($country);
   }
   else
   {
      die "No data for $country";
   }
   
   print($australia->code('New South Wales ')); # NSW
   print($australia->full_name('S.A.'));        # South Australia
   
   $upper_case = 1;
   print($australia->full_name('Qld',$upper_case)); # QUEENSLAND
   print $australia->country;          # AUSTRALIA
   print $australia->country_code;     # AU
   print $australia->sub_country_type; # State
   
   @all_country_codes = &all_country_codes;
   
   %all_australian_states = $australia->full_name_code_hash;
   foreach $abbrev ( sort keys %australian_states )
   {
      printf("%-3s : %s\n",$abbrev,%all_australian_states{$abbrev});
   }
   
   %all_australian_codes = $australia->code_full_name_hash;
   
   @all_australian_states = $australia->all_full_names;
   @all_australian_codes = $australia->all_codes;
   

=head1 REQUIRES

Perl 5.005 or above


=head1 DESCRIPTION

This module allows you to convert the full name for a countries administrative
region to the code commonly used for postal addressing. The reverse lookup
can also be done.

Sub countries are termed as states in the US and Australia, provinces 
in Canada and counties in the UK and Ireland.

Additionally, names and codes for all sub countries in a country can be 
returned as either a hash or an array. 

=head1 METHODS

=head2 new

The C<new> method creates an instance of a sub country object. This must be 
called before any of the following methods are invoked. The method takes a 
single argument, the name of the country that contains the sub country 
that you want to work with. It may be specified either by the ISO 3166
two letter code or the full name. These are currently:

	AF - AFGHANISTAN
	DZ - ALGERIA
	AO - ANGOLA
	AR - ARGENTINA
	AM - ARMENIA
	AU - AUSTRALIA
	AT - AUSTRIA
	AZ - AZERBAIJAN
	BS - BAHAMAS
	BH - BAHRAIN
	BD - BANGLADESH
	BY - BELARUS
	BE - BELGIUM
	BZ - BELIZE
	BJ - BENIN
	BT - BHUTAN
	BO - BOLIVIA
	BA - BOSNIA AND HERZEGOVINA
	BW - BOTSWANA
	BR - BRAZIL
	BN - BRUNEI DARUSSALAM
	BG - BULGARIA
	BF - BURKINA FASO
	KH - CAMBODIA
	CM - CAMEROON
	CA - CANADA
	CV - CAPE VERDE
	CF - CENTRAL AFRICAN REPUBLIC
	TD - CHAD
	CL - CHILE
	CN - CHINA
	CO - COLOMBIA
	KM - COMOROS
	CO - CONGO
	CR - COSTA RICA
	CI - COTE D'IVOIRE
	HR - CROATIA
	CU - CUBA
	CY - CYPRUS
	CX - CZECH REPUBLIC
	CO - DEMOCRATIC REPUBLIC OF CONGO
	DK - DENMARK
	DJ - DJIBOUTI
	DO - DOMINICAN REPUBLIC
	EC - ECUADOR
	EG - EGYPT
	SV - EL SALVADOR
	QQ - EQUATORIAL GUINEA
	ER - ERITREA
	EE - ESTONIA
	ET - ETHIOPIA
	FJ - FIJI
	FR - FRANCE
	GA - GABON
	GM - GAMBIA
	GE - GEORGIA
	DE - GERMANY
	GH - GHANA
	GR - GREECE
	GT - GUATEMALA
	GN - GUINEA
	GW - GUINEA BISSAU
	GY - GUYANA
	HT - HAITI
	HN - HONDURAS
	HU - HUNGARY
	IE - ICELAND
	IN - INDIA
	ID - INDONESIA
	IN - IRAN (ISLAMIC REPUBLIC OF)
	IQ - IRAQ
	IE - IRELAND
	IT - ITALY
	JM - JAMAICA
	JP - JAPAN
	JO - JORDAN
	KZ - KAZAKHSTAN
	KE - KENYA
	KI - KIRIBATI
	KP - KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
	KR - KOREA, REPUBLIC OF
	KW - KUWAIT
	KG - KYRGYZSTAN
	LA - LAO PEOPLE'S DEMOCRATIC REPUBLIC
	LV - LATVIA
	LB - LEBANON
	LS - LESOTHO
	LR - LIBERIA
	LY - LIBYAN ARAB JAMAHIRIYA
	LT - LITHUANIA
	MG - MADAGASCAR
	MW - MALAWI
	MY - MALAYSIA
	MV - MALDIVES
	ML - MALI
	MH - MARSHALL ISLANDS
	MR - MAURITANIA
	MU - MAURITIUS
	MX - MEXICO
	FM - MICRONESIA (FEDERATED STATES OF)
	MD - MOLDOVA, REPUPLIC OF
	MN - MONGOLIA
	MA - MOROCCO
	MZ - MOZAMBIQUE
	MM - MYANMAR
	NA - NAMIBIA
	NL - NETHERLANDS
	NZ - NEW ZEALAND
	NI - NICARAGUA
	NE - NIGER
	NG - NIGERIA
	NO - NORWAY
	OM - OMAN
	PK - PAKISTAN
	PA - PANAMA
	PG - PAPUA NEW GUINEA
	PY - PARAGUAY
	PE - PERU
	PH - PHILIPPINES
	PL - POLAND
	PT - PORTUGAL
	QA - QATAR
	RO - ROMANIA
	RU - RUSSIA
	RW - RWANDA
	ST - SAO TOME AND PRINCIPE
	SA - SAUDI ARABIA
	SN - SENEGAL
	SL - SIERRA LEONE
	SK - SLOVAKIA
	SI - SLOVENIA
	SB - SOLOMON ISLANDS
	SO - SOMALIA
	ZA - SOUTH AFRICA
	ES - SPAIN
	LK - SRI LANKA
	SH - ST HELENA
	SD - SUDAN
	SR - SURINAME
	SZ - SWAZILAND
	SE - SWEDEN
	CH - SWITZERLAND
	SY - SYRIAN ARAB REPUBLIC
	TW - TAIWAN, PROVINCE OF CHINA
	TJ - TAJIKISTAN
	TZ - TANZANIA, UNITED REPUBLIC OF
	TH - THAILAND
	TG - TOGO
	TT - TRINIDAD AND TOBAGO
	TN - TUNISIA
	TR - TURKEY
	TM - TURKMENISTAN
	UG - UGANDA
	UA - UKRAINE
	AE - UNITED ARAB EMIRATES
	GB - UNITED KINGDOM
	US - UNITED STATES
	UM - UNITED STATES MINOR OUTLYING ISLANDS
	UY - URUGUAY
	UZ - UZBEKISTAN
	VU - VANUATU
	VE - VENEZUELA
	VN - VIET NAM
	WF - WALLIS AND FUTUNA ISLANDS
	YE - YEMEN
	YU - YUGOSLAVIA
	ZM - ZAMBIA
	ZW - ZIMBABWE

   
All forms of upper/lower case are acceptable in the country's spelling. If a 
country name is supplied that the module doesn't recognise, it will die.

=head2 country

Returns the current country of the sub country object

=head2 country_code

Returns the two lwttwr current country of the sub country object


=head2 sub_country_type

Returns the current sub country type (state, county etc) for 
the sub country object, or 'unknown' if a value is not defined. 
Currently sub country types are defined for:

Australia : State
Canada    : Province
France    : Department
Germany   : Länder
Ireland   : County
UK        : County
USA       : State


=head2 code

The C<code> method takes the full name of a sub country in the currently
assigned country and returns the sub country's code. The full name can appear
in mixed case. All white space and non alphabetic characters are ignored, 
except the single space used to separate sub country names such as 
"New South Wales". The code is returned as a capitalised string, or 
"unknown" if no match is found.

=head2 full_name

The C<full_name> method takes the code of a sub country in the currently
assigned country and returns the sub country's full name. The code can appear
in mixed case. All white space and non alphabetic characters are ignored. The
full name is returned as a title cased string, such as "South Australia".

If an optional argument is supplied and set to a true value, the full name is
returned as an upper cased string.


=head2 full_name_code_hash

Returns a hash of name/code pairs for the currently assigned country, 
keyed by sub country name.

=head2 code_full_name_hash

Returns a hash of code/name pairs for the currently assigned country,
keyed by sub country code.


=head2 all_full_names

Returns an array of sub country names for the currently assigned country, 
sorted alphabetically. 

=head2 all_codes

Returns an array of sub country codes for the currently assigned country, 
sorted alphabetically.

=head2 all_country_names

Returns an array of all country names that this module can do lookups for,
sorted alphabetically. This is implemented as a conventional subroutine rather 
than a method. This allows us to check if lookups can be done for a given country
before actually creating the lookup object.

=head2 all_country_codes

Returns an array of all country 2 leteer codes that this module can do lookups for,
sorted alphabetically. This is implemented as a conventional subroutine rather 
than a method. This allows us to check if lookups can be done for a given country
code before actually creating the lookup object.


=head1 SEE ALSO

ISO 3166-2:1998, Standard for naming sub country codes
Locale::Country
Locale::US

=head1 LIMITATIONS

If a sub country's full name contains the word 'and', it is represented by an
ampersand, as in 'Dumfries & Galloway'.

ISO 3166-2:1998 defines all sub country codes as being 2 letters. This works
for USA, Canada etc. In Australia and the UK, this method of abbreviation is
not widely accepted. For example, the ISO code for 'New South Wales' is 'NS',
but 'NSW' is the only abbreviation that is actually used. I could add an
enforce ISO-3166 flag if needed.

The ISO 3166-2 standard romanizes the names of provinces and regions in non-latin 
script areas, such as Russia and South Korea. One Romanisation is given for each
province name. For Russia, the BGN (1947) Romanization is used. 

The ISO 3166-2 standard for Italy lists alphabetic codes for provinces and 
numeric codes for the regions they belong to, both are listed.

The following sub country names have more than one code, and may not return  
the correct code for that sub country.

AZERBAIJAN : Länkäran; LA,LAN
AZERBAIJAN : Säki; SA,SAK
AZERBAIJAN : Susa; SS,SUS
AZERBAIJAN : Yevlax; YE,YEV
INDONESIA  : Kalimantan Timur; KI,KT
LAOS       : Vientiane VI,VT
MOLDOVA    : Hahul; CA,CHL
MOLDOVA    : Bubasari; DU,DBI
MOLDOVA    : Hrhei; OR,OHI
MOLDOVA    : Coroca; SO,SOA
MOLDOVA    : Gngheni; UN,UGI
MOZAMBIQUE : Maputo; MPM,L

=head1 BUGS
  

=head1 COPYRIGHT


Copyright (c) 2000-1 Kim Ryan. All rights reserved.
This program is free software; you can redistribute it 
and/or modify it under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html).


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimaryan@ozemail.com.au> in 2000.

=head1 CREDITS

Alastair McKinstry provided nearly all the sub country codes and names.

Terrence Brannon produced Locale::US, which was the starting point for
this module. Some of the ideas in Geography::States were also used.

Mark Summerfield and Guy Fraser provided the list of UK counties.


=cut

#-------------------------------------------------------------------------------

package Locale::SubCountry;

use strict;
require 5.005;  # Needed for use of the INIT subroutine
use locale;


use Exporter;
use vars qw (@ISA $VERSION @EXPORT);

$VERSION = '1.07';
@ISA     = qw(Exporter);
@EXPORT  = qw(&all_country_names &all_country_codes);

#-------------------------------------------------------------------------------
# Create new instance of a sub country object

sub new
{
   my $class = shift;
   my ($country_or_code) = @_;
   
   $country_or_code = uc($country_or_code);
   
   my ($country,$country_code);
   
   # Country may be supplied either as a two letter code, or the full name
   if ( length($country_or_code) == 2 )
   {
   	if ( $::country_lookup{code_keyed}{$country_or_code} )
   	{
	      $country_code = $country_or_code;
      	# set country to it's full name
      	$country = $::country_lookup{code_keyed}{$country_or_code};
   	}
   	else
   	{
	      die "Invalid country code: $country_or_code chosen";
   	}
   }
   else
   {
	   if ( $::country_lookup{full_name_keyed}{$country_or_code} )
      {
	      $country = $country_or_code;
      	$country_code = $::country_lookup{full_name_keyed}{$country_or_code};
      }
      else
	   {
	      die "Invalid country name: $country_or_code chosen";
	   }
   }
   
   my $sub_country = {};
   bless($sub_country,$class);
   $sub_country->{country} = $country;
   $sub_country->{country_code} = $country_code;
   
   
   if ( $::subcountry_lookup{$country}{sub_country_type} )
   {
      $sub_country->{sub_country_type} = $::subcountry_lookup{$country}{sub_country_type};
   }
   else
   {
      $sub_country->{sub_country_type} = 'unknown';
   }
   
   return($sub_country);
}

#-------------------------------------------------------------------------------
# Returns the current country of the sub country object

sub country
{
   my $sub_country = shift;
   return( $sub_country->{country} );
}
#-------------------------------------------------------------------------------
# Returns the current country code of the sub country object

sub country_code
{
   my $sub_country = shift;
   return( $sub_country->{country_code} );
}

#-------------------------------------------------------------------------------
# Returns the current sub country type (state, county etc) of the 
# sub country object

sub sub_country_type
{
   my $sub_country = shift;
   return( $sub_country->{sub_country_type} );
}
#-------------------------------------------------------------------------------
# Given the full name for a sub country, return the code

sub code
{
   my $sub_country = shift;
   my ($full_name) = @_;
   
   my $orig = $full_name;
   
   $full_name = _clean($full_name);
   
   my $code = $::subcountry_lookup{$sub_country->{country}}{full_name_keyed}{$full_name};
   
   # If a code wasn't found, it could be because the user's capitalization
   # does not match the one in the look up data of this module. For example,
   # the user may have supplied the sub country "Ag R" (in Turkey) but the 
   # ISO standard defines the spelling as "Ag r".
   
   unless ( defined $code )
   {
      # For every sub country, compare upper cased full name supplied by user
      # to upper cased full name from lookup hash. If they match, return the
      # correctly cased full name from the lookup hash. 
      
      my @all_names = $sub_country->all_full_names;
      my $current_name;
      foreach $current_name ( @all_names )
      {
         if ( uc($full_name) eq uc($current_name) )
         {
            $code = $::subcountry_lookup{$sub_country->{country}}{full_name_keyed}{$current_name};
         }
      }
   }
   
   if ( defined $code )
   {
      return($code); 
   }
   else
   {
      return('unknown');
   }
}
#-------------------------------------------------------------------------------
# Given the code for a sub country, return the full name.
# Parameters are the code and a flag, which if set to true
# will cause the full name to be uppercased

sub full_name
{
   my $sub_country = shift;
   my ($code,$uc_name) = @_;
   
   $code = _clean($code);
   $code = uc($code);
   
   my $full_name = $::subcountry_lookup{$sub_country->{country}}{code_keyed}{$code};
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
#-------------------------------------------------------------------------------
sub code_full_name_hash
{
   my $sub_country = shift;
   return( %{ $::subcountry_lookup{$sub_country->{country}}{code_keyed} } );
}
#-------------------------------------------------------------------------------
sub full_name_code_hash
{
   my $sub_country = shift;
   return( %{ $::subcountry_lookup{$sub_country->{country}}{full_name_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country full names for the current country

sub all_full_names
{
   my $sub_country = shift;
   my %all_full_names = $sub_country->full_name_code_hash;
   return( sort keys %all_full_names );
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country codes for the current country

sub all_codes
{
   my $sub_country = shift;
   my %all_codes = $sub_country->code_full_name_hash;
   return( sort keys %all_codes );
}
#-------------------------------------------------------------------------------
# Returns sorted array of all countries full names that we can do lookups for

sub all_country_names
{
   return ( sort keys %{ $::country_lookup{full_name_keyed} });
}
#-------------------------------------------------------------------------------
# Returns sorted array of all two letter country codes that we can do lookups for

sub all_country_codes
{
   return ( sort keys %{ $::country_lookup{code_keyed} });
}

#-------------------------------------------------------------------------------
# INTERNAL FUNCTIONS
#-------------------------------------------------------------------------------
# Read in the list of abbreivations and full names defined in the DATA block
# at the bottom of this file.
 
INIT 
{
   my ($country);
   
   while ( <DATA> )
   {
      unless ( /^#/ or /^s*$/ )  # ignore commented and empty lines
      {
         chomp;
         if ( /^Country\s*=(.*)/i )
         {
            $country = _clean($1);
         }
         elsif ( /^Code\s*=(.*)/i )
         {
            # Create doubly indexed hash, keyed by	country code and full name.
            # The user can supply either form to create a new sub_country 
            # object, and the objects properties will hold both the countries
            # name and it's code.
             
         	my $code = _clean($1);
            $::country_lookup{code_keyed}{$code} = $country;
            $::country_lookup{full_name_keyed}{$country} = $code;
         }
         elsif ( /^SubCountryType\s*=(.*)/i )
         {
            $::subcountry_lookup{$country}{sub_country_type} = _clean($1);
         }
         else
         {
            my ($code,$name) = split(/:/,$_);
            
            $code = _clean($code);
            $name = _clean($name);
            
            # Create doubly indexed hash, grouped by country, one keyed by
            # abbrevaiton and one by full name. Although data is duplicated,
            # this provides the fastest lookup and simplest code.
            
            $::subcountry_lookup{$country}{code_keyed}{$code} = $name;
            $::subcountry_lookup{$country}{full_name_keyed}{$name} = $code;
         }
      }
   }
}
#-------------------------------------------------------------------------------
sub _clean
{
   my ($input_string) = @_;

   # remove dots
   $input_string =~ s/\.//go;
   
   # remove repeating spaces
   $input_string =~ s/  +/ /go; 

   # remove any remaining leading or trailing space
   $input_string =~ s/^ //; 
   $input_string =~ s/ $//;
   
   return($input_string);
}
#-------------------------------------------------------------------------------
return(1);

=pod

Code/Sub country data. Comments (lines starting with #) and 
blank lines are ignored. Read in at start up by INIT subroutine.

Format is:
Country=<COUNTRY NAME>
Code=<COUNTRY CODE> # from ISO 3166 format
SubCountryType=<Sub Country Type>  # optional field, specify state, county etc
CODE:Full Name
CODE:Full Name
CODE:Full Name
...

Country=<COUNTRY NAME>
...


=cut

__DATA__

Country=UNITED ARAB EMIRATES
Code=AE

AZ:Abu Zaby
AJ:'Ajman
FU:Al Fujayrah
SH:Ash Shariqah
DU:Dubayy
RK:R'as al Khaymah
UQ:Umm al Qaywayn

Country=AFGHANISTAN
Code=AF

BDS:Badakhshan
BDG:Badghis
BGL:Baghlan
BAL:Balkh
BAM:Bamian
FRA:Farah
FYB:Faryab
GHA:Ghazni
GHO:Ghowr
HEL:Helmand
HER:Herat
JOW:Jowzjan
KAB:Kabul 
KAN:Kandahar
KAP:Kapisa
KNR:Konar
KDZ:Kondoz
LAG:Laghman
LOW:Lowgar
NAN:Nangrahar
NIM:Nimruz
ORU:Oruzgan
PIA:Paktia
PKA:Paktika
PAR:Parwan
SAM:Samangan
SAR:Sar-e Pol
TAK:Takhar
WAR:Wardak
ZAB:Zabol

Country=ALGERIA
Code=DZ

01:Adrar
44:Ain Defla
46:Aïn T6mouchent
16:Alger
23:Annaba
05:Batna
08:Béchar
06:Béjaïa
07:Biskra
09:Blida
34:Bordj Bou Arréridj
10:Bouira
35:Boumerdès
02:Chlef
25:Constantine
17:Djelfa
32:El Bayadh
39:El Oued
36:El Tarf
47:Ghardaïa
24:Guelma
33:Illizi
18:Jijel
40:Khenchela
03:Laghouat
29:Mascara
26:Médéa
43:Mila
27:Mostaganem
28:Msila
45:Naama
31:Oran
30:Ouargla
04:Oum el Bouaghi
48:Relizane
20:Saïda
19:Sétif
22:Sidi Bel Abbès
21:Skikda
41:Souk Ahras
11:Tamanghasset
12:Tébessa
14:Tiaret
37:Tindouf
42:Tipaza
38:Tissemsilt
15:Tizi Ouzou
13:Tlemcen


Country=ARMENIA
Code=AM

ER:Erevan
AG:Aragacotn
AR:Ararat
AV:Armavir
GR:Gegark'unik'
KT:Kotayk'
LO:Lory
SH:Sirak
SU:Syunik'
TV:Tavus
VD:Vayoc Jor

Country=ANGOLA
Code=AO

BGO:Bengo
BGU:Benguela
BIE:Bié
CAB:Cabinda
CCU:Cuando-Cubango
CNO:Cuanza Norte
CUS:Cuanza Sul
CNN:Cunene
HUA:Huambo
HUI:Huíla
LUA:Luanda
LNO:Lunda Norte
LSU:Lunda Sul
MAL:Malange
MOX:Moxico
NAM:Namibe
UIG:Uíge
ZAI:Zaire

Country=ARGENTINA
Code=AR

C:Capital federal
B:Buenos Aires
K:Catamarca
X:Cordoba
W:Corrientes
H:Chaco
U:Chubut
E:Entre Rios
P:Formosa
Y:Jujuy
L:La Pampa
M:Mendoza
N:Misiones
Q:Neuquén
R:Rió Negro
A:Salta
J:San Juan
D:San Luis
Z:Santa Cruz
S:Santa Fe
G:Santiago del Estero
V:Tierra del Fuego
T:Tucumán

Country=AUSTRALIA
Code=AU
SubCountryType=State

AAT:Australian Antarctic Territory
ACT:Australian Capital Territory
NT:Northern Territory
NSW:New South Wales
QLD:Queensland
SA:South Australia
TAS:Tasmania
VIC:Victoria
WA:Western Australia


Country=AUSTRIA
Code=AT

1:Burgenland
2:Kärnten
3:Niederösterreich
4:Oberösterreich
5:Salzburg
6:Steiermark
7:Tirol
8:Vorarlberg
9:Wien

Country=AZERBAIJAN
Code=AZ

MM:Naxçivan
AB:Äli Bayramli
BA:Bäki
GA:Gäncä
LA:Länkäran
MI:Mingäçevir
NA:Naftalan
SA:Säki
SM:Sumqayit
SS:Susa 
XA:Xankandi
YE:Yevlax
ABS:Abseron
AGC:Agcabädi
AGM:Agdam
AGS:Agdas 
AGA:Agstafa
AGU:Agsu
AST:Astara
BAB:Babäk
BAL:Balakän
BAR:Bärdä
BEY:Beylägan
BIL:Biläsuvar
CAB:Cäbrayll
CAL:Cälilabad
CUL:Culfa
DAS:Daskäsän
DAV:Däväçi
FUZ:Fuzuli
GAD:Gädäbäy
GOR:Goranboy
GOY:Göyçay
HAC:Haciqabul
IMI:Imisli
ISM:Ismayilli
KAL:Kälbäcär
KUR:Kurdämir
LAC:Laçin
LAN:Länkäran
LER:Lerik
MAS:Masalli
NEF:Neftcala
OGU:Oguz
ORD:Ordubad
QAB:Qäbälä
QAX:Qax
QAZ:Qazax
QOB:Qobustan
QBA:Quba
QBI:Qubadli
QUS:Qusar
SAT:Saatli
SAB:Sabirabad
SAD:Sadarak
SAH:Sahbuz
SAK:Säki
SAL:Salyan
SMI:Samaxi
SKR:Sämkir
SMX:Samux
SAR:Särur
SIY:Siyäzän
SUS:Susa
TAR:Tartar
TOV:Tovuz
UCA:Ucar
XAC:Xacmaz
XAN:Xanlar
XIZ:Xizi
XCI:Xocali
XVD:Xocavand
YAR:Yardimli
YEV:Yevlax
ZAN:Zängilan
ZAQ:Zaqatala
ZAR:Zärdab

Country=BOSNIA AND HERZEGOVINA
Code=BA

BIH:Federacija Bosna i Hercegovina
SRP:Republika Srpska

Country=BANGLADESH
Code=BD

05:Bagerhat zila
01:Bandarban zila
02:Barguna zila
06:Barisal zila
07:Bhola zila
03:Bogra zila
04:Brahmanbaria zila
09:Chandpur zila
10:Chittagong zila
12:Chuadanga zila
08:Comilla zila
11:Cox's Bazar zila
13:Dhaka zila
14:Dinajpur zila
15:Faridpur zila
16:Feni zila
19:Gaibandha zila
18:Gazipur zila
17:Gopalganj zila
20:Habiganj zila
24:Jaipurhat zila
21:Jamalpur zila
22:Jessore zila
25:Jhalakati zila
23:Jhenaidah zila
29:Khagrachari zila
27:Khulna zila
26:Kishorganj zila
28:Kurigram zila
30:Kushtia zila
31:Lakshmipur zila
32:Lalmonirhat zila
36:Madaripur zila
37:Magura zila
33:Manikganj zila
39:Meherpur zila
38:Moulvibazar zila
35:Munshiganj zila
34:Mymensingh zila
48:Naogaon zila
43:Narail zila
40:Narayanganj zila
42:Narsingdi zila
44:Natore zila
45:Nawabganj zila
41:Netrakona zila
46:Nilphamari zila
47:Noakhali zila
49:Pabna zila
52:Panchagarh zila
51:Patuakhali zila
50:Pirojpur zila
53:Rajbari zila
54:Rajshahi zila
56:Rangamati zila
55:Rangpur zila
58:Satkhira zila
62:Shariatpur zila
57:Sherpur zila
59:SirajOanj zila
61:SunamOanj zila
60:Sylhet zila
63:Tangail zila
64:Thakurgaon zila

Country=BELARUS
Code=BY

BR:Brèsckaja voblasc
HO:Homel'skaja voblasc
HR:Hrodzenskaja voblasc
MA:Mahilëuskaja voblasc'
MI:Minskaja voblasc'
VI:Vicebskaja voblasc'


Country=BELGIUM
Code=BE

VAN:Antwerpen
WBR:Brabant Wallon
WHT:Hainaut
WLG:Liège
VLI:Limburg
WLX:Luxembourg
WNA:Namur
VOV:Oost-Vlaanderen
VBR:Vlaams Brabant
VWV:West-Vlaanderen

Country=BURKINA FASO
Code=BF

BAL:Balé
BAM:Bam
BAN:Banwa
BAZ:Bazega
BGR:Bougouriba
BLG:Boulgou
BLK:Boulkiemdé
COM:Comoé
GAN:Ganzourgou
GNA:Gnagna
GOU:Gourma
HOU:Houet
IOB:Ioba
KAD:Kadiogo
KEN:Kénédougou
KMD:Komondjari
KMP:Kompienga
KOS:Kossi
KOP:KoulpÚlogo
KOT:Kouritenga
KOW:Kourweogo
LER:Léraba
LOR:Loroum
MOU:Mouhoun
NAO:Nahouri
NAM:Namentenga
NAY:Nayala
NOU:Noumbiel
OUB:Oubritenga
OUD:Oudalan
PAS:Passoré
PON:Poni
SNG:Sanguié
SMT:Sanmatenga
SEN:Séno
SIS:Siasili
SOM:Soum
SOR:Sourou
TAP:Tapoa
TUI:Tui
YAG:Yagha
YAT:Yatenga
ZIR:Ziro
ZON:Zondoma
ZOU:Zoundwéogo

Country=BULGARIA
Code=BG

02:Burgas
09:Haskovo
04:Lovec
05:Montana
06:Plovdiv
07:Ruse
08:Sofija
01:Sofija-Grad
03:Varna

Country=BAHRAIN
Code=BH

01:Al Hadd
03:Al Manamah
10:Al Mintaqah al Gharbiyah
07:Al Mintagah al Wustá
05:Al Mintaqah ash Shamaliyah
02:Al Muharraq
09:Ar Rifa
04:Jidd Hafs
12:Madluat Jamad
08:Madluat Isã
11:Mintaqat Juzur tawar
06:Sitrah

Country=BENIN
Code=BJ

AK:Atakora
AQ:Atlantique
BO:Borgou
MO:Mono
OU:Ouémé
ZO:Zou

Country=BRUNEI DARUSSALAM
Code=BN

BE:Belait
BM:Brunei-Muara
TE:Temburong
TU:Tutong

Country=BOLIVIA
Code=BO

C:Cochabamba
H:Chuquisaca
B:El Beni
L:La Paz
O:Oruro
N:Pando
P:Potosi
S:Santa Cruz
T:Tarija

Country=BAHAMAS
Code=BS

AC:Acklins and Crooked Islands
BI:Bimini
CI:Cat Island
EX:Exuma
FP:Freeport
FC:Fresh Creek
GH:Governor's Harbour
GT:Green Turtle Cay
HI:Harbour Island
HR:High Rock
IN:Inagua
KB:Kemps Bay
LI:Long Island
MH:Marsh Harbour
MG:Mayaguana
NP:New Providence
NB:Nicholls Town and Berry Islands
RI:Ragged Island
RS:Rock Sound
SP:Sandy Point
SR:San Salvador and Rum Cay

Country=BHUTAN
Code=BT

33:Bumthang
12:Chhukha
22:Dagana
GA:Gasa
13:Ha
44:Lhuentse
42:Monggar
11:Paro
43:Pemagatshel
23:Punakha
45:Samdrup Jongkha
14:Samtee
31:Sarpang
15:Thimphu
41:Trashigang
TY:Trashi Yangtse
32:Trongsa
21:Tsirang
24:Wangdue Phodrang
34:Zhemgang

Country=BOTSWANA
Code=BW

CE:Central 
CH:Chobe
GH:Ghanzi
KG:Kgalagadi
KL:Kgatleng
KW:Kweneng
NG:Ngamiland 
NE:North-East
SE:South-East
SO:Southern

Country=BELIZE
Code=BZ

BZ:Belize
CY:Cayo
CZL:Corozal
OW:Orange Walk
SC:Stann Creek
TOL:Toledo

Country=BRAZIL
Code=BR

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
Code=CA
SubCountryType=Province

AB:Alberta
BC:British Columbia
MB:Manitoba
NB:New Brunswick
NF:Newfoundland
NS:Nova Scotia
NT:Northwest Territories
NU:Nunavut
ON:Ontario
PE:Prince Edward Island
QC:Quebec
SK:Saskatchewan
YT:Yukon Territory

Country=DEMOCRATIC REPUBLIC OF CONGO
Code=CO

KN:Kinshasa
BN:Bandundu
BC:Bas-Congo
EQ:Équateur
HC:Haut-Congo
KW:Kasai-Occidental
KE:Kasai-Oriental
KA:Katanga
MA:Maniema
NK:Nord-Kivu
SK:Sud-Kivu

Country=COMOROS
Code=KM

A:Anjouan Ndzouani
G:Grande Comore Ngazidja
M:Mohéli Moili

Country=CENTRAL AFRICAN REPUBLIC
Code=CF

BGF:Bangui
BB:Bamingui-Bangoran
BK:Baase-Kotto
HK:Haute-Kotto
HM:Haut-Mbomou
KG:Kémo
LB:Lobaye
HS:Mambéré-Kadéï
MB:Mbomou
KB:Nana-Grébizi
NM:Nana-Mambéré
MP:Ombella-Mpoko
UK:Ouaka
AC:Ouham
OP:Ouham-Pendé
SE:Sangha-Mbaéré
VR:Vakaga

Country=CONGO
Code=CO

BZV:Brazzaville
11:Bouenza
8:Cuvette
15:Cuvette-Ouest
5:Kouilou
2:Lékoumou
7:Likouala
9:Niari
14:Plateaux
12:Pool
13:Sangha

Country=CHAD
Code=TD

BA:Batha
BI:Biltine
BET:Borkou-Ennedi-Tibesti
CB:Chari-Baguirmi
GR:Guéra
KA:Kanem
LC:Lac
LO:Logone-Occidental
LR:Logone-Oriental
MK:Mayo-Kébbi
MC:Moyen-Chari
OD:Ouaddaï
SA:Salamat
TA:Tandjilé

Country=CHILE
Code=CL

AI:Aisén del General Carlos Ibáñez del Campo
AN:Antofagasta
AR:Araucanía
AT:Atacama
BI:Bío-Bío
CO:Coquimbo
LI:Libertador General Bernardo O'Higgins
LL:Los Lagos
MA:Magallanes
ML:Maule
RM:Region Metropolitana de Santiago
TA:Tarapacá
VS:Valparaíso

Country=CAMEROON
Code=CM

AD:Adamaoua
CE:Centre
ES:East
EN:Far North
LT:Littoral
NO:North
NW:North-West
SW:South
SW:South-Weat
OU:West

Country=CHINA
Code=CN

11:Beijing
50:Chongqing
31:Shanghai
12:Tianjin
34:Anhui
35:Fujian
62:Gansu
44:Guangdong
52:Gulzhou
46:Hainan
13:Hebei
23:Heilongjiang
41:Henan
42:Hubei
43:Hunan
32:Jiangsu
36:Jiangxi
22:Jilin
21:Liaoning
63:Qinghai
61:Shaanxi
37:Shandong
14:Shanxi
51:Sichuan
71:Taiwan
53:Yunnan
33:Zhejiang
45:Guangxi
15:Nei Monggol
64:Ningxia
65:Xinjiang
54:Xizang
91:Hong Kong

Country=COLOMBIA
Code=CO

DC:Distrito Capltal de Santa Fe de Bogotá
AMA:Amazonea
ANT:Antioquia
ARA:Arauca
ATL:Atlántico
BOL:Bolívar
BOY:Boyacá
CAL:Caldea
CAQ:Caquetá
CAS:Casanare
CAU:Cauca
CES:Cesar
COR:Córdoba
CUN:Cundinamarca
CHO:Chocó
GUA:Guainía
GUV:Guaviare
HUI:Huila
LAG:La Guajira
MAG:Magdalena
MET:Meta
NAR:Nariño
NSA:Norte de Santander
PUT:Putumayo
QUI:Quindío
RIS:Risaralda
SAP:San Andrés, Providencia y Santa Catalina
SAN:Santander
SUC:Sucre
TOL:Tolima
VAC:Valle del Cauca
VAU:Vaupés
VID:Vichada

Country=COSTA RICA
Code=CR

A:Alajuela
C:Cartago
G:Guanacaste
H:Heredia
L:Limón
P:Puntarenas
SJ:San José

Country=CROATIA
Code=HR

07:Bjelovarsko-bilogorska zupanija
12:Brodsko-posavska zupanija
19:Dubrovacko-neretvanska zupanija
18:Istarska zupanija
04:Karlovacka zupanija
06:Koprivoickco-krizeva6ka zupanija
02:Krapinako-zagorska zupanija
09:Licko-senjska zupanija
20:Medjimuraka zupanija
14:Osjecko-baranjska zupanija
11:Pozesko-slavonska zupanija
08:Primorsko-goranska zupanija
03:Sisasko-moelavacka Iupanija
17:Splitako-dalmatinska zupanija
15:Sibenako-kninska zupanija
05:Varaidinska zupanija
10:VirovitiEko-podravska zupanija
16:VuRovarako-srijemska zupanija
13:Zadaraka 
01:Zagrebacka zupanija

Country=CUBA
Code=CU

09:Camagüey
08:Ciego de `vila
06:Cienfuegos
03:Ciudad de La Habana
12:Granma
14:Guantánamo
11:Holquin
02:La Habana
10:Las Tunas
04:Matanzas
01:Pinar del Río
07:Sancti Spiritus
13:Santiago de Cuba
05:Villa Clara
99:Isla de la Juventud

Country=CAPE VERDE
Code=CV

BV:Boa Vista
BR:Brava
FO:Fogo
MA:Maio
PA:Paul
PN:Porto Novo
PR:Praia
RG:Ribeira Grande
SL:Sal
CA:Santa Catarina
CR:Santa Cruz
SN:Sao Nicolau
SV:Sao Vicente
TA:Tarrafal

Country=CYPRUS
Code=CY

04:Ammochostos Magusa
06:Keryneia
03:Larnaka
01:Lefkosia
02:Lemesos
05:Pafos

Country=CZECH REPUBLIC
Code=CX

PRG:Praha
CJC:Jihocesky kraj
CJM:Jihomoravsky kraj
CSC:Severoceaky kraj
CSM:Soveromoravsky kraj
CST:Stredocesky kraj
CVC:Vychodocesky kraj
CZC:Západocesky kraj

Country=DENMARK
Code=DK

015:Københavns
020:Frederiksborg
025:Roskilde
030:Vestsjællands
035:Storstrøms
040:Bornholms
042:Fyns
050:Sønderjyllands
055:Ribe
060:Vejle
065:Ringkøbing
070:Århus
076:Viborg
080:Nordjyllands

Country=DJIBOUTI
Code=DJ

AS:Ali Sabiah
DI:Dikhil
DJ:Djibouti
OB:Obock
TA:Tadjoura

Country=DOMINICAN REPUBLIC
Code=DO

01:Distrito Nacional (Santo Domingo)
02:Azua
03:Bahoruco
04:Barahona
05:Dajabón
06:Duarte
08:El Seybo [El Seibo]
09:Espaillat
30:Hato Mayor
10:Independencia
11:La Altagracia
07:La Estrelleta [Elías Piña]
12:La Romana
13:La Vega
14:María Trinidad Sánchez
28:Monseñor Nouel
15:Monte Cristi
29:Monte Plata
16:Pedernales
17:Peravia
18:Puerto Plata
19:Salcedo
20:Samaná
21:San Cristóbal
22:San Juan
23:San Pedro de Macorís
24:Sánchez Ramírez
25:Santiago
26:Santiago Rodríguez
27:Valverde


Country=ECUADOR
Code=EC

A:Azuay
B:Bolívar
F:Cañar
C:Carchi
X:Cotopaxi
H:Chimborazo
O:El Oro
E:Esmeraldas
W:Galápagos
G:Guayas
I:Imbabura
L:Loja
R:Los Rios
M:Manabi
S:Morona-Santiago
N:Napo
Y:Pastaza
P:Pichincha
U:Sucumbíos
T:Tungurahua
Z:Zamora-Chinchipe

Country=EGYPT
Code=EG

DK:Ad Daqahllyah
BA:Al Bahr al Ahmar
BH:Al Buhayrah
FYM:Al FayyÜm
GH:Al Gharbîyah
ALX:Al Iskandarlyah
IS:Al Isma îllyah
GZ:Al Jîzah
MNF:Al Minuflyah
MN:Al Minya
C:Al Qahirah
KB:Al Qalyûblyah
WAD:Al Wadi al Jadîd
SHR:Ash Sharqiyah
SUZ:As Suways
ASN:Aswan
AST:Asyut
BNS:Bani Suwayf
PTS:Bûr Sa'îd
DT:Dumyàt
JS:Janûb Sîna'
KFS:Kafr ash Shaykh
MT:Matrûh
KN:Qinå
SIN:Shamâl Sinã'
SHG:Suhâj

Country=ERITREA
Code=ER

AN:Anseba
DU:Debub
DK:Debubawi Keyih Bahri [Debub-Keih-Bahri]
GB:Gash-Barka
MA:Maakel [Maekel]
SK:Semenawi Keyih Bahri [Semien-Keih-Bahri]

Country=ESTONIA
Code=EE

37:Harjumsa
39:Hitumea
44:Ida-Virumsa
49:Jögevamsa
51:Järvamsa
57:Läsnemsa
59:Lääne-Virumaa
65:Polvamea
67:Pärnumsa
70:Raplamsa
74:Saaremsa
7B:Tartumsa
82:Valgamaa
84:Viljandimsa
86:Vôrumaa

Country=ETHIOPIA
Code=ET

AA:Addis Ababa 
AF:Afar
AM:Amara {Amhara]
BE:Benshangul-Gumaz 
GA:Gambela Peoples 
HA:Harari People 
OR:Oromia 
SO:Somali
SN:Southern Nations, Nationalitioa and Peoples
TI:Tigrai 

Country=FIJI
Code=FJ

C:Central
E:Eastern
N:Northern
W:Western
R:Rotuma

Country=MICRONESIA (FEDERATED STATES OF)
Code=FM

TRK:Chuuk
KSA:Kosrae
PNI:Pohnpei
YAP:Yap

Country=FRANCE
Code=FR
SubCountryType=Department

01:Ain
02:Aisne
03:Allier
04:Alpes-de-Haute-Provence
06:Alpes-Maritimes
07:Ardèche
08:Ardennes
09:Ariege
10:Aube
11:Aude
12:Aveyron
67:Bas-Rhin
90:Belfort, Territoire de
13:Bouches-du-Rhone
14:Calvados
15:Cantal
16:Charente
17:Charente-Maritime
18:Cher
19:Correze
20:Corse-du-Sud
21:Cote-d'Or
22:Cotes-d'Armour
23:Creuse
79:Deux-Sevres
24:Dordogne
25:Doubs
26:Drome
91:Essonne
27:Eure
28:Eure-et-Loir
29:Finistere
30:Gard
32:Gers
33:Gironde
68:Haut-Rhin
20:Haute-Corse
31:Haute-Garonne
43:Haute-Loire
70:Haute-Saone
74:Haute-Savoie
87:Haute-Vienne
05:Hautes-Alpes
65:Hautes-Pyrenees
92:Hauts-de-Seine
34:Herault
35:Indre
36:Ille-et-Vilaine
37:Indre-et-Loire
38:Isere
39:Jura
40:Landes
41:Loir-et-Cher
42:Loire
44:Loire-Atlantique
45:Loiret
46:Lot
47:Lot-et-Garonne
48:Lozere
49:Maine-et-Loire
50:Manche
51:Marne
54:Meurthe-et-Moselle
55:Meuse
56:Morbihan
57:Moselle
58:Nievre
59:Nord
60:Oise
61:Orne
75:Paris
62:Pas-de-Calais
63:Puy-de-Dome
64:Pyrenees-Atlantiques
66:Pyrenees-Orientales
69:Rhône
71:Saone-et-Loire
72:Sarthe
73:Savoie
77:Seine-et-Marne
76:Seine-Maritime
93:Seine-Saint-Denis
80:Somme
81:Tarn
82:Tarn-et-Garonne
95:Val d'Oise
94:Val-de-Marne
83:Var
84:Vaucluse
85:Vendee
86:Vienne
88:Vosges
89:Yonne
78:Yvelines

Country=GAMBIA
Code=GM

B:Banjul
L:Lower River
M:MacCarthy Island
N:North Bank
U:Upper River
W:Western

Country=GABON
Code=GA

1:Estuaire
2:Haut-Ogooué
3:Moyen-Ogooué
4:Ngounié
5:Nyanga
6:Ogooué-Ivindo
7:Ogooué-Lolo
8:Ogooué-Maritime
9:Woleu-Ntem

Country=GEORGIA
Code=GE

AB:Ap'khazet'is Avtonomiuri Respublika 
AJ:Acharis Avtonomiuri Respublika 
BUS:Bat 'umi
CHI:Chiat'ura
GAG:Gagra
GOP:Gori
KUT:K'ut'aisi
PTI:P'ot'i
PUS:Rust'avi
SUI:Sokhumi
TBS:T'bilisi
TQI:Tqibuli
TQV:Tqvarch'eli
TSQ:Tsqalmbo
ZUG:Zuqdidi
01:Abashin Raioni
02:Adigenis Raioni
03:Akhalgoria Raioni
04:Akhalk'alak'is Raioni
05:Akhalts'ikhis Raioni
06:Akhmetis Raioni
07:Ambrolauris Raioni
08:Aspindzis Raioni
09:Baghdat' is Raioni
10:Bolniais Raioni
11:Borjamie Raioni
12:Ch'khorotsqus Raioni
13:Ch'okhatauris Raioni
14:Dedop'listsqaros Raioni
15:Dmaniais Raioni
16:Dushet' is Raioni
17:Galis Raioni
18:Gardabnis Raioni
19:Goris Raioni
20:Gudaut' is Raioni
21:Gulrip'shis Raioni
22:Gurjeanis Raioni
23:Javis Raioni
24:K'arelis Raioni
25:Kaspis Raioni
26:K'edis Raioni
27:Kharagaulis Raioni
28:Khashuris Raioni
29:Khelvach'auri6 Raioni
30:Khobis Raioni
31:Xhonis Raioni
32:Khulos Raioni
33:K'obuletis Raioni
34:Lagodekhis Raioni
35:Lanch'khut'is Raioni
36:Lentekhis Raioni
37:Marneulis Raioni
38:Martvilis Raioni
39:Mestiis Raioni
40:Mts'khet'is Raioni
41:Ninotsmindis Raioni
42:Och'amch'iris Raioni
43:Onis Raioni
44:Ozurget' is Raioni
45:Qazbegis Raioni
46:Qvarlis Raioni
47:Sach'kheris Raioni
48:Sagarejos Raioni
49:Samtrediis Raioni
50:Senakis Raioni
51:Shuakhevis Raioni
52:Sighnaghis Raioni
53:Sokhumis Raioni
54:T'elavis Raioni
55:T'erjolis Raioni
56:T'et'ritsqaros Raioni
57:T'ianet'is Raioni
58:Ts'ageris Raioni
59:Tsalenjikhis Raioni
62:Zestap'onis Raioni
63:Zugdidis Raioni

Country=GERMANY
Code=DE
SubCountryType=Bundesländ

BW:Baden-Württemberg
BY:Bayern
HB:Bremen
HH:Hamburg
HE:Hessen
NI:Niedersachsen
NW:Nordrhein-Westfalen
RP:Rheinland-Pfalz
SL:Saarland
SH:Schleswig-Holstein
BR:Berlin
BB:Brandenburg
MV:Mecklenburg-Vorpommern
SN:Sachsen
ST:Sachsen-Anhalt
TH:Thüringen

Country=GHANA
Code=GH

AH:Ashanti
BA:Brong-Ahafo
CP:Central
EP:Eastern
AA:Greater Accra
NP:Northern
UE:Upper East
UW:Upper West
TV:Volta
WP:Western

Country=GUINEA
Code=GN

BE:Beyla
BF:Boffa
BK:Boké
CO:Coyah
DB:Dabola
DL:Dalaba
DI:Dinguiraye
DU:Dubréka
FA:Faranah
FO:Forécariah
FR:Fria
GA:Gaoual
GU:Guékédou
KA:Kankan
KE:Kérouané
KD:Kindia
KS:Kissidougou
KB:Koubia
KD:Koundara
KO:Kouroussa
LA:Labé
LE:Lélouma
LO:Lola
MC:Macenta
ML:Mali
MM:Mamou
MD:Mandiana
NZ:Nzérékoré
PI:Pita
SI:Siguiri
TE:Télimélé
TO:Tougué
YO:Yomou

Country=EQUATORIAL GUINEA
Code=QQ

C:Regiôn Continental
I:Region Insular
AN:Annobón
BN:Bioko Norte
BS:Bioko Sur
CS:Centro Sur
KN:Kie-Ntem
LI:Litoral
WN:Wele-Nzas

Country=GREECE
Code=GR

13:Achaïa
01:Aitolia-Akarnania
11:Argolis
12:Arkadia
31:Arta
A1:Attiki
64:Chalkidiki
94:Chania
85:Chios
81:Dodekanisos
52:Drama
71:Evros
05:Evrytania
04:Evvoia
63:Florina
07:Fokis
06:Fthiotis
51:Grevena
14:Ileia
53:Imathia
33:Ioannina
91:Irakleion
41:Karditsa
56:Kastoria
55:Kavalla
23:Kefallinia
22:Kerkyra
57:Kilkis
15:Korinthia
58:Kozani
82:Kyklades
16:Lakonia
42:Larisa
92:Lasithion
24:Lefkas
83:Lesvos
43:Magnisia
17:Messinia
59:Pella
34:Preveza
93:Rethymnon
73:Rodopi
84:Samos
62:Serrai
32:Thesprotia
54:Thessaloniki
44:Trikala
03:Voiotia
72:Xanthi
21:Zakynthos
69:Agio Oros

Country=GUATEMALA
Code=GT

AV:Alta Verapez
BV:Baja Verapez
CM:Chimaltenango
CQ:Chiquimula
PR:El Progreso
ES:Escuintla
GU:Guatemala
HU:Huehuetenango
IZ:Izabal
JA:Jalapa
JU:Jutíapa
PE:Petén
QZ:Quezaltenango
QC:Quiché
RE:Reta.thuleu
SA:Sacatepéquez
SM:San Marcos
SR:Santa Rosa
SO:Solol6
SU:Suchitepéquez
TO:Totonicapán
ZA:Zacapa

Country=GUINEA BISSAU
Code=GW

BS:Bissau
BA:Bafatá
BM:Biombo
BL:Bolama
CA:Cacheu
GA:Gabú
OI:Oio
QU:Quloara
TO:Tombali S

Country=GUYANA
Code=GY

BA:Barima-Waini
CU:Cuyuni-Mazaruni
DE:Demerara-Mahaica
EB:East Berbice-Corentyne
ES:Essequibo Islands-West Demerara
MA:Mahaica-Berbice
PM:Pomeroon-Supenaam
PT:Potaro-Siparuni
UD:Upper Demerara-Berbice
UT:Upper Takutu-Upper Essequibo

Country=HAITI
Code=HT

CE:Centre
GA:Grande-Anse
ND:Nord
NE:Nord-Eat
NO:Nord-Ouest
OU:Ouest
SD:Sud
SE:Sud-Est

Country=HONDURAS
Code=HN

AT:Atlántida
CL:Colón
CM:Comayagua
CP:Copán
CR:Cortés
CH:Choluteca
EP:El Paraíso
FM:Francisco Morazán
GD:Gracias a Dios
IN:Intibucá
IB:Islas de la Bahía
LP:La Paz
LE:Lempira
OC:Ocotepeque
OL:Olancho
SB:Santa Bárbara
VA:Valle
YO:Yoro

Country=HUNGARY
Code=HU

BU:Budapest
BK:Bács-Kiskun
BA:Baranya
BE:Békés
BZ:Borsod-Abaúj-Zemplén
CS:Csongrád
FE:Fejér
GS:Gyõr-Moson-Sopron
HB:Hajdû-Bihar
HE:Heves
JN:Jász-Nagykun-Szolnok
KE:Komárom-Esztergom
NO:Nógrád
PE:Pest
SO:Somogy
SZ:Szabolcs-Szatmár-Bereg
TO:Tolna
VA:Vas
VE:Veszprém
ZA:Zala
BC:Békéscsaba
DE:Debrecen
DU:Dunaújváros
EG:Eger
GY:Gyór
HV:Hôdmezóvásárhely
KV:Kaposvár
KM:Kecékemét
MI:Miskolc
NK:Nagykanizaa
NY:Nyíregyháza
PS:Pécs
ST:Salgótarján
SN:Sopron
SD:Szaged
SF:Szakeafahérvár
SS:Szakszárd
SK:Szolnok
SH:Szombathely
TB:Tatabinya
VM:Veezprém
ZE:Zalaegerszeg

Country=ICELAND
Code=IE

7:Austurland
1:Höfuoborgarsvæöi utan Reykjavíkur
6:Noröurland eystra
5:Noröurland vestra
0:Reykjavík
8:Suöurland
2:Suöurnes
4:Vestfirölr
3:Vesturland

Country=INDIA
Code=IN

AP:Andhra Pradesh
AR:Arunachal Pradesh
AS:Assam
BR:Bihar
GA:Goa
GJ:Gujarat
HR:Haryana
HP:Himachal Pradesh
JK:Jammu and Kashmir
KA:Karnataka
KL:Kerala
MP:Madhya Pradesh
MM:Maharashtra
MN:Manipur
ML:Meghalaya
MZ:Mizoram
NL:Nagaland
OR:Orissa
PB:Punjab
RJ:Rajasthan
SK:Sikkim
TN:Tamil Nadu
TR:Tripura
UP:Uttar Pradesh
W8:West Bengal
AN:Andaman and Nicobar Islands
CH:Chandigarh
DN:Dadra and Nagar Haveli
DD:Daman and Diu
DL:Delhi
LD:Lakshadweep
PY:Pondicherry

Country=INDONESIA
Code=ID

AC:Aceh
BA:Bali
BE:Bengkulu
IJ:Irian Jaya
JA:Jambi
JB:Jawa Barat
JI:Jawa Timur
JK:Jakarta Raya
JT:Jawa Tengah
JW:Jawa
KA:Kalimantan
KB:Kalimantan Barat
KI:Kalimantan Timur
KS:Kalimantan Selatan
KT:Kalimantan Timur
LA:Lampung
MA:Maluku
NB:Nusa Tenggara Barat
NT:Nusa Tenggara Timur
NU:Nusa Tenggara
RI:Riau
SA:Sulawesi Utara
SB:Sumatra Barat
SG:Sulawesi Tenggara
SL:Sulawesi
SM:Sumatera
SN:Sulawesi Selatan
SS:Sumatra Selatan
ST:Sulawesi Tengah
SU:Sumatera Utara
TT:Timor-Timur
YO:Yogyakarta

Country=IRELAND
Code=IE
SubCountryType=County

C:Cork
CE:Clare
CN:Cavan
CW:Carlow
D:Dublin
G:Galway
KE:Kildare
KK:Kilkenny
K:Kerry
LD:Longford
LH:Louth
LK:Limerick
LM:Leitrim
LS:Laois
MH:Meath
MN:Monaghan
MO:Mayo
OY:Offaly
RN:Roscommon
SO:Sligo
TA:Tipperary
WD:Waterford
WH:Westmeath
WW:Wicklow
WX:Wexford

Country=ITALY
Code=IT

AG:Agrigento
AL:Alessandria
AN:Ancona
AO:Aosta
AR:Arezzo
AP:Ascoli Piceno
AT:Asti
AV:Avellino
BA:Bari
BL:Belluno
BN:Benevento
BG:Bergamo
BI:Biella
BO:Bologna
BZ:Bolzano
BS:Brescia
BR:Brindisi
CA:Cagliari
CL:Caltanissetta
CB:Campobasso
CE:Caserta
CT:Catania
CZ:Catanzaro
CH:Chieti
CO:Como
CS:Cosenza
CR:Cremona
KR:Crotone
CN:Cuneo
EN:Enna
FE:Ferrara
FI:Firenze
FG:Foggia
FO:Forlì
FR:Frosinone
GE:Genova
GO:Gorizia
GR:Grosseto
IM:Imperia
IS:Isernia
AQ:L'Aquila
SP:La Spezia
LT:Latina
LE:Lecce
LC:Lecco
LI:Livorno
LO:Lodi
LU:Lucca
MC:Macerata
MN:Mantova
MS:Massa-Carrara
MT:Matera
ME:Messina
MI:Milano
MO:Modena
NA:Napoli
NO:Novara
NU:Nuoro
OR:Oristano
PD:Padova
PA:Palermo
PR:Parma
PV:Pavia
PG:Perugia
PS:Pesaro e Urbino
PE:Pescara
PC:Piacenza
PI:Pisa
PT:Pistoia
PN:Pordenone
PZ:Potenza
PO:Prato
RG:Ragusa
RA:Ravenna
RC:Reggio Calabria
RE:Reggio Emilia
RI:Rieti
RN:Rimini
RM:Roma
RO:Rovigo
SA:Salerno
SS:Sassari
SV:Savona
SI:Siena
SR:Siracusa
SO:Sondrio
TA:Taranto
TE:Teramo
TR:Terni
TO:Torino
TP:Trapani
TN:Trento
TV:Treviso
TS:Trieste
UD:Udine
VA:Varese
VE:Venezia
VB:Verbano-Cusio-Ossola
VC:Vercelli
VR:Verona
VV:Vibo Valentia
VI:Vicenza
VT:Viterbo

# See note in limitations
65:Abruzzo
77:Basilicata
78:Calabria
72:Campania
45:Emilia-Romagna
36:Friuli-Venezia Giulia
62:Lazio
42:Liguria
25:Lombardia
57:Marche
67:Molise
21:Piemonte
75:Puglia
88:Sardegna
82:Sicilia
52:Toscana
32:Trentino-Alto Adige
55:Umbria
23:Valle d'Aosta
34:Veneto

Country=IRAQ
Code=IQ

AN:Al Anbar
BA:Al Ba,rah
MU:Al Muthanná
QA:Al Qadisiyah
NA:An Najef
AR:Arbil
SW:As Sulaymaniyah
TS:At Ta'mîm
BB:Babil
BG:Baghdäd
DA:Dahùk
DQ:Dhi Qär
DI:Diyälá
KA:Karbalä'
MA:Maysan
NI:Ninawá
SD:Salah ad Din
WA:Wasit

Country=IRAN (ISLAMIC REPUBLIC OF)
Code=IN

03:ArdabLl
02:Azarbayjän-e-Gharbî
01:Azarb&yjan-e-Sharq
06:Büahahr
08:Chahar Mahall va Bakhtlari
04:Esfahan
14:Fars
19:Gilan
24:Hamadan
23:Hormozgän
05:Ilam
15:Kerman
17:Kermanshähan
09:Khoràsàn
10:KhÜzestan
18:Kohkilüyeh va Büyer Ahmadî
16:Kordeatan
20:Lorestan
22:Markazî
21:Mazandaran
26:Qom
12:Semnan
13:SIstan va Balûchestan
07:Tehran
25:Yazd
11:Zanjan

Country=COTE D'IVOIRE
Code=CI

06:18 Montagnes
16:Agnébi
09:Bas-Sassandra
10:Denguélé
02:Haut-Sassandra
07:Lacs
01:Lagunes
12:Marahoué
05:Moyen-Comoé
11:Nzi-Comoé
03:Savanes
15:Sud-Bandama
13:Sud-Comoé
04:Vallée du Bandama
14:Worodouqou
08:Zanzan

Country=JAPAN
Code=JP

23:Aichi
05:Akita
02:Aomori
12:Chiba
38:Ehime
18:Fukui
40:Fukuoka
07:Fukusima
21:Gifu
10:Gunma
34:Hiroshima
01:Hokkaido
28:Hyogo
08:Ibaraki
17:Ishikawa
03:Iwate
37:Kagawa
46:Kagoshima
14:Kanagawa
39:Kochi
43:Kumamoto
26:Kyoto
24:Mie
04:Miyagi
45:Miyazaki
20:Nagano
42:Nagasaki
29:Nara
15:Niigata
44:Oita
33:Okayama
47:Okinawa
27:Osaka
41:Saga
11:Saitama
25:Shiga
32:Shimane
22:Shizuoka
09:Tochigi
36:Tokushima
13:Tokyo
31:Tottori
16:Toyama
30:Wakayama
06:Yamagata
35:Yamaguchi
19:Yamanashi

Country=JAMAICA
Code=JM

13:Clarendon
09:Hanover
01:Kingston
12:Manchester
04:Portland
02:Saint Andrew
06:Saint Ann
14:Saint Catherine
11:Saint Elizabeth
08:Saint James
05:Saint Mary
03:Saint Thomea
07:Trelawny
10:Westmoreland

Country=JORDAN
Code=JO

AJ:Ajlün
AQ:Al 'Aqaba
BA:Al Balqa'
KA:Al Karak
MA:Al Mafraq
AM:'Ammãn
AT:At Tafîlah
AZ:Az Zargã'
JR:Irbid
JA:Jarash
MN:Ma'ãn
MD:Madaba

Country=KENYA
Code=KE

110:Nairobi Municipality
200:Central
300:Coast
400:Eastern
500:North-Eastern Kaskazini Mashariki
700:Rift Valley
900:Western Magharibi

Country=KYRGYZSTAN
Code=KG

C:Chu
J:Jalal-Abad
N:Naryn
O:Osh
T:Talas
Y:Ysyk-Kol

Country=CAMBODIA
Code=KH

23:Krong Kaeb 
18:Xrong Preah Sihanouk 
12:Phnom Penh 
2:Baat Dambang 
1:Banteay Mean Chey 
3:Rampong Chaam 
4:Kampong Chhnang 
5:Kampong Spueu 
6:Kampong Thum 
7:Kampot 
8:Kandaal 
9:Kach Kong 
10:Krachoh 
11:Mondol Kiri 
22:Otdar Mean Chey 
15:Pousaat 
13:Preah Vihear 
14:Prey Veaeng 
16:Rotanak Kiri 
17:Siem Reab 
19:Stueng Traeng 
20:Svaay Rieng 
21:Taakaev

Country=KIRIBATI
Code=KI

G:Gilbert Islands
L:Line Islands
P:Phoenix Islands

Country=KUWAIT
Code=KW

AH:Al Ahmadî
FA:Al Farwanlyah
JA:Al Jahrah
KU:Al Kuwayt
HA:Hawallî

Country=KAZAKHSTAN
Code=KZ

ALA:Almaty
BAY:Bayqonyr
ALM:Almaty oblysy
AKM:Aqmola oblysy
AKT:Aqtöbe oblysy
ATY:Atyraû oblyfiy
ZAP:Batys Kazakstan
MAN:Mangghystaû oblysy
YUZ:Ongtustik Kazakstan Yuzhno-Kazakhstanskaya Juzno-Kazahetanskaja
PAV:Pavlodar oblysy
KAR:Qaraghandy oblysy
KUS:Qostanay oblysy
KZY:Qyzylorda oblysy
VOS:Shyghys Kazakstan
SEV:SoltÜatik Kazakstan Severo-Kazakhstanskaya Severo-Kazahstanskaja
ZHA:Zhambyl oblysy Zhambylskaya oblast'

Country=LAO PEOPLE'S DEMOCRATIC REPUBLIC
Code=LA

VT:Vientiane
AT:Attapu 
BK:Bokèo
BL:Bolikhamxai 
CH:Champasak 
HO:Houaphan
KH:Khammouan
LM:Louang Namtha
LP:Louangphabang 
OU:Oudômxai 
PH:Phôngsali 
SL:Salavan 
SV:Savannakhét
VI:Vientiane
XA:Xaignabouli 
XE:Xékong 
XI:Xiangkhoang 

Country=LEBANON
Code=LB

BA:Beirout
BI:El Bégsa
JL:Jabal Loubnâne
AS:Loubnane ech Chemàli
JA:Loubnâne ej Jnoûbi
NA:Nabatîyé

Country=SRI LANKA
Code=LK

52:Ampara
71:Anuradhapura
81:Badulla
51:Batticaloa
11:Colombo
31:Galle
12:Gampaha
33:Hambantota
41:Jaffna
13:Kalutara
21:Kandy
92:Kegalla
42:Kilinochchi
61:Kurunegala
43:Mannar
22:Matale
32:Matara
82:Monaragala
45:Mullaittivu
23:Nuwara Eliya
72:Polonnaruwa
62:Puttalum
91:Ratnapura
53:Trincomalee
44:VavunLya

Country=LIBERIA
Code=LR

BM:Bomi
BG:Bong
GB:Grand Basaa
CM:Grand Cape Mount
GG:Grand Gedeh
GK:Grand Kru
LO:Lofa
MG:Margibi
MY:Maryland
MO:Montserrado
NI:Nimba
RI:Rivercess
SI:Sinoe

Country=LESOTHO
Code=LS

D:Berea
B:Butha-Buthe
C:Leribe
E:Mafeteng
A:Maseru
F:Mohale's Hoek
J:Mokhotlong
H:Qacha's Nek
G:Quthing
K:Thaba-Tseka

Country=LITHUANIA
Code=LT

AL:Alytaus Apskritis
KU:Kauno Apskritis
KL:Klaipedos Apskritis
MR:Marijampoles Apskritis
PN:Panevezio Apskritis
SA:Sisuliu Apskritis
TA:Taurages Apskritis
TE:Telsiu Apskritis
UT:Utenos Apskritis
VL:Vilniaus Apskritis

Country=LATVIA
Code=LV

AI:Aizkraukles Apripkis
AL:AlÜkanes Apripkis
BL:Balvu Apripkis
BU:Bauskas Apripkis
CE:Cêsu Aprikis
DA:Daugavpile Apripkis
DO:Dobeles Apripkis
GU:Gulbenes Aprlpkis
JL:Jelgavas Apripkis
JK:Jékabpils Apripkis
KR:Kräslavas Apripkis
KU:Kuldlgas Apripkis
LM:Limbazu Apripkis
LE:Liepàjas Apripkis
LU:Ludzas Apripkis
MA:Madonas Apripkis
OG:Ogres Apripkis
PR:Preilu Apripkis
RE:Rèzaknes Apripkis
RI:Rîgas Apripkis
SA:Saldus Apripkis
TA:Talsu Apripkis
TU:Tukuma Apriplcis
VK:Valkas Apripkis
VM:Valmieras Apripkis
VE:Ventspils Apripkis
DGV:Daugavpils
JEL:Jelgava
JUR:Jurmala
LPX:Liepäja
REZ:Rêzekne
RIX:Rlga
VEN:Ventspils

Country=LIBYAN ARAB JAMAHIRIYA
Code=LY

BU:Al Butnan
JA:Al Jabal al Akhdar
JG:Al Jabal al Gharbî
JU:Al Jufrah
WA:Al Wâhah
WU:Al Wustá
ZA:Az Zãwiyah
BA:Banghazi
FA:Fazzan
MI:Misratah
NA:Naggaza
SF:Sawfajjin
TB:Tarãbulus

Country=MOROCCO
Code=MA

AGD:Agadir
BAH:Aït Baha
MEL:Aït Melloul
HAO:Al Haouz
HOC:Al Hoceïma
ASZ:Assa-Zag
AZI:Azilal
BEM:Beni Mellal
BES:Ben Sllmane
BER:Berkane
BOD:Boujdour 
BOM:Boulemane
CAS:Casablanca 
CHE:Chefchaouene
CHI:Chichaoua
HAJ:El Hajeb
JDI:El Jadida
ERR:Errachidia
ESI:Essaouira
ESM:Es Semara 
FES:Fès
FIG:Figuig
GUE:Guelmim
IFR:Ifrane
IRA:Jrada
KES:Kelaat Sraghna
KEN:Kénitra
KHE:Khemisaet
KHN:Khenifra
KHO:Khouribga
LAA:Laayoune. (EH)
LAP:Larache
MAR:Marrakech
MEK:Meknès
NAD:Nador
OUA:Ouarzazate
OUD:Oued ed Dahab (EH)
OUJ:Oujda
RBA:Rabat-Salé
SAF:Safi
SEF:Sefrou
SET:Settat
SIK:Sidl Kacem
TNG:Tanger
TNT:Tan-Tan
TAO:Taounate
TAR:Taroudannt
TAT:Tata
TAZ:Taza
TET:Tétouan
TIZ:Tiznit

Country=MOLDOVA, REPUPLIC OF
Code=MD

BAL:Balti
CAH:Cahul
CHI:Chisinau
DUB:Dubasari
ORH:Orhei
RIB:Ribnita
SOC:Soroca
TIG:Tighina
TIP:Tiraspol
UNG:Ungheni
ANE:Anenii Noi
BAS:Basarabeasca
BRI:Brinceni
CHL:Cahul
CAM:Camenca
CAN:Cantemir
CAI:Cainari
CAL:Calarayi
CAS:Causeni
CIA:Ciadîr-Lunga
CIM:Cimi'lia
COM:Comrat
CRI:Criuleni
DON:Donduseni
DRO:Drochia
DBI:Dubasari
EDI:Edine;
FAL:Fãlesti
FLO:Floresti
GLO:Glodeni
GRI:Grigoriopol
HIN:Hîncesti
IAL:Ialoveni
LEO:Leova
NIS:Nisporeni
OCN:Ocni\a
OHI:Orhei
REZ:Rezina
RIT:Rîbnita
RIS:Rîscani
SIN:Sîngerei
SLO:Slobozia
SOA:Soroca
STR:Straseni
SOL:Soldanesti
STE:Stefan Voda
TAR:Taraclia
TEL:Telenesti
UGI:Ungheni
VUL:Vulcanesti

Country=MADAGASCAR
Code=MG

T:Antananarivo
D:Antsiranana
F:Fianarantsoa
M:Mahajanga
A:Toamasina
U:Toliara

Country=MALI
Code=ML

BK0:Bamako
7:Gao
1:Kayes
8:Kidal
2:Xoulikoro
5:Mopti
4:S69ou
3:Sikasso
6:Tombouctou

Country=MYANMAR
Code=MM

07:Ayeyarwady
02:Bago
03:Magway
04:Mandalay
01:Sagaing
05:Tanintharyi
06:Yangon
14:Chin
11:Kachin
12:Kayah
13:Kayin
15:Mon
16:Rakhine
17:Shan

Country=MONGOLIA
Code=MN

1:Ulanbaatar
073:Arhangay
069:Bayanhongor
071:Bayan-Ölgiy
067:Bulgan
037:Darhan uul
061:Dornod
063:Dornogov
059:DundgovL
057:Dzavhan
065:Govi-Altay
064:Govi-Sümber
039:Hentiy
043:Hovd
041:Hövsgöl
053:Ömnögovi
035:Orhon
055:Övörhangay
049:Selenge
051:Sühbaatar
047:Töv
046:Uvs

Country=MARSHALL ISLANDS
Code=MH

ALL:Ailinglapalap
ALK:Ailuk
ARN:Arno
AUR:Aur
EBO:Ebon
ENI:Eniwetok
JAL:Jaluit
KIL:Kili
KWA:Kwajalein
LAE:Lae
LIB:Lib
LIK:Likiep
MAJ:Majuro
MAL:Maloelap
MEJ:Mejit
MIL:Mili
NMK:Namorik
NMU:Namu
RON:Rongelap
UJA:Ujae
UJL:Ujelang
UTI:Utirik
WTN:Wotho
WTJ:Wotje

Country=MAURITANIA
Code=MR

NKC:Nouakchott
07:Adrar
03:Assaba
05:Brakna
08:Dakhlet Nouadhibou
04:Gorgol
10:Guidimaka
01:Hodh ech Chargui
02:Hodh el Charbi
12:Inchiri
09:Tagant
11:Tiris Zemmour
06:Trarza

Country=MAURITIUS
Code=MU

BR:Beau Bassin-Rose Hill
CU:Curepipe
PL:Port Louis
QB:Quatre Bornes
VP:Vacosa-Phoenix
BL:Black River
FL:Flacq
GP:Grand Port
MO:Moka
PA:Pamplemousses
PW:Plaines Wilhems
PL:Port Louis
RP:Riviére du Rempart
SA:Savanne
AG:Agalega Islands
CC:Cargados Carajos Shoals 
RO:Rodrigues Island

Country=MALDIVES
Code=MV

MLE:Male
02:Alif
20:Baa
17:Dhaalu
14:Faafu
27:Gaaf Alif
28:Gaefu Dhaalu
29:Gnaviyani
07:Haa Alif
23:Haa Dhaalu
26:Kaafu
05:Laamu
03:Lhaviyani
12:Meemu
25:Noonu
13:Raa
01:Seenu
24:Shaviyani
08:Thaa
04:Vaavu

Country=MALAWI
Code=MW

BL:Blantyre
CK:Chikwawa
CR:Chiradzulu
CT:Chitipa
DE:Dedza
DO:Dowa
KR:Karonga
KS:Kasungu
LI:Lilongwe
MH:Machinga
MG:Mangochi
MC:Mchinji
MU:Mulanje
MW:Mwanza
MZ:Mzimba
NB:Nkhata Bay
NK:Nkhotakota
NS:Nsanje
NU:Ntcheu
NI:Ntchisi
RU:Rumphi
SA:Salima
TH:Thyolo
ZO:Zomba

Country=MEXICO
Code=MX

DIF:Distrito Federal
AGU:Aguascalientes
BCN:Baja California
BCS:Baja California Sur
CAM:Campeche
COA:Coahu ila
COL:Col ima
CHP:Chiapas
CHH:Chihushua
DUR:Durango
GUA:Guanajuato
GRO:Guerrero
HID:Hidalgo
JAL:Jalisco
MEX:Mexico
MIC:Michoacin
MOR:Moreloa
NAY:Nayarit
NLE:Nuevo León
OAX:Oaxaca
PUE:Puebla
QUE:Querétaro
ROO:Quintana Roo
SLP:San Luis Potosí
SIN:Sinaloa
SON:Sonora
TAB:Tabasco
TAM:Tamaulipas
TLA:Tlaxcala
VER:Veracruz
YUC:Yucatán
ZAC:Zacatecas

Country=MALAYSIA
Code=MY

W:Wilayah Persekutuan Kuala Lumpur
L:Wilayah Persekutuan Labuan
J:Johor
K:Kedah
D:Kelantan
M:Melaka
N:Negeri Sembilan
C:Pahang
A:Perak
R:Perlis
P:Pulau Pinang
SA:Sabah
SK:Sarawak
B:Selangor
T:Terengganu

Country=MOZAMBIQUE
Code=MZ

MPM:Maputo
P:Cabo Delgado
G:Gaza
I:Inhambane
B:Manica
L:Maputo
N:Numpula
A:Niaaea
S:Sofala
T:Tete
Q:Zambézia

Country=NAMIBIA
Code=NA

CA:Caprivi
ER:Erongo
HA:Hardap
KA:Karas
KH:Khomae
KU:Kunene
OW:Ohangwena
OK:Okavango
OH:Omaheke
OS:Omusati
ON:Oshana
OT:Oshikoto
OD:Otjozondjupa

Country=NETHERLANDS
Code=NL

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

Country=NIGERIA
Code=NG

FC:Abuja Capital Territory
AB:Abia
AD:Adamawa
AK:Akwa Ibom
AN:Anambra
BA:Bauchi
BY:Bayelsa
BE:Benue
BO:Borno
CR:Cross River
DE:Delta
EB:Ebonyi
ED:Edo
EK:Ekiti
EN:Enugu
GO:Gombe
IM:Imo
JI:Jigawa
KD:Kaduna
KN:Kano
KT:Katsina
KE:Kebbi
KO:Kogi
KW:Kwara
LA:Lagos
NA:Nassarawa
NI:Niger
OG:Ogun
ON:Ondo
OS:Osun
OY:Oyo
PL:Plateau
RI:Rivers
SO:Sokoto
TA:Taraba
YO:Yobe
ZA:Zamfara

Country=NIGER
Code=NE

8:Niamey
1:Agadez
2:Diffa
3:Dosso
4:Maradi
S:Tahoua
6:Tillabéri
7:Zinder

Country=NICARAGUA
Code=NI

BO:Boaco
CA:Carazo
CI:Chinandega
CO:Chontales
ES:Estelí
GR:Granada
JI:Jinotega
LE:Leon
MD:Madriz
MN:Managua
MS:Masaya
MT:Matagalpa
NS:Nueva Segovia
SJ:Río San Juan
RI:Rivas
ZE:Zelaya

Country=KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
Code=KP

KAE:Kaesong-si
NAM:Nampo-si
PYO:Pyongyang-ai
CHA:Chagang-do
HAB:Hamgyongbuk-do
HAN:Hamgyongnam-do
HWB:Hwanghaebuk-do
HWN:Hwanghaenam-do
KAN:Kangwon-do
PYB:Pyonganbuk-do
PYN:Pyongannam-do
YAN:Yanggang-do

Country=NORWAY
Code=NO

02:Akershus
09:Aust-Agder
06:Buskerud
20:Finumark
04:Hedmark
12:Hordaland
15:Míre og Romsdal
18:Nordland
17:Nord-Tríndelag
05:Oppland
03:Oslo
11:Rogaland
14:Sogn og Fjordane
16:Sír-Tríndelag
06:Telemark
19:Troms
10:Vest-Agder
07:Vestfold
01:Østfold
22:Jan Mayen
21:Svalbard

Country=NEW ZEALAND
Code=NZ

AUK:Auckland
BOP:Bay of Plenty
CAN:Canterbury
GIS:Gisborne
HKB:Hawkes's Bay
MWT:Manawatu-Wanganui
MBH:Marlborough
NSN:Nelson
NTL:Northland
OTA:Otago
STL:Southland
TKI:Taranaki
TAS:Tasman
WKO:waikato
WGN:Wellington
WTC:West Coast

Country=OMAN
Code=OM

DA:Ad Dakhillyah
BA:Al Batinah
JA:Al JanÜblyah 
WU:Al Wustá
SH:Ash Sharqlyah
ZA:Az Zahirah
MA:Masqat
MU:Musandam

Country=PANAMA
Code=PA

1:Bocas del Toro
2:Coclé
3:Colón
4:Chiriqui
5:Darién
6:Herrera
7:Loa Santoa
8:Panamá
9:Veraguas
Q:Comarca de San Blas

Country=PAKISTAN
Code=PK

IS:Islamabad
BA:Baluchistan (en)
NW:North-West Frontier
PB:Punjab
SD:Sind (en)
TA:Federally Administered Tribal Aresa
JK:Azad Rashmir
NA:Northern Areas

Country=PAPUA NEW GUINEA
Code=PG

NCD:National Capital District (Port Moresby)
CPM:Central
CPK:Chimbu
EHG:Eastern Highlands
EBR:East New Britain
ESW:East Sepik
EPW:Enga
GPK:Gulf
MPM:Madang
MRL:Manus
MBA:Milne Bay
MPL:Morobe
NIK:New Ireland
NPP:Northern
NSA:North Solomons
SAN:Santaun 
SHM:Southern Highlands
WPD:Western
WHM:Western Highlands
WBK:West New Britain

Country=PERU
Code=PE

CAL:El Callao
AMA:Amazonas
ANC:Ancash
APU:Apurímac
ARE:Arequipa
AYA:Ayacucho
CAJ:Cajamarca
CUS:Cuzco 
HUV:Huancavelica
HUC:Huánuco
ICA:Ica
JUN:Junín
LAL:La Libertad
LAM:Lambayeque
LIM:Lima
LOR:Loreto
MDD:Madre de Dios
MOQ:Moquegua
PAS:Pasco
PIU:Piura
PUN:Puno
SAM:San Martín
TAC:Tacna
TUM:Tumbes
UCA:Ucayali

Country=PHILIPPINES
Code=PH

ABR:Abra
AGN:Agusan del Norte
AGS:Agusan del Sur
AKL:Aklan
ALB:Albay
ANT:Antique
AUR:Aurora
BAS:Basilan
BAN:Batasn
BTN:Batanes
BTG:Batangas
BEN:Benguet
BOH:Bohol
BUK:Bukidnon
BUL:Bulacan
CAG:Cagayan
CAN:Camarines Norte
CAS:Camarines Sur
CAM:Camiguin
CAP:Capiz
CAT:Catanduanes
CAV:Cavite
CEB:Cebu
DAV:Davao
DAS:Davao del Sur
DAO:Davao Oriental
EAS:Eastern Samar
IFU:Ifugao
ILN:Ilocos Norte
ILS:Ilocos Sur
ILI:Iloilo
ISA:Isabela
KAL:Kalinga-Apayso
LAG:Laguna
LAN:Lanao del Norte
LAS:Lanao del Sur
LUN:La Union
LEY:Leyte
MAG:Maguindanao
MAD:Marinduque
MAS:Masbate
MDC:Mindoro Occidental
MDR:Mindoro Oriental
MSC:Misamis Occidental
MSR:Misamis Oriental
MOU:Mountain Province
NEC:Negroe Occidental
NER:Negros Oriental
NCO:North Cotabato
NSA:Northern Samar
NUE:Nueva Ecija
NUV:Nueva Vizcaya
PLW:Palawan
PAM:Pampanga
PAN:Pangasinan
QUE:Quezon
QUI:Quirino
RIZ:Rizal
ROM:Romblon
SIG:Siquijor
SOR:Sorsogon
SCO:South Cotabato
SLE:Southern Leyte
SUK:Sultan Kudarat
SLU:Sulu
SUN:Surigao del Norte
SUR:Surigao del Sur
TAR:Tarlac
TAW:Tawi-Tawi
WSA:Western Samar
ZMB:Zambales
ZAN:Zamboanga del Norte
ZAS:Zamboanga del Sur

Country=POLAND
Code=PL

BP:Biala Podlaska
BK:Bialystok
BB:Bielsko
BY:Bydgoszcz
CH:Chelm
CI:Ciechanów
CZ:Czestochowa
DS:Dolnos´laskie
EL:Elblag
GD:Gdansk
GO:Gorzaw
JG:Jelenia Góra
KL:Kalisz
KA:Katowice
KI:Kielce
KN:Konin
KO:Koszalin
KP:Kujawsko-pomorskie

KR:Kraków
KS:Krosno
LB:Lubuskie
LD:ódzkie
LG:Legnica
LE:Leszno
LU:Lublin
LO:Lomza
LD:Lódz
MA:Ma opolskie
MZ:Mazowieckie
NS:Nowy Sacz
OL:Olsztyn
OP:Opole
OS:Ostroleka
PD:Podlaskie
PI:Pila
PK:Podkarpackie
PL:Plock
PL-TO:Torun
PL-WB:Walbrzych
PM:Pomorskie
PO:Poznañ
PR:Przemysl
PT:Piotrków
RA:Radom
RZ:Rzeszów
SE:Siedlce
SI:Sieradz
SR:Skierniewice
SK:S´wietokrzyskie
SL:Slupsk
SU:Suwalki
SZ:Szczecin
TG:Tarnobrzeg
TA:Tarnów
T0:Toruñ
WB:Wañblzych
WA:Warazawa
WL:Wloclawek
WN:Warmi´nsko-mazurskie
WP:Wielkopolskie
WR:Wroclaw
ZA:Zamosc
ZG:Zielona Góra
ZP:Zachodniopomorskie

Country=PORTUGAL
Code=PT

01:Aveiro
02:Beja
03:Braga
04:Bragança
05:Castelo Branco
06:Coimbra
07:Évora
08:Faro
09:Guarda
10:Leiria
11:Lisboa
12:Portalegre
13:Porto
14:Santarém
15:Setúbal
16:Viana do Castelo
17:Vila Real
18:Viseu
20:Regiao Autonoma dos Açores
30:Regiao AutOnoma da Madeira

Country=PARAGUAY
Code=PY

ASU:Asunción
16:Alto Paraguay
10:Alto Paraná
13:Amambay
19:Boquerón
5:Caeguazú
6:Caazapl
14:Canindeyú
11:Central
1:Concepción
3:Cordillera
4:Guairá
7:Itapua
8:Miaiones
12:Ñeembucu
9:Paraguarí
15:Presidente Hayes
2:San Pedro


Country=QATAR
Code=QA

DA:Ad Dawhah
GH:Al Ghuwayrîyah
JU:Al Jumayliyah
KH:Al Khawr
WA:Al Wakrah
RA:Ar Rayyãn
JB:Jariyan al Bãtnah
MS:Madinat ash Shamal
US:Umm Salãl


Country=RWANDA
Code=RW

C:Butare
I:Byumba
E:Cyangugu
D:Gikongoro
G:Gisenyi
B:Gitarama
J:Kibungo
F:Kibuye
K:Kigali-Rural Kigali y' Icyaro
L:Kigali-Ville Kigali Ngari
M:Mutara
H:Ruhengeri

Country=ROMANIA
Code=RO

B:Bucuresti
AB:Alba
AR:Arad
AG:Arges
BC:Bacau
BH:Bihor
BN:Bistrita-Nasaud
BT:Botosani
BV:Brasov
BR:Braila
BZ:Buzau
CS:Caras-Severin
CL:Calarasi
CJ:Cluj
CT:Constanta
CV:Covasna
DB:Dâmbovita
DJ:Dolj
GL:Galati
GR:Giurgiu
GJ:Gorj
HR:Harghita
HD:Hunedoara
IL:Ialomita
IS:Iasi
MM:Maramures
MH:Mehedinti
MS:Mures
NT:Neamt
OT:Olt
PH:Prahova
SM:Satu Mare
SJ:Sa laj
SB:Sibiu
SV:Suceava
TR:Teleorman
TM:Timis
TL:Tulcea
VS:Vaslui
VL:Vâlcea
VN:Vrancea

Country=RUSSIA
Code=RU

AD:Adygeya, Respublika 
AL:Altay, Respublika 
BA:Bashkortostan, Respublika
BU:Buryatiya, Respublika
CE:Chechenskaya Respublika
CU:Chuvashskaya Respublika
DA:Dagestan, Respublika
IN:Ingushskaya Respublika
KB:Kabardino-Balkarskaya
KL:Kalmykiya, Respublika
KC:Karachayevo-Cherkesskaya Respublika
KR:Kareliya, Respublika 
KK:Khakasiya, Respublika
KO:Komi, Respublika
ME:Mariy El, Respublika
MO: Mordoviya, Respublika
SA:Sakha, Respublika [Yakutiya]
SE:Severnaya Osetiya, Respublika
TA:Tatarstan, Respublika
TY:Tyva, Respublika [Tuva]
UD:Udmurtskaya Respublika 
ALT:Altayskiy kray
KHA:Khabarovskiy kray
KDA:Krasnodarskiy kray
KYA:Krasnoyarskiy kray
PRI:Primorskiy kray
STA:Stavropol'skiy kray
AMU:Amurskaya oblast'
ARK:Arkhangel'skaya oblast'
AST:Astrakhanskaya oblast'
BEL:Belgorodskaya oblast'
BRY:Bryanskaya oblast'
CHE:Chelyabinskaya oblast'
CHI:Chitinskaya oblast'
IRK:Irkutskaya oblast'
IVA:Ivanovskaya oblast'
KGD:Kaliningradskaya oblast'
KLU:Kaluzhskaya oblast'
KAM:Kamchatskaya oblast'
KEM:Kemerovskaya oblast'
KIR:Kirovskaya oblast'
KOS:Kostromskaya oblast'
KGN:Kurganskaya oblast'
KRS:Kurskaya oblast'
LEN:Leningradskaya oblast'
LIP:Lipetskaya oblast'
MAG:Magadanskaya oblast'
MOS:Moskovskaya oblast'
MUR:Murmanskaya oblast'
NIZ:Nizhegorodskaya oblast'
NGR:Novgorodskaya oblast'
NVS:Novosibirskaya oblast'
OMS:Omskaya oblast'
ORE:Orenburgskaya oblast'
ORL:Orlovskaya oblast'
PNZ:Penzenskaya oblast'
PER:Permskaya oblast'
PSK:Pskovskaya oblast'
ROS:Rostovskaya oblast'
RYA:Ryazanskaya oblast'
SAK:Sakhalinskaya oblast'
SAM:Samarskaya oblast'
SAR:Saratovskaya oblast'
SMO:Smolenskaya oblast'
SVE:Sverdlovskaya oblast'
TAM:Tambovskaya oblast'
TOM:Tomskaya oblast'
TUL:Tul'skaya oblast'
TVE:Tverskaya oblast'
TYU:Tyumenskaya oblast'
ULY:Ul'yanovskaya oblast'
VLA:Vladimirskaya oblast'
VGG:Volgogradskaya oblast'
VLG:Vologodskaya oblast'
VOR:Voronezhskaya oblast'
YAR:Yaroslavskaya oblast'
MOW:Moskva
SPE:Sankt-Peterburg
YEV:Yevreyskaya avtonomnaya oblast'
AGB:Aginskiy Buryatskiy avtonomnyy
CHU:Chukotskiy avtonomnyy okrug
EVE:Evenkiyskiy avtonomnyy okrug
KHM:Khanty-Mansiyskiy avtonomnyy okrug
KOP:Komi-Permyatskiy avtonomnyy okrug
KOR:Koryakskiy avtonomnyy okrug
NEN:Nenetskiy avtonomnyy okrug
TAY:Taymyrskiy (Dolgano-Nenetskiy
UOB:Ust'-Ordynskiy Buryatskiy
YAN:Yamalo-Nenetskiy avtonomnyy okrug

Country=SAUDI ARABIA
Code=SA

11:Al Batah
08:Al H,udÜd ash Shamallyah
12:Al Jawf
03:Al Madlnah
05:Al Qasim
01:Ar Riyad
04:Ash Sharqlyah
14:Asîr
06:Hã'il
09:Jlzãn
02:Makkah
10:Najran
07:Tabûk

Country=SPAIN
Code=ES

A:Alicante
AB:Albacete
AL:Almería
AN:Andalucía
AR:Aragón
AV:Ávila
B:Barcelona
BA:Badajoz
BI:Vizcaya
BU:Burgos
C:La Coruña
CA:Cádiz
CC:Cáceres
CE:Ceuta
CL:Castilla y León
CM:Castilla-La Mancha
CN:Canarias
CO:Córdoba
CR:Ciudad Real
CS:Castellón
CT:Cataluña
CU:Cuenca
EX:Extremadura
GA:Galicia
GC:Las Palmas
GE:Girona [Gerona]
GR:Granada
GU:Guadalajara
H:Huelva
HU:Huesca
J:Jaén
L:Lleida [Lérida]
LE:León
LO:La Rioja
LU:Lugo
M:Madrid
MA:Málaga
ML:Melilla
MU:Murcia
NA:Navarra
O:Asturias
OR:Orense
P:Palencia
PM:Islas Baleares
PO:Pontevedra
PV:País Vasco
S:Cantabria
SA:Salamanca
SE:Sevilla
SG:Segovia
SO:Soria
SS:Guipúzcoa
T:Tarragona
TE:Teruel
TF:Santa Cruz de Tenerife
TO:Toledo
V:Valencia
VA:Valladolid
VC:Valenciana, Comunidad
VI:Álava
Z:Zaragoza
ZA:Zamora



Country=SOLOMON ISLANDS
Code=SB

CT:Capital Territory (Honiara)
CE:Central
GU:Guadalcanal
IS:Isabel
MK:Makira
ML:Malaita
TE:Temotu
WE:Western

Country=SUDAN
Code=SD

23:A'alî an Nîl
26:Al Bah al Ahmar
18:Al Buhayrat
07:Al Jazirah
03:Al Khartum
06:Al Qadarif
22:Al Wahdah
04:An Nil
08:An Nil al Abyaq
24:An Nil al Azraq
01:Ash Shamallyah
17:Bahr al Jabal
16:Gharb al Istiwa'îyah
14:Gharb Bañr al Ghazal
12:Gharb Darfur
10:Gharb Kurdufan
11:Janub Darfur
13:Janûb Rurdufan
20:Jünqall
05:Kassala
15:Shamal Batr al Ghazal
02:Shamal Darfùr
09:Shamal Kurdufan
19:Sharq al Istiwa'iyah
25:Sinnar
21:Warab

Country=SWEDEN
Code=SE

K:Blekinge län
W:Dalarnas län
I:Gotlands län
X:Gävleborge län
N:Hallands län
Z:Jamtlande län
F:Jonkopings län
H:Kalmar län
G:Kronoberge län
BD:Norrbottena län
M:Skåne län
AB:Stockholms län
D:Södermanlands län
C:Uppsala län
S:Värmlanda län
AC:Västerbottens län
Y:Västernorrlands län
U:Västmanlanda län
Q:Västra Gotalands län
T:Örebro län
E:Östergotlands län

Country=ST. HELENA
Code=SH

SH:Saint Helena
AC:Ascension
TA:Tristan da Cunha

Country=SLOVENIA
Code=SI

07:Dolenjska
09:Gorenjska
11:Goriska
03:Koroéka
10:Notranjsko-kraéka
12:Obalno-krañka
08:Osrednjeslovenska
02:Podravska
01:Pomurska
04:Savinjska
06:Spodnjeposavska
05:Zasavska

Country=SLOVAKIA
Code=SK

BC:Banskobyatricky kraj
BL:Bratislavsky kraj
KI:Kolicky kraj
NJ:Nitrianaky kraj
PV:Prebovaky kraj
TC:Trenciansky kraj
TA:Trnavaky kraj
ZI:Zilinaky kraj

Country=SIERRA LEONE
Code=SL

W:western Area (Freetown)
E:Eastern
N:Northern
S:Southern

Country=SENEGAL
Code=SN

DK:Dakar
DB:Diourbel
FK:Fatick
KL:Kaolack
KD:Kolda
LG:Louga
SL:Saint-Louis
TC:Tambacounda
TH:Thiès
ZG:Ziguinchor

Country=SOMALIA
Code=SO

AW:Awdal
BK:Bakool
BN:Banaadir
BR:Bari
BY:Bay
GA:Galguduud
GE:Gedo
HI:Hiirsan
JD:Jubbada Dhexe
JH:Jubbada Hoose
MU:Mudug
NU:Nugaal
SA:Saneag
SD:Shabeellaha Dhexe
SH:Shabeellaha Hoose
SO:Sool
TO:Togdheer
WO:Woqooyi Galbeed

Country=KOREA, REPUBLIC OF
Code=KR

11:Seoul Teugbyeolsi
26:Busan Gwang'yeogsi
27:Daegu Gwang'yeogsi
30:Daejeon Gwang'yeogsi
29:Gwangju Gwang'yeogsi
28:Incheon Gwang'yeogsi
31:Ulsan Gwang'yeogsi
43:Chungcheongbugdo
44:Chungcheongnamdo
42:Gang'weondo
41:Gyeonggido
47:Gyeongsangbugdo
48:Gyeongsangnamdo
49:Jejudo
45:Jeonrabugdo
46:Jeonranamdo

Country=SURINAME
Code=SR

BR:Brokopondo
CM:Commewijne
CR:Coronie
MA:Marowijne
NI:Nickerie
PR:Para
PM:Paramaribo
SA:Saramacca
SI:Sipaliwini
WA:Wanica

Country=SAO TOME AND PRINCIPE
Code=ST

P:Príncipe
S:Sao Tomé

Country=EL SALVADOR
Code=SV

AH:Ahuachapán
CA:Cabañas
CU:Cuscatlán
CH:Chalatenango
LI:La Libertad
PA:La Paz
UN:La Uniôn
MO:Morazán
SM:San Miguel
SS:San Salvador
SA:Santa Ana
SV:San Vicente
SO:Sonsonate
US:Usulután

Country=SYRIAN ARAB REPUBLIC
Code=SY

HA:Al Hasakah
LA:Al Ladhiqiyah
QU:Al Qunaytirah
RA:Ar Raqqah
SU:As Suwaydä'
DR:Dar'ã
DY:Dayr az Zawr
DI:Dimashq
HL:Halab
HM:Hamah
HI:Jim'
ID:Idlib
RD:Rif Dimashq
TA:Tartüs

Country=SWAZILAND
Code=SZ

HH:Hhohho
LU:Lubombo
MA:Manzini
SH:Shiselweni

Country=TURKMENISTAN
Code=TM

A:Ahal
B:Balkan
D:Da'howuz
L:Lebap
M:Mary

Country=TUNISIA
Code=TN

31:Béja
13:Ben Arous
23:Bizerte
81:Gabès
71:Gafsa
32:Jendouba
41:Kairouan
42:Rasserine
73:Kebili
12:L'Ariana
33:Le Ref
53:Mahdia
82:Medenine
52:Moneatir
21:Naboul
61:Sfax
43:Sidi Bouxid
34:Siliana
51:Sousse
83:Tataouine
72:Tozeur
11:Tunis
22:Zaghouan

Country=TRINIDAD AND TOBAGO
Code=TT

CTT:Couva-Tabaquite-Talparo
DMN:Diego Martin
ETO:Eastern Tobago
PED:Penal-Debe
PRT:Princes Town
RCM:Rio Claro-Mayaro
SGE:Sangre Grande
SJL:San Juan-Laventille
SIP:Siparia
TUP:Tunapuna-Piarco
WTO:Western Tobago
ARI:Arima
CHA:Chaguanas
PTF:Point Fortin
POS:Port of Spain
SFO:San Fernando

Country=TAIWAN, PROVINCE OF CHINA
Code=TW

KHH:Kaohsiung
TPE:Taipei
CYI:Chisyi
HSZ:Hsinchu
KEE:Keelung
TXG:Taichung
TNN:Tainan
CHA:Changhua
CYI:Chiayi
HSZ:Hsinchu
HUA:Hualien
ILA:Ilan
KHH:Kaohsiung
MIA:Miaoli
NAN:Nantou
PEN:Penghu
PIF:Pingtung
TXG:Taichung
TNN:Tainan
TPE:Taipei
TTT:Taitung
TAO:Taoyuan
YUN:Yunlin

Country=TANZANIA, UNITED REPUBLIC OF
Code=TZ

01:Arusha
02:Dar-es-Salaam
03:Dodoma
04:Iringa
05:Kagera
06:Kaskazini Pemba
07:Kaskazini Unguja
08:Xigoma
09:Kilimanjaro
10:Rusini Pemba
11:Kusini Unguja
12:Lindi
13:Mara
14:Mbeya
15:Mjini Magharibi
16:Morogoro
17:Mtwara
18:Mwanza
19:Pwani
20:Rukwa
21:Ruvuma
22:Shinyanga
23:Singida
24:Tabora
25:Tanga

Country=TOGO
Code=TG

C:Centre
K:Kara
M:Maritime (Région)
P:Plateaux
S:Savannes

Country=THAILAND
Code=TH

10:Krung Thep Maha Nakhon Bangkok
S:Phatthaya
37:Amnat Charoen
15:Ang Thong
31:Buri Ram
24:Chachoengsao
18:Chai Nat
36:Chaiyaphum
22:Chanthaburi
50:Chiang Mai
57:Chiang Rai
20:Chon Buri
86:Chumphon
46:Kalasin
62:Kamphasng Phet
71:Kanchanaburi
40:Khon Kaen
81:Krabi
52:Lampang
51:Lamphun
42:Loei
16:Lop Buri
58:Mae Hong Son
44:Maha Sarakham
49:Mukdahan
26:Nakhon Nayok
73:Nakhon Pathom
48:Nakhon Phanom
30:Nakhon Ratchasima
60:Nakhon Sawan
80:Nakhon Si Thammarat
55:Nan
96:Narathiwat
39:Nong Bua Lam Phu
43:Nong Khai
12:Nonthaburi
13:Pathum Thani
94:Pattani
82:Phangnga
93:Phatthalung
56:Phayao
67:Phetchabun
76:Phetchaburi
66:Phichit
65:Phitsanulok
54:Phrae
14:Phra Nakhon Si Ayutthaya
83:Phaket
25:Prachin Buri
77:Prachuap Khiri Khan
85:Ranong
70:Ratchaburi
21:Rayong
45:Roi Et
27:Sa Kaeo
47:Sakon Nakhon
11:Samut Prakan
74:Samut Sakhon
75:Samut Songkhram
19:Saraburi
91:Satun
17:Sing Buri
33:Si Sa Ket
90:Songkhla
64:Sukhothai
72:Suphan Buri
84:Surat Thani
32:Surin
63:Tak
92:Trang
23:Trat
34:Ubon Ratchathani
41:Udon Thani
61:Uthai Thani
53:Uttaradit
95:Yala
35:Yasothon

Country=TAJIKISTAN
Code=TJ

KR:Karategin
KT:Khatlon
LN:Leninabad
GB:Gorno-Badakhshan


Country=TURKEY
Code=TR

01:Adana
02:Ad yaman
03:Afyon
04:Ag r
68:Aksaray
05:Amasya
06:Ankara
07:Antalya
75:Ardahan
08:Artvin
09:Ayd n
10:Bal kesir
74:Bart n
72:Batman
69:Bayburt
11:Bilecik
12:Bingöl
13:Bitlis
14:Bolu
15:Burdur
16:Bursa
17:Çanakkale
18:Çank r
19:Çorum
20:Denizli
21:Diyarbak r
22:Edirne
23:Elaz g
24:Erzincan
25:Erzurum
26:Eskisehir
27:Gaziantep
28:Giresun
29:Gümüshane
30:Hakkâri
31:Hatay
76:Igdr
32:Isparta
33:Içel
34:Istanbul
35:Izmir
46:Kahamanmaras
78:Karabük
70:Karaman
36:Kars
37:Kastamonu
38:Kayseri
71:Krkkale
39:Krklareli
40:Krsehir
79:Kilis
41:Kocaeli
42:Konya
43:Kütahya
44:Malatya
45:Manisa
47:Mardin
48:Mug la
49:Mus
50:Nevsehir
51:Nig de
52:Ordu
80:Osmaniye
53:Rize
54:Sakarya
55:Samsun
56:Siirt
57:Sinop
58:Sivas
63:Sanlurfa
73:Srnak
59:Tekirdag
60:Tokat
61:Trabzon
62:Tunceli
64:Usak
65:Van
77:Yalova
66:Yozgat
67:Zonguldak


Country=UKRAINE
Code=UA

71:Cherkas'ka Oblast'
74:Chernihivs'ka Oblast'
77:Chernivets'ka Oblast'
12:Dnipropetrovs'ka Oblast'
14:Donets'ka Oblast'
26:Ivano-Frankivs'ka Oblast'
63:Kharkivs'ka Oblast'
65:Khersons'ka Oblast'
68:Khmel'nyts'ka Oblast'
35:Kirovohrads'ka Oblast'
32:Kyivs'ka Oblast'
09:Luhans'ka Oblast'
46:L'vivs'ka Oblast'
48:Mykolaivs'ka Oblast'
51:Odes 'ka Oblast'
53:Poltavs'ka Oblast'
56:Rivnens'ka Oblast'
59:Sums 'ka Oblast'
61:Ternopil's'ka Oblast'
05:Vinnyts'ka Oblast'
07:Volyos'ka Oblast'
21:Zakarpats'ka Oblast'
23:Zaporiz'ka Oblast'
18:Zhytomyrs'ka Oblast'
43:Respublika Krym
30:Kyïv
40:Sevastopol'

Country=UGANDA
Code=UG

APA:Apac
ARU:Arua
BUN:Bundibugyo
BUS:Bushenyi
GUL:Gulu
HOI:Hoima
IGA:Iganga
JIN:Jinja
KBL:Kabale
KBR:Kabarole
KLG:Kalangala
KLA:Kampala
KLI:Kamuli
KAP:Kapchorwa
KAS:Kasese
KLE:Kibeale
KIB:Kiboga
KIS:Kisoro
KIT:Kitgum
KOT:Kotido
KUM:Kumi
LIR:Lira
LUW:Luwero
MSK:Masaka
MSI:Masindi
MBL:Mbale
MBR:Mbarara
MOR:Moroto
MOY:Moyo
MPI:Mpigi
MUB:Mubende
MUK:Mukono
NEB:Nebbi
NTU:Ntungamo
PAL:Pallisa
RAK:Rakai
RUK:Rukungiri
SOR:Soroti
TOR:Tororo

Country=UNITED STATES MINOR OUTLYING ISLANDS
Code=UM

81:Baker Island
84:Howland Island
86:Jarvis Island
67:Johnston Atoll
89:Kingman Reef
71:Midway Islands
76:Navassa Island
95:Palmyra Atoll
79:Wake Ialand

Country=URUGUAY
Code=UY

AR:Artigsa
CA:Canelones
CL:Cerro Largo
CO:Colonia
DU:Durazno
FS:Flores
FD:Florida
LA:Lavalleja
MA:Maldonado
MO:Montevideo
PA:Paysandu
RN:Rio Negro
RV:Rivera
RO:Rocha
SA:Salto
SJ:San José
SO:Soriano
TA:Tacuarembo
TT:Treinta y Tres

Country=UZBEKISTAN
Code=UZ

QR:Qoraqalpoghiston Respublikasi Karakalpakstan, Respublika
AN:Andijon
BU:Bukhoro
FA:Farghona
JI:Jizzakh
KH:Khorazm
NG:Namangan
NW:Nawoiy
QA:Qashqadaryo
SA:Samarqand
SI:Sirdaryo
SU:Surkhondaryo
TO:Toshkent

Country=VENEZUELA
Code=VE

A:Diatrito Federal
B:Anzoátegui
C:Apure
D:Aragua
E:Barinas
F:Bolívar
G:Carabobo
H:Cojedes
I:FalcÓn
J:Guârico
K:Lara
L:Mérida
M:Miranda
N:Monagas
O:Nueva Esparta
P:Portuguesa
R:Sucre
S:Tâchira
T:Trujillo
U:Yaracuy
V:Zulia
Z:Amazonas
Y:Delta Amacuro
W:Dependencias Federales

Country=VANUATU
Code=VU

MAP:Malampa
PAM:Pénama
SAM:Sanma
SEE:Shéfa
TAE:Taféa
TOB:Torba

Country=WALLIS AND FUTUNA ISLANDS
Code=WF

AA:A'ana
AL:Aiga-i-le-Tai
AT:Atua
FA:Fa'aaaleleaga
GE:Gaga'emauga
GI:Gagaifomauga
PA:Palauli
SA:Satupa'itea
TU:Tuamasaga
VF:Va'a-o-Fonoti
VS:Vaisigano

Country=YEMEN
Code=YE

AB:Abyan
AD:Adan
BA:Al Bayda'
MU:Al Hudaydah
JA:Al Jawf
MR:Al Mahrah
MW:Al Mahwit
DH:Dhamar
HD:Hadramawt
HJ:Hajjah
IB:Ibb
LA:Lahij
MA:Ma'rib
SD:Sa'dah
SN:San'a'
SH:Shabwah
TA:Ta'izz

Country=SOUTH AFRICA
Code=ZA

EC:Eastern Cape
FS:Free State
GT:Gauteng
NL:Kwazulu-Natal
MP:Mpumalanga
NC:Northern Cape
NP:Northern Province
NW:North-West
WC:Western Cape

Country=SWITZERLAND
Code=CH

AG:Aargau
AI:Appenzell Inner-Rhoden
AR:Appenzell Ausser-Rhoden
BE:Bern
BL:Basel-Landschaft
BS:Basel-Stadt
FR:Fribourg
GE:Genève
GL:Glarus
GR:Graubünden
JU:Jura
LU:Luzern
NE:Neuchatel
NW:Nidwalden
OW:Obwalden
SG:Sankt Gallen
SH:Schaffhausen
SO:Solothurn
SZ:Schwyz
TG:Thurgau
TI:Ticino
UR:Uri
VD:Vaud
VS:Valais
ZG:Zug
ZH:Zürich

Country=UNITED KINGDOM
Code=GB
SubCountryType=County

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
CO FERMANAGH:County Fermanagh
CO DERRY:County Londonderry
CO TYRONE:County Tyrone

Country=UNITED STATES
Code=US
SubCountryType=State

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

Country=VIET NAM
Code=VN

44:An Giang
43:Ba Ria - Vung Tau
53:Bac Can
54:Bac Giang
55:Bac Lieu
56:Bac Ninh
50:Ben Tre
31:Binh Dinh
57:Binh Duong
58:Binh Phuoc
40:Binh Thuan
59:Ca Mau
48:Can Tho
04:Cao Bang
60:Da Nang, thanh pho
33:Dac Lac
39:Dong Nai
45:Dong Thap
30:Gia Lai
03:Ha Giang
63:Ha Nam
64:Ha Noi, thu do
15:Ha Tay
23:Ha Tinh
61:Hai Duong
62:Hai Phong, thanh pho
14:Hoa Binh
65:Ho Chi Minh, thanh po [Sai Gon]
66:Hung Yen
34:Khanh Hoa
47:Kien Giang
28:Kon Tum
01:Lai Chau
35:Lam Dong
09:Lang Son
02:Lao Cai
41:Long An
67:Nam Dinh
22:Nghe An
18:Ninh Binh
36:Ninh Thuan
68:Phu Tho
32:Phu Yen
24:Quang Binh
27:Quang Nam
29:Quang Ngai
13:Quang Ninh
25:Quang Tri
52:Soc Trang
05:Son La
37:Tay Ninh
20:Thai Binh
69:Thai Nguyen
21:Thanh Hoa
26:Thua Thien-Hue
46:Tien Giang
51:Tra Vinh
07:Tuyen Quang
49:Vinh Long
70:Vinh Phuc
06:Yen Bai

Country=YUGOSLAVIA
Code=YU

CG:Crna Gora
SR:Srbija
KM:Kosovo-Metohija
VO:Vojvodina

Country=ZAMBIA
Code=ZM

02:Central
08:Copperbelt
03:Eastern
04:Luapula
09:Lusaka
05:Northern
06:North-Western
07:Southern
01:Western

Country=ZIMBABWE
Code=ZW

BU:Bulawayo
HA:Harare
MA:Manicaland
MC:Mashonaland Central
ME:Mashonaland East
MW:Mashonaland West
MV:Masvingo
MN:Matabeleland North
MS:Matabeleland South
MI:Midlands

