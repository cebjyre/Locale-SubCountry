=head1 NAME

Locale::SubCountry - convert state, province, county etc. names to/from code

=head1 SYNOPSIS

   use Locale::SubCountry;

   $UK_counties = new Locale::SubCountry('GB');
   print($UK_counties->full_name('DUMGAL'));  # Dumfries & Galloway

   $UK_counties = new Locale::SubCountry('AUSTRALIA');

   print($australia->code('New South Wales '),"\n");     # NSW
   print($australia->full_name('S.A.'),"\n");            # South Australia
   $upper_case = 1;
   print($australia->full_name('Qld',$upper_case),"\n"); # QUEENSLAND
   print($australia->country,"\n");                      # AUSTRALIA
   print($australia->country_code,"\n");                 # AU
   print($australia->sub_country_type,"\n");             # State
   print($australia->FIPS10_4_code('ACT'),"\n");         # 01
   print($australia->ISO3166_2_code('02'),"\n");         # NSW
   

   @aus_state_names  = $australia->all_full_names;
   @aus_code_names   = $australia->all_codes;
   %aus_states_keyed_by_code  = $australia->code_full_name_hash;
   %aus_states_keyed_by_name  = $australia->full_name_code_hash;
   
   foreach $code ( sort keys %aus_states_keyed_by_name )
   {
      printf("%-3s : %s\n",$code,$all_australian_states{$code});
   }
   

   # Methods for country codes and names
   
   $world = new Locale::SubCountry::World;
   @all_countries     = $world->all_full_names;
   @all_country_codes = $world->all_codes;

   %all_countries_keyed_by_name = $world->full_name_code_hash;
   %all_country_keyed_by_code   = $world->code_full_name_hash;


=head1 REQUIRES

Perl 5.005 or above


=head1 DESCRIPTION

This module allows you to convert the full name for a countries administrative
region to the code commonly used for postal addressing. The reverse lookup
can also be done.  Sub country codes are defined in "ISO 3166-2:1998,
Codes for the representation of names of countries and their subdivisions".

Sub countries are termed as states in the US and Australia, provinces
in Canada and counties in the UK and Ireland.

Names and ISO 3166-2 codes for all sub countries in a country can be
returned as either a hash or an array.

Names and ISO 3166-1 codes for all countries in the world can be
returned as either a hash or an array.

ISO 3166-2 codes can be converted to FIPS 10 -4 codes. The reverse lookup can 
also be done.

=head1 METHODS

Note that the following methods duplicate some of the functionality of the
Locale::Country module (part of the Locale::Codes bundle). They are provided
here because you may need to first access the list of available countries and
ISO 3166-1 codes, before fetching their sub country data. If you only need
access to country data, then Locale::Country should be used.

Note also the following method names are also used for sub country objects.
(interface polymorphism for the technically minded). TO avoid confusion, make
sure that your chosen method is acting on the correct type of object.

    all_codes
    all_full_names
    code_full_name_hash
    full_name_code_hash


=head2 new Locale::SubCountry::World

The C<new> method creates an instance of a world country object. This must be
called before any of the following methods are invoked. The method takes no
arguments.


=head2 full_name_code_hash (for world objects)

Given a world object, returns a hash of full name/code pairs for every country,
keyed by country name.

=head2 code_full_name_hash  for world objects)

Given a world object, returns a hash of full name/code pairs for every country,
keyed by country code.


=head2 all_full_names (for world objects)

Given a world object, returns an array of all country full names, 
sorted alphabetically.

=head2 all_codes (for world objects)

Given a world object, returns an array of all country IS) 3166-1 codes,
sorted alphabetically.


=head2 new Locale::SubCountry

The C<new> method creates an instance of a sub country object. This must be
called before any of the following methods are invoked. The method takes a
single argument, the name of the country that contains the sub country
that you want to work with. It may be specified either by the ISO 3166-1
two letter code or the full name. These are currently:

    AF - AFGHANISTAN
    AL - ALBANIA
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
    CG - CONGO
    CR - COSTA RICA
    CI - CÔTE D'IVOIRE
    HR - CROATIA
    CU - CUBA
    CY - CYPRUS
    CX - CZECH REPUBLIC
    CO - CONGO, THE DEMOCRATIC REPUBLIC OF THE CONGO
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
    IL - ISRAEL
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
country name is supplied that the module doesn't recognised, it will die.

=head2 country

Returns the current country of a sub country object

=head2 country_code

Given a sub country object, returns the two letter ISO 3166-1 code of the country  


=head2 sub_country_type

Given a sub country object, returns the  sub country type (state, county etc),
or 'unknown' if a value is not defined.


=head2 code

Given a sub country object, the C<code> method takes the full name of a sub 
country and returns the sub country's ISO 3166-2 code. The full name can appear
in mixed case. All white space and non alphabetic characters are ignored, except
the single space used to separate sub country names such as "New South Wales". 
The code is returned as a capitalised string, or "unknown" if no match is found.

=head2 full_name

Given a sub country object, the C<full_name> method takes the ISO 3166-2 code of
a sub country and returns the sub country's full name. The code can appear
in mixed case. All white space and non alphabetic characters are ignored. The
full name is returned as a title cased string, such as "South Australia".

If an optional argument is supplied and set to a true value, the full name is
returned as an upper cased string.


FIPS10_4_code

Given a sub country object, the C<FIPS_10_4_code> method takes the ISO 3166-2 code 
of a sub country and returns the sub country's FIPS 10-4 code. FIPS is a standard 
developed by the US government.

ISO3166_2_code

Given a sub country object, the C<ISO3166_2_code> method takes the FIPS 10-4 code 
of a sub country and returns the sub country's ISO 3166-2 code.


=head2 full_name_code_hash  (for subcountry objects)

Given a sub country object, returns a hash of all full name/code pairs,
keyed by sub country name.

=head2 code_full_name_hash  (for subcountry objects)

Given a sub country object, returns a hash of all code/full name pairs,
keyed by sub country code.


=head2 all_full_names  (for subcountry objects)

Given a sub country object, returns an array of all sub country full names,
sorted alphabetically.

=head2 all_codes  (for subcountry objects)

Given a sub country object, returns an array of all sub country ISO 3166-2 codes,
sorted alphabetically.



=head1 SEE ALSO

ISO 3166-1:1997 Codes for the representation of names of countries and their 
subdivisions - Part 1: Country codes 

ISO 3166-2:1998 Codes for the representation of names of countries and their 
subdivisions - Part 2: Country subdivision code 
Also released as AS/NZS 2632.2:1999

Federal Information Processing Standards Publication 10-4
1995 April Specifications for  COUNTRIES, DEPENDENCIES, AREAS OF SPECIAL SOVEREIGNTY, 
AND THEIR PRINCIPAL ADMINISTRATIVE DIVISIONS 

<http://www.mindspring.com/~gwil/statoids.html>


    Locale::Country
    Lingua::EN::AddressParse
    Geo::IP

=head1 LIMITATIONS

If a sub country's full name contains the word 'and', it is represented by an
ampersand, as in 'Dumfries & Galloway'.

ISO 3166-2:1998 defines all sub country codes as being up to 3 letters and/or
numbers. These codes are commonly accepted for countries like the USA
and Canada. In Australia, Ireland and the UK, this method of abbreviation is
not widely accepted. For example, the ISO code for 'New South Wales' is 'NS',
but 'NSW' is the only abbreviation that is actually used. I could add a
flag to enforce ISO-3166-2 codes if needed.

The ISO 3166-2 standard romanizes the names of provinces and regions in non-latin
script areas, such as Russia and South Korea. One Romanisation is given for each
province name. For Russia, the BGN (1947) Romanization is used.

The ISO 3166-2 standard will typically list more than one type of sub country
for each country. For example, Australia has states and territories, Italy
has provinces and regions. Normally I use all the different types of sub country.
This module will not give you the type of each individual subcountry. It could be
recorded if needed, but would take a lot of effort. Instead, the most common
type of sub country is recorded for each country. So for Australia, this would
be 'State'.

The following sub country names have more than one code, and may not return
the correct code for that sub country. These entries are usually duplicated
because the name represents two different types of sub country, such as a
province and a geographical unit

    AZERBAIJAN : Länkäran; LA (the City), LAN (the Rayon)
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

FIPS codes are not provided for all sub countries. 

=head1 BUGS

None known


=head1 COPYRIGHT


Copyright (c) 2000-2002 Kim Ryan. All rights reserved.
This program is free software; you can redistribute it
and/or modify it under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html).


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimryan@cpan.org>.
<http://www.data-distillers.com>


=head1 CREDITS

Alastair McKinstry provided many of the sub country codes and names.

Terrence Brannon produced Locale::US, which was the starting point for
this module. 

Mark Summerfield and Guy Fraser provided the list of UK counties.

TJ Mather supplied the FIPS codes and many ammendments to the sub country data


=cut

#-------------------------------------------------------------------------------

use strict;
use locale;

use Exporter;
use vars qw (@ISA $VERSION @EXPORT);

$VERSION = '1.21';
@ISA     = qw(Exporter);

#-------------------------------------------------------------------------------

package Locale::SubCountry::World;

# Define all the methods for the 'world' class here. Note that because the 
# name space inherits from the Locale::SubCountry name space, the
# package wide variables $::country_lookup and $::subcountry_lookup are
# accessible.


#-------------------------------------------------------------------------------
# Create new instance of a SubCountry::World object

sub new
{
    my $class = shift;

    my $world = {};
    bless($world,$class);
    return($world);
}

#-------------------------------------------------------------------------------
# Returns a hash of code/name pairs for all countries, keyed by  country code.

sub code_full_name_hash
{
    my $world = shift;
    return(  %{ $::country_lookup{_code_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns a hash of name/code pairs for all countries, keyed by country name.

sub full_name_code_hash
{
    my $world = shift;
    return( %{ $::country_lookup{_full_name_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns sorted array of all country full names

sub all_full_names
{
    my $world = shift;
    return ( sort keys %{ $::country_lookup{_full_name_keyed} });
}
#-------------------------------------------------------------------------------
# Returns sorted array of all two letter country codes

sub all_codes
{
    my $world = shift;
    return ( sort keys %{ $::country_lookup{_code_keyed} });
}

#-------------------------------------------------------------------------------

package Locale::SubCountry;

#-------------------------------------------------------------------------------
# Initialization code must be run first to create global data structure.
# Read in the list of abbreivations and full names defined in the __DATA__ 
# block at the bottom of this file.

{
   my $country;

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
            # Create doubly indexed hash, keyed by  country code and full name.
            # The user can supply either form to create a new sub_country
            # object, and the objects properties will hold both the countries
            # name and it's code.

            my $code = _clean($1);
            $::country_lookup{_code_keyed}{$code} = $country;
            $::country_lookup{_full_name_keyed}{$country} = $code;
         }
         elsif ( /^SubCountryType\s*=(.*)/i )
         {
            $::subcountry_lookup{$country}{_sub_country_type} = _clean($1);
         }
         elsif ( /^\w+(\s\w+)?:/i )
         {
            # Row of sub country data
            my ($code,$FIPS_code,$name);
            my @data = split(/:/,$_);
            if ( @data == 2 )
            {
                ($code,$name) = @data;
            }
            elsif ( @data == 3 )
            {
                ($code,$FIPS_code,$name) = @data;
            }

            $code = _clean($code);
            $name = _clean($name);
            if ( $FIPS_code )
            {
                $FIPS_code = _clean($FIPS_code);
            }


            # Insert into doubly indexed hash, grouped by country for ISO 3166-2 
            # codes. One hash is keyed by abbreviaton and one by full name. Although 
            # data is duplicated, this provides the fastest lookup and simplest
            # code.

            $::subcountry_lookup{$country}{_code_keyed}{$code} = $name;
            $::subcountry_lookup{$country}{_full_name_keyed}{$name} = $code;

            # Insert into doubly indexed hash, grouped by country for 
            # FIPS 10-4 codes

            if ( $FIPS_code )
            {
                $::subcountry_lookup{$country}{_FIPS10_4_code_keyed}{$FIPS_code} = $code;
                $::subcountry_lookup{$country}{_ISO3166_2_code_keyed}{$code} = $FIPS_code;
            }

         }
         else
         {
            die "Invalid  format in sub country data $_";
         }
      }
   }
}


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
        if ( $::country_lookup{_code_keyed}{$country_or_code} )
        {
            $country_code = $country_or_code;
            # set country to it's full name
            $country = $::country_lookup{_code_keyed}{$country_or_code};
        }
        else
        {
          die "Invalid country code: $country_or_code chosen";
        }
    }
    else
    {
        if ( $::country_lookup{_full_name_keyed}{$country_or_code} )
        {
            $country = $country_or_code;
            $country_code = $::country_lookup{_full_name_keyed}{$country_or_code};
        }
        else
        {
            die "Invalid country name: $country_or_code chosen";
        }
    }

    my $sub_country = {};
    bless($sub_country,$class);
    $sub_country->{_country} = $country;
    $sub_country->{_country_code} = $country_code;


    if ( $::subcountry_lookup{$country}{_sub_country_type} )
    {
        $sub_country->{_sub_country_type} = $::subcountry_lookup{$country}{_sub_country_type};
    }
    else
    {
        $sub_country->{_sub_country_type} = 'unknown';
    }

    return($sub_country);
}

#-------------------------------------------------------------------------------
# Returns the current country of the sub country object

sub country
{
    my $sub_country = shift;
    return( $sub_country->{_country} );
}
#-------------------------------------------------------------------------------
# Returns the current country code of the sub country object

sub country_code
{
    my $sub_country = shift;
    return( $sub_country->{_country_code} );
}

#-------------------------------------------------------------------------------
# Returns the current sub country type (state, county etc) of the
# sub country object

sub sub_country_type
{
    my $sub_country = shift;
    return( $sub_country->{_sub_country_type} );
}
#-------------------------------------------------------------------------------
# Given the full name for a sub country, return the ISO 3166-2 code

sub code
{
    my $sub_country = shift;
    my ($full_name) = @_;

    my $orig = $full_name;

    $full_name = _clean($full_name);

    my $code = $::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed}{$full_name};

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
                $code = $::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed}{$current_name};
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
# Given the ISO 3166-2 code for a sub country, return the FIPS 104-4 code.

sub FIPS10_4_code
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);
    $code = uc($code);

    my $FIPS_code = $::subcountry_lookup{$sub_country->{_country}}{_ISO3166_2_code_keyed}{$code};

    if ( $FIPS_code )
    {
        return($FIPS_code);
    }
    else
    {
        return('unknown');
    }
}
#-------------------------------------------------------------------------------
# Given the FIPS 10-4 code for a sub country, return the ISO 3166-2 code.

sub ISO3166_2_code
{
    my $sub_country = shift;
    my ($FIPS_code) = @_;

    $FIPS_code = _clean($FIPS_code);

    my $code = $::subcountry_lookup{$sub_country->{_country}}{_FIPS10_4_code_keyed}{$FIPS_code};

    if ( $code )
    {
        return($code);
    }
    else
    {
        return('unknown');
    }
}


#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the full name.
# Parameters are the code and a flag, which if set to true
# will cause the full name to be uppercased

sub full_name
{
    my $sub_country = shift;
    my ($code,$uc_name) = @_;

    $code = _clean($code);
    $code = uc($code);

    my $full_name = 
        $::subcountry_lookup{$sub_country->{_country}}{_code_keyed}{$code};
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
# Returns a hash of code/full name pairs, keyed by sub country code.

sub code_full_name_hash
{
    my $sub_country = shift;
    return( %{ $::subcountry_lookup{$sub_country->{_country}}{_code_keyed} } );
}
#-------------------------------------------------------------------------------
# Returns a hash of name/code pairs, keyed by sub country name.

sub full_name_code_hash
{
    my $sub_country = shift;
    return( %{ $::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed} } );
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
# Returns sorted array of all sub country ISO 3166-2 codes for the current country

sub all_codes
{
    my $sub_country = shift;
    my %all_codes = $sub_country->code_full_name_hash;
    return( sort keys %all_codes );
}

#-------------------------------------------------------------------------------
sub _clean
{
    my ($input_string) = @_;

    if ( $input_string =~ /[\. ]/ )
    {
        # remove dots
        $input_string =~ s/\.//go;

        # remove repeating spaces
        $input_string =~ s/  +/ /go;

        # remove any remaining leading or trailing space
        $input_string =~ s/^ //;
        $input_string =~ s/ $//;
    }

    return($input_string);
}

return(1);

#-------------------------------------------------------------------------------
=pod

Code/Sub country data. Comments (lines starting with #) and
blank lines are ignored. Read in at start up by first un-named block.
Format is:

Country=<COUNTRY NAME>
SubCountryType=<Sub Country Type>  # optional field, specify state, county etc
Code=<COUNTRY CODE> # from ISO 3166-1 format
ISO3166-2 Code:FIPS10-4 Code:Full Name
ISO3166-2 Code:FIPS10-4 Code:Full Name
ISO3166-2 Code:FIPS10-4 Code:Full Name

...

Country=<COUNTRY NAME>
...

=cut


__DATA__

Country=UNITED ARAB EMIRATES
SubCountryType=Emirate
Code=AE

AZ:01:Abu Zaby
AJ:02:'Ajman
FU:04:Al Fujayrah
SH:06:Ash Shariqah
DU:03:Dubayy
RK::R'as al Khaymah
UQ:07:Umm al Qaywayn

Country=AFGHANISTAN
SubCountryType=Province
Code=AF

BDS:01:Badakhshan
BDG:02:Badghis
BGL:03:Baghlan
BAL:30:Balkh
BAM:05:Bamian
FRA:06:Farah
FYB:07:Faryab
GHA:08:Ghazni
GHO:09:Ghowr
HEL:10:Helmand
HER:11:Herat
JOW:31:Jowzjan
KAB::Kabul
KAN:23:Kandahar
KAP:14:Kapisa
KNR:15:Konar
KDZ:24:Kondoz
LAG:16:Laghman
LOW:17:Lowgar
NAN:18:Nangrahar
NIM:19:Nimruz
ORU:20:Oruzgan
PIA:21:Paktia
PKA:29:Paktika
PAR:22:Parwan
SAM:32:Samangan
SAR:33:Sar-e Pol
TAK:26:Takhar
WAR:27:Wardak
ZAB:28:Zabol


Country=ALBANIA
SubCountryType=District
Code=AL
BR:01:Berat
BU:29:Bulqizë
DL:30:Delvinë
DV:31:Devoll
DI:02:Dibër
DI:03:Durrës
EL:04:Elbasan
FR:05:Fier
GR:07:Gramsh
GJ:06:Gjirokastër
HA:32:Has
KA:33:Kavajë
ER:08:Kolonjë
KO:09:Korçë
KR:10:Krujë
KC:34:Kuçovë
KU:11:Kukës
LA::Laç
LE:12:Lezhë
LB:13:Librazhd
LU:14:Lushnjë
MM::Malësia e Madhe
MK:37:Mallakastër
MT:15:Mat
MR:16:Mirditë
PQ:38:Peqin
PR:17:Përmet
PG:18:Pogradec
PU:19:Pukë
SR:20:Sarandë
SK:22:Skrapar
SH:21:Shkodër
TE:23:Tepelenë
TR:39:Tiranë
TP:26:Tropojë
VL:27:Vlorë


Country=ARMENIA
SubCountryType=Region
Code=AM

ER:11:Erevan
AG::Aragacotn
AR:02:Ararat
AV:03:Armavir
GR:04:Gegark'unik'
KT:05:Kotayk'
LO::Lory
SH::Sirak
SU:08:Syunik'
TV::Tavus
VD::Vayoc Jor

Country=ANGOLA
SubCountryType=Province
Code=AO

BGO:19:Bengo
BGU:01:Benguela
BIE:02:Bié
CAB:03:Cabinda
CCU:04:Cuando-Cubango
CNO:05:Cuanza Norte
CUS:06:Cuanza Sul
CNN:07:Cunene
HUA:08:Huambo
HUI:09:Huíla
LUA:10:Luanda
LNO:17:Lunda Norte
LSU:18:Lunda Sul
MAL:12:Malange
MOX:14:Moxico
NAM:13:Namibe
UIG:15:Uíge
ZAI:16:Zaïre

Country=ARGENTINA
SubCountryType=Province
Code=AR

C::Capital federal
B:01:Buenos Aires
K:02:Catamarca
X:05:Córdoba
W:06:Corrientes
H:03:Chaco
U:04:Chubut
E:08:Entre Ríos
P:09:Formosa
Y:10:Jujuy
L:11:La Pampa
M:13:Mendoza
N:14:Misiones
Q:15:Neuquén
R:16:Río Negro
A:17:Salta
J:18:San Juan
D:19:San Luis
Z:20:Santa Cruz
S:21:Santa Fe
G:22:Santiago del Estero
V:23:Tierra del Fuego
T:24:Tucumán

Country=AUSTRALIA
SubCountryType=State
Code=AU

NSW:02:New South Wales
QLD:04:Queensland
SA:05:South Australia
TAS:06:Tasmania
VIC:07:Victoria
WA:08:Western Australia

ACT:01:Australian Capital Territory
NT:03:Northern Territory

Country=AUSTRIA
SubCountryType=Länder
Code=AT

1:01:Burgenland
2:02:Kärnten
3:03:Niederösterreich
4:04:Oberösterreich
5:05:Salzburg
6:06:Steiermark
7:07:Tirol
8:08:Vorarlberg
9:09:Wien

Country=AZERBAIJAN
SubCountryType=Rayon
Code=AZ

# Cities
MM:35:Naxçivan
AB:07:Äli Bayramli
BA:09:Bäki
GA:20:Gäncä
LA:30:Länkäran
MI:33:Mingäçevir
NA:34:Naftalan
SA:48:Säki
SM:54:Sumqayit
SS:56:Susa
XA:61:Xankandi
YE:68:Yevlax

# Rayons
ABS:01:Abseron
AGC:02:Agcabädi
AGM:03:Agdam
AGS:04:Agdas
AGA:05:Agstafa
AGU:06:Agsu
AST:08:Astara
BAB::Babäk
BAL:10:Balakän
BAR:11:Bärdä
BEY:12:Beylägan
BIL:13:Biläsuvar
CAB:14:Cäbrayll
CAL:15:Cälilabad
CUL::Culfa
DAS:16:Daskäsän
DAV:17:Däväçi
FUZ:18:Fuzuli
GAD:19:Gädäbäy
GOR:21:Goranboy
GOY:22:Göyçay
HAC:23:Haciqabul
IMI:24:Imisli
ISM:25:Ismayilli
KAL:26:Kälbäcär
KUR:27:Kurdämir
LAC:28:Laçin
LAN:30:Länkäran
LER:31:Lerik
MAS:32:Masalli
NEF:36:Neftcala
OGU:37:Oguz
ORD::Ordubad
QAB:38:Qäbälä
QAX:39:Qax
QAZ:40:Qazax
QOB:41:Qobustan
QBA:42:Quba
QBI:43:Qubadli
QUS:44:Qusar
SAT:45:Saatli
SAB:46:Sabirabad
SAD::Sadarak
SAH::Sahbuz
SAK:48:Säki
SAL:49:Salyan
SMI:50:Samaxi
SKR:51:Sämkir
SMX:52:Samux
SAR::Särur
SIY:53:Siyäzän
SUS:56:Susa
TAR:57:Tartar
TOV:58:Tovuz
UCA:59:Ucar
XAC:60:Xaçmaz
XAN:62:Xanlar
XIZ:63:Xizi
XCI:64:Xocali
XVD:65:Xocavand
YAR:66:Yardimli
YEV:68:Yevlax
ZAN:69:Zängilan
ZAQ:70:Zaqatala
ZAR:71:Zärdab

Country=BOSNIA AND HERZEGOVINA
SubCountryType=Entity
Code=BA

BIH::Federacija Bosna i Hercegovina
SRP:SS:Republika Srpska

Country=BANGLADESH
SubCountryType=District
Code=BD

05::Bagerhat zila
01::Bandarban zila
02::Barguna zila
06::Barisal zila
07::Bhola zila
03::Bogra zila
04::Brahmanbaria zila
09::Chandpur zila
10::Chittagong zila
12::Chuadanga zila
08::Comilla zila
11::Cox's Bazar zila
13:81:Dhaka zila
14::Dinajpur zila
15::Faridpur zila
16::Feni zila
19::Gaibandha zila
18::Gazipur zila
17::Gopalganj zila
20::Habiganj zila
24::Jaipurhat zila
21::Jamalpur zila
22::Jessore zila
25::Jhalakati zila
23::Jhenaidah zila
29::Khagrachari zila
27::Khulna zila
26::Kishorganj zila
28::Kurigram zila
30::Kushtia zila
31::Lakshmipur zila
32::Lalmonirhat zila
36::Madaripur zila
37::Magura zila
33::Manikganj zila
39::Meherpur zila
38::Moulvibazar zila
35::Munshiganj zila
34::Mymensingh zila
48::Naogaon zila
43::Narail zila
40::Narayanganj zila
42::Narsingdi zila
44::Natore zila
45::Nawabganj zila
41::Netrakona zila
46::Nilphamari zila
47::Noakhali zila
49::Pabna zila
52::Panchagarh zila
51::Patuakhali zila
50::Pirojpur zila
53::Rajbari zila
54::Rajshahi zila
56::Rangamati zila
55::Rangpur zila
58::Satkhira zila
62::Shariatpur zila
57::Sherpur zila
59::SirajOanj zila
61::SunamOanj zila
60::Sylhet zila
63::Tangail zila
64::Thakurgaon zila

Country=BELGIUM
SubCountryType=Province
Code=BE

VAN:01:Antwerpen
WBR:10:Brabant Wallon
WHT:03:Hainaut
WLG:04:Liège
VLI:05:Limburg
WLX:06:Luxembourg
WNA:07:Namur
VOV:08:Oost-Vlaanderen
VBR:12:Vlaams Brabant
VWV:09:West-Vlaanderen

Country=BELARUS
SubCountryType=Oblast
Code=BY

BR::Bresckaja voblasts'
HO:02:Homyel'skaya voblasts'
HR::Hrodzenskaya voblasts'
MA:06:Mahilyowskaya voblasts'
MI:05:Minskaya voblasts'
VI::Vitsyebskaja voblasts'


Country=BURKINA FASO
SubCountryType=Province
Code=BF

BAL::Balé
BAM:15:Bam
BAN::Banwa
BAZ:16:Bazega
BGR:17:Bougouriba
BLG:18:Boulgou
BLK:19:Boulkiemdé
COM::Comoé
GAN:20:Ganzourgou
GNA:21:Gnagna
GOU:22:Gourma
HOU::Houet
IOB::Ioba
KAD:24:Kadiogo
KEN:25:Kénédougou
KMD::Komondjari
KMP::Kompienga
KOS:27:Kossi
KOP::Koulpélogo
KOT:28:Kouritenga
KOW::Kourwéogo
LER::Léraba
LOR::Loroum
MOU:29:Mouhoun
NAO:31:Nahouri
NAM:30:Namentenga
NAY::Nayala
NOU::Noumbiel
OUB:32:Oubritenga
OUD:33:Oudalan
PAS:34:Passoré
PON:35:Poni
SNG:36:Sanguié
SMT:37:Sanmatenga
SEN:38:Séno
SIS:39:Siasili
SOM:40:Soum
SOR:41:Sourou
TAP:42:Tapoa
TUI::Tui
YAG::Yagha
YAT:43:Yatenga
ZIR::Ziro
ZON::Zondoma
ZOU:44:Zoundwéogo

Country=BULGARIA
SubCountryType=Region
Code=BG

02:39:Burgas
09:43:Haskovo
04::Lovec
05:47:Montana
06:51:Plovdiv
07::Ruse
08:58:Sofija
01:42:Sofija-Grad
03:61:Varna

Country=BAHRAIN
SubCountryType=Region
Code=BH

01:01:Al Hadd
03:02:Al Manamah
10:08:Al Mintaqah al Gharbiyah
07:11:Al Mintagah al Wustá
05:10:Al Mintaqah ash Shamaliyah
02:03:Al Muharraq
09::Ar Rifa
04:05:Jidd Hafs
12::Madluat Jamad
08::Madluat Isã
11:09:Mintaqat Juzur tawar
06:06:Sitrah

Country=BENIN
SubCountryType=Department
Code=BJ

AK:01:Atakora
AQ:02:Atlantique
BO:03:Borgou
MO:04:Mono
OU:05:Ouémé
ZO:06:Zou

Country=BRUNEI DARUSSALAM
SubCountryType=District
Code=BN

BE:01:Belait
BM::Brunei-Muara
TE:03:Temburong
TU:04:Tutong

Country=BOLIVIA
SubCountryType=Department
Code=BO

C:02:Cochabamba
H:01:Chuquisaca
B:03:El Beni
L:04:La Paz
O:05:Oruro
N:06:Pando
P:07:Potosí
S:08:Santa Cruz
T:09:Tarija

Country=BAHAMAS
SubCountryType=District
Code=BS

AC:24:Acklins and Crooked Islands
BI:05:Bimini
CI:06:Cat Island
EX:10:Exuma
FP:25:Freeport
FC:26:Fresh Creek
GH:27:Governor's Harbour
GT:28:Green Turtle Cay
HI:22:Harbour Island
HR:29:High Rock
IN:13:Inagua
KB:30:Kemps Bay
LI:15:Long Island
MH:31:Marsh Harbour
MG:16:Mayaguana
NP:23:New Providence
NB::Nicholls Town and Berry Islands
RI:18:Ragged Island
RS:33:Rock Sound
SP:34:Sandy Point
SR:35:San Salvador and Rum Cay

Country=BHUTAN
SubCountryType=District
Code=BT

33:05:Bumthang
12:06:Chhukha
22:08:Dagana
GA::Gasa
13:10:Ha
44:11:Lhuentse
42:12:Monggar
11:13:Paro
43:14:Pemagatshel
23:15:Punakha
45::Samdrup Jongkha
14:16:Samtee
31::Sarpang
15:20:Thimphu
41::Trashigang
TY::Trashi Yangtse
32:21:Trongsa
21::Tsirang
24::Wangdue Phodrang
34::Zhemgang

Country=BOTSWANA
SubCountryType=District
Code=BW

CE::Central (Serowe-Palapye)
CH:02:Chobe
GH:03:Ghanzi
KG:04:Kgalagadi
KL:05:Kgatleng
KW:06:Kweneng
NG:07:Ngamiland
NE::North-East (North-West)
SE:09:South-East
SO::Southern (Ngwaketse)

Country=BELIZE
SubCountryType=District
Code=BZ

BZ:01:Belize
CY:02:Cayo
CZL:03:Corozal
OW:04:Orange Walk
SC:05:Stann Creek
TOL:06:Toledo

Country=BRAZIL
SubCountryType=State
Code=BR

AC:01:Acre
AL:02:Alagoas
AM:04:Amazonas
AP:03:Amapá
BA::Baia
CE:06:Ceará
DF:07:Distrito Federal
ES:08:Espirito Santo
FN:09:Fernando de Noronha
GO:10:Goiás
MA:13:Maranhao
MG:15:Minas Gerais
MS:11:Mato Grosso do Sul
MT:14:Mato Grosso
PA::Pará
PB:17:Paraíba
PE:19:Pernambuco
PI:20:Piauí
PR:18:Paraná
RJ:21:Rio de Janeiro
RN:22:Rio Grande do Norte
RO:24:Rondonia
RR:25:Roraima
RS:23:Rio Grande do Sul
SC:26:Santa Catarina
SE:28:Sergipe
SP:27:Sao Paulo
TO:31:Tocatins

Country=CANADA
SubCountryType=Province
Code=CA

AB:01:Alberta
BC:02:British Columbia
MB:03:Manitoba
NB:04:New Brunswick
NF:05:Newfoundland
NS:07:Nova Scotia
NU:14:Nunavut
ON:08:Ontario
PE:09:Prince Edward Island
QC:10:Quebec
SK:11:Saskatchewan

NT:13:Northwest Territories
YT:12:Yukon Territory

Country=CONGO, THE DEMOCRATIC REPUBLIC OF THE CONGO
SubCountryType=Region
Code=CO

KN::Kinshasa

BN::Bandundu
BC::Bas-Congo
EQ::Équateur
HC::Haut-Congo
KW::Kasai-Occidental
KE::Kasai-Oriental
KA::Katanga
MA::Maniema
NK::Nord-Kivu
SK::Sud-Kivu

Country=COMOROS
SubCountryType=Governorate
Code=KM

A::Anjouan Ndzouani
G::Grande Comore Ngazidja
M::Mohéli Moili

Country=CENTRAL AFRICAN REPUBLIC
SubCountryType=Prefecture
Code=CF

BGF:18:Bangui
BB:01:Bamingui-Bangoran
BK:02:Baase-Kotto
HK:03:Haute-Kotto
HM:05:Haut-Mbomou
KG::Kémo
LB:07:Lobaye
HS::Mambéré-Kadéï
MB:08:Mbomou
KB::Nana-Grébizi
NM:09:Nana-Mambéré
MP:17:Ombella-Mpoko
UK:11:Ouaka
AC:12:Ouham
OP:13:Ouham-Pendé
SE::Sangha-Mbaéré
VR:14:Vakaga

Country=CONGO
SubCountryType=Region
Code=CG

BZV:12:Brazzaville
11:01:Bouenza
8:03:Cuvette
15::Cuvette-Ouest
5:04:Kouilou
2:05:Lékoumou
7:06:Likouala
9:07:Niari
14:08:Plateaux
12:11:Pool
13:10:Sangha

Country=CHAD
SubCountryType=Prefecture
Code=TD

BA:01:Batha
BI:02:Biltine
BET:03:Borkou-Ennedi-Tibesti
CB:04:Chari-Baguirmi
GR:05:Guéra
KA:06:Kanem
LC:07:Lac
LO:08:Logone-Occidental
LR:09:Logone-Oriental
MK:10:Mayo-Kébbi
MC:11:Moyen-Chari
OD:12:Ouaddaï
SA:13:Salamat
TA:14:Tandjilé

Country=CHILE
SubCountryType=Region
Code=CL

AI:02:Aisén del General Carlos Ibáñez del Campo
AN:03:Antofagasta
AR:04:Araucanía
AT:05:Atacama
BI:06:Bío-Bío
CO:07:Coquimbo
LI:08:Libertador General Bernardo O'Higgins
LL:09:Los Lagos
MA::Magallanes
ML:11:Maule
RM::Region Metropolitana de Santiago
TA:13:Tarapacá
VS:01:Valparaíso

Country=CAMEROON
SubCountryType=Region
Code=CM

AD:10:Adamaoua
CE:11:Centre
ES::East
EN::Far North
LT:05:Littoral
NO::North
NW:04:North-West
SW::South
SW::South-Weat
OU::West

Country=CHINA
SubCountryType=Province
Code=CN

# Municipalities
11:22:Beijing
50:33:Chongqing
31:23:Shanghai
12:28:Tianjin

# Provincies
34:01:Anhui
35:07:Fujian
62:15:Gansu
44:30:Guangdong
52:18:Gulzhou
46:31:Hainan
13:10:Hebei
23:08:Heilongjiang
41:09:Henan
42:12:Hubei
43:11:Hunan
32:04:Jiangsu
36:03:Jiangxi
22:05:Jilin
21:19:Liaoning
63:06:Qinghai
61:26:Shaanxi
37:25:Shandong
14:24:Shanxi
51:32:Sichuan
71::Taiwan
53:29:Yunnan
33:02:Zhejiang

# Autonomous regions:
45:16:Guangxi
15:20:Nei Monggol
64:21:Ningxia
65:13:Xinjiang
54:14:Xizang
91::Hong Kong

Country=COLOMBIA
SubCountryType=Department
Code=CO

DC::Distrito Capltal de Santa Fe de Bogotá
AMA:01:Amazonea
ANT:02:Antioquia
ARA:03:Arauca
ATL:04:Atlántico
BOL:35:Bolívar
BOY:36:Boyacá
CAL:37:Caldea
CAQ:08:Caquetá
CAS:32:Casanare
CAU:09:Cauca
CES:10:Cesar
COR:12:Córdoba
CUN:33:Cundinamarca
CHO:11:Chocó
GUA:15:Guainía
GUV:14:Guaviare
HUI:16:Huila
LAG:17:La Guajira
MAG:38:Magdalena
MET:19:Meta
NAR:20:Nariño
NSA:21:Norte de Santander
PUT:22:Putumayo
QUI:23:Quindío
RIS:24:Risaralda
SAP::San Andrés, Providencia y Santa Catalina
SAN:26:Santander
SUC:27:Sucre
TOL:28:Tolima
VAC:29:Valle del Cauca
VAU:30:Vaupés
VID:31:Vichada

Country=COSTA RICA
SubCountryType=Province
Code=CR

A:01:Alajuela
C:02:Cartago
G:03:Guanacaste
H:04:Heredia
L:06:Limón
P:07:Puntarenas
SJ:08:San José

Country=CROATIA
SubCountryType=County
Code=HR

07::Bjelovarsko-bilogorska zupanija
12::Brodsko-posavska zupanija
19::Dubrovacko-neretvanska zupanija
18::Istarska zupanija
04::Karlovacka zupanija
06::Koprivoickco-krizeva6ka zupanija
02::Krapinako-zagorska zupanija
09::Licko-senjska zupanija
20::Medjimuraka zupanija
14::Osjecko-baranjska zupanija
11::Pozesko-slavonska zupanija
08::Primorsko-goranska zupanija
03::Sisasko-moelavacka Iupanija
17::Splitako-dalmatinska zupanija
15::Sibenako-kninska zupanija
05::Varaidinska zupanija
10::VirovitiEko-podravska zupanija
16::VuRovarako-srijemska zupanija
13:19:Zadaraka
01::Zagrebacka zupanija

Country=CUBA
SubCountryType=Province
Code=CU

09:05:Camagüey
08:07:Ciego de Ávila
06:08:Cienfuegos
03:02:Ciudad de La Habana
12:09:Granma
14:10:Guantánamo
11:12:Holquin
02:11:La Habana
10:13:Las Tunas
04:03:Matanzas
01:01:Pinar del Río
07:14:Sancti Spiritus
13:15:Santiago de Cuba
05:16:Villa Clara
99:04:Isla de la Juventud

Country=CAPE VERDE
SubCountryType=Municipality
Code=CV

BV:01:Boa Vista
BR:02:Brava
FO:03:Fogo
MA:04:Maio
PA:05:Paul
PN::Porto Novo
PR:06:Praia
RG:07:Ribeira Grande
SL:08:Sal
CA:09:Santa Catarina
CR::Santa Cruz
SN:10:Sao Nicolau
SV:11:Sao Vicente
TA:12:Tarrafal

Country=CYPRUS
SubCountryType=District
Code=CY

04::Ammochostos Magusa
06:02:Keryneia
03:03:Larnaka
01::Lefkosia
02:05:Lemesos
05::Pafos

Country=CZECH REPUBLIC
SubCountryType=Region
Code=CX

PRG::Praha
CJC::Jihocesky kraj
CJM::Jihomoravsky kraj
CSC::Severoceaky kraj
CSM::Soveromoravsky kraj
CST::Stredocesky kraj
CVC::Vychodocesky kraj
CZC::Západocesky kraj

Country=DENMARK
SubCountryType=County
Code=DK

015:06:Københavns
020:03:Frederiksborg
025:10:Roskilde
030:14:Vestsjællands
035:12:Storstrøms
040:02:Bornholms
042::Fyns
050:11:Sønderjyllands
055:08:Ribe
060:13:Vejle
065:09:Ringkøbing
070:01:Århus
076:15:Viborg
080:07:Nordjyllands

Country=DJIBOUTI
SubCountryType=District
Code=DJ

AS:01:Ali Sabiah
DI:02:Dikhil
DJ:03:Djibouti
OB:04:Obock
TA:05:Tadjoura

Country=DOMINICAN REPUBLIC
SubCountryType=District
Code=DO

01::Distrito Nacional (Santo Domingo)
02:01:Azua
03:02:Bahoruco
04:03:Barahona
05:04:Dajabón
06:06:Duarte
08::El Seybo [El Seibo]
09:08:Espaillat
30:29:Hato Mayor
10:09:Independencia
11:10:La Altagracia
07::La Estrelleta [Elías Piña]
12:12:La Romana
13:30:La Vega
14:14:María Trinidad Sánchez
28:31:Monseñor Nouel
15:15:Monte Cristi
29:32:Monte Plata
16:16:Pedernales
17:17:Peravia
18:18:Puerto Plata
19:19:Salcedo
20:20:Samaná
21:33:San Cristóbal
22:23:San Juan
23:24:San Pedro de Macorís
24:21:Sánchez Ramírez
25:25:Santiago
26:26:Santiago Rodríguez
27:27:Valverde

Country=ALGERIA
SubCountryType=Province
Code=DZ

01:34:Adrar
44:35:Ain Defla
46:36:Aïn T6mouchent
16:01:Alger
23:37:Annaba
05:03:Batna
08:38:Béchar
06:18:Béjaïa
07:19:Biskra
09:20:Blida
34:39:Bordj Bou Arréridj
10:21:Bouira
35:40:Boumerdès
02:41:Chlef
25:04:Constantine
17:22:Djelfa
32:42:El Bayadh
39:43:El Oued
36:44:El Tarf
47:45:Ghardaïa
24:23:Guelma
33:46:Illizi
18:24:Jijel
40:47:Khenchela
03:25:Laghouat
29:26:Mascara
26:06:Médéa
43:48:Mila
27:07:Mostaganem
28:27:Msila
45:49:Naama
31:09:Oran
30:50:Ouargla
04:29:Oum el Bouaghi
48:51:Relizane
20:10:Saïda
19:12:Sétif
22:30:Sidi Bel Abbès
21:31:Skikda
41:52:Souk Ahras
11:53:Tamanghasset
12:33:Tébessa
14:13:Tiaret
37:54:Tindouf
42:55:Tipaza
38:56:Tissemsilt
15:14:Tizi Ouzou
13:15:Tlemcen

Country=ECUADOR
SubCountryType=Province
Code=EC

A:02:Azuay
B:03:Bolívar
F:04:Cañar
C:05:Carchi
X:07:Cotopaxi
H:06:Chimborazo
O:08:El Oro
E:09:Esmeraldas
W:01:Galápagos
G:10:Guayas
I:11:Imbabura
L:12:Loja
R:13:Los Rios
M:14:Manabi
S:15:Morona-Santiago
N:23:Napo
Y:17:Pastaza
P:18:Pichincha
U:22:Sucumbíos
T:19:Tungurahua
Z:20:Zamora-Chinchipe

Country=EGYPT
SubCountryType=Governorate
Code=EG

DK:01:Ad Daqahllyah
BA:02:Al Bahr al Ahmar
BH:03:Al Buhayrah
FYM:04:Al FayyÜm
GH:05:Al Gharbîyah
ALX::Al Iskandarlyah
IS::Al Isma îllyah
GZ:08:Al Jîzah
MNF:09:Al Minuflyah
MN:10:Al Minya
C:11:Al Qahirah
KB::Al Qalyûblyah
WAD:13:Al Wadi al Jadîd
SHR:14:Ash Sharqiyah
SUZ:15:As Suways
ASN:16:Aswan
AST:17:Asyut
BNS:18:Bani Suwayf
PTS:19:Bûr Sa'îd
DT:20:Dumyàt
JS:26:Janûb Sîna'
KFS:21:Kafr ash Shaykh
MT:22:Matrûh
KN:23:Qinå
SIN:27:Shamâl Sinã'
SHG:24:Suhâj

Country=ERITREA
SubCountryType=Province
Code=ER

AN::Anseba
DU::Debub
DK::Debubawi Keyih Bahri [Debub-Keih-Bahri]
GB::Gash-Barka
MA::Maakel [Maekel]
SK::Semenawi Keyih Bahri [Semien-Keih-Bahri]

Country=ESTONIA
SubCountryType=County
Code=EE

37:01:Harjumsa
39:02:Hitumea
44::Ida-Virumsa
49:05:Jögevamsa
51:04:Järvamsa
57::Läsnemsa
59:08:Lääne-Virumaa
65:12:Polvamea
67:11:Pärnumsa
70:13:Raplamsa
74:14:Saaremsa
7B:18:Tartumsa
82:19:Valgamaa
84:20:Viljandimsa
86:21:Vôrumaa

Country=ETHIOPIA
SubCountryType=State
Code=ET

AA::Addis Ababa
AF::Afar
AM::Amara [Amhara]
BE::Benshangul-Gumaz
GA:38:Gambela Peoples
HA::Harari People
OR::Oromia
SO::Somali
SN::Southern Nations, Nationalitioa and Peoples
TI:37:Tigrai

Country=FIJI
SubCountryType=Division
Code=FJ

C:01:Central
E:02:Eastern
N:03:Northern
W:05:Western
R:04:Rotuma

Country=MICRONESIA (FEDERATED STATES OF)
SubCountryType=State
Code=FM

TRK:03:Chuuk
KSA:01:Kosrae
PNI:02:Pohnpei
YAP:04:Yap

Country=FRANCE
SubCountryType=Department
Code=FR

01::Ain
02::Aisne
03::Allier
04::Alpes-de-Haute-Provence
06::Alpes-Maritimes
07::Ardèche
08::Ardennes
09::Ariege
10::Aube
11::Aude
12:98:Aveyron
67::Bas-Rhin
90::Belfort, Territoire de
13::Bouches-du-Rhone
14::Calvados
15::Cantal
16::Charente
17::Charente-Maritime
18::Cher
19::Correze
2A::Corse-du-Sud
2B::Haute Corse
21::Cote-d'Or
22::Cotes-d'Armour
23::Creuse
79::Deux-Sevres
24::Dordogne
25::Doubs
26::Drome
91::Essonne
27::Eure
28::Eure-et-Loir
29::Finistere
30::Gard
32::Gers
33::Gironde
68::Haut-Rhin
20::Haute-Corse
31::Haute-Garonne
43::Haute-Loire
70::Haute-Saone
74::Haute-Savoie
87::Haute-Vienne
05::Hautes-Alpes
65::Hautes-Pyrenees
92::Hauts-de-Seine
34::Herault
35::Indre
36::Ille-et-Vilaine
37::Indre-et-Loire
38::Isere
39::Jura
40::Landes
41::Loir-et-Cher
42::Loire
44::Loire-Atlantique
45:B2:Loiret
46::Lot
47::Lot-et-Garonne
48::Lozere
49::Maine-et-Loire
50::Manche
51::Marne
54::Meurthe-et-Moselle
55::Meuse
56::Morbihan
57::Moselle
58::Nievre
59::Nord
60::Oise
61::Orne
75::Paris
62::Pas-de-Calais
63::Puy-de-Dome
64::Pyrenees-Atlantiques
66::Pyrenees-Orientales
69::Rhône
71::Saone-et-Loire
72::Sarthe
73::Savoie
77::Seine-et-Marne
76::Seine-Maritime
93::Seine-Saint-Denis
80::Somme
81::Tarn
82::Tarn-et-Garonne
95::Val d'Oise
94::Val-de-Marne
83::Var
84::Vaucluse
85::Vendee
86::Vienne
88::Vosges
89::Yonne
78::Yvelines

Country=GAMBIA
SubCountryType=Division
Code=GM

B:01:Banjul
L:02:Lower River
M:03:MacCarthy Island
N:07:North Bank
U:04:Upper River
W:05:Western

Country=GABON
SubCountryType=Province
Code=GA

1:01:Estuaire
2:02:Haut-Ogooué
3:03:Moyen-Ogooué
4:04:Ngounié
5:05:Nyanga
6:06:Ogooué-Ivindo
7:07:Ogooué-Lolo
8:08:Ogooué-Maritime
9:09:Woleu-Ntem

Country=GEORGIA
SubCountryType=Rayon
Code=GE

AB::Ap'khazet'is Avtonomiuri Respublika
AJ::Acharis Avtonomiuri Respublika
BUS::Bat 'umi
CHI:14:Chiat'ura
GAG::Gagra
GOP:21:Gori
KUT:31:K'ut'aisi
PTI:42:P'ot'i
PUS:45:Rust'avi
SUI::Sokhumi
TBS:51:T'bilisi
TQI:56:Tqibuli
TQV::Tqvarch'eli
TSQ:60:Tsqalmbo
ZUG:63:Zuqdidi
01:01:Abashin Raioni
02:03:Adigenis Raioni
03::Akhalgoria Raioni
04:06:Akhalk'alak'is Raioni
05:07:Akhalts'ikhis Raioni
06:08:Akhmetis Raioni
07:09:Ambrolauris Raioni
08:10:Aspindzis Raioni
09:11:Baghdat' is Raioni
10:12:Bolniais Raioni
11:13:Borjamie Raioni
12:15:Ch'khorotsqus Raioni
13:16:Ch'okhatauris Raioni
14:17:Dedop'listsqaros Raioni
15:18:Dmaniais Raioni
16:19:Dushet' is Raioni
17::Galis Raioni
18:20:Gardabnis Raioni
19:22:Goris Raioni
20::Gudaut' is Raioni
21::Gulrip'shis Raioni
22:23:Gurjeanis Raioni
23:24:Javis Raioni
24:25:K'arelis Raioni
25:26:Kaspis Raioni
26::K'edis Raioni
27:27:Kharagaulis Raioni
28:28:Khashuris Raioni
29::Khelvach'auri6 Raioni
30:29:Khobis Raioni
31:30:Xhonis Raioni
32::Khulos Raioni
33::K'obuletis Raioni
34:32:Lagodekhis Raioni
35:33:Lanch'khut'is Raioni
36:34:Lentekhis Raioni
37:35:Marneulis Raioni
38:36:Martvilis Raioni
39:37:Mestiis Raioni
40:38:Mts'khet'is Raioni
41:39:Ninotsmindis Raioni
42::Och'amch'iris Raioni
43:40:Onis Raioni
44:41:Ozurget' is Raioni
45:43:Qazbegis Raioni
46:44:Qvarlis Raioni
47:46:Sach'kheris Raioni
48:47:Sagarejos Raioni
49:48:Samtrediis Raioni
50:49:Senakis Raioni
51::Shuakhevis Raioni
52:50:Sighnaghis Raioni
53::Sokhumis Raioni
54:52:T'elavis Raioni
55:53:T'erjolis Raioni
56:54:T'et'ritsqaros Raioni
57:55:T'ianet'is Raioni
58:57:Ts'ageris Raioni
59:58:Tsalenjikhis Raioni
62:62:Zestap'onis Raioni
63:64:Zugdidis Raioni

Country=GERMANY
SubCountryType=Bundesland
Code=DE

BW:01:Baden-Württemberg
BY:02:Bayern
HB:03:Bremen
HH:04:Hamburg
HE:05:Hessen
NI:06:Niedersachsen
NW:07:Nordrhein-Westfalen
RP:08:Rheinland-Pfalz
SL:09:Saarland
SH:10:Schleswig-Holstein
BR:16:Berlin
BB:11:Brandenburg
MV:12:Mecklenburg-Vorpommern
SN:13:Sachsen
ST:14:Sachsen-Anhalt
TH:15:Thüringen

Country=GHANA
SubCountryType=Region
Code=GH

AH:02:Ashanti
BA:03:Brong-Ahafo
CP:04:Central
EP:05:Eastern
AA:01:Greater Accra
NP:06:Northern
UE:10:Upper East
UW:11:Upper West
TV:08:Volta
WP:09:Western

Country=GUINEA
SubCountryType=Governorate
Code=GN

BE:01:Beyla
BF:02:Boffa
BK:03:Boké
CO:30:Coyah
DB:05:Dabola
DL:06:Dalaba
DI:07:Dinguiraye
DU:31:Dubréka
FA:09:Faranah
FO:10:Forécariah
FR:11:Fria
GA:12:Gaoual
GU:13:Guékédou
KA:32:Kankan
KE:15:Kérouané
KD:16:Kindia
KS:17:Kissidougou
KB:33:Koubia
KD:18:Koundara
KO:19:Kouroussa
LA:34:Labé
LE:35:Lélouma
LO:36:Lola
MC:21:Macenta
ML:22:Mali
MM:23:Mamou
MD:37:Mandiana
NZ:38:Nzérékoré
PI:25:Pita
SI:39:Siguiri
TE:27:Télimélé
TO:28:Tougué
YO:29:Yomou

Country=EQUATORIAL GUINEA
SubCountryType=Province
Code=QQ

C::Regiôn Continental
I::Region Insular
AN::Annobón
BN::Bioko Norte
BS::Bioko Sur
CS::Centro Sur
KN::Kie-Ntem
LI::Litoral
WN::Wele-Nzas

Country=GREECE
SubCountryType=Department
Code=GR

13::Achaïa
01:39:Aitolia-Akarnania
11:36:Argolis
12:41:Arkadia
31:20:Arta
A1:35:Attiki
64::Chalkidiki
94::Chania
85::Chios
81::Dodekanisos
52:04:Drama
71:01:Evros
05:30:Evrytania
04:34:Evvoia
63:08:Florina
07:32:Fokis
06:29:Fthiotis
51:10:Grevena
14::Ileia
53:12:Imathia
33:17:Ioannina
91:45:Irakleion
41::Karditsa
56:09:Kastoria
55:14:Kavalla
23:27:Kefallinia
22:25:Kerkyra
57:06:Kilkis
15:37:Korinthia
58:11:Kozani
82:49:Kyklades
16:42:Lakonia
42:21:Larisa
92:46:Lasithion
24:26:Lefkas
83:51:Lesvos
43:24:Magnisia
17:40:Messinia
59:07:Pella
34:19:Preveza
93:44:Rethymnon
73:02:Rodopi
84:48:Samos
62:05:Serrai
32:18:Thesprotia
54:13:Thessaloniki
44:22:Trikala
03:33:Voiotia
72:03:Xanthi
21:28:Zakynthos
69::Agio Oros

Country=GUATEMALA
SubCountryType=Department
Code=GT

AV:01:Alta Verapez
BV:02:Baja Verapez
CM:03:Chimaltenango
CQ:04:Chiquimula
PR:05:El Progreso
ES:06:Escuintla
GU:07:Guatemala
HU:08:Huehuetenango
IZ:09:Izabal
JA:10:Jalapa
JU:11:Jutíapa
PE:12:Petén
QZ:13:Quezaltenango
QC:14:Quiché
RE::Reta.thuleu
SA:16:Sacatepéquez
SM:17:San Marcos
SR:18:Santa Rosa
SO:19:Solol6
SU:20:Suchitepéquez
TO:21:Totonicapán
ZA:22:Zacapa

Country=GUINEA BISSAU
SubCountryType=Region
Code=GW

BS:11:Bissau
BA:01:Bafatá
BM:12:Biombo
BL:05:Bolama
CA:06:Cacheu
GA:10:Gabú
OI:04:Oio
QU:02:Quloara
TO:07:Tombali S

Country=GUYANA
SubCountryType=Region
Code=GY

BA:10:Barima-Waini
CU:11:Cuyuni-Mazaruni
DE:12:Demerara-Mahaica
EB:13:East Berbice-Corentyne
ES:14:Essequibo Islands-West Demerara
MA:15:Mahaica-Berbice
PM:16:Pomeroon-Supenaam
PT:17:Potaro-Siparuni
UD:18:Upper Demerara-Berbice
UT:19:Upper Takutu-Upper Essequibo

Country=HAITI
SubCountryType=Department
Code=HT

CE:07:Centre
GA:08:Grande-Anse
ND:09:Nord
NE::Nord-Eat
NO:03:Nord-Ouest
OU:11:Ouest
SD:12:Sud
SE:13:Sud-Est

Country=HONDURAS
SubCountryType=Department
Code=HN

AT:01:Atlántida
CL:03:Colón
CM:04:Comayagua
CP:05:Copán
CR:06:Cortés
CH:02:Choluteca
EP:07:El Paraíso
FM:08:Francisco Morazán
GD:09:Gracias a Dios
IN:10:Intibucá
IB:11:Islas de la Bahía
LP:12:La Paz
LE:13:Lempira
OC:14:Ocotepeque
OL:15:Olancho
SB:16:Santa Bárbara
VA:17:Valle
YO:18:Yoro

Country=HUNGARY
SubCountryType=County
Code=HU

BU:05:Budapest
BK:01:Bács-Kiskun
BA:02:Baranya
BE:03:Békés
BZ:04:Borsod-Abaúj-Zemplén
CS:06:Csongrád
FE:08:Fejér
GS:09:Gyõr-Moson-Sopron
HB:10:Hajdû-Bihar
HE:11:Heves
JN:20:Jász-Nagykun-Szolnok
KE:12:Komárom-Esztergom
NO:14:Nógrád
PE:16:Pest
SO:17:Somogy
SZ:18:Szabolcs-Szatmár-Bereg
TO:21:Tolna
VA:22:Vas
VE:39:Veszprém
ZA:24:Zala
BC:26:Békéscsaba
DE:07:Debrecen
DU:27:Dunaújváros
EG:28:Eger
GY:25:Gyór
HV:29:Hôdmezóvásárhely
KV:30:Kaposvár
KM:31:Kecékemét
MI:13:Miskolc
NK:32:Nagykanizaa
NY:33:Nyíregyháza
PS::Pécs
ST::Salgótarján
SN:34:Sopron
SD:19:Szaged
SF:35:Szakeafahérvár
SS::Szakszárd
SK:36:Szolnok
SH:37:Szombathely
TB:38:Tatabinya
VM::Veezprém
ZE:40:Zalaegerszeg

Country=ICELAND
SubCountryType=Region
Code=IE

7::Austurland
1::Höfuoborgarsvæöi utan Reykjavíkur
6::Noröurland eystra
5::Noröurland vestra
0::Reykjavík
8::Suöurland
2::Suöurnes
4::Vestfirölr
3::Vesturland

Country=INDIA
SubCountryType=State
Code=IN

AP:02:Andhra Pradesh
AR:30:Arunachal Pradesh
AS:03:Assam
BR:04:Bihar
GA:33:Goa
GJ:09:Gujarat
HR:10:Haryana
HP:11:Himachal Pradesh
JK:12:Jammu and Kashmir
KA:19:Karnataka
KL:13:Kerala
MP:15:Madhya Pradesh
MM:16:Maharashtra
MN:17:Manipur
ML:18:Meghalaya
MZ:31:Mizoram
NL:20:Nagaland
OR:21:Orissa
PB:23:Punjab
RJ:24:Rajasthan
SK:29:Sikkim
TN:25:Tamil Nadu
TR:26:Tripura
UP:27:Uttar Pradesh
W8:28:West Bengal
AN:01:Andaman and Nicobar Islands
CH:05:Chandigarh
DN:06:Dadra and Nagar Haveli
DD:32:Daman and Diu
DL:07:Delhi
LD:14:Lakshadweep
PY:22:Pondicherry

Country=INDONESIA
SubCountryType=Province
Code=ID

AC:01:Aceh
BA:02:Bali
BE:03:Bengkulu
IJ:09:Irian Jaya
JA:05:Jambi
JB:30:Jawa Barat
JI:08:Jawa Timur
JK:04:Jakarta Raya
JT:07:Jawa Tengah
JW::Jawa
KA::Kalimantan
KB:11:Kalimantan Barat
KI:14:Kalimantan Timur
KS:12:Kalimantan Selatan
KT:14:Kalimantan Timur
LA:15:Lampung
MA:28:Maluku
NB:17:Nusa Tenggara Barat
NT:18:Nusa Tenggara Timur
NU::Nusa Tenggara
RI:19:Riau
SA:31:Sulawesi Utara
SB:24:Sumatra Barat
SG:22:Sulawesi Tenggara
SL::Sulawesi
SM::Sumatera
SN:20:Sulawesi Selatan
SS:32:Sumatra Selatan
ST:21:Sulawesi Tengah
SU:26:Sumatera Utara
TT::Timor-Timur
YO:10:Yogyakarta

Country=IRELAND
Code=IE
SubCountryType=County

C:04:Cork
CE:03:Clare
CN:02:Cavan
CW:01:Carlow
D:07:Dublin
G:10:Galway
KE:12:Kildare
KK:13:Kilkenny
K:11:Kerry
LD:18:Longford
LH:19:Louth
LK:16:Limerick
LM:14:Leitrim
LS:15:Laois
MH:21:Meath
MN:22:Monaghan
MO:20:Mayo
OY:23:Offaly
RN:24:Roscommon
SO:25:Sligo
TA:26:Tipperary
WD:27:Waterford
WH:29:Westmeath
WW:31:Wicklow
WX:30:Wexford

Country=ISRAEL
SubCountryType=District
Code=IL

D:01:HaDarom
M:02:HaMerkaz
Z:03:HaZafon
HA::Hefa
TA:05:Tel-Aviv
JM:06:Yerushalayim

Country=ITALY
SubCountryType=Province
Code=IT

AG::Agrigento
AL::Alessandria
AN::Ancona
AO::Aosta
AR::Arezzo
AP::Ascoli Piceno
AT::Asti
AV::Avellino
BA::Bari
BL::Belluno
BN::Benevento
BG::Bergamo
BI::Biella
BO::Bologna
BZ::Bolzano
BS::Brescia
BR::Brindisi
CA::Cagliari
CL::Caltanissetta
CB::Campobasso
CE::Caserta
CT::Catania
CZ::Catanzaro
CH::Chieti
CO::Como
CS::Cosenza
CR::Cremona
KR::Crotone
CN::Cuneo
EN::Enna
FE::Ferrara
FI::Firenze
FG::Foggia
FO::Forlì
FR::Frosinone
GE::Genova
GO::Gorizia
GR::Grosseto
IM::Imperia
IS::Isernia
AQ::L'Aquila
SP::La Spezia
LT::Latina
LE::Lecce
LC::Lecco
LI::Livorno
LO::Lodi
LU::Lucca
MC::Macerata
MN::Mantova
MS::Massa-Carrara
MT::Matera
ME::Messina
MI::Milano
MO::Modena
NA::Napoli
NO::Novara
NU::Nuoro
OR::Oristano
PD::Padova
PA::Palermo
PR::Parma
PV::Pavia
PG::Perugia
PS::Pesaro e Urbino
PE::Pescara
PC::Piacenza
PI::Pisa
PT::Pistoia
PN::Pordenone
PZ::Potenza
PO::Prato
RG::Ragusa
RA::Ravenna
RC::Reggio Calabria
RE::Reggio Emilia
RI::Rieti
RN::Rimini
RM::Roma
RO::Rovigo
SA::Salerno
SS::Sassari
SV::Savona
SI::Siena
SR::Siracusa
SO::Sondrio
TA::Taranto
TE::Teramo
TR::Terni
TO::Torino
TP::Trapani
TN::Trento
TV::Treviso
TS::Trieste
UD::Udine
VA::Varese
VE::Venezia
VB::Verbano-Cusio-Ossola
VC::Vercelli
VR::Verona
VV::Vibo Valentia
VI::Vicenza
VT::Viterbo

# See note in limitations
65::Abruzzo
77:02:Basilicata
78:03:Calabria
72:04:Campania
45:05:Emilia-Romagna
36:06:Friuli-Venezia Giulia
62:07:Lazio
42:08:Liguria
25:09:Lombardia
57:10:Marche
67:11:Molise
21:12:Piemonte
75:13:Puglia
88:14:Sardegna
82:15:Sicilia
52:16:Toscana
32:17:Trentino-Alto Adige
55:18:Umbria
23:19:Valle d'Aosta
34:20:Veneto

Country=IRAQ
SubCountryType=Governorate
Code=IQ

AN:01:Al Anbar
BA:02:Al Ba,rah
MU:03:Al Muthanná
QA:04:Al Qadisiyah
NA:17:An Najef
AR:11:Arbil
SW:05:As Sulaymaniyah
TS:13:At Ta'mîm
BB:06:Babil
BG:07:Baghdäd
DA:08:Dahùk
DQ:09:Dhi Qär
DI:10:Diyälá
KA:12:Karbalä'
MA:14:Maysan
NI:15:Ninawá
SD::Salah ad Din
WA:16:Wasit

Country=IRAN (ISLAMIC REPUBLIC OF)
SubCountryType=Province
Code=IN

03::ArdabLl
02::Azarbayjän-e-Gharbî
01::Azarb&yjan-e-Sharq
06::Büahahr
08::Chahar Mahall va Bakhtlari
04::Esfahan
14::Fars
19::Gilan
24::Hamadan
23::Hormozgän
05::Ilam
15::Kerman
17::Kermanshähan
09::Khoràsàn
10::KhÜzestan
18::Kohkilüyeh va Büyer Ahmadî
16::Kordeatan
20::Lorestan
22::Markazî
21::Mazandaran
26::Qom
12::Semnan
13::SIstan va Balûchestan
07::Tehran
25::Yazd
11::Zanjan

Country=CÔTE D'IVOIRE
SubCountryType=Region
Code=CI

06:47:18 Montagnes
16::Agnébi
09::Bas-Sassandra
10:33:Denguélé
02:54:Haut-Sassandra
07::Lacs
01::Lagunes
12::Marahoué
05::Moyen-Comoé
11::Nzi-Comoé
03::Savanes
15::Sud-Bandama
13::Sud-Comoé
04::Vallée du Bandama
14::Worodouqou
08::Zanzan

Country=JAPAN
SubCountryType=Prefecture
Code=JP

23:01:Aichi
05:02:Akita
02:03:Aomori
12:04:Chiba
38:05:Ehime
18:06:Fukui
40:07:Fukuoka
07::Fukusima
21:09:Gifu
10::Gunma
34:11:Hiroshima
01:12:Hokkaido
28:13:Hyogo
08:14:Ibaraki
17:15:Ishikawa
03:16:Iwate
37:17:Kagawa
46:18:Kagoshima
14:19:Kanagawa
39:20:Kochi
43:21:Kumamoto
26:22:Kyoto
24:23:Mie
04:24:Miyagi
45:25:Miyazaki
20:26:Nagano
42:27:Nagasaki
29:28:Nara
15:29:Niigata
44:30:Oita
33:31:Okayama
47:47:Okinawa
27:32:Osaka
41:33:Saga
11:34:Saitama
25:35:Shiga
32:36:Shimane
22:37:Shizuoka
09:38:Tochigi
36:39:Tokushima
13:40:Tokyo
31:41:Tottori
16:42:Toyama
30:43:Wakayama
06:44:Yamagata
35:45:Yamaguchi
19:46:Yamanashi

Country=JAMAICA
SubCountryType=Parish
Code=JM

13:01:Clarendon
09:02:Hanover
01::Kingston
12:04:Manchester
04:07:Portland
02:08:Saint Andrew
06:09:Saint Ann
14:10:Saint Catherine
11:11:Saint Elizabeth
08:12:Saint James
05:13:Saint Mary
03::Saint Thomea
07:15:Trelawny
10:16:Westmoreland

Country=JORDAN
SubCountryType=Governorate
Code=JO

AJ:20:Ajlün
AQ:21:Al 'Aqaba
BA:02:Al Balqa'
KA:09:Al Karak
MA:15:Al Mafraq
AM:16:'Ammãn
AT:12:At Tafîlah
AZ:17:Az Zargã'
JR:18:Irbid
JA:22:Jarash
MN:19:Ma'ãn
MD::Madaba

Country=KENYA
SubCountryType=Province
Code=KE

110::Nairobi Municipality
200:01:Central
300:02:Coast
400:03:Eastern
500::North-Eastern Kaskazini Mashariki
700:08:Rift Valley
900::Western Magharibi

Country=KYRGYZSTAN
SubCountryType=Region
Code=KG

C::Chu
J:03:Jalal-Abad
N:04:Naryn
O:08:Osh
T:06:Talas
Y:07:Ysyk-Kol

Country=CAMBODIA
SubCountryType=Province
Code=KH

23:26:Krong Kaeb
18::Xrong Preah Sihanouk
12:22:Phnom Penh
2:29:Baat Dambang
1:25:Banteay Mean Chey
3:02:Rampong Chaam
4:03:Kampong Chhnang
5:04:Kampong Spueu
6:05:Kampong Thum
7:21:Kampot
8:07:Kandaal
9:08:Kach Kong
10:09:Krachoh
11:10:Mondol Kiri
22:27:Otdar Mean Chey
15:12:Pousaat
13:13:Preah Vihear
14:14:Prey Veaeng
16::Rotanak Kiri
17:24:Siem Reab
19:17:Stueng Traeng
20:18:Svaay Rieng
21:19:Taakaev

Country=KIRIBATI
SubCountryType=Island
Code=KI

G:01:Gilbert Islands
L:02:Line Islands
P:03:Phoenix Islands

Country=KUWAIT
SubCountryType=Province
Code=KW

AH:04:Al Ahmadî
FA:06:Al Farwanlyah
JA:05:Al Jahrah
KU::Al Kuwayt
HA:03:Hawallî

Country=KAZAKHSTAN
SubCountryType=Region
Code=KZ

ALA:02:Almaty
BAY:08:Bayqonyr
ALM::Almaty oblysy
AKM::Aqmola oblysy
AKT::Aqtöbe oblysy
ATY::Atyraû oblyfiy
ZAP:07:Batys Kazakstan
MAN::Mangghystaû oblysy
YUZ::Ongtustik Kazakstan Yuzhno-Kazakhstanskaya Juzno-Kazahetanskaja
PAV::Pavlodar oblysy
KAR::Qaraghandy oblysy
KUS::Qostanay oblysy
KZY::Qyzylorda oblysy
VOS:15:Shyghys Kazakstan
SEV::SoltÜatik Kazakstan Severo-Kazakhstanskaya Severo-Kazahstanskaja
ZHA::Zhambyl oblysy Zhambylskaya oblast'

Country=LAO PEOPLE'S DEMOCRATIC REPUBLIC
SubCountryType=Province
Code=LA

VT::Vientiane
AT:01:Attapu
BK:22:Bokèo
BL:23:Bolikhamxai
CH:02:Champasak
HO:03:Houaphan
KH:15:Khammouan
LM:16:Louang Namtha
LP:17:Louangphabang
OU:07:Oudômxai
PH:18:Phôngsali
SL:19:Salavan
SV:20:Savannakhét
VI::Vientiane
XA:13:Xaignabouli
XE:26:Xékong
XI:14:Xiangkhoang

Country=LEBANON
SubCountryType=Governorate
Code=LB

BA:04:Beirout
BI:01:El Béqaa
JL:05:Jabal Loubnâne
AS::Loubnane ech Chemàli
JA::Loubnâne ej Jnoûbi
NA::Nabatîyé

Country=SRI LANKA
SubCountryType=Province
Code=LK

52::Ampara
71::Anuradhapura
81::Badulla
51::Batticaloa
11::Colombo
31::Galle
12::Gampaha
33::Hambantota
41::Jaffna
13::Kalutara
21::Kandy
92::Kegalla
42::Kilinochchi
61::Kurunegala
43::Mannar
22::Matale
32::Matara
82::Monaragala
45::Mullaittivu
23::Nuwara Eliya
72::Polonnaruwa
62::Puttalum
91::Ratnapura
53::Trincomalee
44::VavunLya

Country=LIBERIA
SubCountryType=County
Code=LR

BM:15:Bomi
BG:01:Bong
GB:11:Grand Basaa
CM:12:Grand Cape Mount
GG:02:Grand Gedeh
GK:16:Grand Kru
LO:05:Lofa
MG:17:Margibi
MY:13:Maryland
MO:14:Montserrado
NI:09:Nimba
RI:18:Rivercess
SI:10:Sinoe

Country=LESOTHO
SubCountryType=District
Code=LS

D:10:Berea
B:11:Butha-Buthe
C:12:Leribe
E:13:Mafeteng
A:14:Maseru
F:15:Mohale's Hoek
J:16:Mokhotlong
H::Qacha's Nek
G:18:Quthing
K:19:Thaba-Tseka

Country=LITHUANIA
SubCountryType=County
Code=LT

AL::Alytaus Apskritis
KU::Kauno Apskritis
KL::Klaipedos Apskritis
MR::Marijampoles Apskritis
PN::Panevezio Apskritis
SA::Sisuliu Apskritis
TA::Taurages Apskritis
TE::Telsiu Apskritis
UT::Utenos Apskritis
VL::Vilniaus Apskritis

Country=LATVIA
SubCountryType=District
Code=LV

AI::Aizkraukles Apripkis
AL::AlÜkanes Apripkis
BL::Balvu Apripkis
BU::Bauskas Apripkis
CE::Cêsu Aprikis
DA::Daugavpile Apripkis
DO::Dobeles Apripkis
GU::Gulbenes Aprlpkis
JL::Jelgavas Apripkis
JK::Jékabpils Apripkis
KR::Kräslavas Apripkis
KU::Kuldlgas Apripkis
LM::Limbazu Apripkis
LE::Liepàjas Apripkis
LU::Ludzas Apripkis
MA::Madonas Apripkis
OG::Ogres Apripkis
PR::Preilu Apripkis
RE::Rèzaknes Apripkis
RI:25:Rîgas Apripkis
SA::Saldus Apripkis
TA::Talsu Apripkis
TU::Tukuma Apriplcis
VK::Valkas Apripkis
VM::Valmieras Apripkis
VE::Ventspils Apripkis
DGV:06:Daugavpils
JEL:11:Jelgava
JUR:13:Jurmala
LPX:16:Liepäja
REZ:23:Rêzekne
RIX::Rlga
VEN:32:Ventspils

Country=LIBYAN ARAB JAMAHIRIYA
SubCountryType=Municipality
Code=LY

BU::Al Butnan
JA:49:Al Jabal al Akhdar
JG::Al Jabal al Gharbî
JU:05:Al Jufrah
WA::Al Wâhah
WU::Al Wustá
ZA:53:Az Zãwiyah
BA:54:Banghazi
FA::Fazzan
MI:58:Misratah
NA::Naggaza
SF:59:Sawfajjin
TB::Tarãbulus

Country=MOROCCO
SubCountryType=Province
Code=MA

AGD:01:Agadir
BAH::Aït Baha
MEL::Aït Melloul
HAO::Al Haouz
HOC::Al Hoceïma
ASZ:43:Assa-Zag
AZI:03:Azilal
BEM:05:Beni Mellal
BES:04:Ben Sllmane
BER::Berkane
BOD::Boujdour
BOM:06:Boulemane
CAS:07:Casablanca
CHE::Chefchaouene
CHI:08:Chichaoua
HAJ::El Hajeb
JDI:09:El Jadida
ERR:11:Errachidia
ESI:12:Essaouira
ESM:44:Es Semara
FES:13:Fès
FIG:14:Figuig
GUE:42:Guelmim
IFR:34:Ifrane
IRA::Jrada
KES::Kelaat Sraghna
KEN:15:Kénitra
KHE:16:Khemisaet
KHN:17:Khenifra
KHO:18:Khouribga
LAA:35:Laayoune. (EH)
LAP:41:Larache
MAR:19:Marrakech
MEK:20:Meknès
NAD:21:Nador
OUA:22:Ouarzazate
OUD::Oued ed Dahab (EH)
OUJ:23:Oujda
RBA:24:Rabat-Salé
SAF:25:Safi
SEF::Sefrou
SET:26:Settat
SIK:38:Sidl Kacem
TNG:27:Tanger
TNT:36:Tan-Tan
TAO:37:Taounate
TAR:39:Taroudannt
TAT:29:Tata
TAZ:30:Taza
TET:40:Tétouan
TIZ:32:Tiznit

Country=MOLDOVA, REPUPLIC OF
SubCountryType=District
Code=MD

BAL:46:Balti
CAH:47:Cahul
CHI:48:Chisinau
DUB:49:Dubasari
ORH:53:Orhei
RIB::Ribnita
SOC:54:Soroca
TIG:55:Tighina
TIP::Tiraspol
UNG:56:Ungheni
ANE::Anenii Noi
BAS::Basarabeasca
BRI::Brinceni
CHL:47:Cahul
CAM::Camenca
CAN::Cantemir
CAI::Cainari
CAL::Calarayi
CAS::Causeni
CIA::Ciadîr-Lunga
CIM::Cimi'lia
COM::Comrat
CRI::Criuleni
DON::Donduseni
DRO::Drochia
DBI:49:Dubasari
EDI:50:Edine;
FAL::Fãlesti
FLO::Floresti
GLO::Glodeni
GRI::Grigoriopol
HIN::Hîncesti
IAL::Ialoveni
LEO::Leova
NIS::Nisporeni
OCN::Ocni\a
OHI:53:Orhei
REZ::Rezina
RIT::Rîbnita
RIS::Rîscani
SIN::Sîngerei
SLO::Slobozia
SOA:54:Soroca
STR::Straseni
SOL::Soldanesti
STE::Stefan Voda
TAR::Taraclia
TEL::Telenesti
UGI:56:Ungheni
VUL::Vulcanesti

Country=MADAGASCAR
SubCountryType=Province
Code=MG

T:05:Antananarivo
D:01:Antsiranana
F:02:Fianarantsoa
M:03:Mahajanga
A:04:Toamasina
U:06:Toliara

Country=MALI
SubCountryType=District
Code=ML

BK0:01:Bamako
7:02:Gao
1:03:Kayes
8::Kidal
2:07:Xoulikoro
5:04:Mopti
4::S69ou
3:06:Sikasso
6:08:Tombouctou

Country=MYANMAR
SubCountryType=State
Code=MM

07:03:Ayeyarwady
02:16:Bago
03:15:Magway
04:08:Mandalay
01:10:Sagaing
05:12:Tanintharyi
06:17:Yangon
14::Chin
11::Kachin
12::Kayah
13::Kayin
15::Mon
16::Rakhine
17::Shan

Country=MONGOLIA
SubCountryType=Province
Code=MN

1:20:Ulanbaatar
073:01:Arhangay
069:02:Bayanhongor
071:03:Bayan-Ölgiy
067:21:Bulgan
037::Darhan uul
061:06:Dornod
063:07:Dornogov
059:08:DundgovL
057:09:Dzavhan
065:10:Govi-Altay
064::Govi-Sümber
039:11:Hentiy
043:12:Hovd
041:13:Hövsgöl
053:14:Ömnögovi
035::Orhon
055:15:Övörhangay
049:16:Selenge
051:17:Sühbaatar
047:18:Töv
046:19:Uvs

Country=MARSHALL ISLANDS
SubCountryType=Municipality
Code=MH

ALL::Ailinglapalap
ALK::Ailuk
ARN::Arno
AUR::Aur
EBO::Ebon
ENI::Eniwetok
JAL::Jaluit
KIL::Kili
KWA::Kwajalein
LAE::Lae
LIB::Lib
LIK::Likiep
MAJ::Majuro
MAL::Maloelap
MEJ::Mejit
MIL::Mili
NMK::Namorik
NMU::Namu
RON::Rongelap
UJA::Ujae
UJL::Ujelang
UTI::Utirik
WTN::Wotho
WTJ::Wotje

Country=MAURITANIA
SubCountryType=Region
Code=MR

NKC::Nouakchott
07:07:Adrar
03:03:Assaba
05:05:Brakna
08:08:Dakhlet Nouadhibou
04:04:Gorgol
10:10:Guidimaka
01:01:Hodh ech Chargui
02::Hodh el Charbi
12:12:Inchiri
09:09:Tagant
11:11:Tiris Zemmour
06:06:Trarza

Country=MAURITIUS
SubCountryType=Province
Code=MU

BR::Beau Bassin-Rose Hill
CU::Curepipe
PL:18:Port Louis
QB::Quatre Bornes
VP::Vacosa-Phoenix
BL:12:Black River
FL:13:Flacq
GP:14:Grand Port
MO:15:Moka
PA:16:Pamplemousses
PW:17:Plaines Wilhems
PL:18:Port Louis
RP:19:Riviére du Rempart
SA:20:Savanne
AG:21:Agalega Islands
CC::Cargados Carajos Shoals
RO::Rodrigues Island

Country=MALDIVES
SubCountryType=Administrative Atoll
Code=MV

MLE::Male
02::Alif
20:31:Baa
17:32:Dhaalu
14::Faafu
27:34:Gaaf Alif
28:35:Gaefu Dhaalu
29:42:Gnaviyani
07:36:Haa Alif
23:37:Haa Dhaalu
26:38:Kaafu
05:05:Laamu
03:39:Lhaviyani
12::Meemu
25:43:Noonu
13:44:Raa
01:01:Seenu
24:45:Shaviyani
08:46:Thaa
04:47:Vaavu

Country=MALAWI
SubCountryType=District
Code=MW

BL:24:Blantyre
CK:02:Chikwawa
CR:03:Chiradzulu
CT:04:Chitipa
DE:06:Dedza
DO:07:Dowa
KR:08:Karonga
KS:09:Kasungu
LI:11:Lilongwe
MH:10:Machinga
MG:12:Mangochi
MC:13:Mchinji
MU:14:Mulanje
MW:25:Mwanza
MZ:15:Mzimba
NB:17:Nkhata Bay
NK:18:Nkhotakota
NS:19:Nsanje
NU:16:Ntcheu
NI:20:Ntchisi
RU:21:Rumphi
SA:22:Salima
TH:05:Thyolo
ZO:23:Zomba

Country=MEXICO
SubCountryType=State
Code=MX

DIF:09:Distrito Federal
AGU:01:Aguascalientes
BCN:02:Baja California
BCS:03:Baja California Sur
CAM:04:Campeche
COA::Coahu ila
COL:08:Col ima
CHP:05:Chiapas
CHH:06:Chihushua
DUR:10:Durango
GUA:11:Guanajuato
GRO:12:Guerrero
HID:13:Hidalgo
JAL:14:Jalisco
MEX:15:Mexico
MIC::Michoacin
MOR:17:Moreloa
NAY:18:Nayarit
NLE:19:Nuevo León
OAX:20:Oaxaca
PUE:21:Puebla
QUE::Querétaro
ROO:23:Quintana Roo
SLP:24:San Luis Potosí
SIN:25:Sinaloa
SON:26:Sonora
TAB:27:Tabasco
TAM:28:Tamaulipas
TLA:29:Tlaxcala
VER::Veracruz
YUC:31:Yucatán
ZAC:32:Zacatecas

Country=MALAYSIA
SubCountryType=State
Code=MY

W::Wilayah Persekutuan Kuala Lumpur
L::Wilayah Persekutuan Labuan
J:01:Johor
K:02:Kedah
D:03:Kelantan
M:04:Melaka
N:05:Negeri Sembilan
C:06:Pahang
A:07:Perak
R:08:Perlis
P:09:Pulau Pinang
SA:16:Sabah
SK:11:Sarawak
B:12:Selangor
T:13:Terengganu

Country=MOZAMBIQUE
SubCountryType=Province
Code=MZ

MPM:04:Maputo
P:01:Cabo Delgado
G:02:Gaza
I:03:Inhambane
B:10:Manica
L:04:Maputo
N:06:Numpula
A:07:Niaaea
S:05:Sofala
T:08:Tete
Q:09:Zambézia

Country=NAMIBIA
SubCountryType=Region
Code=NA

CA:28:Caprivi
ER:29:Erongo
HA:30:Hardap
KA:31:Karas
KH:21:Khomae
KU:32:Kunene
OW:33:Ohangwena
OK:34:Okavango
OH:35:Omaheke
OS:36:Omusati
ON:37:Oshana
OT:38:Oshikoto
OD:39:Otjozondjupa

Country=NETHERLANDS
SubCountryType=Province
Code=NL

DR:01:Drente
FL:16:Flevoland
FR:02:Friesland
GL:03:Gelderland
GR:04:Groningen
LB:05:Limburg
NB:06:Noord Brabant
NH:07:Noord Holland
OV:15:Overijssel
UT:09:Utrecht
ZH:11:Zuid Holland
ZL:10:Zeeland

Country=NIGERIA
SubCountryType=State
Code=NG

FC:11:Abuja Capital Territory
AB:45:Abia
AD:35:Adamawa
AK:21:Akwa Ibom
AN:25:Anambra
BA:46:Bauchi
BY:52:Bayelsa
BE:26:Benue
BO:27:Borno
CR:22:Cross River
DE:36:Delta
EB:53:Ebonyi
ED:37:Edo
EK:54:Ekiti
EN:47:Enugu
GO:55:Gombe
IM:28:Imo
JI:39:Jigawa
KD:23:Kaduna
KN:29:Kano
KT:24:Katsina
KE:40:Kebbi
KO:41:Kogi
KW:30:Kwara
LA:05:Lagos
NA:56:Nassarawa
NI:31:Niger
OG:16:Ogun
ON:48:Ondo
OS:42:Osun
OY:32:Oyo
PL:49:Plateau
RI:50:Rivers
SO:51:Sokoto
TA:43:Taraba
YO:44:Yobe
ZA:57:Zamfara

Country=NIGER
SubCountryType=Department
Code=NE

8:08:Niamey
1:01:Agadez
2:02:Diffa
3:03:Dosso
4:04:Maradi
S:06:Tahoua
6:09:Tillabéri
7:07:Zinder

Country=NICARAGUA
SubCountryType=Department
Code=NI

BO:01:Boaco
CA:02:Carazo
CI:03:Chinandega
CO:04:Chontales
ES:05:Estelí
GR:06:Granada
JI:07:Jinotega
LE:08:Leon
MD:09:Madriz
MN:10:Managua
MS:11:Masaya
MT:12:Matagalpa
NS:13:Nueva Segovia
SJ:14:Río San Juan
RI:15:Rivas
ZE::Zelaya

Country=KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF
SubCountryType=Province
Code=KP

KAE:08:Kaesong-si
NAM:14:Nampo-si
PYO:12:Pyongyang-ai
CHA:01:Chagang-do
HAB:16:Hamgyongbuk-do
HAN:03:Hamgyongnam-do
HWB:07:Hwanghaebuk-do
HWN:06:Hwanghaenam-do
KAN:09:Kangwon-do
PYB:15:Pyonganbuk-do
PYN::Pyongannam-do
YAN:13:Yanggang-do

Country=NORWAY
SubCountryType=County
Code=NO

02:01:Akershus
09:02:Aust-Agder
06:04:Buskerud
20:05:Finumark
04:06:Hedmark
12:07:Hordaland
15:08:Míre og Romsdal
18:09:Nordland
17:10:Nord-Tríndelag
05:11:Oppland
03:12:Oslo
11:14:Rogaland
14:15:Sogn og Fjordane
16:16:Sír-Tríndelag
06:17:Telemark
19:18:Troms
10:19:Vest-Agder
07:20:Vestfold
01::Østfold
22::Jan Mayen
21::Svalbard

Country=NEW ZEALAND
SubCountryType=Region
Code=NZ

AUK:17:Auckland
BOP::Bay of Plenty
CAN::Canterbury
GIS::Gisborne
HKB:31:Hawkes's Bay
MWT::Manawatu-Wanganui
MBH:50:Marlborough
NSN::Nelson
NTL::Northland
OTA::Otago
STL:72:Southland
TKI:76:Taranaki
TAS::Tasman
WKO:85:waikato
WGN::Wellington
WTC::West Coast

Country=OMAN
SubCountryType=Region
Code=OM

DA:01:Ad Dakhillyah
BA:02:Al Batinah
JA::Al JanÜblyah
WU:03:Al Wustá
SH:04:Ash Sharqlyah
ZA:05:Az Zahirah
MA:06:Masqat
MU:07:Musandam

Country=PANAMA
SubCountryType=Province
Code=PA

1:01:Bocas del Toro
2:03:Coclé
3:04:Colón
4:02:Chiriqui
5:05:Darién
6:06:Herrera
7:07:Loa Santoa
8:08:Panamá
9:10:Veraguas
Q::Comarca de San Blas

Country=PAKISTAN
SubCountryType=Province
Code=PK

IS:08:Islamabad
BA::Baluchistan (en)
NW:03:North-West Frontier
PB:04:Punjab
SD::Sind (en)
TA::Federally Administered Tribal Aresa
JK:06:Azad Rashmir
NA:07:Northern Areas

Country=PAPUA NEW GUINEA
SubCountryType=Province
Code=PG

NCD::National Capital District (Port Moresby)
CPM:01:Central
CPK:08:Chimbu
EHG:09:Eastern Highlands
EBR:10:East New Britain
ESW:11:East Sepik
EPW:19:Enga
GPK:02:Gulf
MPM:12:Madang
MRL:13:Manus
MBA:03:Milne Bay
MPL:14:Morobe
NIK:15:New Ireland
NPP:04:Northern
NSA::North Solomons
SAN:18:Santaun
SHM:05:Southern Highlands
WPD:06:Western
WHM:16:Western Highlands
WBK:17:West New Britain

Country=PERU
SubCountryType=Department
Code=PE

CAL::El Callao
AMA:01:Amazonas
ANC:02:Ancash
APU:03:Apurímac
ARE:04:Arequipa
AYA:05:Ayacucho
CAJ:06:Cajamarca
CUS::Cuzco
HUV:09:Huancavelica
HUC:10:Huánuco
ICA:11:Ica
JUN:12:Junín
LAL:13:La Libertad
LAM:14:Lambayeque
LIM:15:Lima
LOR:16:Loreto
MDD:17:Madre de Dios
MOQ:18:Moquegua
PAS:19:Pasco
PIU:20:Piura
PUN:21:Puno
SAM:22:San Martín
TAC:23:Tacna
TUM:24:Tumbes
UCA:25:Ucayali

Country=PHILIPPINES
SubCountryType=Province
Code=PH

ABR:01:Abra
AGN:02:Agusan del Norte
AGS:03:Agusan del Sur
AKL:04:Aklan
ALB:05:Albay
ANT:06:Antique
AUR:G8:Aurora
BAS:22:Basilan
BAN:07:Batasn
BTN:08:Batanes
BTG:09:Batangas
BEN:10:Benguet
BOH:11:Bohol
BUK:12:Bukidnon
BUL:13:Bulacan
CAG:14:Cagayan
CAN:15:Camarines Norte
CAS:16:Camarines Sur
CAM:17:Camiguin
CAP:18:Capiz
CAT:19:Catanduanes
CAV:20:Cavite
CEB:21:Cebu
DAV:24:Davao
DAS:25:Davao del Sur
DAO:26:Davao Oriental
EAS:23:Eastern Samar
IFU:27:Ifugao
ILN:28:Ilocos Norte
ILS:29:Ilocos Sur
ILI:30:Iloilo
ISA:31:Isabela
KAL:D6:Kalinga-Apayso
LAG:33:Laguna
LAN:34:Lanao del Norte
LAS:35:Lanao del Sur
LUN:36:La Union
LEY:37:Leyte
MAG:56:Maguindanao
MAD:38:Marinduque
MAS:39:Masbate
MDC:40:Mindoro Occidental
MDR:41:Mindoro Oriental
MSC:42:Misamis Occidental
MSR:43:Misamis Oriental
MOU::Mountain Province
NEC:H3:Negroe Occidental
NER:46:Negros Oriental
NCO:57:North Cotabato
NSA:67:Northern Samar
NUE:47:Nueva Ecija
NUV:48:Nueva Vizcaya
PLW:49:Palawan
PAM:50:Pampanga
PAN:51:Pangasinan
QUE:H2:Quezon
QUI:68:Quirino
RIZ:53:Rizal
ROM:54:Romblon
SIG:69:Siquijor
SOR:58:Sorsogon
SCO:70:South Cotabato
SLE:59:Southern Leyte
SUK:71:Sultan Kudarat
SLU:60:Sulu
SUN:61:Surigao del Norte
SUR:62:Surigao del Sur
TAR:63:Tarlac
TAW:72:Tawi-Tawi
WSA:55:Western Samar
ZMB:64:Zambales
ZAN:65:Zamboanga del Norte
ZAS:66:Zamboanga del Sur

Country=POLAND
SubCountryType=Province
Code=PL

BP::Biala Podlaska
BK::Bialystok
BB:75:Bielsko
BY::Bydgoszcz
CH::Chelm
CI::Ciechanów
CZ::Czestochowa
EL::Elblag
GD::Gdañsk
GO::Gorzów
JG::Jelenia Góra
KA::Katowice
KI::Kielce
KL::Kalisz
KN::Konin
KO::Koszalin
KR::Kraków
KS::Krosno
LG::Legnica
LE::Leszno
LU::Lublin
LO::Lomza
LD::Lódz
NS::Nowy Sacz
OL::Olsztyn
OP::Opole
OS::Ostroleka
PD:81:Podlaskie
PI::Pila
PL::Plock
PO::Poznañ
PR::Przemysl
PT::Piotrków
RA::Radom
RZ::Rzeszów
SE::Siedlce
SI::Sieradz
SK::Skierniewice
SL:83:Slupsk
SU::Suwalki
SZ::Szczecin
TG::Tarnobrzeg
TA::Tarnów
T0::Toruñ
WB::Wañblzych
WA::Warazawa
WL::Wloclawek
WP:86:Wielkopolskie
WR::Wroclaw
ZA:82:Zamosc
ZG::Zielona Góra

Country=PORTUGAL
SubCountryType=District
Code=PT

01:02:Aveiro
02:03:Beja
03:04:Braga
04:05:Bragança
05:06:Castelo Branco
06:07:Coimbra
07:08:Évora
08:09:Faro
09:11:Guarda
10:13:Leiria
11:14:Lisboa
12:16:Portalegre
13:17:Porto
14:18:Santarém
15:19:Setúbal
16:20:Viana do Castelo
17:21:Vila Real
18:22:Viseu
20::Regiao Autonoma dos Açores
30::Regiao AutOnoma da Madeira

Country=PARAGUAY
SubCountryType=Department
Code=PY

ASU:22:Asunción
16:23:Alto Paraguay
10:01:Alto Paraná
13:02:Amambay
19:24:Boquerón
5:04:Caeguazú
6:05:Caazapl
14:19:Canindeyú
11:06:Central
1:07:Concepción
3:08:Cordillera
4:10:Guairá
7:11:Itapua
8:12:Miaiones
12:13:Ñeembucu
9:15:Paraguarí
15:16:Presidente Hayes
2:17:San Pedro


Country=QATAR
SubCountryType=Municipality
Code=QA

DA:01:Ad Dawhah
GH:02:Al Ghuwayrîyah
JU:03:Al Jumayliyah
KH:04:Al Khawr
WA:05:Al Wakrah
RA:06:Ar Rayyãn
JB:07:Jariyan al Bãtnah
MS:08:Madinat ash Shamal
US:09:Umm Salãl


Country=RWANDA
SubCountryType=Province
Code=RW

C:01:Butare
I:02:Byumba
E:03:Cyangugu
D:04:Gikongoro
G:05:Gisenyi
B:06:Gitarama
J:07:Kibungo
F:08:Kibuye
K::Kigali-Rural Kigali y' Icyaro
L::Kigali-Ville Kigali Ngari
M::Mutara
H:10:Ruhengeri

Country=ROMANIA
SubCountryType=Department
Code=RO

B:10:Bucuresti
AB:01:Alba
AR:02:Arad
AG:03:Arges
BC:04:Bacau
BH:05:Bihor
BN:06:Bistrita-Nasaud
BT:07:Botosani
BV:09:Brasov
BR:08:Braila
BZ:11:Buzau
CS:12:Caras-Severin
CL:41:Calarasi
CJ:13:Cluj
CT:14:Constanta
CV:15:Covasna
DB:16:Dâmbovita
DJ:17:Dolj
GL:18:Galati
GR:42:Giurgiu
GJ:19:Gorj
HR:20:Harghita
HD:21:Hunedoara
IL:22:Ialomita
IS:23:Iasi
MM:25:Maramures
MH:26:Mehedinti
MS:27:Mures
NT:28:Neamt
OT:29:Olt
PH:30:Prahova
SM:32:Satu Mare
SJ:31:Sa laj
SB:33:Sibiu
SV:34:Suceava
TR:35:Teleorman
TM:36:Timis
TL:37:Tulcea
VS:38:Vaslui
VL:39:Vâlcea
VN:40:Vrancea

Country=RUSSIA
SubCountryType=Republic
Code=RU

AD::Adygeya, Respublika
AL:03:Altay, Respublika
BA::Bashkortostan, Respublika
BU::Buryatiya, Respublika
CE::Chechenskaya Respublika
CU::Chuvashskaya Respublika
DA::Dagestan, Respublika
IN::Ingushskaya Respublika
KB::Kabardino-Balkarskaya
KL::Kalmykiya, Respublika
KC::Karachayevo-Cherkesskaya Respublika
KR::Kareliya, Respublika
KK::Khakasiya, Respublika
KO:34:Komi, Respublika
ME::Mariy El, Respublika
MO:: Mordoviya, Respublika
SA:63:Sakha, Respublika [Yakutiya]
SE::Severnaya Osetiya, Respublika
TA::Tatarstan, Respublika
TY:79:Tyva, Respublika [Tuva]
UD::Udmurtskaya Respublika
ALT:04:Altayskiy kray
KHA:30:Khabarovskiy kray
KDA:38:Krasnodarskiy kray
KYA:39:Krasnoyarskiy kray
PRI:59:Primorskiy kray
STA:70:Stavropol'skiy kray
AMU:05:Amurskaya oblast'
ARK:06:Arkhangel'skaya oblast'
AST:07:Astrakhanskaya oblast'
BEL:09:Belgorodskaya oblast'
BRY:10:Bryanskaya oblast'
CHE:13:Chelyabinskaya oblast'
CHI:14:Chitinskaya oblast'
IRK:20:Irkutskaya oblast'
IVA:21:Ivanovskaya oblast'
KGD:23:Kaliningradskaya oblast'
KLU:25:Kaluzhskaya oblast'
KAM:26:Kamchatskaya oblast'
KEM:29:Kemerovskaya oblast'
KIR:33:Kirovskaya oblast'
KOS:37:Kostromskaya oblast'
KGN:40:Kurganskaya oblast'
KRS:41:Kurskaya oblast'
LEN:42:Leningradskaya oblast'
LIP:43:Lipetskaya oblast'
MAG:44:Magadanskaya oblast'
MOS:47:Moskovskaya oblast'
MUR:49:Murmanskaya oblast'
NIZ:51:Nizhegorodskaya oblast'
NGR:52:Novgorodskaya oblast'
NVS:53:Novosibirskaya oblast'
OMS:54:Omskaya oblast'
ORE:55:Orenburgskaya oblast'
ORL:56:Orlovskaya oblast'
PNZ:57:Penzenskaya oblast'
PER:58:Permskaya oblast'
PSK:60:Pskovskaya oblast'
ROS:61:Rostovskaya oblast'
RYA:62:Ryazanskaya oblast'
SAK:64:Sakhalinskaya oblast'
SAM:65:Samarskaya oblast'
SAR:67:Saratovskaya oblast'
SMO:69:Smolenskaya oblast'
SVE:71:Sverdlovskaya oblast'
TAM:72:Tambovskaya oblast'
TOM:75:Tomskaya oblast'
TUL:76:Tul'skaya oblast'
TVE:77:Tverskaya oblast'
TYU:78:Tyumenskaya oblast'
ULY:81:Ul'yanovskaya oblast'
VLA:83:Vladimirskaya oblast'
VGG:84:Volgogradskaya oblast'
VLG:85:Vologodskaya oblast'
VOR:86:Voronezhskaya oblast'
YAR:88:Yaroslavskaya oblast'
MOW:48:Moskva
SPE:66:Sankt-Peterburg
YEV::Yevreyskaya avtonomnaya oblast'
AGB::Aginskiy Buryatskiy avtonomnyy
CHU:15:Chukotskiy avtonomnyy okrug
EVE:18:Evenkiyskiy avtonomnyy okrug
KHM:32:Khanty-Mansiyskiy avtonomnyy okrug
KOP:35:Komi-Permyatskiy avtonomnyy okrug
KOR:36:Koryakskiy avtonomnyy okrug
NEN:50:Nenetskiy avtonomnyy okrug
TAY::Taymyrskiy (Dolgano-Nenetskiy
UOB::Ust'-Ordynskiy Buryatskiy
YAN:87:Yamalo-Nenetskiy avtonomnyy okrug

Country=SAUDI ARABIA
SubCountryType=Province
Code=SA

11:02:Al Batah
08::Al H,udÜd ash Shamallyah
12:20:Al Jawf
03:05:Al Madlnah
05:08:Al Qasim
01:10:Ar Riyad
04:06:Ash Sharqlyah
14:11:Asîr
06:13:Hã'il
09::Jlzãn
02:14:Makkah
10:16:Najran
07:19:Tabûk

Country=SPAIN
SubCountryType=Province
Code=ES

A::Alicante
AB::Albacete
AL::Almería
AN:51:Andalucía
AR:52:Aragón
AV::Ávila
B::Barcelona
BA::Badajoz
BI::Vizcaya
BU::Burgos
C::La Coruña
CA::Cádiz
CC::Cáceres
CE::Ceuta
CL:55:Castilla y León
CM:54:Castilla-La Mancha
CN:53:Canarias
CO::Córdoba
CR::Ciudad Real
CS::Castellón
CT:56:Cataluña
CU::Cuenca
EX:57:Extremadura
GA:58:Galicia
GC::Las Palmas
GE::Girona [Gerona]
GR::Granada
GU::Guadalajara
H::Huelva
HU::Huesca
J::Jaén
L::Lleida [Lérida]
LE::León
LO:27:La Rioja
LU::Lugo
M:29:Madrid
MA::Málaga
ML::Melilla
MU:31:Murcia
NA:32:Navarra
O:34:Asturias
OR::Orense
P::Palencia
PM:07:Islas Baleares
PO::Pontevedra
PV:59:País Vasco
S:39:Cantabria
SA::Salamanca
SE::Sevilla
SG::Segovia
SO::Soria
SS::Guipúzcoa
T::Tarragona
TE::Teruel
TF::Santa Cruz de Tenerife
TO::Toledo
V:60:Valencia
VA::Valladolid
VC::Valenciana, Comunidad
VI::Álava
Z::Zaragoza
ZA::Zamora



Country=SOLOMON ISLANDS
SubCountryType=Province
Code=SB

CT::Capital Territory (Honiara)
CE:05:Central
GU:06:Guadalcanal
IS:07:Isabel
MK:08:Makira
ML:03:Malaita
TE:09:Temotu
WE:04:Western

Country=SUDAN
SubCountryType=State
Code=SD

23:35:A'alî an Nîl
26::Al Bah al Ahmar
18:37:Al Buhayrat
07:38:Al Jazirah
03:29:Al Khartum
06:39:Al Qadarif
22:40:Al Wahdah
04::An Nil
08::An Nil al Abyaq
24:42:An Nil al Azraq
01:43:Ash Shamallyah
17:44:Bahr al Jabal
16:45:Gharb al Istiwa'îyah
14::Gharb Bañr al Ghazal
12:47:Gharb Darfur
10:48:Gharb Kurdufan
11:49:Janub Darfur
13:50:Janûb Rurdufan
20:51:Jünqall
05:52:Kassala
15::Shamal Batr al Ghazal
02:55:Shamal Darfùr
09:56:Shamal Kurdufan
19:57:Sharq al Istiwa'iyah
25:58:Sinnar
21:59:Warab

Country=SWEDEN
SubCountryType=Province
Code=SE

K:02:Blekinge län
W:10:Dalarnas län
I:05:Gotlands län
X:03:Gävleborge län
N:06:Hallands län
Z:07:Jamtlande län
F:08:Jonkopings län
H:09:Kalmar län
G:12:Kronoberge län
BD:14:Norrbottena län
M:27:Skåne län
AB:26:Stockholms län
D:18:Södermanlands län
C:21:Uppsala län
S:22:Värmlanda län
AC:23:Västerbottens län
Y:24:Västernorrlands län
U:25:Västmanlanda län
Q::Västra Gotalands län
T:15:Örebro län
E:16:Östergotlands län

Country=SAINT HELENA
SubCountryType=Dependancy
Code=SH

SH:02:Saint Helena
AC:01:Ascension
TA:03:Tristan da Cunha

Country=SLOVENIA
SubCountryType=Region
Code=SI

07::Dolenjska
09::Gorenjska
11::Goriska
03::Koroéka
10::Notranjsko-kraéka
12::Obalno-krañka
08::Osrednjeslovenska
02::Podravska
01:79:Pomurska
04::Savinjska
06::Spodnjeposavska
05::Zasavska

Country=SLOVAKIA
SubCountryType=Region
Code=SK

BC::Banskobyatricky kraj
BL::Bratislavsky kraj
KI::Kolicky kraj
NJ::Nitrianaky kraj
PV::Prebovaky kraj
TC::Trenciansky kraj
TA::Trnavaky kraj
ZI::Zilinaky kraj

Country=SIERRA LEONE
SubCountryType=Province
Code=SL

W::western Area (Freetown)
E:01:Eastern
N:02:Northern
S:03:Southern

Country=SENEGAL
SubCountryType=Region
Code=SN

DK:01:Dakar
DB:03:Diourbel
FK:09:Fatick
KL:10:Kaolack
KD:11:Kolda
LG:08:Louga
SL:04:Saint-Louis
TC:05:Tambacounda
TH:07:Thiès
ZG:12:Ziguinchor

Country=SOMALIA
SubCountryType=Region
Code=SO

AW::Awdal
BK:01:Bakool
BN:02:Banaadir
BR:03:Bari
BY:04:Bay
GA:05:Galguduud
GE:06:Gedo
HI:07:Hiirsan
JD:08:Jubbada Dhexe
JH:09:Jubbada Hoose
MU:10:Mudug
NU:11:Nugaal
SA:12:Saneag
SD:13:Shabeellaha Dhexe
SH:14:Shabeellaha Hoose
SO::Sool
TO:15:Togdheer
WO:16:Woqooyi Galbeed

Country=KOREA, REPUBLIC OF
SubCountryType=Province
Code=KR

11:11:Seoul Teugbyeolsi
26:10:Busan Gwang'yeogsi
27:15:Daegu Gwang'yeogsi
30:19:Daejeon Gwang'yeogsi
29:18:Gwangju Gwang'yeogsi
28:12:Incheon Gwang'yeogsi
31:21:Ulsan Gwang'yeogsi
43:05:Chungcheongbugdo
44:17:Chungcheongnamdo
42:06:Gang'weondo
41:13:Gyeonggido
47:14:Gyeongsangbugdo
48:20:Gyeongsangnamdo
49:01:Jejudo
45::Jeonrabugdo
46::Jeonranamdo

Country=SURINAME
SubCountryType=District
Code=SR

BR:10:Brokopondo
CM:11:Commewijne
CR:12:Coronie
MA:13:Marowijne
NI:14:Nickerie
PR:15:Para
PM:16:Paramaribo
SA:17:Saramacca
SI:18:Sipaliwini
WA:19:Wanica

Country=SAO TOME AND PRINCIPE
SubCountryType=Province
Code=ST

P:01:Príncipe
S:02:Sao Tomé

Country=EL SALVADOR
SubCountryType=Department
Code=SV

AH:01:Ahuachapán
CA:02:Cabañas
CU:04:Cuscatlán
CH:03:Chalatenango
LI:05:La Libertad
PA:06:La Paz
UN:07:La Uniôn
MO:08:Morazán
SM:09:San Miguel
SS:10:San Salvador
SA:11:Santa Ana
SV:12:San Vicente
SO:13:Sonsonate
US:14:Usulután

Country=SYRIAN ARAB REPUBLIC
SubCountryType=Province
Code=SY

HA:01:Al Hasakah
LA:02:Al Ladhiqiyah
QU:03:Al Qunaytirah
RA:04:Ar Raqqah
SU:05:As Suwaydä'
DR:06:Dar'ã
DY:07:Dayr az Zawr
DI:13:Dimashq
HL:09:Halab
HM:10:Hamah
HI::Jim'
ID:12:Idlib
RD:08:Rif Dimashq
TA:14:Tartüs

Country=SWAZILAND
SubCountryType=District
Code=SZ

HH::Hhohho
LU::Lubombo
MA::Manzini
SH::Shiselweni

Country=TURKMENISTAN
SubCountryType=Region
Code=TM

A::Ahal
B::Balkan
D::Da'howuz
L::Lebap
M::Mary

Country=TUNISIA
SubCountryType=Governorate
Code=TN

31::Béja
13:27:Ben Arous
23:18:Bizerte
81::Gabès
71::Gafsa
32:06:Jendouba
41::Kairouan
42::Rasserine
73:31:Kebili
12::L'Ariana
33::Le Ref
53::Mahdia
82:28:Medenine
52::Moneatir
21:19:Naboul
61::Sfax
43:33:Sidi Bouxid
34:22:Siliana
51:23:Sousse
83:34:Tataouine
72:35:Tozeur
11:36:Tunis
22:37:Zaghouan

Country=TRINIDAD AND TOBAGO
SubCountryType=Region
Code=TT

CTT::Couva-Tabaquite-Talparo
DMN::Diego Martin
ETO::Eastern Tobago
PED::Penal-Debe
PRT::Princes Town
RCM::Rio Claro-Mayaro
SGE::Sangre Grande
SJL::San Juan-Laventille
SIP::Siparia
TUP::Tunapuna-Piarco
WTO::Western Tobago
ARI:01:Arima
CHA::Chaguanas
PTF::Point Fortin
POS:05:Port of Spain
SFO:10:San Fernando

Country=TAIWAN, PROVINCE OF CHINA
SubCountryType=Province
Code=TW

KHH:02:Kaohsiung
TPE:03:Taipei
CYI::Chisyi
HSZ::Hsinchu
KEE::Keelung
TXG::Taichung
TNN::Tainan
CHA::Changhua
CYI::Chiayi
HSZ::Hsinchu
HUA::Hualien
ILA::Ilan
KHH:02:Kaohsiung
MIA::Miaoli
NAN::Nantou
PEN::Penghu
PIF::Pingtung
TXG::Taichung
TNN::Tainan
TPE:03:Taipei
TTT::Taitung
TAO::Taoyuan
YUN::Yunlin

Country=TANZANIA, UNITED REPUBLIC OF
SubCountryType=Region
Code=TZ

01:01:Arusha
02::Dar-es-Salaam
03:03:Dodoma
04:04:Iringa
05::Kagera
06::Kaskazini Pemba
07::Kaskazini Unguja
08::Xigoma
09:06:Kilimanjaro
10::Rusini Pemba
11::Kusini Unguja
12:07:Lindi
13:08:Mara
14:09:Mbeya
15::Mjini Magharibi
16:10:Morogoro
17:11:Mtwara
18:12:Mwanza
19::Pwani
20:24:Rukwa
21:14:Ruvuma
22:15:Shinyanga
23:16:Singida
24:17:Tabora
25:18:Tanga

Country=TOGO
SubCountryType=Region
Code=TG

C::Centre
K::Kara
M::Maritime (Région)
P::Plateaux
S::Savannes

Country=THAILAND
SubCountryType=Province
Code=TH

10::Krung Thep Maha Nakhon Bangkok
S::Phatthaya
37:77:Amnat Charoen
15:35:Ang Thong
31:28:Buri Ram
24:44:Chachoengsao
18:32:Chai Nat
36:26:Chaiyaphum
22:48:Chanthaburi
50:02:Chiang Mai
57:03:Chiang Rai
20:46:Chon Buri
86:58:Chumphon
46:23:Kalasin
62:11:Kamphasng Phet
71:50:Kanchanaburi
40:22:Khon Kaen
81:63:Krabi
52:06:Lampang
51:05:Lamphun
42:18:Loei
16:34:Lop Buri
58:01:Mae Hong Son
44:24:Maha Sarakham
49:78:Mukdahan
26:43:Nakhon Nayok
73:53:Nakhon Pathom
48:73:Nakhon Phanom
30:27:Nakhon Ratchasima
60:16:Nakhon Sawan
80::Nakhon Si Thammarat
55:04:Nan
96:31:Narathiwat
39:79:Nong Bua Lam Phu
43:17:Nong Khai
12:38:Nonthaburi
13:39:Pathum Thani
94:69:Pattani
82:61:Phangnga
93:66:Phatthalung
56:41:Phayao
67:14:Phetchabun
76:56:Phetchaburi
66:13:Phichit
65:12:Phitsanulok
54:07:Phrae
14:36:Phra Nakhon Si Ayutthaya
83:62:Phaket
25:74:Prachin Buri
77:57:Prachuap Khiri Khan
85:59:Ranong
70:52:Ratchaburi
21:47:Rayong
45:25:Roi Et
27:80:Sa Kaeo
47:20:Sakon Nakhon
11:42:Samut Prakan
74:55:Samut Sakhon
75:54:Samut Songkhram
19:37:Saraburi
91:67:Satun
17:33:Sing Buri
33:30:Si Sa Ket
90:68:Songkhla
64:09:Sukhothai
72:51:Suphan Buri
84:60:Surat Thani
32:29:Surin
63:08:Tak
92:65:Trang
23:49:Trat
34::Ubon Ratchathani
41:76:Udon Thani
61:15:Uthai Thani
53:10:Uttaradit
95:70:Yala
35:72:Yasothon

Country=TAJIKISTAN
SubCountryType=Region
Code=TJ

KR::Karategin
KT:02:Khatlon
LN:03:Leninabad
GB::Gorno-Badakhshan


Country=TURKEY
SubCountryType=Department
Code=TR

01:81:Adana
02:02:Adiyaman
03:03:Afyon
04:04:Agri
68:75:Aksaray
05:05:Amasya
06:68:Ankara
07:07:Antalya
75:86:Ardahan
08:08:Artvin
09:09:Aydin
10:10:Balikesir
74:87:Bartin
72:76:Batman
69:77:Bayburt
11:11:Bilecik
12:12:Bingöl
13:13:Bitlis
14:14:Bolu
15:15:Burdur
16:16:Bursa
17:17:Çanakkale
18:82:Çankiri
19:19:Çorum
20:20:Denizli
21:21:Diyarbakir
22:22:Edirne
23:23:Elazig
24:24:Erzincan
25:25:Erzurum
26:26:Eskisehir
27:83:Gaziantep
28:28:Giresun
29:69:Gümüshane
30:70:Hakkâri
31:31:Hatay
76:88:Igdir
32:33:Isparta
33:32:Içel
34:34:Istanbul
35:35:Izmir
46:46:Kahramanmaras
78:89:Karabük
70:78:Karaman
36:84:Kars
37:37:Kastamonu
38:38:Kayseri
71:79:Kirikkale
39:39:Kirklareli
40:40:Kirsehir
79:90:Kilis
41:41:Kocaeli
42:71:Konya
43:43:Kütahya
44:44:Malatya
45:45:Manisa
47:72:Mardin
48:48:Mugla
49:49:Mus
50:50:Nevsehir
51:73:Nigde
52:52:Ordu
80:91:Osmaniye
53:53:Rize
54:54:Sakarya
55:55:Samsun
56:74:Siirt
57:57:Sinop
58:58:Sivas
63:63:Sanliurfa
73:80:Sirnak
59:59:Tekirdag
60:60:Tokat
61:61:Trabzon
62:62:Tunceli
64:64:Usak
65:65:Van
77:92:Yalova
66:66:Yozgat
67:85:Zonguldak


Country=UKRAINE
SubCountryType=Region
Code=UA

71:01:Cherkas'ka Oblast'
74:02:Chernihivs'ka Oblast'
77:03:Chernivets'ka Oblast'
12:04:Dnipropetrovs'ka Oblast'
14:05:Donets'ka Oblast'
26:06:Ivano-Frankivs'ka Oblast'
63:07:Kharkivs'ka Oblast'
65:08:Khersons'ka Oblast'
68:09:Khmel'nyts'ka Oblast'
35:10:Kirovohrads'ka Oblast'
32:13:Kyivs'ka Oblast'
09:14:Luhans'ka Oblast'
46:15:L'vivs'ka Oblast'
48::Mykolaivs'ka Oblast'
51:17:Odes 'ka Oblast'
53:18:Poltavs'ka Oblast'
56:19:Rivnens'ka Oblast'
59:21:Sums 'ka Oblast'
61:22:Ternopil's'ka Oblast'
05:23:Vinnyts'ka Oblast'
07::Volyos'ka Oblast'
21:25:Zakarpats'ka Oblast'
23:26:Zaporiz'ka Oblast'
18:27:Zhytomyrs'ka Oblast'
43:11:Respublika Krym
30::Kyïv
40:20:Sevastopol'

Country=UGANDA
SubCountryType=District
Code=UG

APA:26:Apac
ARU:27:Arua
BUN:28:Bundibugyo
BUS:29:Bushenyi
GUL:30:Gulu
HOI:31:Hoima
IGA:68:Iganga
JIN:33:Jinja
KBL:34:Kabale
KBR:35:Kabarole
KLG:36:Kalangala
KLA:37:Kampala
KLI:38:Kamuli
KAP:39:Kapchorwa
KAS:40:Kasese
KLE:41:Kibeale
KIB:42:Kiboga
KIS:43:Kisoro
KIT:44:Kitgum
KOT:45:Kotido
KUM:46:Kumi
LIR:47:Lira
LUW:70:Luwero
MSK:71:Masaka
MSI:50:Masindi
MBL:51:Mbale
MBR:52:Mbarara
MOR:53:Moroto
MOY:72:Moyo
MPI:55:Mpigi
MUB:56:Mubende
MUK:57:Mukono
NEB:58:Nebbi
NTU:59:Ntungamo
PAL:60:Pallisa
RAK:61:Rakai
RUK:62:Rukungiri
SOR:75:Soroti
TOR:76:Tororo

Country=UNITED STATES MINOR OUTLYING ISLANDS
SubCountryType=Island
Code=UM

81::Baker Island
84::Howland Island
86::Jarvis Island
67::Johnston Atoll
89::Kingman Reef
71::Midway Islands
76::Navassa Island
95::Palmyra Atoll
79::Wake Ialand

Country=URUGUAY
SubCountryType=Department
Code=UY

AR:01:Artigsa
CA:02:Canelones
CL:03:Cerro Largo
CO:04:Colonia
DU:05:Durazno
FS:06:Flores
FD:07:Florida
LA:08:Lavalleja
MA:09:Maldonado
MO:10:Montevideo
PA:11:Paysandu
RN:12:Rio Negro
RV:13:Rivera
RO:14:Rocha
SA:15:Salto
SJ:16:San José
SO:17:Soriano
TA:18:Tacuarembo
TT:19:Treinta y Tres

Country=UZBEKISTAN
SubCountryType=Region
Code=UZ

QR::Qoraqalpoghiston Respublikasi Karakalpakstan, Respublika
AN:01:Andijon
BU:02:Bukhoro
FA:03:Farghona
JI:15:Jizzakh
KH:05:Khorazm
NG:06:Namangan
NW:07:Nawoiy
QA:08:Qashqadaryo
SA:10:Samarqand
SI:16:Sirdaryo
SU:12:Surkhondaryo
TO:14:Toshkent

Country=VENEZUELA
SubCountryType=State
Code=VE

A:25:Diatrito Federal
B:02:Anzoátegui
C:03:Apure
D:04:Aragua
E:05:Barinas
F:06:Bolívar
G:07:Carabobo
H:08:Cojedes
I:11:FalcÓn
J:12:Guârico
K:13:Lara
L:14:Mérida
M:15:Miranda
N:16:Monagas
O:17:Nueva Esparta
P:18:Portuguesa
R:19:Sucre
S:20:Tâchira
T:21:Trujillo
U:22:Yaracuy
V:23:Zulia
Z:01:Amazonas
Y:09:Delta Amacuro
W:24:Dependencias Federales

Country=VANUATU
SubCountryType=Province
Code=VU

MAP:16:Malampa
PAM:17:Pénama
SAM:13:Sanma
SEE:18:Shéfa
TAE:15:Taféa
TOB:07:Torba

Country=WALLIS AND FUTUNA ISLANDS
SubCountryType=Province
Code=WF

AA::A'ana
AL::Aiga-i-le-Tai
AT::Atua
FA::Fa'aaaleleaga
GE::Gaga'emauga
GI::Gagaifomauga
PA::Palauli
SA::Satupa'itea
TU::Tuamasaga
VF::Va'a-o-Fonoti
VS::Vaisigano

Country=SOUTH AFRICA
SubCountryType=Province
Code=ZA

EC:05:Eastern Cape
FS:03:Free State
GT:06:Gauteng
NL:02:Kwazulu-Natal
MP:07:Mpumalanga
NC:08:Northern Cape
NP:09:Northern Province
NW:10:North-West
WC:11:Western Cape

Country=SWITZERLAND
SubCountryType=Canton
Code=CH

AG:01:Aargau
AI::Appenzell Inner-Rhoden
AR::Appenzell Ausser-Rhoden
BE:05:Bern
BL:03:Basel-Landschaft
BS:04:Basel-Stadt
FR:06:Fribourg
GE:07:Genève
GL:08:Glarus
GR:09:Graubünden
JU:26:Jura
LU:11:Luzern
NE:12:Neuchatel
NW:13:Nidwalden
OW:14:Obwalden
SG:15:Sankt Gallen
SH:16:Schaffhausen
SO:18:Solothurn
SZ:17:Schwyz
TG:19:Thurgau
TI:20:Ticino
UR:21:Uri
VD:23:Vaud
VS:22:Valais
ZG:24:Zug
ZH:25:Zürich

Country=UNITED KINGDOM
SubCountryType=County
Code=GB

BEDS:A5:Bedfordshire
BERKS:C1:Berkshire
BORDER::Borders
BUCKS:B9:Buckinghamshire
CAMBS:C3:Cambridgeshire
CENT:L7:Central
CI::Channel Islands
CHESH:C5:Cheshire
CLEVE::Cleveland
CORN:C6:Cornwall
CUMB:C9:Cumbria
DERBY:D3:Derbyshire
DEVON:D4:Devonshire
DORSET:D6:Dorsetshire
DUMGAL::Dumfries & Galloway
GLAM:S3:Glamorganshire
GLOUS:E6:Gloucestershire
GRAMP::Grampian
GWYNED:Y2:Gwynedd
HANTS:F2:Hampshire
HERWOR::Herefordshire & Worcestershire
HERTS:F8:Hertfordshire
HIGHL:V3:Highland
HUMBER::Humberside
HUNTS::Huntingdonshire
IOM::Isle of Man
IOW::Isle of White
LANARKS::Lanarkshire
LANCS:H2:Lancashire
LEICS:H5:Leicestershire
LINCS:H7:Licolnshire
LOTH:I1:Lothian
MIDDX::Middlesex
NORF:I9:Norfolk
NHANTS:J1:Northamptonshire
NTHUMB:J6:Northumberland
NOTTS:J9:Nottinghamshire
OXON:K2:Oxfordshire
PEMBS:Y7:Pembrokeshire
RUTLAND:L4:Rutlandshire
SHROPS:L6:Shropshire
SOM:M3:Somersetshire
STAFFS:N1:Staffordshire
STRATH::Strathclyde
SUFF:N5:Suffolk
SUSS::Sussex
TAYS:O1:Tayside
TYNE::Tyne & Wear
WARKS:P3:Warwickshire
WILTS:P8:Wiltshire
WORCS:Q4:Worcestershire
YORK:Q5:Yorkshire

# Northern Ireland

CO ANTRIM::County Antrim
CO ARMAGH::County Armagh
CO DOWN:R9:County Down
CO DURHAM::County Durham
CO FERMANAGH::County Fermanagh
CO DERRY:S6:County Londonderry
CO TYRONE::County Tyrone

Country=UNITED STATES
SubCountryType=State
Code=US

AA::Armed Forces Americas
AE::Armed Forces Europe, Middle East, & Canada
AP::Armed Forces Pacific
AK:02:Alaska
AL:01:Alabama
AR:05:Arkansas
AS::American Samoa
AZ:04:Arizona
CA:06:California
CO:08:Colorado
CT:09:Connecticut
DC:11:District of Columbia
DE:10:Delaware
FL:12:Florida
FM::Federated States of Micronesia
GA:13:Georgia
GU::Guam
HI:15:Hawaii
IA:19:Iowa
ID:16:Idaho
IL:17:Illinois
IN:18:Indiana
KS:20:Kansas
KY:21:Kentucky
LA:22:Louisiana
MA:25:Massachusetts
MD:24:Maryland
ME:23:Maine
MH::Marshall Islands
MI:26:Michigan
MN:27:Minnesota
MO:29:Missouri
MP::Northern Mariana Islands
MS:28:Mississippi
MT:30:Montana
NC:37:North Carolina
ND:38:North Dakota
NE:31:Nebraska
NH:33:New Hampshire
NJ:34:New Jersey
NM:35:New Mexico
NV:32:Nevada
NY:36:New York
OH:39:Ohio
OK:40:Oklahoma
OR:41:Oregon
PA:42:Pennsylvania
PR::Puerto Rico
PW::Palau
RI:44:Rhode Island
SC:45:South Carolina
SD:46:South Dakota
TN:47:Tennessee
TX:48:Texas
UT:49:Utah
VA:51:Virginia
VI::Virgin Islands
VT:50:Vermont
WA:53:Washington
WV:54:West Virginia
WI:55:Wisconsin
WY:56:Wyoming

Country=VIET NAM
SubCountryType=Province
Code=VN

44:01:An Giang
43:45:Ba Ria - Vung Tau
53:72:Bac Can
54:71:Bac Giang
55:73:Bac Lieu
56:74:Bac Ninh
50:03:Ben Tre
31:46:Binh Dinh
57:75:Binh Duong
58:76:Binh Phuoc
40:47:Binh Thuan
59:77:Ca Mau
48:48:Can Tho
04:05:Cao Bang
60::Da Nang, thanh pho
33:07:Dac Lac
39:43:Dong Nai
45:09:Dong Thap
30:49:Gia Lai
03:50:Ha Giang
63:80:Ha Nam
64::Ha Noi, thu do
15:51:Ha Tay
23:52:Ha Tinh
61:79:Hai Duong
62::Hai Phong, thanh pho
14:53:Hoa Binh
65::Ho Chi Minh, thanh po [Sai Gon]
66:81:Hung Yen
34:54:Khanh Hoa
47:21:Kien Giang
28:55:Kon Tum
01:22:Lai Chau
35:23:Lam Dong
09:39:Lang Son
02:56:Lao Cai
41:24:Long An
67:82:Nam Dinh
22:58:Nghe An
18:59:Ninh Binh
36:60:Ninh Thuan
68:83:Phu Tho
32:61:Phu Yen
24:62:Quang Binh
27:84:Quang Nam
29:63:Quang Ngai
13:30:Quang Ninh
25:64:Quang Tri
52:65:Soc Trang
05:32:Son La
37:33:Tay Ninh
20:35:Thai Binh
69:85:Thai Nguyen
21:34:Thanh Hoa
26:66:Thua Thien-Hue
46:37:Tien Giang
51:67:Tra Vinh
07:68:Tuyen Quang
49:69:Vinh Long
70:86:Vinh Phuc
06:70:Yen Bai

Country=YEMEN
SubCountryType=Governorate
Code=YE

AB::Abyan
AD::Adan
BA::Al Bayda'
MU::Al Hudaydah
JA::Al Jawf
MR::Al Mahrah
MW::Al Mahwit
DH::Dhamar
HD::Hadramawt
HJ::Hajjah
IB::Ibb
LA::Lahij
MA::Ma'rib
SD::Sa'dah
SN::San'a'
SH::Shabwah
TA::Ta'izz

Country=YUGOSLAVIA
SubCountryType=Republic
Code=YU

CG::Crna Gora
SR::Srbija
KM::Kosovo-Metohija
VO::Vojvodina

Country=ZAMBIA
SubCountryType=Province
Code=ZM

02::Central
08::Copperbelt
03::Eastern
04::Luapula
09::Lusaka
05::Northern
06::North-Western
07::Southern
01::Western

Country=ZIMBABWE
SubCountryType=Province
Code=ZW

BU::Bulawayo
HA::Harare
MA::Manicaland
MC::Mashonaland Central
ME::Mashonaland East
MW::Mashonaland West
MV::Masvingo
MN::Matabeleland North
MS::Matabeleland South
MI::Midlands

