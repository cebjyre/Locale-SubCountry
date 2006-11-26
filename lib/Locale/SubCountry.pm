=head1 NAME

Locale::SubCountry - convert state, province, county etc. names to/from code

=head1 SYNOPSIS

   my $country_code = 'GB';
   my $UK = new Locale::SubCountry($country_code);
   if ( not $UK )
   {
       die "Invalid code $country_code\n"; 
   }
   elsif (  $UK->has_sub_countries )
   {
       print($UK->full_name('DGY'),"\n");           # Dumfries and Galloway
       print($UK->regional_division('DGY'),"\n");   # CT (Scotland)
   }

   my $australia = new Locale::SubCountry('AUSTRALIA');
   print($australia->country,"\n");                 # AUSTRALIA
   print($australia->country_code,"\n");            # AU

   if ( $australia->has_sub_countries )
   {
       print($australia->code('New South Wales '),"\n");     # NSW
       print($australia->full_name('S.A.'),"\n");            # South Australia
       my $upper_case = 1;
       print($australia->full_name('Qld',$upper_case),"\n"); # QUEENSLAND
       print($australia->category('NSW'),"\n");              # state
       print($australia->FIPS10_4_code('ACT'),"\n");         # 01
       print($australia->ISO3166_2_code('02'),"\n");         # NSW

       my @aus_state_names  = $australia->all_full_names;
       my @aus_code_names   = $australia->all_codes;
       my %aus_states_keyed_by_code  = $australia->code_full_name_hash;
       my %aus_states_keyed_by_name  = $australia->full_name_code_hash;

       foreach my $code ( sort keys %aus_states_keyed_by_code )
       {
          printf("%-3s : %s\n",$code,$aus_states_keyed_by_code{$code});
       }
   }
   
   # Methods for country codes and names
   
   my $world = new Locale::SubCountry::World;
   my @all_countries     = $world->all_full_names;
   my @all_country_codes = $world->all_codes;

   my %all_countries_keyed_by_name = $world->full_name_code_hash;
   my %all_country_keyed_by_code   = $world->code_full_name_hash;


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

ISO 3166-2 codes can be converted to FIPS 10-4 codes. The reverse lookup can 
also be done.

=head1 METHODS

Note that the following methods duplicate some of the functionality of the
Locale::Country module (part of the Locale::Codes bundle). They are provided
here because you may need to first access the list of available countries and
ISO 3166-1 codes, before fetching their sub country data. If you only need
access to country data, then Locale::Country should be used.

Note also the following method names are also used for sub country objects.
(interface polymorphism for the technically minded). To avoid confusion, make
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
two letter code or the full name. For example:

    AF - AFGHANISTAN
    AL - ALBANIA
    DZ - ALGERIA
    AO - ANGOLA
    AR - ARGENTINA
    AM - ARMENIA
    AU - AUSTRALIA
    AT - AUSTRIA


All forms of upper/lower case are acceptable in the country's spelling. If a
country name is supplied that the module doesn't recognised, it will die.

=head2 country

Returns the current country of a sub country object

=head2 country_code

Given a sub country object, returns the two letter ISO 3166-1 code of the country  


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

=head2 category

Given a sub country object, the C<category> method takes the ISO 3166-2 code of
a sub country and returns the sub country's category type. Examples are city,
province,state and district. The category is returned as a capitalised string, 
or "unknown" if no match is found.
 
=head2 regional_division

Given a sub country object, the C<regional_division> method takes the 
ISO 3166-2 code of a sub country and returns the sub country's 
regionional_division. This is, an alphanumeric code. The regional_division 
is returned as a capitalised string,  or "unknown" if no match is found.

=head2 has_sub_countries

Given a sub country object, the C<has_sub_countries> method returns 1 if the
current country has sub countries, or 0 if it does not. Some small countires 
such as Singapore do not have sub countries.

=head2 FIPS10_4_code

Given a sub country object, the C<FIPS_10_4_code> method takes the ISO 3166-2 code 
of a sub country and returns the sub country's FIPS 10-4 code, or the string 'unknown',
if none exists. FIPS is a standard  developed by the US government.

=head2 ISO3166_2_code

Given a sub country object, the C<ISO3166_2_code> method takes the FIPS 10-4 code 
of a sub country and returns the sub country's ISO 3166-2 code, or the string 'unknown',
if none exists.


=head2 full_name_code_hash  (for subcountry objects)

Given a sub country object, returns a hash of all full name/code pairs,
keyed by sub country name. If the country has no sub countries, returns undef.

=head2 code_full_name_hash  (for subcountry objects)

Given a sub country object, returns a hash of all code/full name pairs,
keyed by sub country code. If the country has no sub countries, returns undef.


=head2 all_full_names  (for subcountry objects)

Given a sub country object, returns an array of all sub country full names,
sorted alphabetically. If the country has no sub countries, returns undef.

=head2 all_codes  (for subcountry objects)

Given a sub country object, returns an array of all sub country ISO 3166-2 codes,
sorted alphabetically. If the country has no sub countries, returns undef.



=head1 SEE ALSO

ISO 3166-1:1997 Codes for the representation of names of countries and their 
subdivisions - Part 1: Country codes 

ISO 3166-2:1998 Codes for the representation of names of countries and their 
subdivisions - Part 2: Country subdivision code 
Also released as AS/NZS 2632.2:1999

Federal Information Processing Standards Publication 10-4
1995 April Specifications for  COUNTRIES, DEPENDENCIES, AREAS OF SPECIAL SOVEREIGNTY, 
AND THEIR PRINCIPAL ADMINISTRATIVE DIVISIONS 

L<http://www.statoids.com/statoids.html>


L<Locale::Country>,L<Lingua::EN::AddressParse>,
L<Geo::StreetAddress::US>L<Geo::PostalAddress>L<Geo::IP>

=head1 LIMITATIONS

ISO 3166-2:1998 defines all sub country codes as being up to 3 letters and/or
numbers. These codes are commonly accepted for countries like the USA
and Canada. In Australia  this method of abbreviation is not widely accepted. 
For example, the ISO code for 'New South Wales' is 'NS', but 'NSW' is the  
abbreviation that is most commonly used. I could add a flag to enforce 
ISO-3166-2 codes if needed.

The ISO 3166-2 standard romanizes the names of provinces and regions in non-latin
script areas, such as Russia and South Korea. One Romanisation is given for each
province name. For Russia, the BGN (1947) Romanization is used.

Several sub country names have more than one code, and may not return
the correct code for that sub country. These entries are usually duplicated
because the name represents two different types of sub country, such as a
province and a geographical unit. Examples are:

    AZERBAIJAN : L�nk�ran; LA (the City), LAN (the Rayon)
    AZERBAIJAN : S�ki; SA,SAK
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


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimryan at cpan dot org>.


=head1 CREDITS

Alastair McKinstry provided many of the sub country codes and names.

Terrence Brannon produced Locale::US, which was the starting point for
this module. 

Mark Summerfield and Guy Fraser provided the list of UK counties.

TJ Mather supplied the FIPS codes and many ammendments to the sub country data


=head1 COPYRIGHT AND LICENSE

Copyright (c) 2006 Kim Ryan. All rights reserved.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.


=cut

#-------------------------------------------------------------------------------

use strict;
use locale;

use Exporter;

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

our $VERSION = '1.38';


#-------------------------------------------------------------------------------
# Initialization code must be run first to create global data structure.
# Read in the list of abbreviations and full names defined in the __DATA__ 
# block at the bottom of this file.

{
    while ( my $current_line = <DATA> )
    {
        chomp($current_line);

        my ($country_name,$country_code);
        if ( $current_line eq '<country>' )
        {
            my $country_finished = 0;
            until ( $country_finished )
            {
                $current_line = <DATA>;
                if ( $current_line =~ /\s*<name>(.*)<\/name>/ )
                {
                    $country_name = $1;
                }
                elsif ( $current_line =~ /\s*<code>(.*)<\/code>/ )
                {
                    $country_code = $1;
                }
                elsif ( $current_line =~ /<subcountry>/ )
                {
                    my $sub_country_finished = 0;

                    my ($sub_country_name,$sub_country_code,$category,$regional_division,$FIPS_code);
                    until ( $sub_country_finished )
                    {
                        $current_line = <DATA>;
                        if ( $current_line =~ /\s*<name>(.*)<\/name>/ )
                        {
                            $sub_country_name = $1;
                        }
                        elsif ( $current_line =~ /\s*<code>(.*)<\/code>/ )
                        {
                            $sub_country_code = $1;
                        }
                        elsif ( $current_line =~ /\s*<FIPS>(.*)<\/FIPS>/ )
                        {
                            $FIPS_code = $1;
                        }
                        elsif ( $current_line =~ /\s*<category>(.*)<\/category>/ )
                        {
                            $category = $1;
                        }
                        elsif ( $current_line =~ /\s*<regional_division>(.*)<\/regional_division>/ )
                        {
                            $regional_division = $1;
                        }
                        elsif ( $current_line =~ /<\/subcountry>/ )
                        {
                            $sub_country_finished = 1;

                            # Insert into doubly indexed hash, grouped by country for ISO 3166-2 
                            # codes. One hash is keyed by abbreviation and one by full name. Although 
                            # data is duplicated, this provides the fastest lookup and simplest code.
            
                            $::subcountry_lookup{$country_name}{_code_keyed}{$sub_country_code} = $sub_country_name;
                            $::subcountry_lookup{$country_name}{_full_name_keyed}{$sub_country_name} = $sub_country_code;

                            if ( $category )
                            {
                                $::subcountry_lookup{$country_name}{$sub_country_code}{_category} = $category;
                            }
            
                            if ( $regional_division )
                            {
                                $::subcountry_lookup{$country_name}{$sub_country_code}{_regional_division} = $regional_division;
                            }

                            if ( $FIPS_code )
                            {
                                # Insert into doubly indexed hash, grouped by country for FIPS 10-4 codes
                                $::subcountry_lookup{$country_name}{_FIPS10_4_code_keyed}{$FIPS_code} = $sub_country_code;
                                $::subcountry_lookup{$country_name}{_ISO3166_2_code_keyed}{$sub_country_code} = $FIPS_code;
                            }
                        }
                        else
                        {
                            die "Badly formed sub country data\n$current_line $!";
                        }
                    }
                }
                elsif ( $current_line =~ /<\/country>/ )
                {
                    $country_finished = 1;

                    # Create doubly indexed hash, keyed by  country code and full name.
                    # The user can supply either form to create a new sub_country
                    # object, and the objects properties will hold both the countries
                    # name and it's code.
    
                    $::country_lookup{_code_keyed}{$country_code} = $country_name;
                    $::country_lookup{_full_name_keyed}{$country_name} = $country_code;

                }
                else
                {
                    die "Badly formed  country data : $current_line";
                }
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
          warn "Invalid country code: $country_or_code chosen";
          return(undef);
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
            warn "Invalid country name: $country_or_code chosen";
            return(undef);

        }
    }

    my $sub_country = {};
    bless($sub_country,$class);
    $sub_country->{_country} = $country;
    $sub_country->{_country_code} = $country_code;


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
# Given the ISO 3166-2 code for a sub country, return the category,
# being state, province, city, council etc

sub category
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);

    my $category = $::subcountry_lookup{$sub_country->{_country}}{$code}{_category};

    if ( $category )
    {
        return($category);
    }
    else
    {
        return('unknown');
    }
}

#-------------------------------------------------------------------------------
# Given the ISO 3166-2 code for a sub country, return the regional division,

sub regional_division
{
    my $sub_country = shift;
    my ($code) = @_;

    $code = _clean($code);

    my $regional_division = $::subcountry_lookup{$sub_country->{_country}}{$code}{_regional_division};

    if ( $regional_division )
    {
        return($regional_division);
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
# Returns 1 if the current country has sub countries. otherwise 0.

sub has_sub_countries
{
    my $sub_country = shift;
    if ( $::subcountry_lookup{$sub_country->{_country}}{_code_keyed} )
    {
        return(1);
    }
    else
    {
        return(0);
    }
}
#-------------------------------------------------------------------------------
# Returns a hash of code/full name pairs, keyed by sub country code.

sub code_full_name_hash
{
    my $sub_country = shift;
    if ( $sub_country->has_sub_countries )
    {
        return( %{ $::subcountry_lookup{$sub_country->{_country}}{_code_keyed} } );
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns a hash of name/code pairs, keyed by sub country name.

sub full_name_code_hash
{
    my $sub_country = shift;
    if ( $sub_country->has_sub_countries )
    {
        return( %{ $::subcountry_lookup{$sub_country->{_country}}{_full_name_keyed} } );
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country full names for the current country

sub all_full_names
{
    my $sub_country = shift;
    if ( $sub_country->full_name_code_hash )
    {
        my %all_full_names = $sub_country->full_name_code_hash;
        if ( %all_full_names )
        {
            return( sort keys %all_full_names );
        }
    }
    else
    {
        return(undef);
    }
}
#-------------------------------------------------------------------------------
# Returns sorted array of all sub country ISO 3166-2 codes for the current country

sub all_codes
{
    my $sub_country = shift;

    if ( $sub_country->code_full_name_hash )
    {
        my %all_codes = $sub_country->code_full_name_hash;
        return( sort keys %all_codes );
    }
    else
    {
        return(undef);
    }
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

# Code/Sub country data in XML format. Read in at start up by first unnamed block.

__DATA__
<?xml version="1.0" encoding="ISO-8859-1" standalone="yes"?>
<ISO_3166_2>

<country>
  <name>GUATEMALA</name>
  <code>GT</code>
  <subcountry>
    <name>Alta Verapaz</name>
    <code>AV</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Baja Verapaz</name>
    <code>BV</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chimaltenango</name>
    <code>CM</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiquimula</name>
    <code>CQ</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>El Progreso</name>
    <code>PR</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Escuintla</name>
    <code>ES</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Guatemala</name>
    <code>GU</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Huehuetenango</name>
    <code>HU</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Izabal</name>
    <code>IZ</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Jalapa</name>
    <code>JA</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Jutiapa</name>
    <code>JU</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Pet�n</name>
    <code>PE</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Quetzaltenango</name>
    <code>QZ</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Quich�</name>
    <code>QC</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Retalhuleu</name>
    <code>RE</code>
  </subcountry>
  <subcountry>
    <name>Sacatep�quez</name>
    <code>SA</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>San Marcos</name>
    <code>SM</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Rosa</name>
    <code>SR</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Solol�</name>
    <code>SO</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Suchitep�quez</name>
    <code>SU</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Totonicap�n</name>
    <code>TO</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Zacapa</name>
    <code>ZA</code>
    <FIPS>22</FIPS>
  </subcountry>
</country>

<country>
  <name>GUINEA BISSAU</name>
  <code>GW</code>
  <subcountry>
    <name>Bissau</name>
    <code>BS</code>
    <category>autonomous sector</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Bafat�</name>
    <code>BA</code>
    <regional_division>L</regional_division>
    <category>region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Biombo</name>
    <code>BM</code>
    <regional_division>N</regional_division>
    <category>region</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Bolama</name>
    <code>BL</code>
    <regional_division>S</regional_division>
    <category>region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cacheu</name>
    <code>CA</code>
    <regional_division>N</regional_division>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Gab�</name>
    <code>GA</code>
    <regional_division>L</regional_division>
    <category>region</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Oio</name>
    <code>OI</code>
    <regional_division>N</regional_division>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Quinara</name>
    <code>QU</code>
    <regional_division>S</regional_division>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Tombali</name>
    <code>TO</code>
    <regional_division>S</regional_division>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
</country>


<country>
  <name>HONDURAS</name>
  <code>HN</code>
  <subcountry>
    <name>Atl�ntida</name>
    <code>AT</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Col�n</name>
    <code>CL</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Comayagua</name>
    <code>CM</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Cop�n</name>
    <code>CP</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cort�s</name>
    <code>CR</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Choluteca</name>
    <code>CH</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>El Para�so</name>
    <code>EP</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Francisco Moraz�n</name>
    <code>FM</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Gracias a Dios</name>
    <code>GD</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Intibuc�</name>
    <code>IN</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Islas de la Bah�a</name>
    <code>IB</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>La Paz</name>
    <code>LP</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Lempira</name>
    <code>LE</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Olancho</name>
    <code>OL</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa B�rbara</name>
    <code>SB</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Valle</name>
    <code>VA</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Yoro</name>
    <code>YO</code>
    <FIPS>18</FIPS>
  </subcountry>
</country>

<country>
  <name>CROATIA</name>
  <code>HR</code>
  <subcountry>
    <name>Grad Zagreb</name>
    <code>21</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Bjelovarsko-bilogorska</name>
    <code>07</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Brodsko-posavska</name>
    <code>12</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Dubrovacko-neretvanska</name>
    <code>19</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Istarska</name>
    <code>18</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Karlovacka</name>
    <code>04</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Koprivnicko-kri�evacka</name>
    <code>06</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Krapinsko-zagorska</name>
    <code>02</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Licko-senjska</name>
    <code>09</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Medimurska</name>
    <code>20</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Osjecko-baranjska</name>
    <code>14</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Po�e�ko-slavonska</name>
    <code>11</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Primorsko-goranska</name>
    <code>08</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Sisacko-moslavacka</name>
    <code>03</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Splitsko-dalmatinska</name>
    <code>17</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>�ibensko-kninska</name>
    <code>15</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Vara�dinska</name>
    <code>05</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Viroviticko-podravska</name>
    <code>10</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Vukovarsko-srijemska</name>
    <code>16</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>Zadarska</name>
    <code>13</code>
    <category>county</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Zagrebacka</name>
    <code>01</code>
    <category>county</category>
  </subcountry>
</country>

<country>
  <name>GUYANA</name>
  <code>GY</code>
  <subcountry>
    <name>Barima-Waini</name>
    <code>BA</code>
    <FIPS>10</FIPS>
  </subcountry>
</country>


<country>
  <name>HAITI</name>
  <code>HT</code>
  <subcountry>
    <name>Artibonite</name>
    <code>AR</code>
  </subcountry>
  <subcountry>
    <name>Centre</name>
    <code>CE</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Grande-Anse</name>
    <code>GA</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Nord</name>
    <code>ND</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Nord-Est</name>
    <code>NE</code>
  </subcountry>
  <subcountry>
    <name>Nord-Ouest</name>
    <code>NO</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouest</name>
    <code>OU</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Sud</name>
    <code>SD</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Sud-Est</name>
    <code>SE</code>
    <FIPS>13</FIPS>
  </subcountry>
</country>

<country>
  <name>HUNGARY</name>
  <code>HU</code>
  <subcountry>
    <name>Budapest</name>
    <code>BU</code>
    <category>capital city</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>B�cs-Kiskun</name>
    <code>BK</code>
    <category>county</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Baranya</name>
    <code>BA</code>
    <category>county</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>B�k�s</name>
    <code>BE</code>
    <category>county</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Borsod-Aba�j-Zempl�n</name>
    <code>BZ</code>
    <category>county</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Csongr�d</name>
    <code>CS</code>
    <category>county</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Fej�r</name>
    <code>FE</code>
    <category>county</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Gyor-Moson-Sopron</name>
    <code>GS</code>
    <category>county</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Hajd�-Bihar</name>
    <code>HB</code>
    <category>county</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Heves</name>
    <code>HE</code>
    <category>county</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>J�sz-Nagykun-Szolnok</name>
    <code>JN</code>
    <category>county</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Kom�rom-Esztergom</name>
    <code>KE</code>
    <category>county</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>N�gr�d</name>
    <code>NO</code>
    <category>county</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Pest</name>
    <code>PE</code>
    <category>county</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Somogy</name>
    <code>SO</code>
    <category>county</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Szabolcs-Szatm�r-Bereg</name>
    <code>SZ</code>
    <category>county</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Tolna</name>
    <code>TO</code>
    <category>county</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Vas</name>
    <code>VA</code>
    <category>county</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Veszpr�m</name>
    <code>VE</code>
    <category>county</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Zala</name>
    <code>ZA</code>
    <category>county</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>B�k�scsaba</name>
    <code>BC</code>
    <category>city of county right</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Debrecen</name>
    <code>DE</code>
    <category>city of county right</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Duna�jv�ros</name>
    <code>DU</code>
    <category>city of county right</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Eger</name>
    <code>EG</code>
    <category>city of county right</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Gyor</name>
    <code>GY</code>
    <category>city of county right</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>H�dmezov�s�rhely</name>
    <code>HV</code>
    <category>city of county right</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaposv�r</name>
    <code>KV</code>
    <category>city of county right</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Kecskem�t</name>
    <code>KM</code>
    <category>city of county right</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Miskolc</name>
    <code>MI</code>
    <category>city of county right</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Nagykanizsa</name>
    <code>NK</code>
    <category>city of county right</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Ny�regyh�za</name>
    <code>NY</code>
    <category>city of county right</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>P�cs</name>
    <code>PS</code>
    <category>city of county right</category>
  </subcountry>
  <subcountry>
    <name>Salg�tarj�n</name>
    <code>ST</code>
    <category>city of county right</category>
  </subcountry>
  <subcountry>
    <name>Sopron</name>
    <code>SN</code>
    <category>city of county right</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Szeged</name>
    <code>SD</code>
    <category>city of county right</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Sz�kesfeh�rv�r</name>
    <code>SF</code>
    <category>city of county right</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Szeksz�rd</name>
    <code>SS</code>
    <category>city of county right</category>
  </subcountry>
  <subcountry>
    <name>Szolnok</name>
    <code>SK</code>
    <category>city of county right</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Szombathely</name>
    <code>SH</code>
    <category>city of county right</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Tatab�nya</name>
    <code>TB</code>
    <category>city of county right</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Veszpr�m</name>
    <code>VM</code>
    <category>city of county right</category>
  </subcountry>
  <subcountry>
    <name>Zalaegerszeg</name>
    <code>ZE</code>
    <category>city of county right</category>
    <FIPS>40</FIPS>
  </subcountry>
</country>

<country>
  <name>INDONESIA</name>
  <code>ID</code>
  <subcountry>
    <name>Bali</name>
    <code>BA</code>
    <regional_division>NU</regional_division>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Bangka Belitung</name>
    <code>BB</code>
    <regional_division>SM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Banten</name>
    <code>BT</code>
    <regional_division>JW</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Bengkulu</name>
    <code>BE</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Gorontalo</name>
    <code>GO</code>
    <regional_division>SL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Jambi</name>
    <code>JA</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Jawa Barat</name>
    <code>JB</code>
    <regional_division>JW</regional_division>
    <category>province</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Jawa Tengah</name>
    <code>JT</code>
    <regional_division>JW</regional_division>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Jawa Timur</name>
    <code>JI</code>
    <regional_division>JW</regional_division>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalimantan Barat</name>
    <code>KB</code>
    <regional_division>KA</regional_division>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalimantan Selatan</name>
    <code>KS</code>
    <regional_division>KA</regional_division>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalimantan Tengah</name>
    <code>KT</code>
    <regional_division>KA</regional_division>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalimantan Timur</name>
    <code>KI</code>
    <regional_division>KA</regional_division>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Lampung</name>
    <code>LA</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Maluku</name>
    <code>MA</code>
    <regional_division>MA</regional_division>
    <category>province</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Maluku Utara</name>
    <code>MU</code>
    <regional_division>MA</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Nusa Tenggara Barat</name>
    <code>NB</code>
    <regional_division>NU</regional_division>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Nusa Tenggara Timur</name>
    <code>NT</code>
    <regional_division>NU</regional_division>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Papua</name>
    <code>PA</code>
    <regional_division>IJ</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Riau</name>
    <code>RI</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Sulawesi Selatan</name>
    <code>SN</code>
    <regional_division>SL</regional_division>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Sulawesi Tengah</name>
    <code>ST</code>
    <regional_division>SL</regional_division>
    <category>province</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Sulawesi Tenggara</name>
    <code>SG</code>
    <regional_division>SL</regional_division>
    <category>province</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Sulawesi Utara</name>
    <code>SA</code>
    <regional_division>SL</regional_division>
    <category>province</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Sumatera Barat</name>
    <code>SB</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Sumatera Selatan</name>
    <code>SS</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Sumatera Utara</name>
    <code>SU</code>
    <regional_division>SM</regional_division>
    <category>province</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Jakarta Raya</name>
    <code>JK</code>
    <regional_division>JW</regional_division>
    <category>special district</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Aceh</name>
    <code>AC</code>
    <regional_division>SM</regional_division>
    <category>special region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Yogyakarta</name>
    <code>YO</code>
    <regional_division>JW</regional_division>
    <category>special region</category>
    <FIPS>10</FIPS>
  </subcountry>
</country>

<country>
  <name>IRELAND</name>
  <code>IE</code>
  <subcountry>
    <name>Carlow</name>
    <code>CW</code>
    <regional_division>L</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Cavan</name>
    <code>CN</code>
    <regional_division>U</regional_division>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Clare</name>
    <code>CE</code>
    <regional_division>M</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Cork</name>
    <code>C</code>
    <regional_division>M</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Donegal</name>
    <code>DL</code>
    <regional_division>U</regional_division>
  </subcountry>
  <subcountry>
    <name>Dublin</name>
    <code>D</code>
    <regional_division>L</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Galway</name>
    <code>G</code>
    <regional_division>C</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Kerry</name>
    <code>KY</code>
    <regional_division>M</regional_division>
  </subcountry>
  <subcountry>
    <name>Kildare</name>
    <code>KE</code>
    <regional_division>L</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Kilkenny</name>
    <code>KK</code>
    <regional_division>L</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Laois</name>
    <code>LS</code>
    <regional_division>L</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Leitrim</name>
    <code>LM</code>
    <regional_division>C</regional_division>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Limerick</name>
    <code>LK</code>
    <regional_division>M</regional_division>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Longford</name>
    <code>LD</code>
    <regional_division>L</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Louth</name>
    <code>LH</code>
    <regional_division>L</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Mayo</name>
    <code>MO</code>
    <regional_division>C</regional_division>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Meath</name>
    <code>MH</code>
    <regional_division>L</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Monaghan</name>
    <code>MN</code>
    <regional_division>U</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Offaly</name>
    <code>OY</code>
    <regional_division>L</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Roscommon</name>
    <code>RN</code>
    <regional_division>C</regional_division>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Sligo</name>
    <code>SO</code>
    <regional_division>C</regional_division>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Tipperary</name>
    <code>TA</code>
    <regional_division>M</regional_division>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Waterford</name>
    <code>WD</code>
    <regional_division>M</regional_division>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Westmeath</name>
    <code>WH</code>
    <regional_division>L</regional_division>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Wexford</name>
    <code>WX</code>
    <regional_division>L</regional_division>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Wicklow</name>
    <code>WW</code>
    <regional_division>L</regional_division>
    <FIPS>31</FIPS>
  </subcountry>
</country>

<country>
  <name>ISRAEL</name>
  <code>IL</code>
  <subcountry>
    <name>HaDarom</name>
    <code>D</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>HaMerkaz</name>
    <code>M</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha Z_afon</name>
    <code>Z</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Hefa</name>
    <code>HA</code>
  </subcountry>
  <subcountry>
    <name>Tel-Aviv</name>
    <code>TA</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Yerushalayim</name>
    <code>JM</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>INDIA</name>
  <code>IN</code>
  <subcountry>
    <name>Andhra Pradesh</name>
    <code>AP</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Arunachal Pradesh</name>
    <code>AR</code>
    <category>state</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Assam</name>
    <code>AS</code>
    <category>state</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bihar</name>
    <code>BR</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Chhattisgarh</name>
    <code>CT</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Goa</name>
    <code>GA</code>
    <category>state</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Gujarat</name>
    <code>GJ</code>
    <category>state</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Haryana</name>
    <code>HR</code>
    <category>state</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Himachal Pradesh</name>
    <code>HP</code>
    <category>state</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Jammu and Kashmir</name>
    <code>JK</code>
    <category>state</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Jharkhand</name>
    <code>JH</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Karnataka</name>
    <code>KA</code>
    <category>state</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Kerala</name>
    <code>KL</code>
    <category>state</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Madhya Pradesh</name>
    <code>MP</code>
    <category>state</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Maharashtra</name>
    <code>MH</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Manipur</name>
    <code>MN</code>
    <category>state</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Meghalaya</name>
    <code>ML</code>
    <category>state</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Mizoram</name>
    <code>MZ</code>
    <category>state</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Nagaland</name>
    <code>NL</code>
    <category>state</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Orissa</name>
    <code>OR</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Punjab</name>
    <code>PB</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Rajasthan</name>
    <code>RJ</code>
    <category>state</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Sikkim</name>
    <code>SK</code>
    <category>state</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Tamil Nadu</name>
    <code>TN</code>
    <category>state</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Tripura</name>
    <code>TR</code>
    <category>state</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Uttaranchal</name>
    <code>UL</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Uttar Pradesh</name>
    <code>UP</code>
    <category>state</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>West Bengal</name>
    <code>WB</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Andaman and Nicobar Islands</name>
    <code>AN</code>
    <category>union territory</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Chandigarh</name>
    <code>CH</code>
    <category>union territory</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Dadra and Nagar Haveli</name>
    <code>DN</code>
    <category>union territory</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Daman and Diu</name>
    <code>DD</code>
    <category>union territory</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Delhi</name>
    <code>DL</code>
    <category>union territory</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Lakshadweep</name>
    <code>LD</code>
    <category>union territory</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Pondicherry</name>
    <code>PY</code>
    <category>union territory</category>
    <FIPS>22</FIPS>
  </subcountry>
</country>

<country>
  <name>IRAQ</name>
  <code>IQ</code>
  <subcountry>
    <name>Al Anbar</name>
    <code>AN</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Basrah</name>
    <code>BA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Muthann�</name>
    <code>MU</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qadisiyah</name>
    <code>QA</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>An Najaf</name>
    <code>NA</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Arbil</name>
    <code>AR</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>As Sulaymaniyah</name>
    <code>SU</code>
  </subcountry>
  <subcountry>
    <name>At Ta'mim</name>
    <code>TS</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Babil</name>
    <code>BB</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Baghdad</name>
    <code>BG</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Dahuk</name>
    <code>DA</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Dhi Qar</name>
    <code>DQ</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Diyal�</name>
    <code>DI</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Karbala'</name>
    <code>KA</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Maysan</name>
    <code>MA</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Ninaw�</name>
    <code>NI</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Salah ad Din</name>
    <code>SD</code>
  </subcountry>
  <subcountry>
    <name>Wasit</name>
    <code>WA</code>
    <FIPS>16</FIPS>
  </subcountry>
</country>

<country>
  <name>IRAN (ISLAMIC REPUBLIC OF)</name>
  <code>IR</code>
  <subcountry>
    <name>Ardabil</name>
    <code>03</code>
  </subcountry>
  <subcountry>
    <name>West Azarbayjan</name>
    <code>02</code>
  </subcountry>
  <subcountry>
    <name>East Azarbayjan</name>
    <code>01</code>
  </subcountry>
  <subcountry>
    <name>Bushehr</name>
    <code>06</code>
  </subcountry>
  <subcountry>
    <name>Chahar Mahall and Bakhtiari</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Esfahan</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>Fars</name>
    <code>14</code>
  </subcountry>
  <subcountry>
    <name>Gilan</name>
    <code>19</code>
  </subcountry>
  <subcountry>
    <name>Golestan</name>
    <code>27</code>
  </subcountry>
  <subcountry>
    <name>Hamadan</name>
    <code>24</code>
  </subcountry>
  <subcountry>
    <name>Hormozgan</name>
    <code>23</code>
  </subcountry>
  <subcountry>
    <name>Ilam</name>
    <code>05</code>
  </subcountry>
  <subcountry>
    <name>Kerman</name>
    <code>15</code>
  </subcountry>
  <subcountry>
    <name>Kermanshah</name>
    <code>17</code>
  </subcountry>
  <subcountry>
    <name>Khorasan</name>
    <code>09</code>
  </subcountry>
  <subcountry>
    <name>Khuzestan</name>
    <code>10</code>
  </subcountry>
  <subcountry>
    <name>Kohkiluyeh and Buyer Ahmad</name>
    <code>18</code>
  </subcountry>
  <subcountry>
    <name>Kordestan</name>
    <code>16</code>
  </subcountry>
</country>

<country>
  <name>EQUATORIAL GUINEA</name>
  <code>GQ</code>
  <subcountry>
    <name>Regi�n Continental</name>
    <code>C</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Regi�n Insular</name>
    <code>I</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Annob�n</name>
    <code>AN</code>
    <regional_division>I</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Bioko Norte</name>
    <code>BN</code>
    <regional_division>I</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Bioko Sur</name>
    <code>BS</code>
    <regional_division>I</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Centro Sur</name>
    <code>CS</code>
    <regional_division>C</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Kie-Ntem</name>
    <code>KN</code>
    <regional_division>C</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Litoral</name>
    <code>LI</code>
    <regional_division>C</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Wele-Nz�s</name>
    <code>WN</code>
    <regional_division>C</regional_division>
    <category>province</category>
  </subcountry>
</country>

<country>
  <name>GREECE</name>
  <code>GR</code>
  <subcountry>
    <name>Acha�a</name>
    <code>13</code>
    <regional_division>VII</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Aitolia-Akarnania</name>
    <code>01</code>
    <regional_division>VII</regional_division>
    <category>department</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Argolis</name>
    <code>11</code>
    <regional_division>X</regional_division>
    <category>department</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Arkadia</name>
    <code>12</code>
    <regional_division>X</regional_division>
    <category>department</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Arta</name>
    <code>31</code>
    <regional_division>IV</regional_division>
    <category>department</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Attiki</name>
    <code>A1</code>
    <regional_division>IX</regional_division>
    <category>department</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Chalkidiki</name>
    <code>64</code>
    <regional_division>II</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Chania</name>
    <code>94</code>
    <regional_division>XIII</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Chios</name>
    <code>85</code>
    <regional_division>XI</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Dodekanisos</name>
    <code>81</code>
    <regional_division>XII</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Drama</name>
    <code>52</code>
    <regional_division>I</regional_division>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Evros</name>
    <code>71</code>
    <regional_division>I</regional_division>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Evrytania</name>
    <code>05</code>
    <regional_division>VIII</regional_division>
    <category>department</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Evvoia</name>
    <code>04</code>
    <regional_division>VIII</regional_division>
    <category>department</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Florina</name>
    <code>63</code>
    <regional_division>III</regional_division>
    <category>department</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Fokis</name>
    <code>07</code>
    <regional_division>VIII</regional_division>
    <category>department</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Fthiotis</name>
    <code>06</code>
    <regional_division>VIII</regional_division>
    <category>department</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Grevena</name>
    <code>51</code>
    <regional_division>III</regional_division>
    <category>department</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Ileia</name>
    <code>14</code>
    <regional_division>VII</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Imathia</name>
    <code>53</code>
    <regional_division>II</regional_division>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Ioannina</name>
    <code>33</code>
    <regional_division>IV</regional_division>
    <category>department</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Irakleion</name>
    <code>91</code>
    <regional_division>XIII</regional_division>
    <category>department</category>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Karditsa</name>
    <code>41</code>
    <regional_division>V</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Kastoria</name>
    <code>56</code>
    <regional_division>III</regional_division>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Kavalla</name>
    <code>55</code>
    <regional_division>I</regional_division>
    <category>department</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Kefallinia</name>
    <code>23</code>
    <regional_division>VI</regional_division>
    <category>department</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Kerkyra</name>
    <code>22</code>
    <regional_division>VI</regional_division>
    <category>department</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Kilkis</name>
    <code>57</code>
    <regional_division>II</regional_division>
    <category>department</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Korinthia</name>
    <code>15</code>
    <regional_division>X</regional_division>
    <category>department</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Kozani</name>
    <code>58</code>
    <regional_division>III</regional_division>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Kyklades</name>
    <code>82</code>
    <regional_division>XII</regional_division>
    <category>department</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Lakonia</name>
    <code>16</code>
    <regional_division>X</regional_division>
    <category>department</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Larisa</name>
    <code>42</code>
    <regional_division>V</regional_division>
    <category>department</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Lasithion</name>
    <code>92</code>
    <regional_division>XIII</regional_division>
    <category>department</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Lefkas</name>
    <code>24</code>
    <regional_division>VI</regional_division>
    <category>department</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Lesvos</name>
    <code>83</code>
    <regional_division>XI</regional_division>
    <category>department</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Magnisia</name>
    <code>43</code>
    <regional_division>V</regional_division>
    <category>department</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Messinia</name>
    <code>17</code>
    <regional_division>X</regional_division>
    <category>department</category>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Pella</name>
    <code>59</code>
    <regional_division>II</regional_division>
    <category>department</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Pieria</name>
    <code>61</code>
    <regional_division>II</regional_division>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Preveza</name>
    <code>34</code>
    <regional_division>IV</regional_division>
    <category>department</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Rethymnon</name>
    <code>93</code>
    <regional_division>XIII</regional_division>
    <category>department</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Rodopi</name>
    <code>73</code>
    <regional_division>I</regional_division>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Samos</name>
    <code>84</code>
    <regional_division>XI</regional_division>
    <category>department</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Serrai</name>
    <code>62</code>
    <regional_division>II</regional_division>
    <category>department</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Thesprotia</name>
    <code>32</code>
    <regional_division>IV</regional_division>
    <category>department</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Thessaloniki</name>
    <code>54</code>
    <regional_division>II</regional_division>
    <category>department</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Trikala</name>
    <code>44</code>
    <regional_division>V</regional_division>
    <category>department</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Voiotia</name>
    <code>03</code>
    <regional_division>VIII</regional_division>
    <category>department</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Xanthi</name>
    <code>72</code>
    <regional_division>I</regional_division>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Zakynthos</name>
    <code>21</code>
    <regional_division>VI</regional_division>
    <category>department</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Agio Oros</name>
    <code>69</code>
    <category>self-governed part</category>
  </subcountry>
</country>

<country>
  <name>IRAN (ISLAMIC REPUBLIC OF)</name>
  <code>IR</code>
  <subcountry>
    <name>Lorestan</name>
    <code>20</code>
  </subcountry>
  <subcountry>
    <name>Markazi</name>
    <code>22</code>
  </subcountry>
  <subcountry>
    <name>Mazandaran</name>
    <code>21</code>
  </subcountry>
  <subcountry>
    <name>Qazvin</name>
    <code>28</code>
  </subcountry>
  <subcountry>
    <name>Qom</name>
    <code>26</code>
  </subcountry>
  <subcountry>
    <name>Semnan</name>
    <code>12</code>
  </subcountry>
  <subcountry>
    <name>Sistan va Baluchestan</name>
    <code>13</code>
  </subcountry>
  <subcountry>
    <name>Tehran</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Yazd</name>
    <code>25</code>
  </subcountry>
  <subcountry>
    <name>Zanjan</name>
    <code>11</code>
  </subcountry>
</country>

<country>
  <name>ICELAND</name>
  <code>IS</code>
  <subcountry>
    <name>Austurland</name>
    <code>7</code>
  </subcountry>
  <subcountry>
    <name>H�fu�borgarsv��i utan Reykjav�kur</name>
    <code>1</code>
  </subcountry>
  <subcountry>
    <name>Nor�urland eystra</name>
    <code>6</code>
  </subcountry>
  <subcountry>
    <name>Nor�urland vestra</name>
    <code>5</code>
  </subcountry>
  <subcountry>
    <name>Reykjav�k</name>
    <code>0</code>
  </subcountry>
  <subcountry>
    <name>Su�urland</name>
    <code>8</code>
  </subcountry>
  <subcountry>
    <name>Su�urnes</name>
    <code>2</code>
  </subcountry>
  <subcountry>
    <name>Vestfir�ir</name>
    <code>4</code>
  </subcountry>
  <subcountry>
    <name>Vesturland</name>
    <code>3</code>
  </subcountry>
</country>

<country>
  <name>ITALY</name>
  <code>IT</code>
  <subcountry>
    <name>Agrigento</name>
    <code>AG</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Alessandria</name>
    <code>AL</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Ancona</name>
    <code>AN</code>
    <regional_division>57</regional_division>
  </subcountry>
  <subcountry>
    <name>Aosta</name>
    <code>AO</code>
    <regional_division>23</regional_division>
  </subcountry>
  <subcountry>
    <name>Arezzo</name>
    <code>AR</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Ascoli Piceno</name>
    <code>AP</code>
    <regional_division>57</regional_division>
  </subcountry>
  <subcountry>
    <name>Asti</name>
    <code>AT</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Avellino</name>
    <code>AV</code>
    <regional_division>72</regional_division>
  </subcountry>
  <subcountry>
    <name>Bari</name>
    <code>BA</code>
    <regional_division>75</regional_division>
  </subcountry>
  <subcountry>
    <name>Belluno</name>
    <code>BL</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Benevento</name>
    <code>BN</code>
    <regional_division>72</regional_division>
  </subcountry>
  <subcountry>
    <name>Bergamo</name>
    <code>BG</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Biella</name>
    <code>BI</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Bologna</name>
    <code>BO</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Bolzano</name>
    <code>BZ</code>
    <regional_division>32</regional_division>
  </subcountry>
  <subcountry>
    <name>Brescia</name>
    <code>BS</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Brindisi</name>
    <code>BR</code>
    <regional_division>75</regional_division>
  </subcountry>
  <subcountry>
    <name>Cagliari</name>
    <code>CA</code>
    <regional_division>88</regional_division>
  </subcountry>
  <subcountry>
    <name>Caltanissetta</name>
    <code>CL</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Campobasso</name>
    <code>CB</code>
    <regional_division>67</regional_division>
  </subcountry>
  <subcountry>
    <name>Caserta</name>
    <code>CE</code>
    <regional_division>72</regional_division>
  </subcountry>
  <subcountry>
    <name>Catania</name>
    <code>CT</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Catanzaro</name>
    <code>CZ</code>
    <regional_division>78</regional_division>
  </subcountry>
  <subcountry>
    <name>Chieti</name>
    <code>CH</code>
    <regional_division>65</regional_division>
  </subcountry>
  <subcountry>
    <name>Como</name>
    <code>CO</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Cosenza</name>
    <code>CS</code>
    <regional_division>78</regional_division>
  </subcountry>
  <subcountry>
    <name>Cremona</name>
    <code>CR</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Crotone</name>
    <code>KR</code>
    <regional_division>78</regional_division>
  </subcountry>
  <subcountry>
    <name>Cuneo</name>
    <code>CN</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Enna</name>
    <code>EN</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Ferrara</name>
    <code>FE</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Firenze</name>
    <code>FI</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Foggia</name>
    <code>FG</code>
    <regional_division>75</regional_division>
  </subcountry>
  <subcountry>
    <name>Forl�</name>
    <code>FO</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Frosinone </name>
    <code>FR</code>
    <regional_division>62</regional_division>
  </subcountry>
  <subcountry>
    <name>Genova</name>
    <code>GE</code>
    <regional_division>42</regional_division>
  </subcountry>
  <subcountry>
    <name>Gorizia</name>
    <code>GO</code>
    <regional_division>36</regional_division>
  </subcountry>
  <subcountry>
    <name>Grosseto</name>
    <code>GR</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Imperia</name>
    <code>IM</code>
    <regional_division>42</regional_division>
  </subcountry>
  <subcountry>
    <name>Isernia</name>
    <code>IS</code>
    <regional_division>67</regional_division>
  </subcountry>
  <subcountry>
    <name>L'Aquila</name>
    <code>AQ</code>
    <regional_division>65</regional_division>
  </subcountry>
  <subcountry>
    <name>La Spezia</name>
    <code>SP</code>
    <regional_division>42</regional_division>
  </subcountry>
  <subcountry>
    <name>Latina</name>
    <code>LT</code>
    <regional_division>62</regional_division>
  </subcountry>
  <subcountry>
    <name>Lecce</name>
    <code>LE</code>
    <regional_division>75</regional_division>
  </subcountry>
  <subcountry>
    <name>Lecco</name>
    <code>LC</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Livorno</name>
    <code>LI</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Lodi</name>
    <code>LO</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Lucca</name>
    <code>LU</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Macerata</name>
    <code>MC</code>
    <regional_division>57</regional_division>
  </subcountry>
  <subcountry>
    <name>Mantova</name>
    <code>MN</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Massa-Carrara</name>
    <code>MS</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Matera</name>
    <code>MT</code>
    <regional_division>77</regional_division>
  </subcountry>
  <subcountry>
    <name>Messina</name>
    <code>ME</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Milano</name>
    <code>MI</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Modena</name>
    <code>MO</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Napoli</name>
    <code>NA</code>
    <regional_division>72</regional_division>
  </subcountry>
  <subcountry>
    <name>Novara</name>
    <code>NO</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Nuoro</name>
    <code>NU</code>
    <regional_division>88</regional_division>
  </subcountry>
  <subcountry>
    <name>Oristano</name>
    <code>OR</code>
    <regional_division>88</regional_division>
  </subcountry>
  <subcountry>
    <name>Padova</name>
    <code>PD</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Palermo</name>
    <code>PA</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Parma</name>
    <code>PR</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Pavia</name>
    <code>PV</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Perugia</name>
    <code>PG</code>
    <regional_division>55</regional_division>
  </subcountry>
  <subcountry>
    <name>Pesaro e Urbino</name>
    <code>PS</code>
    <regional_division>57</regional_division>
  </subcountry>
  <subcountry>
    <name>Pescara</name>
    <code>PE</code>
    <regional_division>65</regional_division>
  </subcountry>
  <subcountry>
    <name>Piacenza</name>
    <code>PC</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Pisa</name>
    <code>PI</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Pistoia</name>
    <code>PT</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Pordenone</name>
    <code>PN</code>
    <regional_division>36</regional_division>
  </subcountry>
  <subcountry>
    <name>Potenza</name>
    <code>PZ</code>
    <regional_division>77</regional_division>
  </subcountry>
  <subcountry>
    <name>Prato</name>
    <code>PO</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Ragusa</name>
    <code>RG</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Ravenna</name>
    <code>RA</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Reggio Calabria</name>
    <code>RC</code>
    <regional_division>78</regional_division>
  </subcountry>
  <subcountry>
    <name>Reggio Emilia</name>
    <code>RE</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Rieti</name>
    <code>RI</code>
    <regional_division>62</regional_division>
  </subcountry>
  <subcountry>
    <name>Rimini</name>
    <code>RN</code>
    <regional_division>45</regional_division>
  </subcountry>
  <subcountry>
    <name>Roma</name>
    <code>RM</code>
    <regional_division>62</regional_division>
  </subcountry>
  <subcountry>
    <name>Rovigo</name>
    <code>RO</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Salerno</name>
    <code>SA</code>
    <regional_division>72</regional_division>
  </subcountry>
  <subcountry>
    <name>Sassari</name>
    <code>SS</code>
    <regional_division>88</regional_division>
  </subcountry>
  <subcountry>
    <name>Savona</name>
    <code>SV</code>
    <regional_division>42</regional_division>
  </subcountry>
  <subcountry>
    <name>Siena</name>
    <code>SI</code>
    <regional_division>52</regional_division>
  </subcountry>
  <subcountry>
    <name>Siracusa</name>
    <code>SR</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Sondrio</name>
    <code>SO</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Taranto</name>
    <code>TA</code>
    <regional_division>75</regional_division>
  </subcountry>
  <subcountry>
    <name>Teramo</name>
    <code>TE</code>
    <regional_division>65</regional_division>
  </subcountry>
  <subcountry>
    <name>Terni</name>
    <code>TR</code>
    <regional_division>55</regional_division>
  </subcountry>
  <subcountry>
    <name>Torino</name>
    <code>TO</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Trapani</name>
    <code>TP</code>
    <regional_division>82</regional_division>
  </subcountry>
  <subcountry>
    <name>Trento</name>
    <code>TN</code>
    <regional_division>32</regional_division>
  </subcountry>
  <subcountry>
    <name>Treviso</name>
    <code>TV</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Trieste</name>
    <code>TS</code>
    <regional_division>36</regional_division>
  </subcountry>
  <subcountry>
    <name>Udine</name>
    <code>UD</code>
    <regional_division>36</regional_division>
  </subcountry>
  <subcountry>
    <name>Varese</name>
    <code>VA</code>
    <regional_division>25</regional_division>
  </subcountry>
  <subcountry>
    <name>Venezia</name>
    <code>VE</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Verbano-Cusio-Ossola</name>
    <code>VB</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Vercelli</name>
    <code>VC</code>
    <regional_division>21</regional_division>
  </subcountry>
  <subcountry>
    <name>Verona</name>
    <code>VR</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Vibo Valentia</name>
    <code>VV</code>
    <regional_division>78</regional_division>
  </subcountry>
  <subcountry>
    <name>Vicenza</name>
    <code>VI</code>
    <regional_division>34</regional_division>
  </subcountry>
  <subcountry>
    <name>Viterbo</name>
    <code>VT</code>
    <regional_division>62</regional_division>
  </subcountry>
</country>

<country>
  <name>JAMAICA</name>
  <code>JM</code>
  <subcountry>
    <name>Clarendon</name>
    <code>13</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Hanover</name>
    <code>09</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Kingston</name>
    <code>01</code>
  </subcountry>
  <subcountry>
    <name>Manchester</name>
    <code>12</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Portland</name>
    <code>04</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Andrew</name>
    <code>02</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Ann</name>
    <code>06</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Catherine</name>
    <code>14</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Elizabeth</name>
    <code>11</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint James</name>
    <code>08</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Mary</name>
    <code>05</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Thomas</name>
    <code>03</code>
  </subcountry>
  <subcountry>
    <name>Trelawny</name>
    <code>07</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Westmoreland</name>
    <code>10</code>
    <FIPS>16</FIPS>
  </subcountry>
</country>

<country>
  <name>JORDAN</name>
  <code>JO</code>
  <subcountry>
    <name>Ajlun</name>
    <code>AJ</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Aqaba</name>
    <code>AQ</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Balqa'</name>
    <code>BA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Karak</name>
    <code>KA</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Mafraq</name>
    <code>MA</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Amman</name>
    <code>AM</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>At Tafilah</name>
    <code>AT</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Az Zarqa'</name>
    <code>AZ</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Irbid</name>
    <code>IR</code>
  </subcountry>
  <subcountry>
    <name>Jarash</name>
    <code>JA</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Ma`an</name>
    <code>MN</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Madaba</name>
    <code>MD</code>
  </subcountry>
</country>

<country>
  <name>JAPAN</name>
  <code>JP</code>
  <subcountry>
    <name>Aichi</name>
    <code>23</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Akita</name>
    <code>05</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Aomori</name>
    <code>02</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ehime</name>
    <code>38</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Gihu</name>
    <code>21</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Gunma</name>
    <code>10</code>
  </subcountry>
  <subcountry>
    <name>Hirosima [Hiroshima]</name>
    <code>34</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Hokkaid� [Hokkaido]</name>
    <code>01</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Hukui [Fukui]</name>
    <code>18</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Hukuoka [Fukuoka]</name>
    <code>40</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Hukusima [Fukushima]</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Hy�go [Hyogo]</name>
    <code>28</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Ibaraki</name>
    <code>08</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Isikawa [Ishikawa]</name>
    <code>17</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Iwate</name>
    <code>03</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Kagawa</name>
    <code>37</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Kagosima [Kagoshima]</name>
    <code>46</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Kanagawa</name>
    <code>14</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>K�ti [Kochi]</name>
    <code>39</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Kumamoto</name>
    <code>43</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Ky�to [Kyoto]</name>
    <code>26</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Mie</name>
    <code>24</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Miyagi</name>
    <code>04</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Miyazaki</name>
    <code>45</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Nagano</name>
    <code>20</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Nagasaki</name>
    <code>42</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Nara</name>
    <code>29</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Niigata</name>
    <code>15</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>�ita [Oita]</name>
    <code>44</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Okayama</name>
    <code>33</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Okinawa</name>
    <code>47</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>�saka [Osaka]</name>
    <code>27</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Saga</name>
    <code>41</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Saitama</name>
    <code>11</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Siga [Shiga]</name>
    <code>25</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Simane [Shimane]</name>
    <code>32</code>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Sizuoka [Shizuoka]</name>
    <code>22</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Tiba [Chiba]</name>
    <code>12</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Totigi [Tochigi]</name>
    <code>09</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Tokusima [Tokushima]</name>
    <code>36</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>T�ky� [Tokyo]</name>
    <code>13</code>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Tottori</name>
    <code>31</code>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Toyama</name>
    <code>16</code>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Wakayama</name>
    <code>30</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Yamagata</name>
    <code>06</code>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Yamaguti [Yamaguchi]</name>
    <code>35</code>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Yamanasi [Yamanashi]</name>
    <code>19</code>
    <FIPS>46</FIPS>
  </subcountry>
</country>

<country>
  <name>KENYA</name>
  <code>KE</code>
  <subcountry>
    <name>Nairobi Municipality</name>
    <code>110</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Central</name>
    <code>200</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Coast</name>
    <code>300</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Eastern</name>
    <code>400</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>North-Eastern</name>
    <code>500</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Nyanza</name>
    <code>600</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Rift Valley</name>
    <code>700</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>900</code>
    <category>province</category>
  </subcountry>
</country>

<country>
  <name>KYRGYZSTAN</name>
  <code>KG</code>
  <subcountry>
    <name>Ch�</name>
    <code>C</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Jalal-Abad</name>
    <code>J</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Naryn</name>
    <code>N</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Osh</name>
    <code>O</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Talas</name>
    <code>T</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Ysyk-K�l</name>
    <code>Y</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>CAMBODIA</name>
  <code>KH</code>
  <subcountry>
    <name>Krong Kaeb [Krong K�b]</name>
    <code>23</code>
    <category>autonomous municipality</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Krong Preah Sihanouk [Krong Preah Sihanouk]</name>
    <code>18</code>
    <category>autonomous municipality</category>
  </subcountry>
  <subcountry>
    <name>Phnom Penh [Phnum P�nh]</name>
    <code>12</code>
    <category>autonomous municipality</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Baat Dambang [Batd�mb�ng]</name>
    <code>2</code>
    <category>province</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Banteay Mean Chey [B�nt�ay M�anchey]</name>
    <code>1</code>
    <category>province</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Kampong Chaam [K�mp�ng Cham]</name>
    <code>3</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Kampong Chhnang [K�mp�ng Chhnang]</name>
    <code>4</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Kampong Spueu [K�mp�ng Sp�]</name>
    <code>5</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Kampong Thum [K�mp�ng Thum]</name>
    <code>6</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Kampot [K�mp�t]</name>
    <code>7</code>
    <category>province</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Kandaal [K�ndal]</name>
    <code>8</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaoh Kong [Ka�h Kong]</name>
    <code>9</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kracheh [Kr�ch�h]</name>
    <code>10</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Mondol Kiri [M�nd�l Kiri]</name>
    <code>11</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Otdar Mean Chey [Otd�r M�anchey] </name>
    <code>22</code>
    <category>province</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Pousaat [Pouthisat]</name>
    <code>15</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Preah Vihear [Preah Vih�ar]</name>
    <code>13</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Prey Veaeng [Prey V�ng]</name>
    <code>14</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Rotanak Kiri [R�t�n�kiri]</name>
    <code>16</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Siem Reab [Siemr�ab]</name>
    <code>17</code>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Stueng Traeng [St�ng Tr�ng]</name>
    <code>19</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Svaay Rieng [Svay Rieng]</name>
    <code>20</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Taakaev [Tak�v]</name>
    <code>21</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>KIRIBATI</name>
  <code>KI</code>
  <subcountry>
    <name>Gilbert Islands</name>
    <code>G</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Line Islands</name>
    <code>L</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Phoenix Islands</name>
    <code>P</code>
    <FIPS>03</FIPS>
  </subcountry>
</country>

<country>
  <name>COMOROS</name>
  <code>KM</code>
  <subcountry>
    <name>Anjouan</name>
    <code>A</code>
  </subcountry>
  <subcountry>
    <name>Grande Comore</name>
    <code>G</code>
  </subcountry>
  <subcountry>
    <name>Moh�li</name>
    <code>M</code>
  </subcountry>
</country>

<country>
  <name>KOREA, DEMOCRATIC PEOPLE'S REPUBLIC OF</name>
  <code>KP</code>
  <subcountry>
    <name>Najin Sonbong-si</name>
    <code>NAJ</code>
    <category>special city</category>
  </subcountry>
  <subcountry>
    <name>Kaesong-si</name>
    <code>KAE</code>
    <category>special city</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Nampo-si</name>
    <code>NAM</code>
    <category>special city</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Pyongyang-si</name>
    <code>PYO</code>
    <category>special city</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Chagang-do</name>
    <code>CHA</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Hamgyongbuk-do</name>
    <code>HAB</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Hamgyongnam-do</name>
    <code>HAN</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Hwanghaebuk-do</name>
    <code>HWB</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Hwanghaenam-do</name>
    <code>HWN</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kangwon-do</name>
    <code>KAN</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Pyonganbuk-do</name>
    <code>PYB</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Pyongannam-do</name>
    <code>PYN</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Yanggang-do</name>
    <code>YAN</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
</country>

<country>
  <name>KOREA, REPUBLIC OF</name>
  <code>KR</code>
  <subcountry>
    <name>Seoul Teugbyeolsi [Seoul-T'ukpyolshi]</name>
    <code>11</code>
    <category>capital metropolitan city</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Busan Gwang'yeogsi [Pusan-Kwangyokshi]</name>
    <code>26</code>
    <category>metropolitan city</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Daegu Gwang'yeogsi [Taegu-Kwangyokshi]</name>
    <code>27</code>
    <category>metropolitan city</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Daejeon Gwang'yeogsi [Taejon-Kwangyokshi]</name>
    <code>30</code>
    <category>metropolitan city</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Gwangju Gwang'yeogsi [Kwangju-Kwangyokshi]</name>
    <code>29</code>
    <category>metropolitan city</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Incheon Gwang'yeogsi [Inch'n-Kwangyokshi]</name>
    <code>28</code>
    <category>metropolitan city</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Ulsan Gwang'yeogsi [Ulsan-Kwangyokshi]</name>
    <code>31</code>
    <category>metropolitan city</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Chungcheongbugdo [Ch'ungch'ongbuk-do]</name>
    <code>43</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Chungcheongnamdo [Ch'ungch'ongnam-do]</name>
    <code>44</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Gang'weondo [Kang-won-do]</name>
    <code>42</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Gyeonggido [Kyonggi-do]</name>
    <code>41</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Gyeongsangbugdo [Kyongsangbuk-do]</name>
    <code>47</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Gyeongsangnamdo [Kyongsangnam-do]</name>
    <code>48</code>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Jejudo [Cheju-do]</name>
    <code>49</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Jeonrabugdo[Chollabuk-do]</name>
    <code>45</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Jeonranamdo [Chollanam-do]</name>
    <code>46</code>
    <category>province</category>
  </subcountry>
</country>

<country>
  <name>KUWAIT</name>
  <code>KW</code>
  <subcountry>
    <name>Al Ahmadi</name>
    <code>AH</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Farwaniyah</name>
    <code>FA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Jahrah</name>
    <code>JA</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Kuwayt</name>
    <code>KU</code>
  </subcountry>
  <subcountry>
    <name>Hawalli</name>
    <code>HA</code>
    <FIPS>03</FIPS>
  </subcountry>
</country>

<country>
  <name>KAZAKHSTAN</name>
  <code>KZ</code>
  <subcountry>
    <name>Almaty</name>
    <code>ALA</code>
    <category>city</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Astana</name>
    <code>AST</code>
    <category>city</category>
  </subcountry>
</country>

<country>
  <name>UNITED ARAB EMIRATES</name>
  <code>AE</code>
  <subcountry>
    <name>Abu Dhabi</name>
    <code>AZ</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Ajman</name>
    <code>AJ</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Fujayrah</name>
    <code>FU</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Sharjah</name>
    <code>SH</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dubay</name>
    <code>DU</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ra�s al Khaymah</name>
    <code>RK</code>
  </subcountry>
  <subcountry>
    <name>Umm al Qaywayn</name>
    <code>UQ</code>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>AFGHANISTAN</name>
  <code>AF</code>
  <subcountry>
    <name>Badakhshan</name>
    <code>BDS</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Badghis</name>
    <code>BDG</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Baghlan</name>
    <code>BGL</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Balkh</name>
    <code>BAL</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Bamian</name>
    <code>BAM</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Farah</name>
    <code>FRA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Faryab</name>
    <code>FYB</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ghazni</name>
    <code>GHA</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Ghowr</name>
    <code>GHO</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Helmand</name>
    <code>HEL</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Herat</name>
    <code>HER</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Jowzjan</name>
    <code>JOW</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Kabul [Kabol]</name>
    <code>KAB</code>
  </subcountry>
  <subcountry>
    <name>Kandahar</name>
    <code>KAN</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Kapisa</name>
    <code>KAP</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Konar [Kunar]</name>
    <code>KNR</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Kondoz [Kunduz]</name>
    <code>KDZ</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Laghman</name>
    <code>LAG</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Lowgar</name>
    <code>LOW</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Nangrahar [Nangarhar]</name>
    <code>NAN</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Nimruz</name>
    <code>NIM</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Oruzgan [Uruzgan]</name>
    <code>ORU</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Paktia</name>
    <code>PIA</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Paktika</name>
    <code>PKA</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Parwan</name>
    <code>PAR</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Samangan</name>
    <code>SAM</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Sar-e Pol</name>
    <code>SAR</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Takhar</name>
    <code>TAK</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Wardak [Wardag]</name>
    <code>WAR</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Zabol [Zabul]</name>
    <code>ZAB</code>
    <FIPS>28</FIPS>
  </subcountry>
</country>

<country>
  <name>ALBANIA</name>
  <code>AL</code>
  <subcountry>
    <name>Berat</name>
    <code>BR</code>
    <regional_division>1</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bulqiz�</name>
    <code>BU</code>
    <regional_division>9</regional_division>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Delvin�</name>
    <code>DL</code>
    <regional_division>12</regional_division>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Devoll</name>
    <code>DV</code>
    <regional_division>6</regional_division>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Dib�r</name>
    <code>DI</code>
    <regional_division>9</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Durr�s</name>
    <code>DR</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Elbasan</name>
    <code>EL</code>
    <regional_division>3</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Fier</name>
    <code>FR</code>
    <regional_division>4</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Gramsh</name>
    <code>GR</code>
    <regional_division>3</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Gjirokast�r</name>
    <code>GJ</code>
    <regional_division>5</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Has</name>
    <code>HA</code>
    <regional_division>7</regional_division>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Kavaj�</name>
    <code>KA</code>
    <regional_division>11</regional_division>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Kolonj�</name>
    <code>ER</code>
    <regional_division>6</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kor��</name>
    <code>KO</code>
    <regional_division>6</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Kruj�</name>
    <code>KR</code>
    <regional_division>2</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Ku�ov�</name>
    <code>KC</code>
    <regional_division>1</regional_division>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Kuk�s</name>
    <code>KU</code>
    <regional_division>7</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Kurbin</name>
    <code>KB</code>
    <regional_division>8</regional_division>
  </subcountry>
  <subcountry>
    <name>Lezh�</name>
    <code>LE</code>
    <regional_division>8</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
</country>

<country>
  <name>KAZAKHSTAN</name>
  <code>KZ</code>
  <subcountry>
    <name>Almaty oblysy</name>
    <code>ALM</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Aqmola oblysy</name>
    <code>AKM</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Aqt�be oblysy</name>
    <code>AKT</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Atyrau oblysy</name>
    <code>ATY</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Batys Qazaqstan oblysy</name>
    <code>ZAP</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Mangghystau oblysy</name>
    <code>MAN</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Ongt�stik Qazaqstan oblysy</name>
    <code>YUZ</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Pavlodar oblysy</name>
    <code>PAV</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Qaraghandy oblysy</name>
    <code>KAR</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Qostanay oblysy</name>
    <code>KUS</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Qyzylorda oblysy</name>
    <code>KZY</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Shyghys Qazaqstan oblysy</name>
    <code>VOS</code>
    <category>region</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Solt�stik Qazaqstan oblysy</name>
    <code>SEV</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Zhambyl oblysy</name>
    <code>ZHA</code>
    <category>region</category>
  </subcountry>
</country>

<country>
  <name>LAO PEOPLE'S DEMOCRATIC REPUBLIC</name>
  <code>LA</code>
  <subcountry>
    <name>Vientiane</name>
    <code>VT</code>
    <category>prefecture</category>
  </subcountry>
  <subcountry>
    <name>Attapu [Attopeu]</name>
    <code>AT</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bok�o</name>
    <code>BK</code>
    <category>province</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Bolikhamxai [Borikhane]</name>
    <code>BL</code>
    <category>province</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Champasak [Champassak]</name>
    <code>CH</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Houaphan</name>
    <code>HO</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Khammouan</name>
    <code>KH</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Louang Namtha</name>
    <code>LM</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Louangphabang [Louang Prabang]</name>
    <code>LP</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Oud�mxai [Oudomsai]</name>
    <code>OU</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ph�ngsali [Phong Saly]</name>
    <code>PH</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Salavan [Saravane]</name>
    <code>SL</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Savannakh�t</name>
    <code>SV</code>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Vientiane</name>
    <code>VI</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Xaignabouli [Sayaboury]</name>
    <code>XA</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Xais�mboun</name>
    <code>XN</code>
    <category>special zone</category>
  </subcountry>
  <subcountry>
    <name>X�kong [S�kong]</name>
    <code>XE</code>
    <category>province</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Xiangkhoang [Xieng Khouang]</name>
    <code>XI</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
</country>

<country>
  <name>MOLDOVA, REPUPLIC OF</name>
  <code>MD</code>
  <subcountry>
    <name>Taraclia</name>
    <code>TA</code>
    <category>district</category>
  </subcountry>
</country>


<country>
  <name>LEBANON</name>
  <code>LB</code>
  <subcountry>
    <name>Beiro�t</name>
    <code>BA</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>El B�qaa</name>
    <code>BI</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Jabal Loubn�ne</name>
    <code>JL</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Loubn�ne ech Chem�li</name>
    <code>AS</code>
  </subcountry>
  <subcountry>
    <name>Loubn�ne ej Jno�bi</name>
    <code>JA</code>
  </subcountry>
  <subcountry>
    <name>Nabat�y�</name>
    <code>NA</code>
  </subcountry>
</country>

<country>
  <name>SRI LANKA</name>
  <code>LK</code>
  <subcountry>
    <name>Ampara</name>
    <code>52</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Anuradhapura</name>
    <code>71</code>
    <regional_division>7</regional_division>
  </subcountry>
  <subcountry>
    <name>Badulla</name>
    <code>81</code>
    <regional_division>8</regional_division>
  </subcountry>
  <subcountry>
    <name>Batticaloa</name>
    <code>51</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Colombo</name>
    <code>11</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Galle</name>
    <code>31</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Gampaha</name>
    <code>12</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Hambantota</name>
    <code>33</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Jaffna</name>
    <code>41</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Kalutara</name>
    <code>13</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Kandy</name>
    <code>21</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Kegalla</name>
    <code>92</code>
    <regional_division>9</regional_division>
  </subcountry>
  <subcountry>
    <name>Kilinochchi</name>
    <code>42</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Kurunegala</name>
    <code>61</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Mannar</name>
    <code>43</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Matale</name>
    <code>22</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Matara</name>
    <code>32</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Monaragala</name>
    <code>82</code>
    <regional_division>8</regional_division>
  </subcountry>
  <subcountry>
    <name>Mullaittivu</name>
    <code>45</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Nuwara Eliya</name>
    <code>23</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Polonnaruwa</name>
    <code>72</code>
    <regional_division>7</regional_division>
  </subcountry>
  <subcountry>
    <name>Puttalam</name>
    <code>62</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Ratnapura</name>
    <code>91</code>
    <regional_division>9</regional_division>
  </subcountry>
  <subcountry>
    <name>Trincomalee</name>
    <code>53</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Vavuniya</name>
    <code>44</code>
    <regional_division>4</regional_division>
  </subcountry>
</country>

<country>
  <name>LIBERIA</name>
  <code>LR</code>
  <subcountry>
    <name>Bomi</name>
    <code>BM</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Bong</name>
    <code>BG</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Grand Bassa</name>
    <code>GB</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Grand Cape Mount</name>
    <code>CM</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Grand Gedeh</name>
    <code>GG</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Grand Kru</name>
    <code>GK</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Lofa</name>
    <code>LO</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Margibi</name>
    <code>MG</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Maryland</name>
    <code>MY</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Montserrado</name>
    <code>MO</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Nimba</name>
    <code>NI</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivercess</name>
    <code>RI</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Sinoe</name>
    <code>SI</code>
    <FIPS>10</FIPS>
  </subcountry>
</country>

<country>
  <name>LESOTHO</name>
  <code>LS</code>
  <subcountry>
    <name>Berea</name>
    <code>D</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Butha-Buthe</name>
    <code>B</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Leribe</name>
    <code>C</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Mafeteng</name>
    <code>E</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Maseru</name>
    <code>A</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Mohale's Hoek</name>
    <code>F</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Mokhotlong</name>
    <code>J</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Qacha's Nek</name>
    <code>H</code>
  </subcountry>
  <subcountry>
    <name>Quthing</name>
    <code>G</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Thaba-Tseka</name>
    <code>K</code>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>LITHUANIA</name>
  <code>LT</code>
  <subcountry>
    <name>Alytaus Apskritis</name>
    <code>AL</code>
  </subcountry>
  <subcountry>
    <name>Kauno Apskritis</name>
    <code>KU</code>
  </subcountry>
  <subcountry>
    <name>Klaipedos Apskritis</name>
    <code>KL</code>
  </subcountry>
  <subcountry>
    <name>Marijampoles Apskritis</name>
    <code>MR</code>
  </subcountry>
  <subcountry>
    <name>Paneve�io Apskritis</name>
    <code>PN</code>
  </subcountry>
  <subcountry>
    <name>�iauliu Apskritis</name>
    <code>SA</code>
  </subcountry>
  <subcountry>
    <name>Taurages Apskritis</name>
    <code>TA</code>
  </subcountry>
  <subcountry>
    <name>Tel�iu Apskritis</name>
    <code>TE</code>
  </subcountry>
  <subcountry>
    <name>Utenos Apskritis</name>
    <code>UT</code>
  </subcountry>
  <subcountry>
    <name>Vilniaus Apskritis</name>
    <code>VL</code>
  </subcountry>
</country>

<country>
  <name>LUXEMBOURG</name>
  <code>LU</code>
  <subcountry>
    <name>Diekirch</name>
    <code>D</code>
  </subcountry>
  <subcountry>
    <name>Grevenmacher</name>
    <code>G</code>
  </subcountry>
  <subcountry>
    <name>Luxembourg</name>
    <code>L</code>
  </subcountry>
</country>

<country>
  <name>LATVIA</name>
  <code>LV</code>
  <subcountry>
    <name>Aizkraukles Aprinkis</name>
    <code>AI</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Aluksnes Aprinkis</name>
    <code>AL</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Balvu Aprinkis</name>
    <code>BL</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Bauskas Aprinkis</name>
    <code>BU</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Cesu Aprinkis</name>
    <code>CE</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Daugavpils Aprinkis</name>
    <code>DA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Dobeles Aprinkis</name>
    <code>DO</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Gulbenes Aprinkis</name>
    <code>GU</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Jelgavas Aprinkis</name>
    <code>JL</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Jekabpils Aprinkis</name>
    <code>JK</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Kraslavas Aprinkis</name>
    <code>KR</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Kuldigas Aprinkis</name>
    <code>KU</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Limba�u Aprinkis</name>
    <code>LM</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Liepajas Aprinkis</name>
    <code>LE</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Ludzas Aprinkis</name>
    <code>LU</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Madonas Aprinkis</name>
    <code>MA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Ogres Aprinkis</name>
    <code>OG</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Preilu Aprinkis</name>
    <code>PR</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Rezeknes Aprinkis</name>
    <code>RE</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Rigas Aprinkis</name>
    <code>RI</code>
    <category>district</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Saldus Aprinkis</name>
    <code>SA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Talsu Aprinkis</name>
    <code>TA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Tukuma Aprinkis</name>
    <code>TU</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Valkas Aprinkis</name>
    <code>VK</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Valmieras Aprinkis</name>
    <code>VM</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Ventspils Aprinkis</name>
    <code>VE</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Daugavpils</name>
    <code>DGV</code>
    <category>city</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Jelgava</name>
    <code>JEL</code>
    <category>city</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Jurmala</name>
    <code>JUR</code>
    <category>city</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Liepaja</name>
    <code>LPX</code>
    <category>city</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Rezekne</name>
    <code>REZ</code>
    <category>city</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Riga</name>
    <code>RIX</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Ventspils</name>
    <code>VEN</code>
    <category>city</category>
    <FIPS>32</FIPS>
  </subcountry>
</country>

<country>
  <name>LIBYAN ARAB JAMAHIRIYA</name>
  <code>LY</code>
  <subcountry>
    <name>Al Butnan</name>
    <code>BU</code>
  </subcountry>
  <subcountry>
    <name>Al Jabal al Akhdar</name>
    <code>JA</code>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Jufrah</name>
    <code>JU</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Wahah</name>
    <code>WA</code>
  </subcountry>
  <subcountry>
    <name>Az Zawiyah</name>
    <code>ZA</code>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Banghazi</name>
    <code>BA</code>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Misratah</name>
    <code>MI</code>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Tarabulus</name>
    <code>TB</code>
  </subcountry>
</country>

<country>
  <name>MOROCCO</name>
  <code>MA</code>
  <subcountry>
    <name>Agadir</name>
    <code>AGD</code>
    <regional_division>13</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>A�t Baha</name>
    <code>BAH</code>
    <regional_division>13</regional_division>
  </subcountry>
  <subcountry>
    <name>A�t Melloul</name>
    <code>MEL</code>
    <regional_division>13</regional_division>
  </subcountry>
  <subcountry>
    <name>Al Haouz</name>
    <code>HAO</code>
    <regional_division>11</regional_division>
  </subcountry>
  <subcountry>
    <name>Al Hoce�ma</name>
    <code>HOC</code>
    <regional_division>03</regional_division>
  </subcountry>
  <subcountry>
    <name>Assa-Zag</name>
    <code>ASZ</code>
    <regional_division>14</regional_division>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Azilal</name>
    <code>AZI</code>
    <regional_division>12</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Beni Mellal</name>
    <code>BEM</code>
    <regional_division>12</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ben Slimane</name>
    <code>BES</code>
    <regional_division>09</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Berkane</name>
    <code>BER</code>
    <regional_division>04</regional_division>
  </subcountry>
  <subcountry>
    <name>Boujdour (EH)</name>
    <code>BOD</code>
    <regional_division>15</regional_division>
  </subcountry>
  <subcountry>
    <name>Boulemane</name>
    <code>BOM</code>
    <regional_division>05</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Casablanca [Dar el Be�da]</name>
    <code>CAS</code>
    <regional_division>08</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Chefchaouene</name>
    <code>CHE</code>
    <regional_division>01</regional_division>
  </subcountry>
  <subcountry>
    <name>Chichaoua</name>
    <code>CHI</code>
    <regional_division>11</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>El Hajeb</name>
    <code>HAJ</code>
    <regional_division>06</regional_division>
  </subcountry>
  <subcountry>
    <name>El Jadida</name>
    <code>JDI</code>
    <regional_division>10</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Errachidia</name>
    <code>ERR</code>
    <regional_division>06</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Essaouira</name>
    <code>ESI</code>
    <regional_division>11</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Es Smara (EH)</name>
    <code>ESM</code>
    <regional_division>14</regional_division>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>F�s</name>
    <code>FES</code>
    <regional_division>05</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
</country>

<country>
  <name>ALBANIA</name>
  <code>AL</code>
  <subcountry>
    <name>Librazhd</name>
    <code>LB</code>
    <regional_division>3</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Lushnj�</name>
    <code>LU</code>
    <regional_division>4</regional_division>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Mal�si e Madhe</name>
    <code>MM</code>
    <regional_division>10</regional_division>
  </subcountry>
  <subcountry>
    <name>Mallakast�r</name>
    <code>MK</code>
    <regional_division>4</regional_division>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Mat</name>
    <code>MT</code>
    <regional_division>9</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Mirdit�</name>
    <code>MR</code>
    <regional_division>8</regional_division>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Peqin</name>
    <code>PQ</code>
    <regional_division>3</regional_division>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>P�rmet</name>
    <code>PR</code>
    <regional_division>5</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Pogradec</name>
    <code>PG</code>
    <regional_division>6</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Puk�</name>
    <code>PU</code>
    <regional_division>10</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Sarand�</name>
    <code>SR</code>
    <regional_division>12</regional_division>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Skrapar</name>
    <code>SK</code>
    <regional_division>1</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Shkod�r</name>
    <code>SH</code>
    <regional_division>10</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Tepelen�</name>
    <code>TE</code>
    <regional_division>5</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Tiran�</name>
    <code>TR</code>
    <regional_division>11</regional_division>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Tropoj�</name>
    <code>TP</code>
    <regional_division>7</regional_division>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Vlor�</name>
    <code>VL</code>
    <regional_division>12</regional_division>
    <FIPS>27</FIPS>
  </subcountry>
</country>

<country>
  <name>ARMENIA</name>
  <code>AM</code>
  <subcountry>
    <name>Erevan</name>
    <code>ER</code>
    <category>city</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Aragacotn</name>
    <code>AG</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Ararat</name>
    <code>AR</code>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Armavir</name>
    <code>AV</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Gegark'unik'</name>
    <code>GR</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Kotayk'</name>
    <code>KT</code>
    <category>region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Lory</name>
    <code>LO</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>�irak</name>
    <code>SH</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Syunik'</name>
    <code>SU</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Tavu�</name>
    <code>TV</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Vayoc Jor</name>
    <code>VD</code>
    <category>region</category>
  </subcountry>
</country>

<country>
  <name>SENEGAL</name>
  <code>SN</code>
  <subcountry>
    <name>Matam</name>
    <code>MT</code>
  </subcountry>
</country>

<country>
  <name>ANGOLA</name>
  <code>AO</code>
  <subcountry>
    <name>Bengo</name>
    <code>BGO</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Benguela</name>
    <code>BGU</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bi�</name>
    <code>BIE</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Cabinda</name>
    <code>CAB</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuando-Cubango</name>
    <code>CCU</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuanza Norte</name>
    <code>CNO</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuanza Sul</name>
    <code>CUS</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Cunene</name>
    <code>CNN</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Huambo</name>
    <code>HUA</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Hu�la</name>
    <code>HUI</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Luanda</name>
    <code>LUA</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Lunda Norte</name>
    <code>LNO</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Lunda Sul</name>
    <code>LSU</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Malange</name>
    <code>MAL</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Moxico</name>
    <code>MOX</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Namibe</name>
    <code>NAM</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>U�ge</name>
    <code>UIG</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Zaire</name>
    <code>ZAI</code>
    <FIPS>16</FIPS>
  </subcountry>
</country>

<country>
  <name>ARGENTINA</name>
  <code>AR</code>
  <subcountry>
    <name>Capital federal</name>
    <code>C</code>
    <category>federal district</category>
  </subcountry>
  <subcountry>
    <name>Buenos Aires</name>
    <code>B</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Catamarca</name>
    <code>K</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>C�rdoba</name>
    <code>X</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Corrientes</name>
    <code>W</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Chaco</name>
    <code>H</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chubut</name>
    <code>U</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Entre R�os</name>
    <code>E</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Formosa</name>
    <code>P</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Jujuy</name>
    <code>Y</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>La Pampa</name>
    <code>L</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>La Rioja</name>
    <code>F</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Mendoza</name>
    <code>M</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Misiones</name>
    <code>N</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Neuqu�n</name>
    <code>Q</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>R�o Negro</name>
    <code>R</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Salta</name>
    <code>A</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>San Juan</name>
    <code>J</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>San Luis</name>
    <code>D</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Cruz</name>
    <code>Z</code>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Fe</name>
    <code>S</code>
    <category>province</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Santiago del Estero</name>
    <code>G</code>
    <category>province</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Tierra del Fuego</name>
    <code>V</code>
    <category>province</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Tucum�n</name>
    <code>T</code>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
</country>

<country>
  <name>AUSTRIA</name>
  <code>AT</code>
  <subcountry>
    <name>Burgenland</name>
    <code>1</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>K�rnten</name>
    <code>2</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Nieder�sterreich</name>
    <code>3</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ober�sterreich</name>
    <code>4</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Salzburg</name>
    <code>5</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Steiermark</name>
    <code>6</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Tirol</name>
    <code>7</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Vorarlberg</name>
    <code>8</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Wien</name>
    <code>9</code>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>AUSTRALIA</name>
  <code>AU</code>
  <subcountry>
    <name>New South Wales</name>
    <code>NSW</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Queensland</name>
    <code>QLD</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>South Australia</name>
    <code>SA</code>
    <category>state</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Tasmania</name>
    <code>TAS</code>
    <category>state</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Victoria</name>
    <code>VIC</code>
    <category>state</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Western Australia</name>
    <code>WA</code>
    <category>state</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Australian Capital Territory</name>
    <code>ACT</code>
    <category>territory</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern Territory</name>
    <code>NT</code>
    <category>territory</category>
    <FIPS>03</FIPS>
  </subcountry>
</country>

<country>
  <name>AZERBAIJAN</name>
  <code>AZ</code>
  <subcountry>
    <name>�li Bayramli</name>
    <code>AB</code>
    <category>city</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Baki</name>
    <code>BA</code>
    <category>city</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>G�nc�</name>
    <code>GA</code>
    <category>city</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>L�nk�ran</name>
    <code>LA</code>
    <category>city</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Ming��evir</name>
    <code>MI</code>
    <category>city</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Naftalan</name>
    <code>NA</code>
    <category>city</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>S�ki</name>
    <code>SA</code>
    <category>city</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Sumqayit</name>
    <code>SM</code>
    <category>city</category>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Susa</name>
    <code>SS</code>
    <category>city</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Xank�ndi</name>
    <code>XA</code>
    <category>city</category>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Yevlax</name>
    <code>YE</code>
    <category>city</category>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Abseron</name>
    <code>ABS</code>
    <category>rayon</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Agcab�di</name>
    <code>AGC</code>
    <category>rayon</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Agdam</name>
    <code>AGM</code>
    <category>rayon</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Agdas</name>
    <code>AGS</code>
    <category>rayon</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Agstafa</name>
    <code>AGA</code>
    <category>rayon</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Agsu</name>
    <code>AGU</code>
    <category>rayon</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Astara</name>
    <code>AST</code>
    <category>rayon</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Bab�k</name>
    <code>BAB</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>Balak�n</name>
    <code>BAL</code>
    <category>rayon</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>B�rd�</name>
    <code>BAR</code>
    <category>rayon</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Beyl�qan</name>
    <code>BEY</code>
    <category>rayon</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Bil�suvar</name>
    <code>BIL</code>
    <category>rayon</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>C�brayil</name>
    <code>CAB</code>
    <category>rayon</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>C�lilabab</name>
    <code>CAL</code>
    <category>rayon</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Culfa</name>
    <code>CUL</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>Dask�s�n</name>
    <code>DAS</code>
    <category>rayon</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>D�v��i</name>
    <code>DAV</code>
    <category>rayon</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>F�zuli</name>
    <code>FUZ</code>
    <category>rayon</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>G�d�b�y</name>
    <code>GAD</code>
    <category>rayon</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Goranboy</name>
    <code>GOR</code>
    <category>rayon</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>G�y�ay</name>
    <code>GOY</code>
    <category>rayon</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Haciqabul</name>
    <code>HAC</code>
    <category>rayon</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Imisli</name>
    <code>IMI</code>
    <category>rayon</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Ismayilli</name>
    <code>ISM</code>
    <category>rayon</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>K�lb�c�r</name>
    <code>KAL</code>
    <category>rayon</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>K�rd�mir</name>
    <code>KUR</code>
    <category>rayon</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>La�in</name>
    <code>LAC</code>
    <category>rayon</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>L�nk�ran</name>
    <code>LAN</code>
    <category>rayon</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Lerik</name>
    <code>LER</code>
    <category>rayon</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Masalli</name>
    <code>MAS</code>
    <category>rayon</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Neft�ala</name>
    <code>NEF</code>
    <category>rayon</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Oguz</name>
    <code>OGU</code>
    <category>rayon</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Ordubad</name>
    <code>ORD</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>Q�b�l�</name>
    <code>QAB</code>
    <category>rayon</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Qax</name>
    <code>QAX</code>
    <category>rayon</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Qazax</name>
    <code>QAZ</code>
    <category>rayon</category>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Qobustan</name>
    <code>QOB</code>
    <category>rayon</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Quba</name>
    <code>QBA</code>
    <category>rayon</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Qubadli</name>
    <code>QBI</code>
    <category>rayon</category>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Qusar</name>
    <code>QUS</code>
    <category>rayon</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Saatli</name>
    <code>SAT</code>
    <category>rayon</category>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Sabirabad</name>
    <code>SAB</code>
    <category>rayon</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>S�d�r�k</name>
    <code>SAD</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>Sahbuz</name>
    <code>SAH</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>S�ki</name>
    <code>SAK</code>
    <category>rayon</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Salyan</name>
    <code>SAL</code>
    <category>rayon</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Samaxi</name>
    <code>SMI</code>
    <category>rayon</category>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>S�mkir</name>
    <code>SKR</code>
    <category>rayon</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Samux</name>
    <code>SMX</code>
    <category>rayon</category>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>S�rur</name>
    <code>SAR</code>
    <regional_division>NX</regional_division>
    <category>rayon</category>
  </subcountry>
  <subcountry>
    <name>Siy�z�n</name>
    <code>SIY</code>
    <category>rayon</category>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Susa</name>
    <code>SUS</code>
    <category>rayon</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>T�rt�r</name>
    <code>TAR</code>
    <category>rayon</category>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Tovuz</name>
    <code>TOV</code>
    <category>rayon</category>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Ucar</name>
    <code>UCA</code>
    <category>rayon</category>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Xa�maz</name>
    <code>XAC</code>
    <category>rayon</category>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Xanlar</name>
    <code>XAN</code>
    <category>rayon</category>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Xizi</name>
    <code>XIZ</code>
    <category>rayon</category>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Xocali</name>
    <code>XCI</code>
    <category>rayon</category>
    <FIPS>64</FIPS>
  </subcountry>
  <subcountry>
    <name>Xocav�nd</name>
    <code>XVD</code>
    <category>rayon</category>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Yardimli</name>
    <code>YAR</code>
    <category>rayon</category>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Yevlax</name>
    <code>YEV</code>
    <category>rayon</category>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Z�ngilan</name>
    <code>ZAN</code>
    <category>rayon</category>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Zaqatala</name>
    <code>ZAQ</code>
    <category>rayon</category>
    <FIPS>70</FIPS>
  </subcountry>
  <subcountry>
    <name>Z�rdab</name>
    <code>ZAR</code>
    <category>rayon</category>
    <FIPS>71</FIPS>
  </subcountry>
</country>

<country>
  <name>BOSNIA AND HERZEGOVINA</name>
  <code>BA</code>
  <subcountry>
    <name>Federacija Bosna i Hercegovina</name>
    <code>BIH</code>
  </subcountry>
  <subcountry>
    <name>Republika Srpska</name>
    <code>SRP</code>
    <FIPS>SS</FIPS>
  </subcountry>
</country>

<country>
  <name>BANGLADESH</name>
  <code>BD</code>
  <subcountry>
    <name>Bagerhat zila</name>
    <code>05</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Bandarban zila</name>
    <code>01</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Barguna zila</name>
    <code>02</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Barisal zila</name>
    <code>06</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Bhola zila</name>
    <code>07</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Bogra zila</name>
    <code>03</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Brahmanbaria zila</name>
    <code>04</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Chandpur zila</name>
    <code>09</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Chittagong zila</name>
    <code>10</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Chuadanga zila</name>
    <code>12</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Comilla zila</name>
    <code>08</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Cox's Bazar zila</name>
    <code>11</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Dhaka zila</name>
    <code>13</code>
    <regional_division>3</regional_division>
    <FIPS>81</FIPS>
  </subcountry>
  <subcountry>
    <name>Dinajpur zila</name>
    <code>14</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Faridpur zila</name>
    <code>15</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Feni zila</name>
    <code>16</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Gaibandha zila</name>
    <code>19</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Gazipur zila</name>
    <code>18</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Gopalganj zila</name>
    <code>17</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Habiganj zila</name>
    <code>20</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Jaipurhat zila</name>
    <code>24</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Jamalpur zila</name>
    <code>21</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Jessore zila</name>
    <code>22</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Jhalakati zila</name>
    <code>25</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Jhenaidah zila</name>
    <code>23</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Khagrachari zila</name>
    <code>29</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Khulna zila</name>
    <code>27</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Kishoreganj zila</name>
    <code>26</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Kurigram zila</name>
    <code>28</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Kushtia zila</name>
    <code>30</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Lakshmipur zila</name>
    <code>31</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Lalmonirhat zila</name>
    <code>32</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Madaripur zila</name>
    <code>36</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Magura zila</name>
    <code>37</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Manikganj zila</name>
    <code>33</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Meherpur zila</name>
    <code>39</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Moulvibazar zila</name>
    <code>38</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Munshiganj zila</name>
    <code>35</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Mymensingh zila</name>
    <code>34</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Naogaon zila</name>
    <code>48</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Narail zila</name>
    <code>43</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Narayanganj zila</name>
    <code>40</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Narsingdi zila</name>
    <code>42</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Natore zila</name>
    <code>44</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Nawabganj zila</name>
    <code>45</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Netrakona zila</name>
    <code>41</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Nilphamari zila</name>
    <code>46</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Noakhali zila</name>
    <code>47</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Pabna zila</name>
    <code>49</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Panchagarh zila</name>
    <code>52</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Patuakhali zila</name>
    <code>51</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Pirojpur zila</name>
    <code>50</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Rajbari zila</name>
    <code>53</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Rajshahi zila</name>
    <code>54</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Rangamati zila</name>
    <code>56</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Rangpur zila</name>
    <code>55</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Satkhira zila</name>
    <code>58</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Shariatpur zila</name>
    <code>62</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Sherpur zila</name>
    <code>57</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Sirajganj zila</name>
    <code>59</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Sunamganj zila</name>
    <code>61</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Sylhet zila</name>
    <code>60</code>
    <regional_division>6</regional_division>
  </subcountry>
  <subcountry>
    <name>Tangail zila</name>
    <code>63</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Thakurgaon zila</name>
    <code>64</code>
    <regional_division>5</regional_division>
  </subcountry>
</country>

<country>
  <name>BELGIUM</name>
  <code>BE</code>
  <subcountry>
    <name>Antwerp</name>
    <code>VAN</code>
    <regional_division>VLG</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Wallon Brabant</name>
    <code>WBR</code>
    <regional_division>WAL</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Hainaut</name>
    <code>WHT</code>
    <regional_division>WAL</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Li�ge</name>
    <code>WLG</code>
    <regional_division>WAL</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Limburg</name>
    <code>VLI</code>
    <regional_division>VLG</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Luxembourg</name>
    <code>WLX</code>
    <regional_division>WAL</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Namur</name>
    <code>WNA</code>
    <regional_division>WAL</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>East Flanders</name>
    <code>VOV</code>
    <regional_division>VLG</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Vlaams Brabant</name>
    <code>VBR</code>
    <regional_division>VLG</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>West Flanders </name>
    <code>VWV</code>
    <regional_division>VLG</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>BURKINA FASO</name>
  <code>BF</code>
  <subcountry>
    <name>Bal�</name>
    <code>BAL</code>
  </subcountry>
  <subcountry>
    <name>Bam</name>
    <code>BAM</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Banwa</name>
    <code>BAN</code>
  </subcountry>
  <subcountry>
    <name>Baz�ga</name>
    <code>BAZ</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Bougouriba</name>
    <code>BGR</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Boulgou</name>
    <code>BLG</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Boulkiemd�</name>
    <code>BLK</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Como�</name>
    <code>COM</code>
  </subcountry>
  <subcountry>
    <name>Ganzourgou</name>
    <code>GAN</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Gnagna</name>
    <code>GNA</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Gourma</name>
    <code>GOU</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Houet</name>
    <code>HOU</code>
  </subcountry>
  <subcountry>
    <name>Ioba</name>
    <code>IOB</code>
  </subcountry>
  <subcountry>
    <name>Kadiogo</name>
    <code>KAD</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>K�n�dougou</name>
    <code>KEN</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Komondjari</name>
    <code>KMD</code>
  </subcountry>
  <subcountry>
    <name>Kompienga</name>
    <code>KMP</code>
  </subcountry>
  <subcountry>
    <name>Kossi</name>
    <code>KOS</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Koulp�logo</name>
    <code>KOP</code>
  </subcountry>
  <subcountry>
    <name>Kouritenga</name>
    <code>KOT</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Kourw�ogo</name>
    <code>KOW</code>
  </subcountry>
  <subcountry>
    <name>L�raba</name>
    <code>LER</code>
  </subcountry>
  <subcountry>
    <name>Loroum</name>
    <code>LOR</code>
  </subcountry>
  <subcountry>
    <name>Mouhoun</name>
    <code>MOU</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Nahouri</name>
    <code>NAO</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Namentenga</name>
    <code>NAM</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Nayala</name>
    <code>NAY</code>
  </subcountry>
  <subcountry>
    <name>Noumbiel</name>
    <code>NOU</code>
  </subcountry>
  <subcountry>
    <name>Oubritenga</name>
    <code>OUB</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Oudalan</name>
    <code>OUD</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Passor�</name>
    <code>PAS</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Poni</name>
    <code>PON</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Sangui�</name>
    <code>SNG</code>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Sanmatenga</name>
    <code>SMT</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>S�no</name>
    <code>SEN</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Sissili</name>
    <code>SIS</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Soum</name>
    <code>SOM</code>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Sourou</name>
    <code>SOR</code>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Tapoa</name>
    <code>TAP</code>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Tui</name>
    <code>TUI</code>
  </subcountry>
  <subcountry>
    <name>Yagha</name>
    <code>YAG</code>
  </subcountry>
  <subcountry>
    <name>Yatenga</name>
    <code>YAT</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Ziro</name>
    <code>ZIR</code>
  </subcountry>
  <subcountry>
    <name>Zondoma</name>
    <code>ZON</code>
  </subcountry>
  <subcountry>
    <name>Zoundw�ogo</name>
    <code>ZOU</code>
    <FIPS>44</FIPS>
  </subcountry>
</country>

<country>
  <name>BULGARIA</name>
  <code>BG</code>
  <subcountry>
    <name>Blagoevgrad</name>
    <code>01</code>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Burgas</name>
    <code>02</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Dobric</name>
    <code>08</code>
    <FIPS>58</FIPS>
  </subcountry>
</country>

<country>
  <name>MOROCCO</name>
  <code>MA</code>
  <subcountry>
    <name>Figuig</name>
    <code>FIG</code>
    <regional_division>04</regional_division>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Guelmim</name>
    <code>GUE</code>
    <regional_division>14</regional_division>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Ifrane</name>
    <code>IFR</code>
    <regional_division>06</regional_division>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Jerada</name>
    <code>JRA</code>
    <regional_division>04</regional_division>
  </subcountry>
  <subcountry>
    <name>Kelaat Sraghna</name>
    <code>KES</code>
    <regional_division>11</regional_division>
  </subcountry>
  <subcountry>
    <name>K�nitra</name>
    <code>KEN</code>
    <regional_division>02</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Khemisset</name>
    <code>KHE</code>
    <regional_division>07</regional_division>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Khenifra</name>
    <code>KHN</code>
    <regional_division>06</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Khouribga</name>
    <code>KHO</code>
    <regional_division>09</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Laayoune (EH)</name>
    <code>LAA</code>
    <regional_division>15</regional_division>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Larache</name>
    <code>LAR</code>
    <regional_division>01</regional_division>
  </subcountry>
  <subcountry>
    <name>Marrakech</name>
    <code>MAR</code>
    <regional_division>11</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Mekn�s</name>
    <code>MEK</code>
    <regional_division>06</regional_division>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Nador</name>
    <code>NAD</code>
    <regional_division>04</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouarzazate</name>
    <code>OUA</code>
    <regional_division>13</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Oued ed Dahab (EH)</name>
    <code>OUD</code>
    <regional_division>16</regional_division>
  </subcountry>
  <subcountry>
    <name>Oujda</name>
    <code>OUJ</code>
    <regional_division>04</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Rabat-Sal�</name>
    <code>RBA</code>
    <regional_division>07</regional_division>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Safi</name>
    <code>SAF</code>
    <regional_division>10</regional_division>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Sefrou</name>
    <code>SEF</code>
    <regional_division>05</regional_division>
  </subcountry>
  <subcountry>
    <name>Settat</name>
    <code>SET</code>
    <regional_division>09</regional_division>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Sidi Kacem</name>
    <code>SIK</code>
    <regional_division>02</regional_division>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Tanger</name>
    <code>TNG</code>
    <regional_division>01</regional_division>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Tan-Tan</name>
    <code>TNT</code>
    <regional_division>14</regional_division>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Taounate</name>
    <code>TAO</code>
    <regional_division>03</regional_division>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Taroudannt</name>
    <code>TAR</code>
    <regional_division>13</regional_division>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Tata</name>
    <code>TAT</code>
    <regional_division>14</regional_division>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Taza</name>
    <code>TAZ</code>
    <regional_division>03</regional_division>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>T�touan</name>
    <code>TET</code>
    <regional_division>01</regional_division>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Tiznit</name>
    <code>TIZ</code>
    <regional_division>13</regional_division>
    <FIPS>32</FIPS>
  </subcountry>
</country>

<country>
  <name>MOLDOVA, REPUPLIC OF</name>
  <code>MD</code>
  <subcountry>
    <name>Gagauzia, Unitate Teritoriala Autonoma (UTAG)</name>
    <code>GA</code>
    <category>autonomous territory</category>
  </subcountry>
  <subcountry>
    <name>Chisinau</name>
    <code>CU</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>St�nga Nistrului, unitatea teritoriala din</name>
    <code>SN</code>
    <category>territorial unit</category>
  </subcountry>
  <subcountry>
    <name>Balti</name>
    <code>BA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Cahul</name>
    <code>CA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Chisinau</name>
    <code>CH</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Edinet</name>
    <code>ED</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Lapusna</name>
    <code>LA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Orhei</name>
    <code>OR</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Soroca</name>
    <code>SO</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Tighina [Bender]</name>
    <code>TI</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Ungheni</name>
    <code>UN</code>
    <category>district</category>
  </subcountry>
</country>

<country>
  <name>MADAGASCAR</name>
  <code>MG</code>
  <subcountry>
    <name>Antananarivo</name>
    <code>T</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Antsiranana</name>
    <code>D</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Fianarantsoa</name>
    <code>F</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Mahajanga</name>
    <code>M</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Toamasina</name>
    <code>A</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Toliara</name>
    <code>U</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>MARSHALL ISLANDS</name>
  <code>MH</code>
  <subcountry>
    <name>Ailinglapalap</name>
    <code>ALL</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Ailuk</name>
    <code>ALK</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Arno</name>
    <code>ARN</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Aur</name>
    <code>AUR</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Ebon</name>
    <code>EBO</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Eniwetok</name>
    <code>ENI</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Jaluit</name>
    <code>JAL</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Kili</name>
    <code>KIL</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Kwajalein</name>
    <code>KWA</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Lae</name>
    <code>LAE</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Lib</name>
    <code>LIB</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Likiep</name>
    <code>LIK</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Majuro</name>
    <code>MAJ</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Maloelap</name>
    <code>MAL</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Mejit</name>
    <code>MEJ</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Mili</name>
    <code>MIL</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Namorik</name>
    <code>NMK</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Namu</name>
    <code>NMU</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Rongelap</name>
    <code>RON</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Ujae</name>
    <code>UJA</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Ujelang</name>
    <code>UJL</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Utirik</name>
    <code>UTI</code>
    <regional_division>T</regional_division>
  </subcountry>
  <subcountry>
    <name>Wotho</name>
    <code>WTH</code>
    <regional_division>L</regional_division>
  </subcountry>
  <subcountry>
    <name>Wotje</name>
    <code>WTJ</code>
    <regional_division>T</regional_division>
  </subcountry>
</country>

<country>
  <name>BULGARIA</name>
  <code>BG</code>
  <subcountry>
    <name>Gabrovo</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Haskovo</name>
    <code>26</code>
  </subcountry>
  <subcountry>
    <name>Jambol</name>
    <code>28</code>
  </subcountry>
  <subcountry>
    <name>Kard�ali</name>
    <code>09</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Kjustendil</name>
    <code>10</code>
  </subcountry>
  <subcountry>
    <name>Lovec</name>
    <code>11</code>
  </subcountry>
  <subcountry>
    <name>Montana</name>
    <code>12</code>
  </subcountry>
  <subcountry>
    <name>Pazard�ik</name>
    <code>13</code>
  </subcountry>
  <subcountry>
    <name>Pernik</name>
    <code>14</code>
  </subcountry>
  <subcountry>
    <name>Pleven</name>
    <code>15</code>
  </subcountry>
  <subcountry>
    <name>Plovdiv</name>
    <code>16</code>
  </subcountry>
  <subcountry>
    <name>Razgrad</name>
    <code>17</code>
  </subcountry>
  <subcountry>
    <name>Ruse</name>
    <code>18</code>
  </subcountry>
  <subcountry>
    <name>Silistra</name>
    <code>19</code>
  </subcountry>
  <subcountry>
    <name>Sliven</name>
    <code>20</code>
  </subcountry>
  <subcountry>
    <name>Smoljan</name>
    <code>21</code>
  </subcountry>
  <subcountry>
    <name>Sofija</name>
    <code>23</code>
  </subcountry>
  <subcountry>
    <name>Sofija-Grad</name>
    <code>22</code>
  </subcountry>
  <subcountry>
    <name>Stara Zagora</name>
    <code>24</code>
  </subcountry>
  <subcountry>
    <name>�umen</name>
    <code>27</code>
  </subcountry>
  <subcountry>
    <name>Targovi�te</name>
    <code>25</code>
  </subcountry>
  <subcountry>
    <name>Varna</name>
    <code>03</code>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Veliko Tarnovo</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>Vidin</name>
    <code>05</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Vraca</name>
    <code>06</code>
    <FIPS>51</FIPS>
  </subcountry>
</country>

<country>
  <name>BAHRAIN</name>
  <code>BH</code>
  <subcountry>
    <name>Al Hadd</name>
    <code>01</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Manamah</name>
    <code>03</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Mintaqah al Gharbiyah</name>
    <code>10</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Mintaqah al Wust�</name>
    <code>07</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Mintaqah ash Shamaliyah</name>
    <code>05</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Muharraq</name>
    <code>02</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ar Rifa</name>
    <code>09</code>
  </subcountry>
  <subcountry>
    <name>Jidd Hafs</name>
    <code>04</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Madinat Hamad</name>
    <code>12</code>
  </subcountry>
  <subcountry>
    <name>Madinat `Is�</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Mintaqat Juzur Hawar</name>
    <code>11</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Sitrah</name>
    <code>06</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>BURUNDI</name>
  <code>BI</code>
  <subcountry>
    <name>Bubanza</name>
    <code>BB</code>
  </subcountry>
  <subcountry>
    <name>Bujumbura</name>
    <code>BJ</code>
  </subcountry>
  <subcountry>
    <name>Bururi</name>
    <code>BR</code>
  </subcountry>
  <subcountry>
    <name>Cankuzo</name>
    <code>CA</code>
  </subcountry>
  <subcountry>
    <name>Cibitoke</name>
    <code>CI</code>
  </subcountry>
  <subcountry>
    <name>Gitega</name>
    <code>GI</code>
  </subcountry>
  <subcountry>
    <name>Karuzi</name>
    <code>KR</code>
  </subcountry>
  <subcountry>
    <name>Kayanza</name>
    <code>KY</code>
  </subcountry>
  <subcountry>
    <name>Kirundo</name>
    <code>KI</code>
  </subcountry>
  <subcountry>
    <name>Makamba</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Muramvya</name>
    <code>MU</code>
  </subcountry>
  <subcountry>
    <name>Muyinga</name>
    <code>MY</code>
  </subcountry>
  <subcountry>
    <name>Ngozi</name>
    <code>NG</code>
  </subcountry>
  <subcountry>
    <name>Rutana</name>
    <code>RT</code>
  </subcountry>
  <subcountry>
    <name>Ruyigi</name>
    <code>RY</code>
  </subcountry>
</country>

<country>
  <name>BENIN</name>
  <code>BJ</code>
  <subcountry>
    <name>Alibori</name>
    <code>AL</code>
  </subcountry>
  <subcountry>
    <name>Atakora</name>
    <code>AK</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Atlantique</name>
    <code>AQ</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Borgou</name>
    <code>BO</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Collines</name>
    <code>CO</code>
  </subcountry>
  <subcountry>
    <name>Donga</name>
    <code>DO</code>
  </subcountry>
  <subcountry>
    <name>Kouffo</name>
    <code>KO</code>
  </subcountry>
  <subcountry>
    <name>Littoral</name>
    <code>LI</code>
  </subcountry>
  <subcountry>
    <name>Mono</name>
    <code>MO</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Ou�m�</name>
    <code>OU</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Plateau</name>
    <code>PL</code>
  </subcountry>
  <subcountry>
    <name>Zou</name>
    <code>ZO</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>BRUNEI DARUSSALAM</name>
  <code>BN</code>
  <subcountry>
    <name>Belait</name>
    <code>BE</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Brunei-Muara</name>
    <code>BM</code>
  </subcountry>
  <subcountry>
    <name>Temburong</name>
    <code>TE</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Tutong</name>
    <code>TU</code>
    <FIPS>04</FIPS>
  </subcountry>
</country>

<country>
  <name>BOLIVIA</name>
  <code>BO</code>
  <subcountry>
    <name>Cochabamba</name>
    <code>C</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chuquisaca</name>
    <code>H</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>El Beni</name>
    <code>B</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>La Paz</name>
    <code>L</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Oruro</name>
    <code>O</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Pando</name>
    <code>N</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Potos�</name>
    <code>P</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Cruz</name>
    <code>S</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Tarija</name>
    <code>T</code>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>BRAZIL</name>
  <code>BR</code>
  <subcountry>
    <name>Distrito Federal</name>
    <code>DF</code>
    <category>federal district</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Acre</name>
    <code>AC</code>
    <category>state</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Alagoas</name>
    <code>AL</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Amap�</name>
    <code>AP</code>
    <category>state</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Amazonas</name>
    <code>AM</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Bahia</name>
    <code>BA</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Cear�</name>
    <code>CE</code>
    <category>state</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Esp�rito Santo</name>
    <code>ES</code>
    <category>state</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Goi�s</name>
    <code>GO</code>
    <category>state</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Maranh�o</name>
    <code>MA</code>
    <category>state</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Mato Grosso</name>
    <code>MT</code>
    <category>state</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Mato Grosso do Sul</name>
    <code>MS</code>
    <category>state</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Minas Gerais</name>
    <code>MG</code>
    <category>state</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Par�</name>
    <code>PA</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Para�ba</name>
    <code>PB</code>
    <category>state</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Paran�</name>
    <code>PR</code>
    <category>state</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Pernambuco</name>
    <code>PE</code>
    <category>state</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Piau�</name>
    <code>PI</code>
    <category>state</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Rio de Janeiro</name>
    <code>RJ</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Rio Grande do Norte</name>
    <code>RN</code>
    <category>state</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Rio Grande do Sul</name>
    <code>RS</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Rond�nia</name>
    <code>RO</code>
    <category>state</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Roraima</name>
    <code>RR</code>
    <category>state</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Catarina</name>
    <code>SC</code>
    <category>state</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>S�o Paulo</name>
    <code>SP</code>
    <category>state</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Sergipe</name>
    <code>SE</code>
    <category>state</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Tocantins</name>
    <code>TO</code>
    <category>state</category>
    <FIPS>31</FIPS>
  </subcountry>
</country>

<country>
  <name>BAHAMAS</name>
  <code>BS</code>
  <subcountry>
    <name>Acklins and Crooked Islands</name>
    <code>AC</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Bimini</name>
    <code>BI</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cat Island</name>
    <code>CI</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Exuma</name>
    <code>EX</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Freeport</name>
    <code>FP</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Fresh Creek</name>
    <code>FC</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Governor's Harbour</name>
    <code>GH</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Green Turtle Cay</name>
    <code>GT</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Harbour Island</name>
    <code>HI</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>High Rock</name>
    <code>HR</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Inagua</name>
    <code>IN</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Kemps Bay</name>
    <code>KB</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Long Island</name>
    <code>LI</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Marsh Harbour</name>
    <code>MH</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Mayaguana</name>
    <code>MG</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>New Providence</name>
    <code>NP</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Nicholls Town and Berry Islands</name>
    <code>NB</code>
  </subcountry>
  <subcountry>
    <name>Ragged Island</name>
    <code>RI</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Rock Sound</name>
    <code>RS</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Sandy Point</name>
    <code>SP</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>San Salvador and Rum Cay</name>
    <code>SR</code>
    <FIPS>35</FIPS>
  </subcountry>
</country>


<country>
  <name>BHUTAN</name>
  <code>BT</code>
  <subcountry>
    <name>Bumthang</name>
    <code>33</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Chhukha</name>
    <code>12</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dagana</name>
    <code>22</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Gasa</name>
    <code>GA</code>
  </subcountry>
  <subcountry>
    <name>Ha</name>
    <code>13</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Lhuentse</name>
    <code>44</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Monggar</name>
    <code>42</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Paro</name>
    <code>11</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Pemagatshel</name>
    <code>43</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Punakha</name>
    <code>23</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Samdrup Jongkha</name>
    <code>45</code>
  </subcountry>
  <subcountry>
    <name>Samtse</name>
    <code>14</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Sarpang</name>
    <code>31</code>
  </subcountry>
  <subcountry>
    <name>Thimphu</name>
    <code>15</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Trashigang</name>
    <code>41</code>
  </subcountry>
  <subcountry>
    <name>Trashi Yangtse</name>
    <code>TY</code>
  </subcountry>
  <subcountry>
    <name>Trongsa</name>
    <code>32</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Tsirang</name>
    <code>21</code>
  </subcountry>
  <subcountry>
    <name>Wangdue Phodrang</name>
    <code>24</code>
  </subcountry>
  <subcountry>
    <name>Zhemgang</name>
    <code>34</code>
  </subcountry>
</country>

<country>
  <name>BOTSWANA</name>
  <code>BW</code>
  <subcountry>
    <name>Central</name>
    <code>CE</code>
  </subcountry>
  <subcountry>
    <name>Ghanzi</name>
    <code>GH</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Kgalagadi</name>
    <code>KG</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Kgatleng</name>
    <code>KL</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Kweneng</name>
    <code>KW</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>North-West</name>
    <code>NW</code>
  </subcountry>
  <subcountry>
    <name>North-East</name>
    <code>NE</code>
  </subcountry>
  <subcountry>
    <name>South-East</name>
    <code>SE</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Southern</name>
    <code>SO</code>
  </subcountry>
</country>

<country>
  <name>BELARUS</name>
  <code>BY</code>
  <subcountry>
    <name>Brest</name>
    <code>BR</code>
  </subcountry>
  <subcountry>
    <name>Homyel'</name>
    <code>HO</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Hrodna</name>
    <code>HR</code>
  </subcountry>
  <subcountry>
    <name>Mahilyow</name>
    <code>MA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Minsk</name>
    <code>MI</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Vitsyebsk</name>
    <code>VI</code>
  </subcountry>
</country>

<country>
  <name>BELIZE</name>
  <code>BZ</code>
  <subcountry>
    <name>Belize</name>
    <code>BZ</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Cayo</name>
    <code>CY</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Corozal</name>
    <code>CZL</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Orange Walk</name>
    <code>OW</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Stann Creek</name>
    <code>SC</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Toledo</name>
    <code>TOL</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>CANADA</name>
  <code>CA</code>
  <subcountry>
    <name>Alberta</name>
    <code>AB</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>British Columbia</name>
    <code>BC</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Manitoba</name>
    <code>MB</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>New Brunswick</name>
    <code>NB</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Newfoundland and Labrador</name>
    <code>NL</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Nova Scotia</name>
    <code>NS</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ontario</name>
    <code>ON</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Prince Edward Island</name>
    <code>PE</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Quebec</name>
    <code>QC</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Saskatchewan</name>
    <code>SK</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Northwest Territories</name>
    <code>NT</code>
    <category>territory</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Nunavut</name>
    <code>NU</code>
    <category>territory</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Yukon Territory</name>
    <code>YT</code>
    <category>territory</category>
    <FIPS>12</FIPS>
  </subcountry>
</country>

<country>
  <name>CONGO (KINSHASA)</name>
  <code>CD</code>
  <subcountry>
    <name>Kinshasa</name>
    <code>KN</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Bandundu</name>
    <code>BN</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Bas-Congo</name>
    <code>BC</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>�quateur</name>
    <code>EQ</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Kasai-Occidental</name>
    <code>KW</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Kasai-Oriental</name>
    <code>KE</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Katanga</name>
    <code>KA</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Maniema</name>
    <code>MA</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Nord-Kivu</name>
    <code>NK</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Orientale</name>
    <code>OR</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Sud-Kivu</name>
    <code>SK</code>
    <category>province</category>
  </subcountry>
</country>

<country>
  <name>CENTRAL AFRICAN REPUBLIC</name>
  <code>CF</code>
  <subcountry>
    <name>Bangui</name>
    <code>BGF</code>
    <category>capital</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Bamingui-Bangoran</name>
    <code>BB</code>
    <category>prefecture</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Basse-Kotto</name>
    <code>BK</code>
    <category>prefecture</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Haute-Kotto</name>
    <code>HK</code>
    <category>prefecture</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Haut-Mbomou</name>
    <code>HM</code>
    <category>prefecture</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>K�mo</name>
    <code>KG</code>
    <category>prefecture</category>
  </subcountry>
  <subcountry>
    <name>Lobaye</name>
    <code>LB</code>
    <category>prefecture</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Mamb�r�-Kad��</name>
    <code>HS</code>
    <category>prefecture</category>
  </subcountry>
  <subcountry>
    <name>Mbomou</name>
    <code>MB</code>
    <category>prefecture</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Nana-Gr�bizi</name>
    <code>KB</code>
    <category>prefecture</category>
  </subcountry>
  <subcountry>
    <name>Nana-Mamb�r�</name>
    <code>NM</code>
    <category>prefecture</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Ombella-Mpoko</name>
    <code>MP</code>
    <category>prefecture</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouaka</name>
    <code>UK</code>
    <category>prefecture</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouham</name>
    <code>AC</code>
    <category>prefecture</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouham-Pend�</name>
    <code>OP</code>
    <category>prefecture</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Sangha-Mba�r�</name>
    <code>SE</code>
    <category>prefecture</category>
  </subcountry>
  <subcountry>
    <name>Vakaga</name>
    <code>VK</code>
    <category>prefecture</category>
  </subcountry>
</country>

<country>
  <name>CONGO (BRAZZAVILLE)</name>
  <code>CG</code>
  <subcountry>
    <name>Brazzaville</name>
    <code>BZV</code>
    <category>capital</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Bouenza</name>
    <code>11</code>
    <category>region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuvette</name>
    <code>8</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuvette-Ouest</name>
    <code>15</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Kouilou</name>
    <code>5</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>L�koumou</name>
    <code>2</code>
    <category>region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Likouala</name>
    <code>7</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Niari</name>
    <code>9</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Plateaux</name>
    <code>14</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Pool</name>
    <code>12</code>
    <category>region</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Sangha</name>
    <code>13</code>
    <category>region</category>
    <FIPS>10</FIPS>
  </subcountry>
</country>

<country>
  <name>SWITZERLAND</name>
  <code>CH</code>
  <subcountry>
    <name>Aargau</name>
    <code>AG</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Appenzell Ausserrhoden</name>
    <code>AR</code>
  </subcountry>
  <subcountry>
    <name>Appenzell Innerrhoden</name>
    <code>AI</code>
  </subcountry>
  <subcountry>
    <name>Basel-Landschaft</name>
    <code>BL</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Basel-Stadt</name>
    <code>BS</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Bern</name>
    <code>BE</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Fribourg</name>
    <code>FR</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Gen�ve</name>
    <code>GE</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Glarus</name>
    <code>GL</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Graub�nden</name>
    <code>GR</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Jura</name>
    <code>JU</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Luzern</name>
    <code>LU</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Neuch�tel</name>
    <code>NE</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Nidwalden</name>
    <code>NW</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Obwalden</name>
    <code>OW</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Sankt Gallen</name>
    <code>SG</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Schaffhausen</name>
    <code>SH</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Schwyz</name>
    <code>SZ</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Solothurn</name>
    <code>SO</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Thurgau</name>
    <code>TG</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Ticino</name>
    <code>TI</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Uri</name>
    <code>UR</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Valais</name>
    <code>VS</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Vaud</name>
    <code>VD</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Zug</name>
    <code>ZG</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Z�rich</name>
    <code>ZH</code>
    <FIPS>25</FIPS>
  </subcountry>
</country>

<country>
  <name>C�TE D'IVOIRE</name>
  <code>CI</code>
  <subcountry>
    <name>Dix-Huit Montagnes</name>
    <code>06</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Agn�bi )</name>
    <code>16</code>
  </subcountry>
  <subcountry>
    <name>Bas-Sassandra</name>
    <code>09</code>
  </subcountry>
  <subcountry>
    <name>Dengu�l�</name>
    <code>10</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Haut-Sassandra</name>
    <code>02</code>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Lacs</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Lagunes</name>
    <code>01</code>
  </subcountry>
  <subcountry>
    <name>Marahou�</name>
    <code>12</code>
  </subcountry>
  <subcountry>
    <name>Moyen-Como�</name>
    <code>05</code>
  </subcountry>
  <subcountry>
    <name>Nzi-Como�</name>
    <code>11</code>
  </subcountry>
  <subcountry>
    <name>Savanes</name>
    <code>03</code>
  </subcountry>
  <subcountry>
    <name>Sud-Bandama</name>
    <code>15</code>
  </subcountry>
  <subcountry>
    <name>Sud-Como�</name>
    <code>13</code>
  </subcountry>
  <subcountry>
    <name>Vall�e du Bandama</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>Worodougou</name>
    <code>14</code>
  </subcountry>
  <subcountry>
    <name>Zanzan</name>
    <code>08</code>
  </subcountry>
</country>

<country>
  <name>CHILE</name>
  <code>CL</code>
  <subcountry>
    <name>Ais�n del General Carlos Ib��ez del Campo</name>
    <code>AI</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Antofagasta</name>
    <code>AN</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Araucan�a</name>
    <code>AR</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Atacama</name>
    <code>AT</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>B�o-B�o</name>
    <code>BI</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Coquimbo</name>
    <code>CO</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Libertador General Bernardo O'Higgins</name>
    <code>LI</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Los Lagos</name>
    <code>LL</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Magallanes</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Maule</name>
    <code>ML</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Regi�n Metropolitana de Santiago</name>
    <code>RM</code>
  </subcountry>
  <subcountry>
    <name>Tarapac�</name>
    <code>TA</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Valpara�so</name>
    <code>VS</code>
    <FIPS>01</FIPS>
  </subcountry>
</country>

<country>
  <name>CAMEROON</name>
  <code>CM</code>
  <subcountry>
    <name>Adamaoua</name>
    <code>AD</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Centre</name>
    <code>CE</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>East</name>
    <code>ES</code>
  </subcountry>
  <subcountry>
    <name>Far North</name>
    <code>EN</code>
  </subcountry>
  <subcountry>
    <name>Littoral</name>
    <code>LT</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>North</name>
    <code>NO</code>
  </subcountry>
  <subcountry>
    <name>North-West</name>
    <code>NW</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>South</name>
    <code>SU</code>
  </subcountry>
  <subcountry>
    <name>South-West</name>
    <code>SW</code>
  </subcountry>
  <subcountry>
    <name>West</name>
    <code>OU</code>
  </subcountry>
</country>

<country>
  <name>CHINA</name>
  <code>CN</code>
  <subcountry>
    <name>Beijing</name>
    <code>11</code>
    <category>municipality</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Chongqing</name>
    <code>50</code>
    <category>municipality</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Shanghai</name>
    <code>31</code>
    <category>municipality</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Tianjin</name>
    <code>12</code>
    <category>municipality</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Anhui</name>
    <code>34</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Fujian</name>
    <code>35</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Gansu</name>
    <code>62</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Guangdong</name>
    <code>44</code>
    <category>province</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Guizhou</name>
    <code>52</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Hainan</name>
    <code>46</code>
    <category>province</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Hebei</name>
    <code>13</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Heilongjiang</name>
    <code>23</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Henan</name>
    <code>41</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Hubei</name>
    <code>42</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Hunan</name>
    <code>43</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Jiangsu</name>
    <code>32</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Jiangxi</name>
    <code>36</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Jilin</name>
    <code>22</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Liaoning</name>
    <code>21</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Qinghai</name>
    <code>63</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Shaanxi</name>
    <code>61</code>
    <category>province</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Shandong</name>
    <code>37</code>
    <category>province</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Shanxi</name>
    <code>14</code>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Sichuan</name>
    <code>51</code>
    <category>province</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Taiwan </name>
    <code>71</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Yunnan</name>
    <code>53</code>
    <category>province</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Zhejiang</name>
    <code>33</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Guangxi</name>
    <code>45</code>
    <category>autonomous region</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Neimenggu</name>
    <code>15</code>
    <category>autonomous region</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Ningxia</name>
    <code>64</code>
    <category>autonomous region</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Xinjiang</name>
    <code>65</code>
    <category>autonomous region</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Xizang</name>
    <code>54</code>
    <category>autonomous region</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Xianggang</name>
    <code>91</code>
    <category>special administrative region</category>
  </subcountry>
  <subcountry>
    <name>Aomen</name>
    <code>92</code>
    <category>special administrative region</category>
  </subcountry>
</country>

<country>
  <name>COLOMBIA</name>
  <code>CO</code>
  <subcountry>
    <name>Distrito Capital de Santa Fe de Bogot�</name>
    <code>DC</code>
    <category>capital district</category>
  </subcountry>
  <subcountry>
    <name>Amazonas</name>
    <code>AMA</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Antioquia</name>
    <code>ANT</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Arauca</name>
    <code>ARA</code>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Atl�ntico</name>
    <code>ATL</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Bol�var</name>
    <code>BOL</code>
    <category>department</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Boyac�</name>
    <code>BOY</code>
    <category>department</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Caldas</name>
    <code>CAL</code>
    <category>department</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Caquet�</name>
    <code>CAQ</code>
    <category>department</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Casanare</name>
    <code>CAS</code>
    <category>department</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Cauca</name>
    <code>CAU</code>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Cesar</name>
    <code>CES</code>
    <category>department</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>C�rdoba</name>
    <code>COR</code>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Cundinamarca</name>
    <code>CUN</code>
    <category>department</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Choc�</name>
    <code>CHO</code>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Guain�a</name>
    <code>GUA</code>
    <category>department</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Guaviare</name>
    <code>GUV</code>
    <category>department</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Huila</name>
    <code>HUI</code>
    <category>department</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>La Guajira</name>
    <code>LAG</code>
    <category>department</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Magdalena</name>
    <code>MAG</code>
    <category>department</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Meta</name>
    <code>MET</code>
    <category>department</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Nari�o</name>
    <code>NAR</code>
    <category>department</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Norte de Santander</name>
    <code>NSA</code>
    <category>department</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Putumayo</name>
    <code>PUT</code>
    <category>department</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Quind�o</name>
    <code>QUI</code>
    <category>department</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Risaralda</name>
    <code>RIS</code>
    <category>department</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>San Andr�s, Providencia y Santa Catalina</name>
    <code>SAP</code>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Santander</name>
    <code>SAN</code>
    <category>department</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Sucre</name>
    <code>SUC</code>
    <category>department</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Tolima</name>
    <code>TOL</code>
    <category>department</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Valle del Cauca</name>
    <code>VAC</code>
    <category>department</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Vaup�s</name>
    <code>VAU</code>
    <category>department</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Vichada</name>
    <code>VID</code>
    <category>department</category>
    <FIPS>31</FIPS>
  </subcountry>
</country>

<country>
  <name>COSTA RICA</name>
  <code>CR</code>
  <subcountry>
    <name>Alajuela</name>
    <code>A</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Cartago</name>
    <code>C</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Guanacaste</name>
    <code>G</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Heredia</name>
    <code>H</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Lim�n</name>
    <code>L</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Puntarenas</name>
    <code>P</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>San Jos�</name>
    <code>SJ</code>
    <FIPS>08</FIPS>
  </subcountry>
</country>

<country>
  <name>CUBA</name>
  <code>CU</code>
  <subcountry>
    <name>Camag�ey</name>
    <code>09</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ciego de �vila</name>
    <code>08</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Cienfuegos</name>
    <code>06</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Ciudad de La Habana</name>
    <code>03</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Granma</name>
    <code>12</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Guant�namo</name>
    <code>14</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Holgu�n</name>
    <code>11</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>La Habana</name>
    <code>02</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Las Tunas</name>
    <code>10</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Matanzas</name>
    <code>04</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Pinar del R�o</name>
    <code>01</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Sancti Sp�ritus</name>
    <code>07</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Santiago de Cuba</name>
    <code>13</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Villa Clara</name>
    <code>05</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Isla de la Juventud</name>
    <code>99</code>
    <category>special municipality</category>
    <FIPS>04</FIPS>
  </subcountry>
</country>

<country>
  <name>CAPE VERDE</name>
  <code>CV</code>
  <subcountry>
    <name>Boa Vista</name>
    <code>BV</code>
    <regional_division>B</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Brava</name>
    <code>BR</code>
    <regional_division>S</regional_division>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Calheta de S�o Miguel</name>
    <code>CS</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Maio</name>
    <code>MA</code>
    <regional_division>S</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Mosteiros</name>
    <code>MO</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Pa�l</name>
    <code>PA</code>
    <regional_division>B</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Porto Novo</name>
    <code>PN</code>
    <regional_division>B</regional_division>
  </subcountry>
  <subcountry>
    <name>Praia</name>
    <code>PR</code>
    <regional_division>S</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Ribeira Grande</name>
    <code>RG</code>
    <regional_division>B</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Sal</name>
    <code>SL</code>
    <regional_division>B</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Catarina</name>
    <code>CA</code>
    <regional_division>S</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Cruz</name>
    <code>CR</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>S�o Domingos</name>
    <code>SD</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>S�o Filipe</name>
    <code>SF</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>S�o Nicolau</name>
    <code>SN</code>
    <regional_division>B</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>S�o Vicente</name>
    <code>SV</code>
    <regional_division>B</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Tarrafal</name>
    <code>TA</code>
    <regional_division>S</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
</country>

<country>
  <name>CYPRUS</name>
  <code>CY</code>
  <subcountry>
    <name>Ammochostos</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>Keryneia</name>
    <code>06</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Larnaka</name>
    <code>03</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Lefkosia</name>
    <code>01</code>
  </subcountry>
  <subcountry>
    <name>Lemesos</name>
    <code>02</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Pafos</name>
    <code>05</code>
  </subcountry>
</country>

<country>
  <name>CZECH REPUBLIC</name>
  <code>CZ</code>
  <subcountry>
    <name>Jihocesk� kraj</name>
    <code>JC</code>
  </subcountry>
  <subcountry>
    <name>Jihomoravsk� kraj </name>
    <code>JM</code>
  </subcountry>
  <subcountry>
    <name>Karlovarsk� kraj</name>
    <code>KA</code>
  </subcountry>
  <subcountry>
    <name>Kr�lov�hradeck� kraj</name>
    <code>KR</code>
  </subcountry>
  <subcountry>
    <name>Libereck� kraj</name>
    <code>LI</code>
  </subcountry>
  <subcountry>
    <name>Moravskoslezsk� kraj</name>
    <code>MO</code>
  </subcountry>
  <subcountry>
    <name>Olomouck� kraj</name>
    <code>OL</code>
  </subcountry>
  <subcountry>
    <name>Pardubick� kraj</name>
    <code>PA</code>
  </subcountry>
  <subcountry>
    <name>Plzensk� kraj</name>
    <code>PL</code>
  </subcountry>
  <subcountry>
    <name>Praha, hlavn� mesto</name>
    <code>PR</code>
  </subcountry>
  <subcountry>
    <name>Stredocesk� kraj</name>
    <code>ST</code>
  </subcountry>
  <subcountry>
    <name>�steck� kraj </name>
    <code>US</code>
  </subcountry>
  <subcountry>
    <name>Vysocina</name>
    <code>VY</code>
  </subcountry>
  <subcountry>
    <name>Zl�nsk� kraj</name>
    <code>ZL</code>
  </subcountry>
</country>

<country>
  <name>GERMANY</name>
  <code>DE</code>
  <subcountry>
    <name>Baden-W�rttemberg</name>
    <code>BW</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bayern</name>
    <code>BY</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Berlin</name>
    <code>BE</code>
  </subcountry>
  <subcountry>
    <name>Brandenburg</name>
    <code>BB</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Bremen</name>
    <code>HB</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Hamburg</name>
    <code>HH</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Hessen</name>
    <code>HE</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Mecklenburg-Vorpommern</name>
    <code>MV</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Niedersachsen</name>
    <code>NI</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Nordrhein-Westfalen</name>
    <code>NW</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Rheinland-Pfalz</name>
    <code>RP</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Saarland</name>
    <code>SL</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Sachsen</name>
    <code>SN</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Sachsen-Anhalt</name>
    <code>ST</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Schleswig-Holstein</name>
    <code>SH</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Th�ringen</name>
    <code>TH</code>
    <FIPS>15</FIPS>
  </subcountry>
</country>

<country>
  <name>DJIBOUTI</name>
  <code>DJ</code>
  <subcountry>
    <name>Ali Sabieh</name>
    <code>AS</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Dikhil</name>
    <code>DI</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Djibouti</name>
    <code>DJ</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Obock</name>
    <code>OB</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Tadjoura</name>
    <code>TA</code>
    <FIPS>05</FIPS>
  </subcountry>
</country>

<country>
  <name>DENMARK</name>
  <code>DK</code>
  <subcountry>
    <name>Frederiksberg</name>
    <code>147</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>K�benhavn</name>
    <code>101</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Bornholm</name>
    <code>040</code>
    <category>county</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Frederiksborg</name>
    <code>020</code>
    <category>county</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Fyn</name>
    <code>042</code>
    <category>county</category>
  </subcountry>
  <subcountry>
    <name>K�benhavn</name>
    <code>015</code>
    <category>county</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Nordjylland</name>
    <code>080</code>
    <category>county</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ribe</name>
    <code>055</code>
    <category>county</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Ringk�bing</name>
    <code>065</code>
    <category>county</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Roskilde</name>
    <code>025</code>
    <category>county</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Storstr�m</name>
    <code>035</code>
    <category>county</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>S�nderjylland</name>
    <code>050</code>
    <category>county</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Vejle</name>
    <code>060</code>
    <category>county</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Vestsj�lland</name>
    <code>030</code>
    <category>county</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Viborg</name>
    <code>076</code>
    <category>county</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>�rhus</name>
    <code>070</code>
    <category>county</category>
    <FIPS>01</FIPS>
  </subcountry>
</country>

<country>
  <name>DOMINICAN REPUBLIC</name>
  <code>DO</code>
  <subcountry>
    <name>Distrito Nacional </name>
    <code>01</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Azua</name>
    <code>02</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bahoruco</name>
    <code>03</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Barahona</name>
    <code>04</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Dajab�n</name>
    <code>05</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Duarte</name>
    <code>06</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>El Seybo [El Seibo]</name>
    <code>08</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Espaillat</name>
    <code>09</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Hato Mayor</name>
    <code>30</code>
    <category>province</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Independencia</name>
    <code>10</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>La Altagracia</name>
    <code>11</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>La Estrelleta [El�as Pi�a]</name>
    <code>07</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>La Romana</name>
    <code>12</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>La Vega</name>
    <code>13</code>
    <category>province</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Mar�a Trinidad S�nchez</name>
    <code>14</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Monse�or Nouel</name>
    <code>28</code>
    <category>province</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Monte Cristi</name>
    <code>15</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Monte Plata</name>
    <code>29</code>
    <category>province</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Pedernales</name>
    <code>16</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Peravia</name>
    <code>17</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Puerto Plata</name>
    <code>18</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Salcedo</name>
    <code>19</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Saman�</name>
    <code>20</code>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>San Crist�bal</name>
    <code>21</code>
    <category>province</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>San Juan</name>
    <code>22</code>
    <category>province</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>San Pedro de Macor�s</name>
    <code>23</code>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>S�nchez Ram�rez</name>
    <code>24</code>
    <category>province</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Santiago</name>
    <code>25</code>
    <category>province</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Santiago Rodr�guez</name>
    <code>26</code>
    <category>province</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Valverde</name>
    <code>27</code>
    <category>province</category>
    <FIPS>27</FIPS>
  </subcountry>
</country>

<country>
  <name>ALGERIA</name>
  <code>DZ</code>
  <subcountry>
    <name>Adrar</name>
    <code>01</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>A�n Defla</name>
    <code>44</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>A�n T�mouchent</name>
    <code>46</code>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Alger</name>
    <code>16</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Annaba</name>
    <code>23</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Batna</name>
    <code>05</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>B�char</name>
    <code>08</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>B�ja�a</name>
    <code>06</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Biskra</name>
    <code>07</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Blida</name>
    <code>09</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Bordj Bou Arr�ridj</name>
    <code>34</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Bouira</name>
    <code>10</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Boumerd�s</name>
    <code>35</code>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Chlef</name>
    <code>02</code>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Constantine</name>
    <code>25</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Djelfa</name>
    <code>17</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>El Bayadh</name>
    <code>32</code>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>El Oued</name>
    <code>39</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>El Tarf</name>
    <code>36</code>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Gharda�a</name>
    <code>47</code>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Guelma</name>
    <code>24</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Illizi</name>
    <code>33</code>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Jijel</name>
    <code>18</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Khenchela</name>
    <code>40</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Laghouat</name>
    <code>03</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Mascara</name>
    <code>29</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>M�d�a</name>
    <code>26</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Mila</name>
    <code>43</code>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Mostaganem</name>
    <code>27</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Msila</name>
    <code>28</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Naama</name>
    <code>45</code>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Oran</name>
    <code>31</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouargla</name>
    <code>30</code>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Oum el Bouaghi</name>
    <code>04</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Relizane</name>
    <code>48</code>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Sa�da</name>
    <code>20</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>S�tif</name>
    <code>19</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Sidi Bel Abb�s</name>
    <code>22</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Skikda</name>
    <code>21</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Souk Ahras</name>
    <code>41</code>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Tamanghasset</name>
    <code>11</code>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>T�bessa</name>
    <code>12</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Tiaret</name>
    <code>14</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Tindouf</name>
    <code>37</code>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Tipaza</name>
    <code>42</code>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Tissemsilt</name>
    <code>38</code>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Tizi Ouzou</name>
    <code>15</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Tlemcen</name>
    <code>13</code>
    <FIPS>15</FIPS>
  </subcountry>
</country>

<country>
  <name>ECUADOR</name>
  <code>EC</code>
  <subcountry>
    <name>Azuay</name>
    <code>A</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Bol�var</name>
    <code>B</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ca�ar</name>
    <code>F</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Carchi</name>
    <code>C</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cotopaxi</name>
    <code>X</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Chimborazo</name>
    <code>H</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>El Oro</name>
    <code>O</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Esmeraldas</name>
    <code>E</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Gal�pagos</name>
    <code>W</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Guayas</name>
    <code>G</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Imbabura</name>
    <code>I</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Loja</name>
    <code>L</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Los R�os</name>
    <code>R</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Manab�</name>
    <code>M</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Morona-Santiago</name>
    <code>S</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Napo</name>
    <code>N</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Pastaza</name>
    <code>Y</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Pichincha</name>
    <code>P</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Sucumb�os</name>
    <code>U</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Tungurahua</name>
    <code>T</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamora-Chinchipe</name>
    <code>Z</code>
    <FIPS>20</FIPS>
  </subcountry>
</country>

<country>
  <name>ESTONIA</name>
  <code>EE</code>
  <subcountry>
    <name>Harjumaa</name>
    <code>37</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Hiiumaa</name>
    <code>39</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Ida-Virumaa</name>
    <code>44</code>
  </subcountry>
  <subcountry>
    <name>J�gevamaa</name>
    <code>49</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>J�rvamaa</name>
    <code>51</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>L��nemaa</name>
    <code>57</code>
  </subcountry>
  <subcountry>
    <name>L��ne-Virumaa</name>
    <code>59</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>P�lvamaa</name>
    <code>65</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>P�rnumaa</name>
    <code>67</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Raplamaa</name>
    <code>70</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Saaremaa</name>
    <code>74</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Tartumaa</name>
    <code>78</code>
  </subcountry>
  <subcountry>
    <name>Valgamaa</name>
    <code>82</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Viljandimaa</name>
    <code>84</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>V�rumaa</name>
    <code>86</code>
    <FIPS>21</FIPS>
  </subcountry>
</country>

<country>
  <name>EGYPT</name>
  <code>EG</code>
  <subcountry>
    <name>Ad Daqahliyah</name>
    <code>DK</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Bahr al Ahmar</name>
    <code>BA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Buhayrah</name>
    <code>BH</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Fayyum</name>
    <code>FYM</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Gharbiyah</name>
    <code>GH</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Iskandariyah</name>
    <code>ALX</code>
  </subcountry>
  <subcountry>
    <name>Al Ismahiliyah</name>
    <code>IS</code>
  </subcountry>
  <subcountry>
    <name>Al Jizah</name>
    <code>GZ</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Minufiyah</name>
    <code>MNF</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Minya</name>
    <code>MN</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qahirah</name>
    <code>C</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qalyubiyah</name>
    <code>KB</code>
  </subcountry>
  <subcountry>
    <name>Al Wadi al Jadid</name>
    <code>WAD</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Ash Sharqiyah</name>
    <code>SHR</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>As Suways</name>
    <code>SUZ</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Aswan</name>
    <code>ASN</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Asyut</name>
    <code>AST</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Bani Suwayf</name>
    <code>BNS</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Bur Sahid</name>
    <code>PTS</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Dumyat</name>
    <code>DT</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Janub Sina'</name>
    <code>JS</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Kafr ash Shaykh</name>
    <code>KFS</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Matruh</name>
    <code>MT</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Qina</name>
    <code>KN</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Shamal Sina'</name>
    <code>SIN</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Suhaj</name>
    <code>SHG</code>
    <FIPS>24</FIPS>
  </subcountry>
</country>

<country>
  <name>ERITREA</name>
  <code>ER</code>
  <subcountry>
    <name>Anseba</name>
    <code>AN</code>
  </subcountry>
  <subcountry>
    <name>Debub</name>
    <code>DU</code>
  </subcountry>
  <subcountry>
    <name>Debubawi Keyih Bahri</name>
    <code>DK</code>
  </subcountry>
  <subcountry>
    <name>Gash-Barka</name>
    <code>GB</code>
  </subcountry>
  <subcountry>
    <name>Maakel [Maekel]</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Semenawi Keyih Bahri</name>
    <code>SK</code>
  </subcountry>
</country>

<country>
  <name>SPAIN</name>
  <code>ES</code>
  <subcountry>
    <name>A Coru�a</name>
    <code>C</code>
    <regional_division>GA</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>�lava</name>
    <code>VI</code>
    <regional_division>PV</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Albacete</name>
    <code>AB</code>
    <regional_division>CM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Alicante</name>
    <code>A</code>
    <regional_division>VC</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Almer�a</name>
    <code>AL</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Asturias</name>
    <code>O</code>
    <regional_division>O</regional_division>
    <category>province</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>�vila</name>
    <code>AV</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Badajoz</name>
    <code>BA</code>
    <regional_division>EX</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Baleares</name>
    <code>PM</code>
    <regional_division>IB</regional_division>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Barcelona</name>
    <code>B</code>
    <regional_division>CT</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Burgos</name>
    <code>BU</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>C�ceres</name>
    <code>CC</code>
    <regional_division>EX</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>C�diz</name>
    <code>CA</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Cantabria</name>
    <code>S</code>
    <regional_division>S</regional_division>
    <category>province</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Castell�n</name>
    <code>CS</code>
    <regional_division>VC</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Ciudad Real</name>
    <code>CR</code>
    <regional_division>CM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>C�rdoba</name>
    <code>CO</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Cuenca</name>
    <code>CU</code>
    <regional_division>CM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Girona</name>
    <code>GI</code>
    <regional_division>CT</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Granada</name>
    <code>GR</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Guadalajara</name>
    <code>GU</code>
    <regional_division>CM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Guip�zcoa</name>
    <code>SS</code>
    <regional_division>PV</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Huelva</name>
    <code>H</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Huesca</name>
    <code>HU</code>
    <regional_division>AR</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Ja�n</name>
    <code>J</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>La Rioja</name>
    <code>LO</code>
    <regional_division>LO</regional_division>
    <category>province</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Las Palmas</name>
    <code>GC</code>
    <regional_division>CN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Le�n</name>
    <code>LE</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Lleida</name>
    <code>L</code>
    <regional_division>CT</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Lugo</name>
    <code>LU</code>
    <regional_division>GA</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Madrid</name>
    <code>M</code>
    <regional_division>M</regional_division>
    <category>province</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>M�laga</name>
    <code>MA</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Murcia</name>
    <code>MU</code>
    <regional_division>MU</regional_division>
    <category>province</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Navarra</name>
    <code>NA</code>
    <regional_division>NA</regional_division>
    <category>province</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Ourense</name>
    <code>OR</code>
    <regional_division>GA</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Palencia</name>
    <code>P</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Pontevedra</name>
    <code>PO</code>
    <regional_division>GA</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Salamanca</name>
    <code>SA</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Santa Cruz de Tenerife</name>
    <code>TF</code>
    <regional_division>CN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Segovia</name>
    <code>SG</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Sevilla</name>
    <code>SE</code>
    <regional_division>AN</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Soria</name>
    <code>SO</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Tarragona</name>
    <code>T</code>
    <regional_division>CT</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Teruel</name>
    <code>TE</code>
    <regional_division>AR</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Toledo</name>
    <code>TO</code>
    <regional_division>CM</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Valencia</name>
    <code>V</code>
    <regional_division>VC</regional_division>
    <category>province</category>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Valladolid</name>
    <code>VA</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Vizcaya</name>
    <code>BI</code>
    <regional_division>PV</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Zamora</name>
    <code>ZA</code>
    <regional_division>CL</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Zaragoza</name>
    <code>Z</code>
    <regional_division>AR</regional_division>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Ceuta</name>
    <code>CE</code>
    <category>autonomous city in North Africa</category>
  </subcountry>
  <subcountry>
    <name>Melilla</name>
    <code>ML</code>
    <category>autonomous city in North Africa</category>
  </subcountry>
</country>

<country>
  <name>ETHIOPIA</name>
  <code>ET</code>
  <subcountry>
    <name>Adis Abeba</name>
    <code>AA</code>
    <category>administration</category>
  </subcountry>
  <subcountry>
    <name>Afar</name>
    <code>AF</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Amara</name>
    <code>AM</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Binshangul Gumuz</name>
    <code>BE</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Gambela Hizboch</name>
    <code>GA</code>
    <category>state</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Hareri Hizb</name>
    <code>HA</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Oromiya</name>
    <code>OR</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Sumale</name>
    <code>SO</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>YeDebub Biheroch Bihereseboch na Hizboch</name>
    <code>SN</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Tigray</name>
    <code>TI</code>
    <category>state</category>
    <FIPS>37</FIPS>
  </subcountry>
</country>

<country>
  <name>FINLAND</name>
  <code>FI</code>
  <subcountry>
    <name>Ahvenanmaan l��ni</name>
    <code>AL</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Etel�-Suomen l��ni</name>
    <code>ES</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>It�-Suomen l��ni</name>
    <code>IS</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Lapin l��ni</name>
    <code>LL</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>L�nsi-Suomen l��ni</name>
    <code>LS</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Oulun l��ni</name>
    <code>OL</code>
  </subcountry>
</country>

<country>
  <name>FIJI</name>
  <code>FJ</code>
  <subcountry>
    <name>Central</name>
    <code>C</code>
    <category>division</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Eastern</name>
    <code>E</code>
    <category>division</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern</name>
    <code>N</code>
    <category>division</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>W</code>
    <category>division</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Rotuma</name>
    <code>R</code>
    <category>dependency</category>
    <FIPS>04</FIPS>
  </subcountry>
</country>

<country>
  <name>MICRONESIA (FEDERATED STATES OF)</name>
  <code>FM</code>
  <subcountry>
    <name>Chuuk</name>
    <code>TRK</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Kosrae</name>
    <code>KSA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Pohnpei</name>
    <code>PNI</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Yap</name>
    <code>YAP</code>
    <FIPS>04</FIPS>
  </subcountry>
</country>

<country>
  <name>FRANCE</name>
  <code>FR</code>
  <subcountry>
    <name>Ain</name>
    <code>01</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Aisne</name>
    <code>02</code>
    <regional_division>S</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Allier</name>
    <code>03</code>
    <regional_division>C</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Alpes-de-Haute-Provence</name>
    <code>04</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Alpes-Maritimes</name>
    <code>06</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Ard�che</name>
    <code>07</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Ardennes</name>
    <code>08</code>
    <regional_division>G</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Ari�ge</name>
    <code>09</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Aube</name>
    <code>10</code>
    <regional_division>G</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Aude</name>
    <code>11</code>
    <regional_division>K</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Aveyron</name>
    <code>12</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
    <FIPS>98</FIPS>
  </subcountry>
  <subcountry>
    <name>Bas-Rhin</name>
    <code>67</code>
    <regional_division>A</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Bouches-du-Rh�ne</name>
    <code>13</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Calvados</name>
    <code>14</code>
    <regional_division>P</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Cantal</name>
    <code>15</code>
    <regional_division>C</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Charente</name>
    <code>16</code>
    <regional_division>T</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Charente-Maritime</name>
    <code>17</code>
    <regional_division>T</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Cher</name>
    <code>18</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Corr�ze</name>
    <code>19</code>
    <regional_division>L</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Corse-du-Sud</name>
    <code>2A</code>
    <regional_division>H</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>C�te-d'Or</name>
    <code>21</code>
    <regional_division>D</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>C�tes-d'Armor</name>
    <code>22</code>
    <regional_division>E</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Creuse</name>
    <code>23</code>
    <regional_division>L</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Deux-S�vres</name>
    <code>79</code>
    <regional_division>T</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Dordogne</name>
    <code>24</code>
    <regional_division>B</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Doubs</name>
    <code>25</code>
    <regional_division>I</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Dr�me</name>
    <code>26</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Essonne</name>
    <code>91</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Eure</name>
    <code>27</code>
    <regional_division>Q</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Eure-et-Loir</name>
    <code>28</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Finist�re</name>
    <code>29</code>
    <regional_division>E</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Gard</name>
    <code>30</code>
    <regional_division>K</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Gers</name>
    <code>32</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Gironde</name>
    <code>33</code>
    <regional_division>B</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Corse</name>
    <code>2B</code>
    <regional_division>H</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Garonne</name>
    <code>31</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Loire</name>
    <code>43</code>
    <regional_division>C</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Marne</name>
    <code>52</code>
    <regional_division>G</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Hautes-Alpes</name>
    <code>05</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Sa�ne</name>
    <code>70</code>
    <regional_division>I</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Savoie</name>
    <code>74</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Hautes-Pyr�n�es</name>
    <code>65</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haute-Vienne</name>
    <code>87</code>
    <regional_division>L</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Haut-Rhin</name>
    <code>68</code>
    <regional_division>A</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Hauts-de-Seine</name>
    <code>92</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>H�rault</name>
    <code>34</code>
    <regional_division>K</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Ille-et-Vilaine</name>
    <code>35</code>
    <regional_division>E</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Indre</name>
    <code>36</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Indre-et-Loire</name>
    <code>37</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Is�re</name>
    <code>38</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Jura</name>
    <code>39</code>
    <regional_division>I</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Landes</name>
    <code>40</code>
    <regional_division>B</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Loir-et-Cher</name>
    <code>41</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Loire</name>
    <code>42</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Loire-Atlantique</name>
    <code>44</code>
    <regional_division>R</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Loiret</name>
    <code>45</code>
    <regional_division>F</regional_division>
    <category>metropolitan department</category>
    <FIPS>B2</FIPS>
  </subcountry>
  <subcountry>
    <name>Lot</name>
    <code>46</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Lot-et-Garonne</name>
    <code>47</code>
    <regional_division>B</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Loz�re</name>
    <code>48</code>
    <regional_division>K</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Maine-et-Loire</name>
    <code>49</code>
    <regional_division>R</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Manche</name>
    <code>50</code>
    <regional_division>P</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Marne</name>
    <code>51</code>
    <regional_division>G</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Mayenne</name>
    <code>53</code>
    <regional_division>R</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Meurthe-et-Moselle</name>
    <code>54</code>
    <regional_division>M</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Meuse</name>
    <code>55</code>
    <regional_division>M</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Morbihan</name>
    <code>56</code>
    <regional_division>E</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Moselle</name>
    <code>57</code>
    <regional_division>M</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Ni�vre</name>
    <code>58</code>
    <regional_division>D</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Nord</name>
    <code>59</code>
    <regional_division>O</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Oise</name>
    <code>60</code>
    <regional_division>S</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Orne</name>
    <code>61</code>
    <regional_division>P</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Paris</name>
    <code>75</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Pas-de-Calais</name>
    <code>62</code>
    <regional_division>O</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Puy-de-D�me</name>
    <code>63</code>
    <regional_division>C</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Pyr�n�es-Atlantiques</name>
    <code>64</code>
    <regional_division>B</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Pyr�n�es-Orientales</name>
    <code>66</code>
    <regional_division>K</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Rh�ne</name>
    <code>69</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Sa�ne-et-Loire</name>
    <code>71</code>
    <regional_division>D</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Sarthe</name>
    <code>72</code>
    <regional_division>R</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Savoie</name>
    <code>73</code>
    <regional_division>V</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Seine-et-Marne</name>
    <code>77</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Seine-Maritime</name>
    <code>76</code>
    <regional_division>Q</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Seine-Saint-Denis</name>
    <code>93</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Somme</name>
    <code>80</code>
    <regional_division>S</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Tarn</name>
    <code>81</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Tarn-et-Garonne</name>
    <code>82</code>
    <regional_division>N</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Territoire de Belfort</name>
    <code>90</code>
    <regional_division>I</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Val-de-Marne</name>
    <code>94</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Val-d'Oise</name>
    <code>95</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Var</name>
    <code>83</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Vaucluse</name>
    <code>84</code>
    <regional_division>U</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Vend�e</name>
    <code>85</code>
    <regional_division>R</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Vienne</name>
    <code>86</code>
    <regional_division>T</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Vosges</name>
    <code>88</code>
    <regional_division>M</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Yonne</name>
    <code>89</code>
    <regional_division>D</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Yvelines</name>
    <code>78</code>
    <regional_division>J</regional_division>
    <category>metropolitan department</category>
  </subcountry>
  <subcountry>
    <name>Mayotte (see also separate entry under YT)</name>
    <code>YT</code>
    <category>territorial collectivity</category>
  </subcountry>
  <subcountry>
    <name>Saint-Pierre-et-Miquelon (see also separate entry under PM)</name>
    <code>PM</code>
    <category>territorial collectivity</category>
  </subcountry>
  <subcountry>
    <name>Nouvelle-Cal�donie (see also separate entry under NC)</name>
    <code>NC</code>
    <category>overseas territory</category>
  </subcountry>
  <subcountry>
    <name>Polyn�sie fran�aise (see also separate entry under PF)</name>
    <code>PF</code>
    <category>overseas territory</category>
  </subcountry>
  <subcountry>
    <name>Terres Australes Fran�aises (see also separate entry under TF)</name>
    <code>TF</code>
    <category>overseas territory</category>
  </subcountry>
  <subcountry>
    <name>Wallis et Futuna (see also separate entry under WF)</name>
    <code>WF</code>
    <category>overseas territory</category>
  </subcountry>
</country>

<country>
  <name>GABON</name>
  <code>GA</code>
  <subcountry>
    <name>Estuaire</name>
    <code>1</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Haut-Ogoou�</name>
    <code>2</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Moyen-Ogoou�</name>
    <code>3</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ngouni�</name>
    <code>4</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Nyanga</name>
    <code>5</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ogoou�-Ivindo</name>
    <code>6</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Ogoou�-Lolo</name>
    <code>7</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ogoou�-Maritime</name>
    <code>8</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Woleu-Ntem</name>
    <code>9</code>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>UNITED KINGDOM</name>
  <code>GB</code>
  <subcountry>
    <name>Aberdeen City</name>
    <code>ABE</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Aberdeenshire</name>
    <code>ABD</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Angus</name>
    <code>ANS</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Antrim</name>
    <code>ANT</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Ards</name>
    <code>ARD</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Argyll and Bute</name>
    <code>AGB</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Armagh</name>
    <code>ARM</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Ballymena</name>
    <code>BLA</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Ballymoney</name>
    <code>BLY</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Banbridge</name>
    <code>BNB</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Barking and Dagenham</name>
    <code>BDG</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Barnet</name>
    <code>BNE</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Barnsley</name>
    <code>BNS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bath and North East Somerset</name>
    <code>BAS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bedfordshire</name>
    <code>BDF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Belfast</name>
    <code>BFS</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Bexley</name>
    <code>BEX</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Birmingham</name>
    <code>BIR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Blackburn with Darwen</name>
    <code>BBD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Blackpool</name>
    <code>BPL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Blaenau Gwent</name>
    <code>BGW</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Bolton</name>
    <code>BOL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bournemouth</name>
    <code>BMH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bracknell Forest</name>
    <code>BRC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bradford</name>
    <code>BRD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Brent</name>
    <code>BEN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bridgend</name>
    <code>BGE</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Brighton and Hove</name>
    <code>BNH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bristol, City of</name>
    <code>BST</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bromley</name>
    <code>BRY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Buckinghamshire</name>
    <code>BKM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Bury</name>
    <code>BUR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Caerphilly</name>
    <code>CAY</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Calderdale</name>
    <code>CLD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Cambridgeshire</name>
    <code>CAM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Camden</name>
    <code>CMD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Cardiff</name>
    <code>CRF</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Carmarthenshire</name>
    <code>CMN</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Carrickfergus</name>
    <code>CKF</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Castlereagh</name>
    <code>CSR</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Ceredigion</name>
    <code>CGN</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Cheshire</name>
    <code>CHS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Clackmannanshire</name>
    <code>CLK</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Coleraine</name>
    <code>CLR</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Conwy</name>
    <code>CWY</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Cookstown</name>
    <code>CKT</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Cornwall</name>
    <code>CON</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Coventry</name>
    <code>COV</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Craigavon</name>
    <code>CGV</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Croydon</name>
    <code>CRY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Cumbria</name>
    <code>CMA</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Darlington</name>
    <code>DAL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Denbighshire</name>
    <code>DEN</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Derby</name>
    <code>DER</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Derbyshire</name>
    <code>DBY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Derry</name>
    <code>DRY</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Devon</name>
    <code>DEV</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Doncaster</name>
    <code>DNC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Dorset</name>
    <code>DOR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Down</name>
    <code>DOW</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Dudley</name>
    <code>DUD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Dumfries and Galloway</name>
    <code>DGY</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Dundee City</name>
    <code>DND</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Dungannon</name>
    <code>DGN</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Durham</name>
    <code>DUR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Ealing</name>
    <code>EAL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>East Ayrshire</name>
    <code>EAY</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>East Dunbartonshire</name>
    <code>EDU</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>East Lothian</name>
    <code>ELN</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>East Renfrewshire</name>
    <code>ERW</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>East Riding of Yorkshire</name>
    <code>ERY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>East Sussex</name>
    <code>ESX</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Edinburgh, City of</name>
    <code>EDH</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Eilean Siar</name>
    <code>ELS</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Enfield</name>
    <code>ENF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Essex</name>
    <code>ESS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Falkirk</name>
    <code>FAL</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Fermanagh</name>
    <code>FER</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Fife</name>
    <code>FIF</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Flintshire</name>
    <code>FLN</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Gateshead</name>
    <code>GAT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Glasgow City</name>
    <code>GLG</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Gloucestershire</name>
    <code>GLS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Greenwich</name>
    <code>GRE</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Guernsey</name>
    <code>GSY</code>
    <regional_division>CHA</regional_division>
  </subcountry>
  <subcountry>
    <name>Gwynedd</name>
    <code>GWN</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Hackney</name>
    <code>HCK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Halton</name>
    <code>HAL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Hammersmith and Fulham</name>
    <code>HMF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Hampshire</name>
    <code>HAM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Haringey</name>
    <code>HRY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Harrow</name>
    <code>HRW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Hartlepool</name>
    <code>HPL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Havering</name>
    <code>HAV</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Herefordshire, County of</name>
    <code>HEF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Hertfordshire</name>
    <code>HRT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Highland</name>
    <code>HLD</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Hillingdon</name>
    <code>HIL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Hounslow</name>
    <code>HNS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Inverclyde</name>
    <code>IVC</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Isle of Anglesey</name>
    <code>AGY</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Isle of Wight</name>
    <code>IOW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Isles of Scilly</name>
    <code>IOS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Islington</name>
    <code>ISL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Jersey</name>
    <code>JSY</code>
    <regional_division>CHA</regional_division>
  </subcountry>
  <subcountry>
    <name>Kensington and Chelsea</name>
    <code>KEC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Kent</name>
    <code>KEN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Kingston upon Hull, City of</name>
    <code>KHL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Kingston upon Thames</name>
    <code>KTT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Kirklees</name>
    <code>KIR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Knowsley</name>
    <code>KWL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Lambeth</name>
    <code>LBH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Lancashire</name>
    <code>LAN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Larne</name>
    <code>LRN</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Leeds</name>
    <code>LDS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Leicester</name>
    <code>LCE</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Leicestershire</name>
    <code>LEC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Lewisham</name>
    <code>LEW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Limavady</name>
    <code>LMV</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Lincolnshire</name>
    <code>LIN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Lisburn</name>
    <code>LSB</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Liverpool</name>
    <code>LIV</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>London, City of</name>
    <code>LND</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Luton</name>
    <code>LUT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Magherafelt</name>
    <code>MFT</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Manchester</name>
    <code>MAN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Medway</name>
    <code>MDW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Merthyr Tydfil</name>
    <code>MTY</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Merton</name>
    <code>MRT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Middlesbrough</name>
    <code>MDB</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Midlothian</name>
    <code>MLN</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Milton Keynes</name>
    <code>MIK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Monmouthshire [Sir Fynwy GB-FYN]</name>
    <code>MON</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Moray</name>
    <code>MRY</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Moyle</name>
    <code>MYL</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Neath Port Talbot</name>
    <code>NTL</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Newcastle upon Tyne</name>
    <code>NET</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Newham</name>
    <code>NWM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Newport</name>
    <code>NWP</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Newry and Mourne</name>
    <code>NYM</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Newtownabbey</name>
    <code>NTA</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Norfolk</name>
    <code>NFK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>North Ayrshire</name>
    <code>NAY</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>North Down</name>
    <code>NDN</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>North East Lincolnshire</name>
    <code>NEL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>North Lanarkshire</name>
    <code>NLK</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>North Lincolnshire</name>
    <code>NLN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>North Somerset</name>
    <code>NSM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>North Tyneside</name>
    <code>NTY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>North Yorkshire</name>
    <code>NYK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Northamptonshire</name>
    <code>NTH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Northumberland</name>
    <code>NBL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Nottingham</name>
    <code>NGM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Nottinghamshire</name>
    <code>NTT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Oldham</name>
    <code>OLD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Omagh</name>
    <code>OMH</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Orkney Islands</name>
    <code>ORK</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Oxfordshire</name>
    <code>OXF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Pembrokeshire</name>
    <code>PEM</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Perth and Kinross</name>
    <code>PKN</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Peterborough</name>
    <code>PTE</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Plymouth</name>
    <code>PLY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Poole</name>
    <code>POL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Portsmouth</name>
    <code>POR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Powys</name>
    <code>POW</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Reading</name>
    <code>RDG</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Redbridge</name>
    <code>RDB</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Redcar and Cleveland</name>
    <code>RCC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Renfrewshire</name>
    <code>RFW</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Rhondda, Cynon, Taff</name>
    <code>RCT</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Richmond upon Thames</name>
    <code>RIC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Rochdale</name>
    <code>RCH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Rotherham</name>
    <code>ROT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Rutland</name>
    <code>RUT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>St. Helens</name>
    <code>SHN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Salford</name>
    <code>SLF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Sandwell</name>
    <code>SAW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Scottish Borders, The</name>
    <code>SCB</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Sefton</name>
    <code>SFT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Sheffield</name>
    <code>SHF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Shetland Islands</name>
    <code>ZET</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Shropshire</name>
    <code>SHR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Slough</name>
    <code>SLG</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Solihull</name>
    <code>SOL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Somerset</name>
    <code>SOM</code>
    <regional_division>ENG</regional_division>
    <FIPS>M3</FIPS>
  </subcountry>
  <subcountry>
    <name>South Ayrshire</name>
    <code>SAY</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>South Gloucestershire</name>
    <code>SGC</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>South Lanarkshire</name>
    <code>SLK</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>South Tyneside</name>
    <code>STY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Southampton</name>
    <code>STH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Southend-on-Sea</name>
    <code>SOS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Southwark</name>
    <code>SWK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Staffordshire</name>
    <code>STS</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Stirling</name>
    <code>STG</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>Stockport</name>
    <code>SKP</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Stockton-on-Tees</name>
    <code>STT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Stoke-on-Trent</name>
    <code>STE</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Strabane</name>
    <code>STB</code>
    <regional_division>NIR</regional_division>
  </subcountry>
  <subcountry>
    <name>Suffolk</name>
    <code>SFK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Sunderland</name>
    <code>SND</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Surrey</name>
    <code>SRY</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Sutton</name>
    <code>STN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Swansea</name>
    <code>SWA</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Swindon</name>
    <code>SWD</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Tameside</name>
    <code>TAM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Telford and Wrekin</name>
    <code>TFW</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Thurrock</name>
    <code>THR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Torbay</name>
    <code>TOB</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Torfaen</name>
    <code>TOF</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Tower Hamlets</name>
    <code>TWH</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Trafford</name>
    <code>TRF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Vale of Glamorgan</name>
    <code>VGL</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>Wakefield</name>
    <code>WKF</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Walsall</name>
    <code>WLL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Waltham Forest</name>
    <code>WFT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wandsworth</name>
    <code>WND</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Warrington</name>
    <code>WRT</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Warwickshire</name>
    <code>WAR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>West Berkshire</name>
    <code>WBK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>West Dunbartonshire</name>
    <code>WDU</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>West Lothian</name>
    <code>WLN</code>
    <regional_division>SCT</regional_division>
  </subcountry>
  <subcountry>
    <name>West Sussex</name>
    <code>WSX</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Westminster</name>
    <code>WSM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wigan</name>
    <code>WGN</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wiltshire</name>
    <code>WIL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Windsor and Maidenhead</name>
    <code>WNM</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wirral</name>
    <code>WRL</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wokingham</name>
    <code>WOK</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wolverhampton</name>
    <code>WLV</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Worcestershire</name>
    <code>WOR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
  <subcountry>
    <name>Wrexham</name>
    <code>WRX</code>
    <regional_division>WLS</regional_division>
  </subcountry>
  <subcountry>
    <name>York</name>
    <code>YOR</code>
    <regional_division>ENG</regional_division>
  </subcountry>
</country>

<country>
  <name>GHANA</name>
  <code>GH</code>
  <subcountry>
    <name>Ashanti</name>
    <code>AH</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Brong-Ahafo</name>
    <code>BA</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Central</name>
    <code>CP</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Eastern</name>
    <code>EP</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Greater Accra</name>
    <code>AA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern</name>
    <code>NP</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Upper East</name>
    <code>UE</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Upper West</name>
    <code>UW</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Volta</name>
    <code>TV</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>WP</code>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>GAMBIA</name>
  <code>GM</code>
  <subcountry>
    <name>Banjul</name>
    <code>B</code>
    <category>city</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Lower River</name>
    <code>L</code>
    <category>division</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>MacCarthy Island</name>
    <code>M</code>
    <category>division</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>North Bank</name>
    <code>N</code>
    <category>division</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Upper River</name>
    <code>U</code>
    <category>division</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>W</code>
    <category>division</category>
    <FIPS>05</FIPS>
  </subcountry>
</country>

<country>
  <name>GUINEA</name>
  <code>GN</code>
  <subcountry>
    <name>Beyla</name>
    <code>BE</code>
    <regional_division>N</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Boffa</name>
    <code>BF</code>
    <regional_division>B</regional_division>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Bok�</name>
    <code>BK</code>
    <regional_division>B</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Coyah</name>
    <code>CO</code>
    <regional_division>D</regional_division>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Dabola</name>
    <code>DB</code>
    <regional_division>F</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Dalaba</name>
    <code>DL</code>
    <regional_division>M</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dinguiraye</name>
    <code>DI</code>
    <regional_division>F</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Dubr�ka</name>
    <code>DU</code>
    <regional_division>D</regional_division>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Faranah</name>
    <code>FA</code>
    <regional_division>F</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>For�cariah</name>
    <code>FO</code>
    <regional_division>D</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Fria</name>
    <code>FR</code>
    <regional_division>B</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Gaoual</name>
    <code>GA</code>
    <regional_division>B</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Gu�k�dou</name>
    <code>GU</code>
    <regional_division>N</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Kankan</name>
    <code>KA</code>
    <regional_division>K</regional_division>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>K�rouan�</name>
    <code>KE</code>
    <regional_division>K</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Kindia</name>
    <code>KD</code>
    <regional_division>D</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Kissidougou</name>
    <code>KS</code>
    <regional_division>F</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Koubia</name>
    <code>KB</code>
    <regional_division>L</regional_division>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Koundara</name>
    <code>KN</code>
    <regional_division>B</regional_division>
  </subcountry>
  <subcountry>
    <name>Kouroussa</name>
    <code>KO</code>
    <regional_division>K</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Lab�</name>
    <code>LA</code>
    <regional_division>L</regional_division>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>L�louma</name>
    <code>LE</code>
    <regional_division>L</regional_division>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Lola</name>
    <code>LO</code>
    <regional_division>N</regional_division>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Macenta</name>
    <code>MC</code>
    <regional_division>N</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Mali</name>
    <code>ML</code>
    <regional_division>L</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Mamou</name>
    <code>MM</code>
    <regional_division>M</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Mandiana</name>
    <code>MD</code>
    <regional_division>K</regional_division>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Nz�r�kor�</name>
    <code>NZ</code>
    <regional_division>N</regional_division>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Pita</name>
    <code>PI</code>
    <regional_division>M</regional_division>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Siguiri</name>
    <code>SI</code>
    <regional_division>K</regional_division>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>T�lim�l�</name>
    <code>TE</code>
    <regional_division>D</regional_division>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Tougu�</name>
    <code>TO</code>
    <regional_division>L</regional_division>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Yomou</name>
    <code>YO</code>
    <regional_division>N</regional_division>
    <FIPS>29</FIPS>
  </subcountry>
</country>

<country>
  <name>MALI</name>
  <code>ML</code>
  <subcountry>
    <name>Bamako</name>
    <code>BKO</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Gao</name>
    <code>7</code>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Kayes</name>
    <code>1</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Kidal</name>
    <code>8</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Koulikoro</name>
    <code>2</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Mopti</name>
    <code>5</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>S�gou</name>
    <code>4</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Sikasso</name>
    <code>3</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Tombouctou</name>
    <code>6</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
</country>

<country>
  <name>MYANMAR</name>
  <code>MM</code>
  <subcountry>
    <name>Ayeyarwady</name>
    <code>07</code>
    <category>division</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bago</name>
    <code>02</code>
    <category>division</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Magway</name>
    <code>03</code>
    <category>division</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Mandalay</name>
    <code>04</code>
    <category>division</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Sagaing</name>
    <code>01</code>
    <category>division</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Tanintharyi</name>
    <code>05</code>
    <category>division</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Yangon</name>
    <code>06</code>
    <category>division</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Chin</name>
    <code>14</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Kachin</name>
    <code>11</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Kayah</name>
    <code>12</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Kayin</name>
    <code>13</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Mon</name>
    <code>15</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Rakhine</name>
    <code>16</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Shan</name>
    <code>17</code>
    <category>state</category>
  </subcountry>
</country>

<country>
  <name>MONGOLIA</name>
  <code>MN</code>
  <subcountry>
    <name>Ulaanbaatar</name>
    <code>1</code>
    <category>capital city</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Arhangay</name>
    <code>073</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Bayanhongor</name>
    <code>069</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Bayan-�lgiy</name>
    <code>071</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bulgan</name>
    <code>067</code>
    <category>province</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Darhan uul</name>
    <code>037</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Dornod</name>
    <code>061</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dornogovi</name>
    <code>063</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Dundgovi</name>
    <code>059</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Dzavhan</name>
    <code>057</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Govi-Altay</name>
    <code>065</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Govi-S�mber</name>
    <code>064</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Hentiy</name>
    <code>039</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Hovd</name>
    <code>043</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>H�vsg�l</name>
    <code>041</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>�mn�govi</name>
    <code>053</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Orhon</name>
    <code>035</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>�v�rhangay</name>
    <code>055</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Selenge</name>
    <code>049</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>S�hbaatar</name>
    <code>051</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>T�v</name>
    <code>047</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Uvs</name>
    <code>046</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>MAURITANIA</name>
  <code>MR</code>
  <subcountry>
    <name>Nouakchott</name>
    <code>NKC</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Adrar</name>
    <code>07</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Assaba</name>
    <code>03</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Brakna</name>
    <code>05</code>
    <category>region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Dakhlet Nou�dhibou</name>
    <code>08</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Gorgol</name>
    <code>04</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Guidimaka</name>
    <code>10</code>
    <category>region</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Hodh ech Chargui</name>
    <code>01</code>
    <category>region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Hodh el Gharbi</name>
    <code>02</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Inchiri</name>
    <code>12</code>
    <category>region</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Tagant</name>
    <code>09</code>
    <category>region</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Tiris Zemmour</name>
    <code>11</code>
    <category>region</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Trarza</name>
    <code>06</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
</country>

<country>
  <name>MAURITIUS</name>
  <code>MU</code>
  <subcountry>
    <name>Beau Bassin-Rose Hill</name>
    <code>BR</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Curepipe</name>
    <code>CU</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Port Louis</name>
    <code>PU</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Quatre Bornes</name>
    <code>QB</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Vacoas-Phoenix</name>
    <code>VP</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Black River</name>
    <code>BL</code>
    <category>district</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Flacq</name>
    <code>FL</code>
    <category>district</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Grand Port</name>
    <code>GP</code>
    <category>district</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Moka</name>
    <code>MO</code>
    <category>district</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Pamplemousses</name>
    <code>PA</code>
    <category>district</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Plaines Wilhems</name>
    <code>PW</code>
    <category>district</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Port Louis</name>
    <code>PL</code>
    <category>district</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivi�re du Rempart</name>
    <code>RR</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Savanne</name>
    <code>SA</code>
    <category>district</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Agalega Islands</name>
    <code>AG</code>
    <category>dependency</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Cargados Carajos</name>
    <code>CC</code>
    <category>dependency</category>
  </subcountry>
  <subcountry>
    <name>Rodrigues Island</name>
    <code>RO</code>
    <category>dependency</category>
  </subcountry>
</country>

<country>
  <name>MALDIVES</name>
  <code>MV</code>
  <subcountry>
    <name>Male</name>
    <code>MLE</code>
    <category>capital</category>
  </subcountry>
  <subcountry>
    <name>Alif</name>
    <code>02</code>
    <category>administrative atoll</category>
  </subcountry>
  <subcountry>
    <name>Baa</name>
    <code>20</code>
    <category>administrative atoll</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Dhaalu</name>
    <code>17</code>
    <category>administrative atoll</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Faafu</name>
    <code>14</code>
    <category>administrative atoll</category>
  </subcountry>
  <subcountry>
    <name>Gaaf Alif</name>
    <code>27</code>
    <category>administrative atoll</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Gaafu Dhaalu</name>
    <code>28</code>
    <category>administrative atoll</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Gnaviyani</name>
    <code>29</code>
    <category>administrative atoll</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Haa Alif</name>
    <code>07</code>
    <category>administrative atoll</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Haa Dhaalu</name>
    <code>23</code>
    <category>administrative atoll</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaafu</name>
    <code>26</code>
    <category>administrative atoll</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Laamu</name>
    <code>05</code>
    <category>administrative atoll</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Lhaviyani</name>
    <code>03</code>
    <category>administrative atoll</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Meemu</name>
    <code>12</code>
    <category>administrative atoll</category>
  </subcountry>
  <subcountry>
    <name>Noonu</name>
    <code>25</code>
    <category>administrative atoll</category>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Raa</name>
    <code>13</code>
    <category>administrative atoll</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Seenu</name>
    <code>01</code>
    <category>administrative atoll</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Shaviyani</name>
    <code>24</code>
    <category>administrative atoll</category>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Thaa</name>
    <code>08</code>
    <category>administrative atoll</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Vaavu</name>
    <code>04</code>
    <category>administrative atoll</category>
    <FIPS>47</FIPS>
  </subcountry>
</country>

<country>
  <name>MALAWI</name>
  <code>MW</code>
  <subcountry>
    <name>Balaka</name>
    <code>BA</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Blantyre</name>
    <code>BL</code>
    <regional_division>S</regional_division>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Chikwawa</name>
    <code>CK</code>
    <regional_division>S</regional_division>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiradzulu</name>
    <code>CR</code>
    <regional_division>S</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chitipa</name>
    <code>CT</code>
    <regional_division>N</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Dedza</name>
    <code>DE</code>
    <regional_division>C</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dowa</name>
    <code>DO</code>
    <regional_division>C</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Karonga</name>
    <code>KR</code>
    <regional_division>N</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kasungu</name>
    <code>KS</code>
    <regional_division>C</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Likoma Island</name>
    <code>LK</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Lilongwe</name>
    <code>LI</code>
    <regional_division>C</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Machinga</name>
    <code>MH</code>
    <regional_division>S</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Mangochi</name>
    <code>MG</code>
    <regional_division>S</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Mchinji</name>
    <code>MC</code>
    <regional_division>C</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Mulanje</name>
    <code>MU</code>
    <regional_division>S</regional_division>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Mwanza</name>
    <code>MW</code>
    <regional_division>S</regional_division>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Mzimba</name>
    <code>MZ</code>
    <regional_division>N</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Nkhata Bay</name>
    <code>NB</code>
    <regional_division>N</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Nkhotakota</name>
    <code>NK</code>
    <regional_division>C</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Nsanje</name>
    <code>NS</code>
    <regional_division>S</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Ntcheu</name>
    <code>NU</code>
    <regional_division>C</regional_division>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Ntchisi</name>
    <code>NI</code>
    <regional_division>C</regional_division>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Phalombe</name>
    <code>PH</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Rumphi</name>
    <code>RU</code>
    <regional_division>N</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Salima</name>
    <code>SA</code>
    <regional_division>C</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Thyolo</name>
    <code>TH</code>
    <regional_division>S</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Zomba</name>
    <code>ZO</code>
    <regional_division>S</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
</country>

<country>
  <name>MEXICO</name>
  <code>MX</code>
  <subcountry>
    <name>Distrito Federal</name>
    <code>DIF</code>
    <category>federal district</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Aguascalientes</name>
    <code>AGU</code>
    <category>state</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Baja California</name>
    <code>BCN</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Baja California Sur</name>
    <code>BCS</code>
    <category>state</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Campeche</name>
    <code>CAM</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Coahuila</name>
    <code>COA</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Colima</name>
    <code>COL</code>
    <category>state</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiapas</name>
    <code>CHP</code>
    <category>state</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Chihuahua</name>
    <code>CHH</code>
    <category>state</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Durango</name>
    <code>DUR</code>
    <category>state</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Guanajuato</name>
    <code>GUA</code>
    <category>state</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Guerrero</name>
    <code>GRO</code>
    <category>state</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Hidalgo</name>
    <code>HID</code>
    <category>state</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Jalisco</name>
    <code>JAL</code>
    <category>state</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>M�xico</name>
    <code>MEX</code>
    <category>state</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Michoac�n</name>
    <code>MIC</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Morelos</name>
    <code>MOR</code>
    <category>state</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Nayarit</name>
    <code>NAY</code>
    <category>state</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Nuevo Le�n</name>
    <code>NLE</code>
    <category>state</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Oaxaca</name>
    <code>OAX</code>
    <category>state</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Puebla</name>
    <code>PUE</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Quer�taro</name>
    <code>QUE</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Quintana Roo</name>
    <code>ROO</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>San Luis Potos�</name>
    <code>SLP</code>
    <category>state</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Sinaloa</name>
    <code>SIN</code>
    <category>state</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Sonora</name>
    <code>SON</code>
    <category>state</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Tabasco</name>
    <code>TAB</code>
    <category>state</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Tamaulipas</name>
    <code>TAM</code>
    <category>state</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Tlaxcala</name>
    <code>TLA</code>
    <category>state</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Veracruz</name>
    <code>VER</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Yucat�n</name>
    <code>YUC</code>
    <category>state</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Zacatecas</name>
    <code>ZAC</code>
    <category>state</category>
    <FIPS>32</FIPS>
  </subcountry>
</country>

<country>
  <name>MALAYSIA</name>
  <code>MY</code>
  <subcountry>
    <name>Wilayah Persekutuan Kuala Lumpur</name>
    <code>14</code>
    <category>federal territory</category>
  </subcountry>
  <subcountry>
    <name>Wilayah Persekutuan Labuan</name>
    <code>15</code>
    <category>federal territory</category>
  </subcountry>
  <subcountry>
    <name>Johor</name>
    <code>01</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Kedah</name>
    <code>02</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Kelantan</name>
    <code>03</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Melaka</name>
    <code>04</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Negeri Sembilan</name>
    <code>05</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Pahang</name>
    <code>06</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Perak</name>
    <code>08</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Perlis</name>
    <code>09</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Pulau Pinang</name>
    <code>07</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Sabah</name>
    <code>12</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Sarawak</name>
    <code>13</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Selangor</name>
    <code>10</code>
    <category>state</category>
  </subcountry>
  <subcountry>
    <name>Terengganu</name>
    <code>11</code>
    <category>state</category>
  </subcountry>
</country>

<country>
  <name>MOZAMBIQUE</name>
  <code>MZ</code>
  <subcountry>
    <name>Maputo</name>
    <code>MPM</code>
    <category>city</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Cabo Delgado</name>
    <code>P</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Gaza</name>
    <code>G</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Inhambane</name>
    <code>I</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Manica</name>
    <code>B</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Maputo</name>
    <code>L</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Nampula</name>
    <code>N</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Niassa</name>
    <code>A</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Sofala</name>
    <code>S</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Tete</name>
    <code>T</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamb�zia</name>
    <code>Q</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>NAMIBIA</name>
  <code>NA</code>
  <subcountry>
    <name>Caprivi</name>
    <code>CA</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Erongo</name>
    <code>ER</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Hardap</name>
    <code>HA</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Karas</name>
    <code>KA</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Khomas</name>
    <code>KH</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Kunene</name>
    <code>KU</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Ohangwena</name>
    <code>OW</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Okavango</name>
    <code>OK</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Omaheke</name>
    <code>OH</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Omusati</name>
    <code>OS</code>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Oshana</name>
    <code>ON</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Oshikoto</name>
    <code>OT</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Otjozondjupa</name>
    <code>OD</code>
    <FIPS>39</FIPS>
  </subcountry>
</country>

<country>
  <name>NIGER</name>
  <code>NE</code>
  <subcountry>
    <name>Niamey</name>
    <code>8</code>
    <category>urban community</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Agadez</name>
    <code>1</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Diffa</name>
    <code>2</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Dosso</name>
    <code>3</code>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Maradi</name>
    <code>4</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Tahoua</name>
    <code>5</code>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Tillab�ri</name>
    <code>6</code>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Zinder</name>
    <code>7</code>
    <category>department</category>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>NIGERIA</name>
  <code>NG</code>
  <subcountry>
    <name>Abuja Capital Territory</name>
    <code>FC</code>
    <category>capital territory</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Abia</name>
    <code>AB</code>
    <category>state</category>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Adamawa</name>
    <code>AD</code>
    <category>state</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Akwa Ibom</name>
    <code>AK</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Anambra</name>
    <code>AN</code>
    <category>state</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Bauchi</name>
    <code>BA</code>
    <category>state</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Bayelsa</name>
    <code>BY</code>
    <category>state</category>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Benue</name>
    <code>BE</code>
    <category>state</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Borno</name>
    <code>BO</code>
    <category>state</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Cross River</name>
    <code>CR</code>
    <category>state</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Delta</name>
    <code>DE</code>
    <category>state</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Ebonyi</name>
    <code>EB</code>
    <category>state</category>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Edo</name>
    <code>ED</code>
    <category>state</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Ekiti</name>
    <code>EK</code>
    <category>state</category>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Enugu</name>
    <code>EN</code>
    <category>state</category>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Gombe</name>
    <code>GO</code>
    <category>state</category>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Imo</name>
    <code>IM</code>
    <category>state</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Jigawa</name>
    <code>JI</code>
    <category>state</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaduna</name>
    <code>KD</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Kano</name>
    <code>KN</code>
    <category>state</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Katsina</name>
    <code>KT</code>
    <category>state</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Kebbi</name>
    <code>KE</code>
    <category>state</category>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Kogi</name>
    <code>KO</code>
    <category>state</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Kwara</name>
    <code>KW</code>
    <category>state</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Lagos</name>
    <code>LA</code>
    <category>state</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Nassarawa</name>
    <code>NA</code>
    <category>state</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Niger</name>
    <code>NI</code>
    <category>state</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Ogun</name>
    <code>OG</code>
    <category>state</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Ondo</name>
    <code>ON</code>
    <category>state</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Osun</name>
    <code>OS</code>
    <category>state</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Oyo</name>
    <code>OY</code>
    <category>state</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Plateau</name>
    <code>PL</code>
    <category>state</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivers</name>
    <code>RI</code>
    <category>state</category>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Sokoto</name>
    <code>SO</code>
    <category>state</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Taraba</name>
    <code>TA</code>
    <category>state</category>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Yobe</name>
    <code>YO</code>
    <category>state</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamfara</name>
    <code>ZA</code>
    <category>state</category>
    <FIPS>57</FIPS>
  </subcountry>
</country>

<country>
  <name>NICARAGUA</name>
  <code>NI</code>
  <subcountry>
    <name>Boaco</name>
    <code>BO</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Carazo</name>
    <code>CA</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chinandega</name>
    <code>CI</code>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chontales</name>
    <code>CO</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Estel�</name>
    <code>ES</code>
    <category>department</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Granada</name>
    <code>GR</code>
    <category>department</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Jinotega</name>
    <code>JI</code>
    <category>department</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Le�n</name>
    <code>LE</code>
    <category>department</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Madriz</name>
    <code>MD</code>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Managua</name>
    <code>MN</code>
    <category>department</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Masaya</name>
    <code>MS</code>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Matagalpa</name>
    <code>MT</code>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Nueva Segovia</name>
    <code>NS</code>
    <category>department</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>R�o San Juan</name>
    <code>SJ</code>
    <category>department</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivas</name>
    <code>RI</code>
    <category>department</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Atl�ntico Norte</name>
    <code>AN</code>
    <category>autonomous region</category>
  </subcountry>
  <subcountry>
    <name>Atl�ntico Sur</name>
    <code>AS</code>
    <category>autonomous region</category>
  </subcountry>
</country>

<country>
  <name>NETHERLANDS</name>
  <code>NL</code>
  <subcountry>
    <name>Drenthe</name>
    <code>DR</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Flevoland</name>
    <code>FL</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Friesland</name>
    <code>FR</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Gelderland</name>
    <code>GE</code>
  </subcountry>
  <subcountry>
    <name>Groningen</name>
    <code>GR</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Limburg</name>
    <code>LI</code>
  </subcountry>
  <subcountry>
    <name>Noord-Brabant</name>
    <code>NB</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Noord-Holland</name>
    <code>NH</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Overijssel</name>
    <code>OV</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Utrecht</name>
    <code>UT</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Zeeland</name>
    <code>ZE</code>
  </subcountry>
  <subcountry>
    <name>Zuid-Holland</name>
    <code>ZH</code>
    <FIPS>11</FIPS>
  </subcountry>
</country>

<country>
  <name>NORWAY</name>
  <code>NO</code>
  <subcountry>
    <name>Akershus</name>
    <code>02</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Aust-Agder</name>
    <code>09</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Buskerud</name>
    <code>06</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Finnmark</name>
    <code>20</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Hedmark</name>
    <code>04</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Hordaland</name>
    <code>12</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>M�re og Romsdal</name>
    <code>15</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Nordland</name>
    <code>18</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Nord-Tr�ndelag</name>
    <code>17</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Oppland</name>
    <code>05</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Oslo</name>
    <code>03</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Rogaland</name>
    <code>11</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Sogn og Fjordane</name>
    <code>14</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>S�r-Tr�ndelag</name>
    <code>16</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Telemark</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Troms</name>
    <code>19</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Vest-Agder</name>
    <code>10</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Vestfold</name>
    <code>07</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>�stfold</name>
    <code>01</code>
  </subcountry>
  <subcountry>
    <name>Jan Mayen (Arctic Region) (See also country code SJ)</name>
    <code>22</code>
  </subcountry>
  <subcountry>
    <name>Svalbard (Arctic Region) (See also country code SJ)</name>
    <code>21</code>
  </subcountry>
</country>

<country>
  <name>NEPAL</name>
  <code>NP</code>
  <subcountry>
    <name>Bagmati</name>
    <code>BA</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Bheri</name>
    <code>BH</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Dhawalagiri</name>
    <code>DH</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Gandaki</name>
    <code>GA</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Janakpur</name>
    <code>JA</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Karnali</name>
    <code>KA</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Kosi [Koshi]</name>
    <code>KO</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Lumbini</name>
    <code>LU</code>
    <regional_division>3</regional_division>
  </subcountry>
  <subcountry>
    <name>Mahakali</name>
    <code>MA</code>
    <regional_division>5</regional_division>
  </subcountry>
  <subcountry>
    <name>Mechi</name>
    <code>ME</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Narayani</name>
    <code>NA</code>
    <regional_division>1</regional_division>
  </subcountry>
  <subcountry>
    <name>Rapti</name>
    <code>RA</code>
    <regional_division>2</regional_division>
  </subcountry>
  <subcountry>
    <name>Sagarmatha</name>
    <code>SA</code>
    <regional_division>4</regional_division>
  </subcountry>
  <subcountry>
    <name>Seti</name>
    <code>SE</code>
    <regional_division>5</regional_division>
  </subcountry>
</country>

<country>
  <name>NEW ZEALAND</name>
  <code>NZ</code>
  <subcountry>
    <name>Auckland</name>
    <code>AUK</code>
    <regional_division>N</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Bay of Plenty</name>
    <code>BOP</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Canterbury</name>
    <code>CAN</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Gisborne</name>
    <code>GIS</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Hawkes's Bay</name>
    <code>HKB</code>
    <regional_division>N</regional_division>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Manawatu-Wanganui</name>
    <code>MWT</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Marlborough</name>
    <code>MBH</code>
    <regional_division>S</regional_division>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Nelson</name>
    <code>NSN</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Northland</name>
    <code>NTL</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Otago</name>
    <code>OTA</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Southland</name>
    <code>STL</code>
    <regional_division>S</regional_division>
    <FIPS>72</FIPS>
  </subcountry>
  <subcountry>
    <name>Taranaki</name>
    <code>TKI</code>
    <regional_division>N</regional_division>
    <FIPS>76</FIPS>
  </subcountry>
  <subcountry>
    <name>Tasman</name>
    <code>TAS</code>
    <regional_division>S</regional_division>
  </subcountry>
  <subcountry>
    <name>Waikato</name>
    <code>WKO</code>
    <regional_division>N</regional_division>
    <FIPS>85</FIPS>
  </subcountry>
  <subcountry>
    <name>Wellington</name>
    <code>WGN</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>West Coast</name>
    <code>WTC</code>
    <regional_division>S</regional_division>
  </subcountry>
</country>

<country>
  <name>OMAN</name>
  <code>OM</code>
  <subcountry>
    <name>Ad Dakhiliyah</name>
    <code>DA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Batinah</name>
    <code>BA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Janubiyah [Zufar]</name>
    <code>JA</code>
  </subcountry>
  <subcountry>
    <name>Al Wust�</name>
    <code>WU</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ash Sharqiyah</name>
    <code>SH</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Az Zahirah</name>
    <code>ZA</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Masqat</name>
    <code>MA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Musandam</name>
    <code>MU</code>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>PANAMA</name>
  <code>PA</code>
  <subcountry>
    <name>Bocas del Toro</name>
    <code>1</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Cocl�</name>
    <code>2</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Col�n</name>
    <code>3</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiriqu�</name>
    <code>4</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Dari�n</name>
    <code>5</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Herrera</name>
    <code>6</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Los Santos</name>
    <code>7</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Panam�</name>
    <code>8</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Veraguas</name>
    <code>9</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Comarca de San Blas</name>
    <code>0</code>
    <category>special territory</category>
  </subcountry>
</country>

<country>
  <name>PERU</name>
  <code>PE</code>
  <subcountry>
    <name>El Callao</name>
    <code>CAL</code>
    <category>constitutional province</category>
  </subcountry>
  <subcountry>
    <name>Amazonas</name>
    <code>AMA</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Ancash</name>
    <code>ANC</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Apur�mac</name>
    <code>APU</code>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Arequipa</name>
    <code>ARE</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Ayacucho</name>
    <code>AYA</code>
    <category>department</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Cajamarca</name>
    <code>CAJ</code>
    <category>department</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuzco [Cusco]</name>
    <code>CUS</code>
    <category>department</category>
  </subcountry>
  <subcountry>
    <name>Huancavelica</name>
    <code>HUV</code>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Hu�nuco</name>
    <code>HUC</code>
    <category>department</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Ica</name>
    <code>ICA</code>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Jun�n</name>
    <code>JUN</code>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>La Libertad</name>
    <code>LAL</code>
    <category>department</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Lambayeque</name>
    <code>LAM</code>
    <category>department</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Lima</name>
    <code>LIM</code>
    <category>department</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Loreto</name>
    <code>LOR</code>
    <category>department</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Madre de Dios</name>
    <code>MDD</code>
    <category>department</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Moquegua</name>
    <code>MOQ</code>
    <category>department</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Pasco</name>
    <code>PAS</code>
    <category>department</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Piura</name>
    <code>PIU</code>
    <category>department</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Puno</name>
    <code>PUN</code>
    <category>department</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>San Mart�n</name>
    <code>SAM</code>
    <category>department</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Tacna</name>
    <code>TAC</code>
    <category>department</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Tumbes</name>
    <code>TUM</code>
    <category>department</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Ucayali</name>
    <code>UCA</code>
    <category>department</category>
    <FIPS>25</FIPS>
  </subcountry>
</country>

<country>
  <name>PAPUA NEW GUINEA</name>
  <code>PG</code>
  <subcountry>
    <name>National Capital District (Port Moresby)</name>
    <code>NCD</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Central</name>
    <code>CPM</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Chimbu</name>
    <code>CPK</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Eastern Highlands</name>
    <code>EHG</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>East New Britain</name>
    <code>EBR</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>East Sepik</name>
    <code>ESW</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Enga</name>
    <code>EPW</code>
    <category>province</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Gulf</name>
    <code>GPK</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Madang</name>
    <code>MPM</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Manus</name>
    <code>MRL</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Milne Bay</name>
    <code>MBA</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Morobe</name>
    <code>MPL</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>New Ireland</name>
    <code>NIK</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern</name>
    <code>NPP</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>North Solomons</name>
    <code>NSA</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Sandaun [West Sepik]</name>
    <code>SAN</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Southern Highlands</name>
    <code>SHM</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>WPD</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Western Highlands</name>
    <code>WHM</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>West New Britain</name>
    <code>WBK</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
</country>

<country>
  <name>PHILIPPINES</name>
  <code>PH</code>
  <subcountry>
    <name>Abra</name>
    <code>ABR</code>
    <regional_division>15</regional_division>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Agusan del Norte</name>
    <code>AGN</code>
    <regional_division>13</regional_division>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Agusan del Sur</name>
    <code>AGS</code>
    <regional_division>13</regional_division>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Aklan</name>
    <code>AKL</code>
    <regional_division>06</regional_division>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Albay</name>
    <code>ALB</code>
    <regional_division>05</regional_division>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Antique</name>
    <code>ANT</code>
    <regional_division>06</regional_division>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Apayao</name>
    <code>APA</code>
    <regional_division>15</regional_division>
  </subcountry>
  <subcountry>
    <name>Aurora</name>
    <code>AUR</code>
    <regional_division>04</regional_division>
    <FIPS>G8</FIPS>
  </subcountry>
  <subcountry>
    <name>Basilan</name>
    <code>BAS</code>
    <regional_division>09</regional_division>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Bataan</name>
    <code>BAN</code>
    <regional_division>03</regional_division>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Batanes</name>
    <code>BTN</code>
    <regional_division>02</regional_division>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Batangas</name>
    <code>BTG</code>
    <regional_division>04</regional_division>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Benguet</name>
    <code>BEN</code>
    <regional_division>15</regional_division>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Biliran</name>
    <code>BIL</code>
    <regional_division>08</regional_division>
  </subcountry>
  <subcountry>
    <name>Bohol</name>
    <code>BOH</code>
    <regional_division>07</regional_division>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Bukidnon</name>
    <code>BUK</code>
    <regional_division>10</regional_division>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Bulacan</name>
    <code>BUL</code>
    <regional_division>03</regional_division>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Cagayan</name>
    <code>CAG</code>
    <regional_division>02</regional_division>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Camarines Norte</name>
    <code>CAN</code>
    <regional_division>05</regional_division>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Camarines Sur</name>
    <code>CAS</code>
    <regional_division>05</regional_division>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Camiguin</name>
    <code>CAM</code>
    <regional_division>10</regional_division>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Capiz</name>
    <code>CAP</code>
    <regional_division>06</regional_division>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Catanduanes</name>
    <code>CAT</code>
    <regional_division>05</regional_division>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Cavite</name>
    <code>CAV</code>
    <regional_division>04</regional_division>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Cebu</name>
    <code>CEB</code>
    <regional_division>07</regional_division>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Compostela Valley</name>
    <code>COM</code>
    <regional_division>11</regional_division>
  </subcountry>
  <subcountry>
    <name>Davao del Norte</name>
    <code>DAV</code>
    <regional_division>11</regional_division>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Davao del Sur</name>
    <code>DAS</code>
    <regional_division>11</regional_division>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Davao Oriental</name>
    <code>DAO</code>
    <regional_division>11</regional_division>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Eastern Samar</name>
    <code>EAS</code>
    <regional_division>08</regional_division>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Guimaras</name>
    <code>GUI</code>
    <regional_division>06</regional_division>
  </subcountry>
  <subcountry>
    <name>Ifugao</name>
    <code>IFU</code>
    <regional_division>15</regional_division>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Ilocos Norte</name>
    <code>ILN</code>
    <regional_division>01</regional_division>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Ilocos Sur</name>
    <code>ILS</code>
    <regional_division>01</regional_division>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Iloilo</name>
    <code>ILI</code>
    <regional_division>06</regional_division>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Isabela</name>
    <code>ISA</code>
    <regional_division>02</regional_division>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalinga</name>
    <code>KAL</code>
    <regional_division>15</regional_division>
    <FIPS>D6</FIPS>
  </subcountry>
  <subcountry>
    <name>Laguna</name>
    <code>LAG</code>
    <regional_division>04</regional_division>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Lanao del Norte</name>
    <code>LAN</code>
    <regional_division>12</regional_division>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Lanao del Sur</name>
    <code>LAS</code>
    <regional_division>14</regional_division>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>La Union</name>
    <code>LUN</code>
    <regional_division>01</regional_division>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Leyte</name>
    <code>LEY</code>
    <regional_division>08</regional_division>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Maguindanao</name>
    <code>MAG</code>
    <regional_division>14</regional_division>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Marinduque</name>
    <code>MAD</code>
    <regional_division>04</regional_division>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Masbate</name>
    <code>MAS</code>
    <regional_division>05</regional_division>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Mindoro Occidental</name>
    <code>MDC</code>
    <regional_division>04</regional_division>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Mindoro Oriental</name>
    <code>MDR</code>
    <regional_division>04</regional_division>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Misamis Occidental</name>
    <code>MSC</code>
    <regional_division>10</regional_division>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Misamis Oriental</name>
    <code>MSR</code>
    <regional_division>10</regional_division>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Mountain Province</name>
    <code>MOU</code>
    <regional_division>15</regional_division>
  </subcountry>
  <subcountry>
    <name>Negros Occidental</name>
    <code>NEC</code>
    <regional_division>06</regional_division>
    <FIPS>H3</FIPS>
  </subcountry>
  <subcountry>
    <name>Negros Oriental</name>
    <code>NER</code>
    <regional_division>07</regional_division>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>North Cotabato</name>
    <code>NCO</code>
    <regional_division>12</regional_division>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern Samar</name>
    <code>NSA</code>
    <regional_division>08</regional_division>
    <FIPS>67</FIPS>
  </subcountry>
  <subcountry>
    <name>Nueva Ecija</name>
    <code>NUE</code>
    <regional_division>03</regional_division>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Nueva Vizcaya</name>
    <code>NUV</code>
    <regional_division>02</regional_division>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Palawan</name>
    <code>PLW</code>
    <regional_division>04</regional_division>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Pampanga</name>
    <code>PAM</code>
    <regional_division>03</regional_division>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Pangasinan</name>
    <code>PAN</code>
    <regional_division>01</regional_division>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Quezon</name>
    <code>QUE</code>
    <regional_division>04</regional_division>
    <FIPS>H2</FIPS>
  </subcountry>
  <subcountry>
    <name>Quirino</name>
    <code>QUI</code>
    <regional_division>02</regional_division>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Rizal</name>
    <code>RIZ</code>
    <regional_division>04</regional_division>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Romblon</name>
    <code>ROM</code>
    <regional_division>04</regional_division>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Sarangani</name>
    <code>SAR</code>
    <regional_division>11</regional_division>
  </subcountry>
  <subcountry>
    <name>Shariff Kabunsuan</name>
  </subcountry>
  <subcountry>
    <name>Siquijor</name>
    <code>SIG</code>
    <regional_division>07</regional_division>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Sorsogon</name>
    <code>SOR</code>
    <regional_division>05</regional_division>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>South Cotabato</name>
    <code>SCO</code>
    <regional_division>11</regional_division>
    <FIPS>70</FIPS>
  </subcountry>
  <subcountry>
    <name>Southern Leyte</name>
    <code>SLE</code>
    <regional_division>08</regional_division>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Sultan Kudarat</name>
    <code>SUK</code>
    <regional_division>12</regional_division>
    <FIPS>71</FIPS>
  </subcountry>
  <subcountry>
    <name>Sulu</name>
    <code>SLU</code>
    <regional_division>14</regional_division>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Surigao del Norte</name>
    <code>SUN</code>
    <regional_division>13</regional_division>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Surigao del Sur</name>
    <code>SUR</code>
    <regional_division>13</regional_division>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Tarlac</name>
    <code>TAR</code>
    <regional_division>03</regional_division>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Tawi-Tawi</name>
    <code>TAW</code>
    <regional_division>14</regional_division>
    <FIPS>72</FIPS>
  </subcountry>
  <subcountry>
    <name>Western Samar</name>
    <code>WSA</code>
    <regional_division>08</regional_division>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Zambales</name>
    <code>ZMB</code>
    <regional_division>03</regional_division>
    <FIPS>64</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamboanga del Norte</name>
    <code>ZAN</code>
    <regional_division>09</regional_division>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamboanga del Sur</name>
    <code>ZAS</code>
    <regional_division>09</regional_division>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Zamboanga Sibuguey [Zamboanga Sibugay]</name>
    <code>ZSI</code>
    <regional_division>09</regional_division>
  </subcountry>
</country>

<country>
  <name>PAKISTAN</name>
  <code>PK</code>
  <subcountry>
    <name>Islamabad</name>
    <code>IS</code>
    <category>federal capital territory</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Baluchistan</name>
    <code>BA</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>North-West Frontier</name>
    <code>NW</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Punjab</name>
    <code>PB</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Sind</name>
    <code>SD</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Federally Administered Tribal Areas</name>
    <code>TA</code>
    <category>territory</category>
  </subcountry>
  <subcountry>
    <name>Azad Kashmir</name>
    <code>JK</code>
    <category>Pakistan administered area</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern Areas</name>
    <code>NA</code>
    <category>Pakistan administered area</category>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>POLAND</name>
  <code>PL</code>
  <subcountry>
    <name>Dolnoslaskie</name>
    <code>DS</code>
  </subcountry>
  <subcountry>
    <name>Kujawsko-pomorskie</name>
    <code>KP</code>
  </subcountry>
  <subcountry>
    <name>Lubelskie</name>
    <code>LU</code>
  </subcountry>
  <subcountry>
    <name>Lubuskie</name>
    <code>LB</code>
  </subcountry>
  <subcountry>
    <name>L�dzkie</name>
    <code>LD</code>
  </subcountry>
  <subcountry>
    <name>Malopolskie</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Mazowieckie</name>
    <code>MZ</code>
  </subcountry>
  <subcountry>
    <name>Opolskie</name>
    <code>OP</code>
  </subcountry>
  <subcountry>
    <name>Podkarpackie</name>
    <code>PK</code>
  </subcountry>
  <subcountry>
    <name>Podlaskie</name>
    <code>PD</code>
    <FIPS>81</FIPS>
  </subcountry>
  <subcountry>
    <name>Pomorskie</name>
    <code>PM</code>
  </subcountry>
  <subcountry>
    <name>Slaskie</name>
    <code>SL</code>
    <FIPS>83</FIPS>
  </subcountry>
  <subcountry>
    <name>Swietokrzyskie</name>
    <code>SK</code>
  </subcountry>
  <subcountry>
    <name>Warminsko-mazurskie</name>
    <code>WN</code>
  </subcountry>
  <subcountry>
    <name>Wielkopolskie</name>
    <code>WP</code>
    <FIPS>86</FIPS>
  </subcountry>
  <subcountry>
    <name>Zachodniopomorskie</name>
    <code>ZP</code>
  </subcountry>
</country>

<country>
  <name>PORTUGAL</name>
  <code>PT</code>
  <subcountry>
    <name>Aveiro</name>
    <code>01</code>
    <category>district</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Beja</name>
    <code>02</code>
    <category>district</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Braga</name>
    <code>03</code>
    <category>district</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Bragan�a</name>
    <code>04</code>
    <category>district</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Castelo Branco</name>
    <code>05</code>
    <category>district</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Coimbra</name>
    <code>06</code>
    <category>district</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>�vora</name>
    <code>07</code>
    <category>district</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Faro</name>
    <code>08</code>
    <category>district</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Guarda</name>
    <code>09</code>
    <category>district</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Leiria</name>
    <code>10</code>
    <category>district</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Lisboa</name>
    <code>11</code>
    <category>district</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Portalegre</name>
    <code>12</code>
    <category>district</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Porto</name>
    <code>13</code>
    <category>district</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Santar�m</name>
    <code>14</code>
    <category>district</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Set�bal</name>
    <code>15</code>
    <category>district</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Viana do Castelo</name>
    <code>16</code>
    <category>district</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Vila Real</name>
    <code>17</code>
    <category>district</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Viseu</name>
    <code>18</code>
    <category>district</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Regi�o Aut�noma dos A�ores</name>
    <code>20</code>
    <category>autonomous region</category>
  </subcountry>
  <subcountry>
    <name>Regi�o Aut�noma da Madeira</name>
    <code>30</code>
    <category>autonomous region</category>
  </subcountry>
</country>

<country>
  <name>PARAGUAY</name>
  <code>PY</code>
  <subcountry>
    <name>Asunci�n</name>
    <code>ASU</code>
    <category>capital</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Alto Paraguay</name>
    <code>16</code>
    <category>department</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Alto Paran�</name>
    <code>10</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Amambay</name>
    <code>13</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Boquer�n</name>
    <code>19</code>
    <category>department</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Caaguaz�</name>
    <code>5</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Caazap�</name>
    <code>6</code>
    <category>department</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Canindey�</name>
    <code>14</code>
    <category>department</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Central</name>
    <code>11</code>
    <category>department</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Concepci�n</name>
    <code>1</code>
    <category>department</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Cordillera</name>
    <code>3</code>
    <category>department</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Guair�</name>
    <code>4</code>
    <category>department</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Itap�a</name>
    <code>7</code>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Misiones</name>
    <code>8</code>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>�eembuc�</name>
    <code>12</code>
    <category>department</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Paraguar�</name>
    <code>9</code>
    <category>department</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Presidente Hayes</name>
    <code>15</code>
    <category>department</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>San Pedro</name>
    <code>2</code>
    <category>department</category>
    <FIPS>17</FIPS>
  </subcountry>
</country>

<country>
  <name>QATAR</name>
  <code>QA</code>
  <subcountry>
    <name>Ad Dawhah</name>
    <code>DA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Ghuwayriyah</name>
    <code>GH</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Jumayliyah</name>
    <code>JU</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Khawr</name>
    <code>KH</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Wakrah</name>
    <code>WA</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ar Rayyan</name>
    <code>RA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Jariyan al Batnah</name>
    <code>JB</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Madinat ash Shamal</name>
    <code>MS</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Umm Salal</name>
    <code>US</code>
    <FIPS>09</FIPS>
  </subcountry>
</country>

<country>
  <name>ROMANIA</name>
  <code>RO</code>
  <subcountry>
    <name>Bucuresti</name>
    <code>B</code>
    <category>municipality</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Alba</name>
    <code>AB</code>
    <category>department</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Arad</name>
    <code>AR</code>
    <category>department</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Arges</name>
    <code>AG</code>
    <category>department</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bacau</name>
    <code>BC</code>
    <category>department</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Bihor</name>
    <code>BH</code>
    <category>department</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Bistrita-Nasaud</name>
    <code>BN</code>
    <category>department</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Botosani</name>
    <code>BT</code>
    <category>department</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Brasov</name>
    <code>BV</code>
    <category>department</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Braila</name>
    <code>BR</code>
    <category>department</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Buzau</name>
    <code>BZ</code>
    <category>department</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Caras-Severin</name>
    <code>CS</code>
    <category>department</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Calarasi</name>
    <code>CL</code>
    <category>department</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Cluj</name>
    <code>CJ</code>
    <category>department</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Constanta</name>
    <code>CT</code>
    <category>department</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Covasna</name>
    <code>CV</code>
    <category>department</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>D�mbovita</name>
    <code>DB</code>
    <category>department</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Dolj</name>
    <code>DJ</code>
    <category>department</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Galati</name>
    <code>GL</code>
    <category>department</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Giurgiu</name>
    <code>GR</code>
    <category>department</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Gorj</name>
    <code>GJ</code>
    <category>department</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Harghita</name>
    <code>HR</code>
    <category>department</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Hunedoara</name>
    <code>HD</code>
    <category>department</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Ialomita</name>
    <code>IL</code>
    <category>department</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Iasi</name>
    <code>IS</code>
    <category>department</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Maramures</name>
    <code>MM</code>
    <category>department</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Mehedinti</name>
    <code>MH</code>
    <category>department</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Mures</name>
    <code>MS</code>
    <category>department</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Neamt</name>
    <code>NT</code>
    <category>department</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Olt</name>
    <code>OT</code>
    <category>department</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Prahova</name>
    <code>PH</code>
    <category>department</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Satu Mare</name>
    <code>SM</code>
    <category>department</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Salaj</name>
    <code>SJ</code>
    <category>department</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Sibiu</name>
    <code>SB</code>
    <category>department</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Suceava</name>
    <code>SV</code>
    <category>department</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Teleorman</name>
    <code>TR</code>
    <category>department</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Timis</name>
    <code>TM</code>
    <category>department</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Tulcea</name>
    <code>TL</code>
    <category>department</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Vaslui</name>
    <code>VS</code>
    <category>department</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>V�lcea</name>
    <code>VL</code>
    <category>department</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Vrancea</name>
    <code>VN</code>
    <category>department</category>
    <FIPS>40</FIPS>
  </subcountry>
</country>

<country>
  <name>RUSSIA</name>
  <code>RU</code>
  <subcountry>
    <name>Adygeya, Respublika</name>
    <code>AD</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Altay, Respublika</name>
    <code>AL</code>
    <category>republic</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bashkortostan, Respublika</name>
    <code>BA</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Buryatiya, Respublika</name>
    <code>BU</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Chechenskaya Respublika</name>
    <code>CE</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Chuvashskaya Respublika</name>
    <code>CU</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Dagestan, Respublika</name>
    <code>DA</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Ingushskaya Respublika [Respublika Ingushetiya]</name>
    <code>IN</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Kabardino-Balkarskaya Respublika</name>
    <code>KB</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Kalmykiya, Respublika</name>
    <code>KL</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Karachayevo-Cherkesskaya Respublika</name>
    <code>KC</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Kareliya, Respublika</name>
    <code>KR</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Khakasiya, Respublika</name>
    <code>KK</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Komi, Respublika</name>
    <code>KO</code>
    <category>republic</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Mariy El, Respublika</name>
    <code>ME</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Mordoviya, Respublika</name>
    <code>MO</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Sakha, Respublika [Yakutiya]</name>
    <code>SA</code>
    <category>republic</category>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Severnaya Osetiya, Respublika [Alaniya] [Respublika Severnaya Osetiya-Alaniya]</name>
    <code>SE</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Tatarstan, Respublika</name>
    <code>TA</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Tyva, Respublika [Tuva]</name>
    <code>TY</code>
    <category>republic</category>
    <FIPS>79</FIPS>
  </subcountry>
  <subcountry>
    <name>Udmurtskaya Respublika</name>
    <code>UD</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Altayskiy kray</name>
    <code>ALT</code>
    <category>administrative territory</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Khabarovskiy kray</name>
    <code>KHA</code>
    <category>administrative territory</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Krasnodarskiy kray</name>
    <code>KDA</code>
    <category>administrative territory</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Krasnoyarskiy kray</name>
    <code>KYA</code>
    <category>administrative territory</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Primorskiy kray</name>
    <code>PRI</code>
    <category>administrative territory</category>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Stavropol'skiy kray</name>
    <code>STA</code>
    <category>administrative territory</category>
    <FIPS>70</FIPS>
  </subcountry>
  <subcountry>
    <name>Amurskaya oblast'</name>
    <code>AMU</code>
    <category>administrative region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Arkhangel'skaya oblast'</name>
    <code>ARK</code>
    <category>administrative region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Astrakhanskaya oblast'</name>
    <code>AST</code>
    <category>administrative region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Belgorodskaya oblast'</name>
    <code>BEL</code>
    <category>administrative region</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Bryanskaya oblast'</name>
    <code>BRY</code>
    <category>administrative region</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Chelyabinskaya oblast'</name>
    <code>CHE</code>
    <category>administrative region</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Chitinskaya oblast'</name>
    <code>CHI</code>
    <category>administrative region</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Irkutskaya oblast'</name>
    <code>IRK</code>
    <category>administrative region</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Ivanovskaya oblast'</name>
    <code>IVA</code>
    <category>administrative region</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaliningradskaya oblast'</name>
    <code>KGD</code>
    <category>administrative region</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaluzhskaya oblast'</name>
    <code>KLU</code>
    <category>administrative region</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Kamchatskaya oblast'</name>
    <code>KAM</code>
    <category>administrative region</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Kemerovskaya oblast'</name>
    <code>KEM</code>
    <category>administrative region</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Kirovskaya oblast'</name>
    <code>KIR</code>
    <category>administrative region</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Kostromskaya oblast'</name>
    <code>KOS</code>
    <category>administrative region</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Kurganskaya oblast'</name>
    <code>KGN</code>
    <category>administrative region</category>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Kurskaya oblast'</name>
    <code>KRS</code>
    <category>administrative region</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Leningradskaya oblast'</name>
    <code>LEN</code>
    <category>administrative region</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Lipetskaya oblast'</name>
    <code>LIP</code>
    <category>administrative region</category>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Magadanskaya oblast'</name>
    <code>MAG</code>
    <category>administrative region</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Moskovskaya oblast'</name>
    <code>MOS</code>
    <category>administrative region</category>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Murmanskaya oblast'</name>
    <code>MUR</code>
    <category>administrative region</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Nizhegorodskaya oblast'</name>
    <code>NIZ</code>
    <category>administrative region</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Novgorodskaya oblast'</name>
    <code>NGR</code>
    <category>administrative region</category>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Novosibirskaya oblast'</name>
    <code>NVS</code>
    <category>administrative region</category>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Omskaya oblast'</name>
    <code>OMS</code>
    <category>administrative region</category>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Orenburgskaya oblast'</name>
    <code>ORE</code>
    <category>administrative region</category>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Orlovskaya oblast'</name>
    <code>ORL</code>
    <category>administrative region</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Penzenskaya oblast'</name>
    <code>PNZ</code>
    <category>administrative region</category>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Permskaya oblast'</name>
    <code>PER</code>
    <category>administrative region</category>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Pskovskaya oblast'</name>
    <code>PSK</code>
    <category>administrative region</category>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Rostovskaya oblast'</name>
    <code>ROS</code>
    <category>administrative region</category>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Ryazanskaya oblast'</name>
    <code>RYA</code>
    <category>administrative region</category>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Sakhalinskaya oblast'</name>
    <code>SAK</code>
    <category>administrative region</category>
    <FIPS>64</FIPS>
  </subcountry>
  <subcountry>
    <name>Samarskaya oblast'</name>
    <code>SAM</code>
    <category>administrative region</category>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Saratovskaya oblast'</name>
    <code>SAR</code>
    <category>administrative region</category>
    <FIPS>67</FIPS>
  </subcountry>
  <subcountry>
    <name>Smolenskaya oblast'</name>
    <code>SMO</code>
    <category>administrative region</category>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Sverdlovskaya oblast'</name>
    <code>SVE</code>
    <category>administrative region</category>
    <FIPS>71</FIPS>
  </subcountry>
  <subcountry>
    <name>Tambovskaya oblast'</name>
    <code>TAM</code>
    <category>administrative region</category>
    <FIPS>72</FIPS>
  </subcountry>
  <subcountry>
    <name>Tomskaya oblast'</name>
    <code>TOM</code>
    <category>administrative region</category>
    <FIPS>75</FIPS>
  </subcountry>
  <subcountry>
    <name>Tul'skaya oblast'</name>
    <code>TUL</code>
    <category>administrative region</category>
    <FIPS>76</FIPS>
  </subcountry>
  <subcountry>
    <name>Tverskaya oblast'</name>
    <code>TVE</code>
    <category>administrative region</category>
    <FIPS>77</FIPS>
  </subcountry>
  <subcountry>
    <name>Tyumenskaya oblast'</name>
    <code>TYU</code>
    <category>administrative region</category>
    <FIPS>78</FIPS>
  </subcountry>
  <subcountry>
    <name>Ul'yanovskaya oblast'</name>
    <code>ULY</code>
    <category>administrative region</category>
    <FIPS>81</FIPS>
  </subcountry>
  <subcountry>
    <name>Vladimirskaya oblast'</name>
    <code>VLA</code>
    <category>administrative region</category>
    <FIPS>83</FIPS>
  </subcountry>
  <subcountry>
    <name>Volgogradskaya oblast'</name>
    <code>VGG</code>
    <category>administrative region</category>
    <FIPS>84</FIPS>
  </subcountry>
  <subcountry>
    <name>Vologodskaya oblast'</name>
    <code>VLG</code>
    <category>administrative region</category>
    <FIPS>85</FIPS>
  </subcountry>
  <subcountry>
    <name>Voronezhskaya oblast'</name>
    <code>VOR</code>
    <category>administrative region</category>
    <FIPS>86</FIPS>
  </subcountry>
  <subcountry>
    <name>Yaroslavskaya oblast'</name>
    <code>YAR</code>
    <category>administrative region</category>
    <FIPS>88</FIPS>
  </subcountry>
  <subcountry>
    <name>Moskva</name>
    <code>MOW</code>
    <category>autonomous city</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Sankt-Peterburg</name>
    <code>SPE</code>
    <category>autonomous city</category>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Yevreyskaya avtonomnaya oblast'</name>
    <code>YEV</code>
    <category>autonomous region</category>
  </subcountry>
  <subcountry>
    <name>Aginskiy Buryatskiy avtonomnyy okrug</name>
    <code>AGB</code>
    <category>autonomous district</category>
  </subcountry>
  <subcountry>
    <name>Chukotskiy avtonomnyy okrug</name>
    <code>CHU</code>
    <category>autonomous district</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Evenkiyskiy avtonomnyy okrug</name>
    <code>EVE</code>
    <category>autonomous district</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Khanty-Mansiyskiy avtonomnyy okrug</name>
    <code>KHM</code>
    <category>autonomous district</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Komi-Permyatskiy avtonomnyy okrug</name>
    <code>KOP</code>
    <category>autonomous district</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Koryakskiy avtonomnyy okrug</name>
    <code>KOR</code>
    <category>autonomous district</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Nenetskiy avtonomnyy okrug</name>
    <code>NEN</code>
    <category>autonomous district</category>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Taymyrskiy (Dolgano-Nenetskiy) avtonomnyy okrug</name>
    <code>TAY</code>
    <category>autonomous district</category>
  </subcountry>
  <subcountry>
    <name>Ust'-Ordynskiy Buryatskiy avtonomnyy okrug</name>
    <code>UOB</code>
    <category>autonomous district</category>
  </subcountry>
  <subcountry>
    <name>Yamalo-Nenetskiy avtonomnyy okrug</name>
    <code>YAN</code>
    <category>autonomous district</category>
    <FIPS>87</FIPS>
  </subcountry>
</country>

<country>
  <name>RWANDA</name>
  <code>RW</code>
  <subcountry>
    <name>Butare</name>
    <code>C</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Byumba</name>
    <code>I</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Cyangugu</name>
    <code>E</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Gikongoro</name>
    <code>D</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Gisenyi</name>
    <code>G</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Gitarama</name>
    <code>B</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kibungo</name>
    <code>J</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Kibuye</name>
    <code>F</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kigali-Rural</name>
    <code>K</code>
  </subcountry>
  <subcountry>
    <name>Kigali-Ville</name>
    <code>L</code>
  </subcountry>
  <subcountry>
    <name>Mutara</name>
    <code>M</code>
  </subcountry>
  <subcountry>
    <name>Ruhengeri</name>
    <code>H</code>
    <FIPS>10</FIPS>
  </subcountry>
</country>

<country>
  <name>SAUDI ARABIA</name>
  <code>SA</code>
  <subcountry>
    <name>Al Bahah</name>
    <code>11</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Hudud ash Shamaliyah</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Al Jawf</name>
    <code>12</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Madinah</name>
    <code>03</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qasim</name>
    <code>05</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Ar Riyah</name>
    <code>01</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Ash Sharqiyah</name>
    <code>04</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Asir</name>
    <code>14</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha'il</name>
    <code>06</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Jizan</name>
    <code>09</code>
  </subcountry>
  <subcountry>
    <name>Makkah</name>
    <code>02</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Najran</name>
    <code>10</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Tabuk</name>
    <code>07</code>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>SOLOMON ISLANDS</name>
  <code>SB</code>
  <subcountry>
    <name>Capital Territory (Honiara)</name>
    <code>CT</code>
    <category>capital territory</category>
  </subcountry>
  <subcountry>
    <name>Central</name>
    <code>CE</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Guadalcanal</name>
    <code>GU</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Isabel</name>
    <code>IS</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Makira</name>
    <code>MK</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Malaita</name>
    <code>ML</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Temotu</name>
    <code>TE</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>WE</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
</country>

<country>
  <name>SUDAN</name>
  <code>SD</code>
  <subcountry>
    <name>Ahali an Nil</name>
    <code>23</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Bahr al Ahmar</name>
    <code>26</code>
  </subcountry>
  <subcountry>
    <name>Al Buhayrat</name>
    <code>18</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Jazirah</name>
    <code>07</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Khartum</name>
    <code>03</code>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qaharif</name>
    <code>06</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Wahdah</name>
    <code>22</code>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>An Nil</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>An Nil al Abyah</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>An Nil al Azraq</name>
    <code>24</code>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Ash Shamaliyah</name>
    <code>01</code>
    <FIPS>43</FIPS>
  </subcountry>
   <subcountry>
    <name>Central Equatoria</name>
    <code>17</code>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Gharb al Istiwa'iyah</name>
    <code>16</code>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Gharb Bahr al Ghazal</name>
    <code>14</code>
  </subcountry>
  <subcountry>
    <name>Gharb Darfur</name>
    <code>12</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Gharb Kurdufan</name>
    <code>10</code>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Janub Darfur</name>
    <code>11</code>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Janub Kurdufan</name>
    <code>13</code>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Junqali</name>
    <code>20</code>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Kassala</name>
    <code>05</code>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Shamal Bahr al Ghazal</name>
    <code>15</code>
  </subcountry>
  <subcountry>
    <name>Shamal Darfur</name>
    <code>02</code>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Shamal Kurdufan</name>
    <code>09</code>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Sharq al Istiwa'iyah</name>
    <code>19</code>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Sinnar</name>
    <code>25</code>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Warab</name>
    <code>21</code>
    <FIPS>59</FIPS>
  </subcountry>
</country>

<country>
  <name>SWEDEN</name>
  <code>SE</code>
  <subcountry>
    <name>Blekinge l�n [SE-10]</name>
    <code>K</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Dalarnas l�n [SE-20]</name>
    <code>W</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Gotlands l�n [SE-09]</name>
    <code>I</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>G�vleborgs l�n [SE-21]</name>
    <code>X</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Hallands l�n [SE-13]</name>
    <code>N</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>J�mtlands l�n [SE-23]</name>
    <code>Z</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>J�nk�pings l�n [SE-06]</name>
    <code>F</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalmar l�n [SE-08]</name>
    <code>H</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Kronobergs l�n [SE-07]</name>
    <code>G</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Norrbottens l�n [SE-25]</name>
    <code>BD</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Sk�ne l�n [SE-12]</name>
    <code>M</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Stockholms l�n [SE-01]</name>
    <code>AB</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>S�dermanlands l�n [SE-04]</name>
    <code>D</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Uppsala l�n [SE-03]</name>
    <code>C</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>V�rmlands l�n [SE-17]</name>
    <code>S</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>V�sterbottens l�n [SE-24]</name>
    <code>AC</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>V�sternorrlands l�n [SE-22]</name>
    <code>Y</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>V�stmanlands l�n [SE-19]</name>
    <code>U</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>V�stra G�talands l�n [SE-14]</name>
    <code>O</code>
  </subcountry>
  <subcountry>
    <name>�rebro l�n [SE-18]</name>
    <code>T</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>�sterg�tlands l�n [SE-05]</name>
    <code>E</code>
    <FIPS>16</FIPS>
  </subcountry>
</country>

<country>
  <name>SAINT HELENA</name>
  <code>SH</code>
  <subcountry>
    <name>Saint Helena</name>
    <code>SH</code>
    <category>administrative area</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Ascension</name>
    <code>AC</code>
    <category>dependency</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Tristan da Cunha</name>
    <code>TA</code>
    <category>dependency</category>
    <FIPS>03</FIPS>
  </subcountry>
</country>

<country>
  <name>SLOVAKIA</name>
  <code>SK</code>
  <subcountry>
    <name>Banskobystrick� kraj</name>
    <code>BC</code>
  </subcountry>
  <subcountry>
    <name>Bratislavsk� kraj</name>
    <code>BL</code>
  </subcountry>
  <subcountry>
    <name>Ko�ick� kraj</name>
    <code>KI</code>
  </subcountry>
  <subcountry>
    <name>Nitriansky kraj</name>
    <code>NI</code>
  </subcountry>
  <subcountry>
    <name>Pre�ovsk� kraj</name>
    <code>PV</code>
  </subcountry>
  <subcountry>
    <name>Trenciansky kraj</name>
    <code>TC</code>
  </subcountry>
  <subcountry>
    <name>Trnavsk� kraj</name>
    <code>TA</code>
  </subcountry>
  <subcountry>
    <name>�ilinsk� kraj</name>
    <code>ZI</code>
  </subcountry>
</country>

<country>
  <name>SIERRA LEONE</name>
  <code>SL</code>
  <subcountry>
    <name>Western Area (Freetown)</name>
    <code>W</code>
    <category>area</category>
  </subcountry>
  <subcountry>
    <name>Eastern</name>
    <code>E</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern</name>
    <code>N</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Southern</name>
    <code>S</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
</country>

<country>
  <name>SENEGAL</name>
  <code>SN</code>
  <subcountry>
    <name>Dakar</name>
    <code>DK</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Diourbel</name>
    <code>DB</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Fatick</name>
    <code>FK</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Kaolack</name>
    <code>KL</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Kolda</name>
    <code>KD</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Louga</name>
    <code>LG</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint-Louis</name>
    <code>SL</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Tambacounda</name>
    <code>TC</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Thi�s</name>
    <code>TH</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ziguinchor</name>
    <code>ZG</code>
    <FIPS>12</FIPS>
  </subcountry>
</country>

<country>
  <name>SOMALIA</name>
  <code>SO</code>
  <subcountry>
    <name>Awdal</name>
    <code>AW</code>
  </subcountry>
  <subcountry>
    <name>Bakool</name>
    <code>BK</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Banaadir</name>
    <code>BN</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Bari</name>
    <code>BR</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Bay</name>
    <code>BY</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Galguduud</name>
    <code>GA</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Gedo</name>
    <code>GE</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Hiiraan</name>
    <code>HI</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Jubbada Dhexe</name>
    <code>JD</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Jubbada Hoose</name>
    <code>JH</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Mudug</name>
    <code>MU</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Nugaal</name>
    <code>NU</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Sanaag</name>
    <code>SA</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Shabeellaha Dhexe</name>
    <code>SD</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Shabeellaha Hoose</name>
    <code>SH</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Sool</name>
    <code>SO</code>
  </subcountry>
  <subcountry>
    <name>Togdheer</name>
    <code>TO</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Woqooyi Galbeed</name>
    <code>WO</code>
    <FIPS>16</FIPS>
  </subcountry>
</country>

<country>
  <name>SURINAME</name>
  <code>SR</code>
  <subcountry>
    <name>Brokopondo</name>
    <code>BR</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Commewijne</name>
    <code>CM</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Coronie</name>
    <code>CR</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Marowijne</name>
    <code>MA</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Nickerie</name>
    <code>NI</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Para</name>
    <code>PR</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Paramaribo</name>
    <code>PM</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Saramacca</name>
    <code>SA</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Sipaliwini</name>
    <code>SI</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Wanica</name>
    <code>WA</code>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>SAO TOME AND PRINCIPE</name>
  <code>ST</code>
  <subcountry>
    <name>Pr�ncipe</name>
    <code>P</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>S�o Tom�</name>
    <code>S</code>
    <FIPS>02</FIPS>
  </subcountry>
</country>

<country>
  <name>EL SALVADOR</name>
  <code>SV</code>
  <subcountry>
    <name>Ahuachap�n</name>
    <code>AH</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Caba�as</name>
    <code>CA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Cuscatl�n</name>
    <code>CU</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Chalatenango</name>
    <code>CH</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>La Libertad</name>
    <code>LI</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>La Paz</name>
    <code>PA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>La Uni�n</name>
    <code>UN</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Moraz�n</name>
    <code>MO</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>San Miguel</name>
    <code>SM</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>San Salvador</name>
    <code>SS</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Santa Ana</name>
    <code>SA</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>San Vicente</name>
    <code>SV</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Sonsonate</name>
    <code>SO</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Usulut�n</name>
    <code>US</code>
    <FIPS>14</FIPS>
  </subcountry>
</country>

<country>
  <name>SYRIAN ARAB REPUBLIC</name>
  <code>SY</code>
  <subcountry>
    <name>Al Hasakah</name>
    <code>HA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Ladhiqiyah</name>
    <code>LA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Al Qunaytirah</name>
    <code>QU</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Ar Raqqah</name>
    <code>RA</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>As Suwayda'</name>
    <code>SU</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Darha</name>
    <code>DR</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Dayr az Zawr</name>
    <code>DY</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Dimashq</name>
    <code>DI</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Halab</name>
    <code>HL</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Hamah</name>
    <code>HM</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Hims</name>
    <code>HI</code>
  </subcountry>
  <subcountry>
    <name>Idlib</name>
    <code>ID</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Rif Dimashq</name>
    <code>RD</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Tartus</name>
    <code>TA</code>
    <FIPS>14</FIPS>
  </subcountry>
</country>

<country>
  <name>SWAZILAND</name>
  <code>SZ</code>
  <subcountry>
    <name>Hhohho</name>
    <code>HH</code>
  </subcountry>
  <subcountry>
    <name>Lubombo</name>
    <code>LU</code>
  </subcountry>
  <subcountry>
    <name>Manzini</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Shiselweni</name>
    <code>SH</code>
  </subcountry>
</country>

<country>
  <name>CHAD</name>
  <code>TD</code>
  <subcountry>
    <name>Batha</name>
    <code>BA</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Biltine</name>
    <code>BI</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Borkou-Ennedi-Tibesti</name>
    <code>BET</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chari-Baguirmi</name>
    <code>CB</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Gu�ra</name>
    <code>GR</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Kanem</name>
    <code>KA</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Lac</name>
    <code>LC</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Logone-Occidental</name>
    <code>LO</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Logone-Oriental</name>
    <code>LR</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Mayo-K�bbi</name>
    <code>MK</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Moyen-Chari</name>
    <code>MC</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Ouadda�</name>
    <code>OD</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Salamat</name>
    <code>SA</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Tandjil�</name>
    <code>TA</code>
    <FIPS>14</FIPS>
  </subcountry>
</country>

<country>
  <name>TOGO</name>
  <code>TG</code>
  <subcountry>
    <name>Centre</name>
    <code>C</code>
  </subcountry>
  <subcountry>
    <name>Kara</name>
    <code>K</code>
  </subcountry>
  <subcountry>
    <name>Maritime (R�gion)</name>
    <code>M</code>
  </subcountry>
  <subcountry>
    <name>Plateaux</name>
    <code>P</code>
  </subcountry>
  <subcountry>
    <name>Savannes</name>
    <code>S</code>
  </subcountry>
</country>

<country>
  <name>THAILAND</name>
  <code>TH</code>
  <subcountry>
    <name>Krung Thep Maha Nakhon [Bangkok]</name>
    <code>10</code>
    <category>metropolitan administration</category>
  </subcountry>
  <subcountry>
    <name>Phatthaya</name>
    <code>S</code>
    <category>special administrative city</category>
  </subcountry>
  <subcountry>
    <name>Amnat Charoen</name>
    <code>37</code>
    <category>province</category>
    <FIPS>77</FIPS>
  </subcountry>
  <subcountry>
    <name>Ang Thong</name>
    <code>15</code>
    <category>province</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Buri Ram</name>
    <code>31</code>
    <category>province</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Chachoengsao</name>
    <code>24</code>
    <category>province</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Chai Nat</name>
    <code>18</code>
    <category>province</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Chaiyaphum</name>
    <code>36</code>
    <category>province</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Chanthaburi</name>
    <code>22</code>
    <category>province</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiang Mai</name>
    <code>50</code>
    <category>province</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiang Rai</name>
    <code>57</code>
    <category>province</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chon Buri</name>
    <code>20</code>
    <category>province</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Chumphon</name>
    <code>86</code>
    <category>province</category>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Kalasin</name>
    <code>46</code>
    <category>province</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Kamphaeng Phet</name>
    <code>62</code>
    <category>province</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Kanchanaburi</name>
    <code>71</code>
    <category>province</category>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Khon Kaen</name>
    <code>40</code>
    <category>province</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Krabi</name>
    <code>81</code>
    <category>province</category>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Lampang</name>
    <code>52</code>
    <category>province</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Lamphun</name>
    <code>51</code>
    <category>province</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Loei</name>
    <code>42</code>
    <category>province</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Lop Buri</name>
    <code>16</code>
    <category>province</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Mae Hong Son</name>
    <code>58</code>
    <category>province</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Maha Sarakham</name>
    <code>44</code>
    <category>province</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Mukdahan</name>
    <code>49</code>
    <category>province</category>
    <FIPS>78</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Nayok</name>
    <code>26</code>
    <category>province</category>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Pathom</name>
    <code>73</code>
    <category>province</category>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Phanom</name>
    <code>48</code>
    <category>province</category>
    <FIPS>73</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Ratchasima</name>
    <code>30</code>
    <category>province</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Sawan</name>
    <code>60</code>
    <category>province</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Nakhon Si Thammarat</name>
    <code>80</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Nan</name>
    <code>55</code>
    <category>province</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Narathiwat</name>
    <code>96</code>
    <category>province</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Nong Bua Lam Phu</name>
    <code>39</code>
    <category>province</category>
    <FIPS>79</FIPS>
  </subcountry>
  <subcountry>
    <name>Nong Khai</name>
    <code>43</code>
    <category>province</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Nonthaburi</name>
    <code>12</code>
    <category>province</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Pathum Thani</name>
    <code>13</code>
    <category>province</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Pattani</name>
    <code>94</code>
    <category>province</category>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Phangnga</name>
    <code>82</code>
    <category>province</category>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Phatthalung</name>
    <code>93</code>
    <category>province</category>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Phayao</name>
    <code>56</code>
    <category>province</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Phetchabun</name>
    <code>67</code>
    <category>province</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Phetchaburi</name>
    <code>76</code>
    <category>province</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Phichit</name>
    <code>66</code>
    <category>province</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Phitsanulok</name>
    <code>65</code>
    <category>province</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Phrae</name>
    <code>54</code>
    <category>province</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Phra Nakhon Si Ayutthaya</name>
    <code>14</code>
    <category>province</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Phuket</name>
    <code>83</code>
    <category>province</category>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Prachin Buri</name>
    <code>25</code>
    <category>province</category>
    <FIPS>74</FIPS>
  </subcountry>
  <subcountry>
    <name>Prachuap Khiri Khan</name>
    <code>77</code>
    <category>province</category>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Ranong</name>
    <code>85</code>
    <category>province</category>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Ratchaburi</name>
    <code>70</code>
    <category>province</category>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Rayong</name>
    <code>21</code>
    <category>province</category>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Roi Et</name>
    <code>45</code>
    <category>province</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Sa Kaeo</name>
    <code>27</code>
    <category>province</category>
    <FIPS>80</FIPS>
  </subcountry>
  <subcountry>
    <name>Sakon Nakhon</name>
    <code>47</code>
    <category>province</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Samut Prakan</name>
    <code>11</code>
    <category>province</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Samut Sakhon</name>
    <code>74</code>
    <category>province</category>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Samut Songkhram</name>
    <code>75</code>
    <category>province</category>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Saraburi</name>
    <code>19</code>
    <category>province</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Satun</name>
    <code>91</code>
    <category>province</category>
    <FIPS>67</FIPS>
  </subcountry>
  <subcountry>
    <name>Sing Buri</name>
    <code>17</code>
    <category>province</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Si Sa Ket</name>
    <code>33</code>
    <category>province</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Songkhla</name>
    <code>90</code>
    <category>province</category>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Sukhothai</name>
    <code>64</code>
    <category>province</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Suphan Buri</name>
    <code>72</code>
    <category>province</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Surat Thani</name>
    <code>84</code>
    <category>province</category>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Surin</name>
    <code>32</code>
    <category>province</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Tak</name>
    <code>63</code>
    <category>province</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Trang</name>
    <code>92</code>
    <category>province</category>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Trat</name>
    <code>23</code>
    <category>province</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Ubon Ratchathani</name>
    <code>34</code>
    <category>province</category>
  </subcountry>
  <subcountry>
    <name>Udon Thani</name>
    <code>41</code>
    <category>province</category>
    <FIPS>76</FIPS>
  </subcountry>
  <subcountry>
    <name>Uthai Thani</name>
    <code>61</code>
    <category>province</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Uttaradit</name>
    <code>53</code>
    <category>province</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Yala</name>
    <code>95</code>
    <category>province</category>
    <FIPS>70</FIPS>
  </subcountry>
  <subcountry>
    <name>Yasothon</name>
    <code>35</code>
    <category>province</category>
    <FIPS>72</FIPS>
  </subcountry>
</country>

<country>
  <name>TAJIKISTAN</name>
  <code>TJ</code>
  <subcountry>
    <name>Khatlon</name>
    <code>KT</code>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Sughd</name>
    <code>SU</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Gorno-Badakhshan</name>
    <code>GB</code>
    <category>autonomous region</category>
  </subcountry>
</country>

<country>
  <name>TURKMENISTAN</name>
  <code>TM</code>
  <subcountry>
    <name>Ahal</name>
    <code>A</code>
  </subcountry>
  <subcountry>
    <name>Balkan</name>
    <code>B</code>
  </subcountry>
  <subcountry>
    <name>Dasoguz</name>
    <code>D</code>
  </subcountry>
  <subcountry>
    <name>Lebap</name>
    <code>L</code>
  </subcountry>
  <subcountry>
    <name>Mary</name>
    <code>M</code>
  </subcountry>
</country>

<country>
  <name>TUNISIA</name>
  <code>TN</code>
  <subcountry>
    <name>B�ja</name>
    <code>31</code>
  </subcountry>
  <subcountry>
    <name>Ben Arous</name>
    <code>13</code>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Bizerte</name>
    <code>23</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Gab�s</name>
    <code>81</code>
  </subcountry>
  <subcountry>
    <name>Gafsa</name>
    <code>71</code>
  </subcountry>
  <subcountry>
    <name>Jendouba</name>
    <code>32</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kairouan</name>
    <code>41</code>
  </subcountry>
  <subcountry>
    <name>Kasserine</name>
    <code>42</code>
  </subcountry>
  <subcountry>
    <name>Kebili</name>
    <code>73</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>L'Ariana</name>
    <code>12</code>
  </subcountry>
  <subcountry>
    <name>Le Kef</name>
    <code>33</code>
  </subcountry>
  <subcountry>
    <name>Mahdia</name>
    <code>53</code>
  </subcountry>
  <subcountry>
    <name>Medenine</name>
    <code>82</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Monastir</name>
    <code>52</code>
  </subcountry>
  <subcountry>
    <name>Nabeul</name>
    <code>21</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Sfax</name>
    <code>61</code>
  </subcountry>
  <subcountry>
    <name>Sidi Bouzid</name>
    <code>43</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Siliana</name>
    <code>34</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Sousse</name>
    <code>51</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Tataouine</name>
    <code>83</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Tozeur</name>
    <code>72</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Tunis</name>
    <code>11</code>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>Zaghouan</name>
    <code>22</code>
    <FIPS>37</FIPS>
  </subcountry>
</country>

<country>
  <name>TURKEY</name>
  <code>TR</code>
  <subcountry>
    <name>Adana</name>
    <code>01</code>
    <FIPS>81</FIPS>
  </subcountry>
  <subcountry>
    <name>Adiyaman</name>
    <code>02</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Afyon</name>
    <code>03</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Agri</name>
    <code>04</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Aksaray</name>
    <code>68</code>
    <FIPS>75</FIPS>
  </subcountry>
  <subcountry>
    <name>Amasya</name>
    <code>05</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ankara</name>
    <code>06</code>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Antalya</name>
    <code>07</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Ardahan</name>
    <code>75</code>
    <FIPS>86</FIPS>
  </subcountry>
  <subcountry>
    <name>Artvin</name>
    <code>08</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Aydin</name>
    <code>09</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Balikesir</name>
    <code>10</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Bartin</name>
    <code>74</code>
    <FIPS>87</FIPS>
  </subcountry>
  <subcountry>
    <name>Batman</name>
    <code>72</code>
    <FIPS>76</FIPS>
  </subcountry>
  <subcountry>
    <name>Bayburt</name>
    <code>69</code>
    <FIPS>77</FIPS>
  </subcountry>
  <subcountry>
    <name>Bilecik</name>
    <code>11</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Bing�l</name>
    <code>12</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Bitlis</name>
    <code>13</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Bolu</name>
    <code>14</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Burdur</name>
    <code>15</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Bursa</name>
    <code>16</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>�anakkale</name>
    <code>17</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>�ankiri</name>
    <code>18</code>
    <FIPS>82</FIPS>
  </subcountry>
  <subcountry>
    <name>�orum</name>
    <code>19</code>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Denizli</name>
    <code>20</code>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Diyarbakir</name>
    <code>21</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>D�zce</name>
    <code>81</code>
  </subcountry>
  <subcountry>
    <name>Edirne</name>
    <code>22</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Elazig</name>
    <code>23</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Erzincan</name>
    <code>24</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Erzurum</name>
    <code>25</code>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Eskisehir</name>
    <code>26</code>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Gaziantep</name>
    <code>27</code>
    <FIPS>83</FIPS>
  </subcountry>
  <subcountry>
    <name>Giresun</name>
    <code>28</code>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>G�m�shane</name>
    <code>29</code>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Hakk�ri</name>
    <code>30</code>
    <FIPS>70</FIPS>
  </subcountry>
  <subcountry>
    <name>Hatay</name>
    <code>31</code>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Igdir</name>
    <code>76</code>
    <FIPS>88</FIPS>
  </subcountry>
  <subcountry>
    <name>Isparta</name>
    <code>32</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>I�el</name>
    <code>33</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Istanbul</name>
    <code>34</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Izmir</name>
    <code>35</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Kahramanmaras</name>
    <code>46</code>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Karab�k</name>
    <code>78</code>
    <FIPS>89</FIPS>
  </subcountry>
  <subcountry>
    <name>Karaman</name>
    <code>70</code>
    <FIPS>78</FIPS>
  </subcountry>
  <subcountry>
    <name>Kars</name>
    <code>36</code>
    <FIPS>84</FIPS>
  </subcountry>
  <subcountry>
    <name>Kastamonu</name>
    <code>37</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Kayseri</name>
    <code>38</code>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Kirikkale</name>
    <code>71</code>
    <FIPS>79</FIPS>
  </subcountry>
  <subcountry>
    <name>Kirklareli</name>
    <code>39</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Kirsehir</name>
    <code>40</code>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Kilis</name>
    <code>79</code>
    <FIPS>90</FIPS>
  </subcountry>
  <subcountry>
    <name>Kocaeli</name>
    <code>41</code>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Konya</name>
    <code>42</code>
    <FIPS>71</FIPS>
  </subcountry>
  <subcountry>
    <name>K�tahya</name>
    <code>43</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Malatya</name>
    <code>44</code>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>Manisa</name>
    <code>45</code>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Mardin</name>
    <code>47</code>
    <FIPS>72</FIPS>
  </subcountry>
  <subcountry>
    <name>Mugla</name>
    <code>48</code>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Mus</name>
    <code>49</code>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Nevsehir</name>
    <code>50</code>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Nigde</name>
    <code>51</code>
    <FIPS>73</FIPS>
  </subcountry>
  <subcountry>
    <name>Ordu</name>
    <code>52</code>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Osmaniye</name>
    <code>80</code>
    <FIPS>91</FIPS>
  </subcountry>
  <subcountry>
    <name>Rize</name>
    <code>53</code>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Sakarya</name>
    <code>54</code>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Samsun</name>
    <code>55</code>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Siirt</name>
    <code>56</code>
    <FIPS>74</FIPS>
  </subcountry>
  <subcountry>
    <name>Sinop</name>
    <code>57</code>
    <FIPS>57</FIPS>
  </subcountry>
  <subcountry>
    <name>Sivas</name>
    <code>58</code>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Sanliurfa</name>
    <code>63</code>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Sirnak</name>
    <code>73</code>
    <FIPS>80</FIPS>
  </subcountry>
  <subcountry>
    <name>Tekirdag</name>
    <code>59</code>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Tokat</name>
    <code>60</code>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Trabzon</name>
    <code>61</code>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Tunceli</name>
    <code>62</code>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Usak</name>
    <code>64</code>
    <FIPS>64</FIPS>
  </subcountry>
  <subcountry>
    <name>Van</name>
    <code>65</code>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Yalova</name>
    <code>77</code>
    <FIPS>92</FIPS>
  </subcountry>
  <subcountry>
    <name>Yozgat</name>
    <code>66</code>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Zonguldak</name>
    <code>67</code>
    <FIPS>85</FIPS>
  </subcountry>
</country>

<country>
  <name>TRINIDAD AND TOBAGO</name>
  <code>TT</code>
  <subcountry>
    <name>Couva-Tabaquite-Talparo</name>
    <code>CTT</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Diego Martin</name>
    <code>DMN</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Eastern Tobago</name>
    <code>ETO</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Penal-Debe</name>
    <code>PED</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Princes Town</name>
    <code>PRT</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Rio Claro-Mayaro</name>
    <code>RCM</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Sangre Grande</name>
    <code>SGE</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>San Juan-Laventille</name>
    <code>SJL</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Siparia</name>
    <code>SIP</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Tunapuna-Piarco</name>
    <code>TUP</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Western Tobago</name>
    <code>WTO</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Arima</name>
    <code>ARI</code>
    <category>municipality</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Chaguanas</name>
    <code>CHA</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Point Fortin</name>
    <code>PTF</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Port of Spain</name>
    <code>POS</code>
    <category>municipality</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>San Fernando</name>
    <code>SFO</code>
    <category>municipality</category>
    <FIPS>10</FIPS>
  </subcountry>
</country>

<country>
  <name>TAIWAN, PROVINCE OF CHINA</name>
  <code>TW</code>
  <subcountry>
    <name>Kaohsiung</name>
    <code>KHH</code>
    <category>special municipality</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Taipei</name>
    <code>TPE</code>
    <category>special municipality</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Chiayi</name>
    <code>CYI</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Hsinchu</name>
    <code>HSZ</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Keelung</name>
    <code>KEE</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Taichung</name>
    <code>TXG</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Tainan</name>
    <code>TNN</code>
    <category>municipality</category>
  </subcountry>
  <subcountry>
    <name>Changhua</name>
    <code>CHA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Chiayi</name>
    <code>CYQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Hsinchu</name>
    <code>HSQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Hualien</name>
    <code>HUA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Ilan</name>
    <code>ILA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Kaohsiung</name>
    <code>KHQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Miaoli</name>
    <code>MIA</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Nantou</name>
    <code>NAN</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Penghu</name>
    <code>PEN</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Pingtung</name>
    <code>PIF</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Taichung</name>
    <code>TXQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Tainan</name>
    <code>TNQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Taipei</name>
    <code>TPQ</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Taitung</name>
    <code>TTT</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Taoyuan</name>
    <code>TAO</code>
    <category>district</category>
  </subcountry>
  <subcountry>
    <name>Yunlin</name>
    <code>YUN</code>
    <category>district</category>
  </subcountry>
</country>

<country>
  <name>TANZANIA, UNITED REPUBLIC OF</name>
  <code>TZ</code>
  <subcountry>
    <name>Arusha</name>
    <code>01</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Dar es Salaam</name>
    <code>02</code>
  </subcountry>
  <subcountry>
    <name>Dodoma</name>
    <code>03</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Iringa</name>
    <code>04</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Kagera</name>
    <code>05</code>
  </subcountry>
  <subcountry>
    <name>Kaskazini Pemba</name>
    <code>06</code>
  </subcountry>
  <subcountry>
    <name>Kaskazini Unguja</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Kigoma</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Kilimanjaro</name>
    <code>09</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kusini Pemba</name>
    <code>10</code>
  </subcountry>
  <subcountry>
    <name>Kusini Unguja</name>
    <code>11</code>
  </subcountry>
  <subcountry>
    <name>Lindi</name>
    <code>12</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Mara</name>
    <code>13</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Mbeya</name>
    <code>14</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Mjini Magharibi</name>
    <code>15</code>
  </subcountry>
  <subcountry>
    <name>Morogoro</name>
    <code>16</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Mtwara</name>
    <code>17</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Mwanza</name>
    <code>18</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Pwani</name>
    <code>19</code>
  </subcountry>
  <subcountry>
    <name>Rukwa</name>
    <code>20</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Ruvuma</name>
    <code>21</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Shinyanga</name>
    <code>22</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Singida</name>
    <code>23</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Tabora</name>
    <code>24</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Tanga</name>
    <code>25</code>
    <FIPS>18</FIPS>
  </subcountry>
</country>

<country>
  <name>UKRAINE</name>
  <code>UA</code>
  <subcountry>
    <name>Cherkas'ka Oblast'</name>
    <code>71</code>
    <category>region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Chernihivs'ka Oblast'</name>
    <code>74</code>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Chernivets'ka Oblast'</name>
    <code>77</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Dnipropetrovs'ka Oblast'</name>
    <code>12</code>
    <category>region</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Donets'ka Oblast'</name>
    <code>14</code>
    <category>region</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Ivano-Frankivs'ka Oblast'</name>
    <code>26</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kharkivs'ka Oblast'</name>
    <code>63</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Khersons'ka Oblast'</name>
    <code>65</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Khmel'nyts'ka Oblast'</name>
    <code>68</code>
    <category>region</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Kirovohrads'ka Oblast'</name>
    <code>35</code>
    <category>region</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Ky�vs'ka Oblast'</name>
    <code>32</code>
    <category>region</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Luhans'ka Oblast'</name>
    <code>09</code>
    <category>region</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>L'vivs'ka Oblast'</name>
    <code>46</code>
    <category>region</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Mykola�vs'ka Oblast'</name>
    <code>48</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Odes'ka Oblast'</name>
    <code>51</code>
    <category>region</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Poltavs'ka Oblast'</name>
    <code>53</code>
    <category>region</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivnens'ka Oblast'</name>
    <code>56</code>
    <category>region</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Sums'ka Oblast'</name>
    <code>59</code>
    <category>region</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Ternopil's'ka Oblast'</name>
    <code>61</code>
    <category>region</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Vinnyts'ka Oblast'</name>
    <code>05</code>
    <category>region</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Volyns'ka Oblast'</name>
    <code>07</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Zakarpats'ka Oblast'</name>
    <code>21</code>
    <category>region</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Zaporiz'ka Oblast'</name>
    <code>23</code>
    <category>region</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Zhytomyrs'ka Oblast'</name>
    <code>18</code>
    <category>region</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Respublika Krym</name>
    <code>43</code>
    <category>republic</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Ky�v</name>
    <code>30</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Sevastopol'</name>
    <code>40</code>
    <category>city</category>
    <FIPS>20</FIPS>
  </subcountry>
</country>

<country>
  <name>UGANDA</name>
  <code>UG</code>
  <subcountry>
    <name>Apac</name>
    <code>302</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Arua</name>
    <code>303</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Bundibugyo</name>
    <code>401</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Bushenyi</name>
    <code>402</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Gulu</name>
    <code>304</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Hoima</name>
    <code>403</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Iganga</name>
    <code>203</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Jinja</name>
    <code>204</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Kabale</name>
    <code>404</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kabarole</name>
    <code>405</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kalangala</name>
    <code>101</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Kampala</name>
    <code>102</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Kamuli</name>
    <code>205</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Kapchorwa</name>
    <code>206</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Kasese</name>
    <code>406</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kibaale</name>
    <code>407</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kiboga</name>
    <code>103</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Kisoro</name>
    <code>408</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kitgum</name>
    <code>305</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Kotido</name>
    <code>306</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Kumi</name>
    <code>208</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Lira</name>
    <code>307</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Luwero</name>
    <code>104</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Masaka</name>
    <code>105</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Masindi</name>
    <code>409</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Mbale</name>
    <code>209</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Mbarara</name>
    <code>410</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Moroto</name>
    <code>308</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Moyo</name>
    <code>309</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Mpigi</name>
    <code>106</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Mubende</name>
    <code>107</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Mukono</name>
    <code>108</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Nebbi</name>
    <code>310</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Ntungamo</name>
    <code>411</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Pallisa</name>
    <code>210</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Rakai</name>
    <code>110</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Rukungiri</name>
    <code>412</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Soroti</name>
    <code>211</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Tororo</name>
    <code>212</code>
    <regional_division>E</regional_division>
  </subcountry>
</country>

<country>
  <name>UNITED STATES MINOR OUTLYING ISLANDS</name>
  <code>UM</code>
  <subcountry>
    <name>Baker Island</name>
    <code>81</code>
  </subcountry>
  <subcountry>
    <name>Howland Island</name>
    <code>84</code>
  </subcountry>
  <subcountry>
    <name>Jarvis Island</name>
    <code>86</code>
  </subcountry>
  <subcountry>
    <name>Johnston Atoll</name>
    <code>67</code>
  </subcountry>
  <subcountry>
    <name>Kingman Reef</name>
    <code>89</code>
  </subcountry>
  <subcountry>
    <name>Midway Islands</name>
    <code>71</code>
  </subcountry>
  <subcountry>
    <name>Navassa Island</name>
    <code>76</code>
  </subcountry>
  <subcountry>
    <name>Palmyra Atoll</name>
    <code>95</code>
  </subcountry>
  <subcountry>
    <name>Wake Island</name>
    <code>79</code>
  </subcountry>
</country>

<country>
  <name>UNITED STATES</name>
  <code>US</code>
  <subcountry>
    <name>Alabama</name>
    <code>AL</code>
    <category>state</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Alaska</name>
    <code>AK</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Arizona</name>
    <code>AZ</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Arkansas</name>
    <code>AR</code>
    <category>state</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>California</name>
    <code>CA</code>
    <category>state</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Colorado</name>
    <code>CO</code>
    <category>state</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Connecticut</name>
    <code>CT</code>
    <category>state</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Delaware</name>
    <code>DE</code>
    <category>state</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Florida</name>
    <code>FL</code>
    <category>state</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Georgia</name>
    <code>GA</code>
    <category>state</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Hawaii</name>
    <code>HI</code>
    <category>state</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Idaho</name>
    <code>ID</code>
    <category>state</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Illinois</name>
    <code>IL</code>
    <category>state</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Indiana</name>
    <code>IN</code>
    <category>state</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Iowa</name>
    <code>IA</code>
    <category>state</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>Kansas</name>
    <code>KS</code>
    <category>state</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Kentucky</name>
    <code>KY</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Louisiana</name>
    <code>LA</code>
    <category>state</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Maine</name>
    <code>ME</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Maryland</name>
    <code>MD</code>
    <category>state</category>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Massachusetts</name>
    <code>MA</code>
    <category>state</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Michigan</name>
    <code>MI</code>
    <category>state</category>
    <FIPS>26</FIPS>
  </subcountry>
  <subcountry>
    <name>Minnesota</name>
    <code>MN</code>
    <category>state</category>
    <FIPS>27</FIPS>
  </subcountry>
  <subcountry>
    <name>Mississippi</name>
    <code>MS</code>
    <category>state</category>
    <FIPS>28</FIPS>
  </subcountry>
  <subcountry>
    <name>Missouri</name>
    <code>MO</code>
    <category>state</category>
    <FIPS>29</FIPS>
  </subcountry>
  <subcountry>
    <name>Montana</name>
    <code>MT</code>
    <category>state</category>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Nebraska</name>
    <code>NE</code>
    <category>state</category>
    <FIPS>31</FIPS>
  </subcountry>
  <subcountry>
    <name>Nevada</name>
    <code>NV</code>
    <category>state</category>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>New Hampshire</name>
    <code>NH</code>
    <category>state</category>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>New Jersey</name>
    <code>NJ</code>
    <category>state</category>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>New Mexico</name>
    <code>NM</code>
    <category>state</category>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>New York</name>
    <code>NY</code>
    <category>state</category>
    <FIPS>36</FIPS>
  </subcountry>
  <subcountry>
    <name>North Carolina</name>
    <code>NC</code>
    <category>state</category>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>North Dakota</name>
    <code>ND</code>
    <category>state</category>
    <FIPS>38</FIPS>
  </subcountry>
  <subcountry>
    <name>Ohio</name>
    <code>OH</code>
    <category>state</category>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Oklahoma</name>
    <code>OK</code>
    <category>state</category>
    <FIPS>40</FIPS>
  </subcountry>
  <subcountry>
    <name>Oregon</name>
    <code>OR</code>
    <category>state</category>
    <FIPS>41</FIPS>
  </subcountry>
  <subcountry>
    <name>Pennsylvania</name>
    <code>PA</code>
    <category>state</category>
    <FIPS>42</FIPS>
  </subcountry>
  <subcountry>
    <name>Rhode Island</name>
    <code>RI</code>
    <category>state</category>
    <FIPS>44</FIPS>
  </subcountry>
  <subcountry>
    <name>South Carolina</name>
    <code>SC</code>
    <category>state</category>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>South Dakota</name>
    <code>SD</code>
    <category>state</category>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Tennessee</name>
    <code>TN</code>
    <category>state</category>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Texas</name>
    <code>TX</code>
    <category>state</category>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Utah</name>
    <code>UT</code>
    <category>state</category>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Vermont</name>
    <code>VT</code>
    <category>state</category>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Virginia</name>
    <code>VA</code>
    <category>state</category>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Washington</name>
    <code>WA</code>
    <category>state</category>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>West Virginia</name>
    <code>WV</code>
    <category>state</category>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Wisconsin</name>
    <code>WI</code>
    <category>state</category>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Wyoming</name>
    <code>WY</code>
    <category>state</category>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>District of Columbia</name>
    <code>DC</code>
    <category>district</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>American Samoa (see also separate entry under AS)</name>
    <code>AS</code>
    <category>outlying area</category>
  </subcountry>
  <subcountry>
    <name>Guam (see also separate entry under GU)</name>
    <code>GU</code>
    <category>outlying area</category>
  </subcountry>
  <subcountry>
    <name>Northern Mariana Islands (see also separate entry under MP)</name>
    <code>MP</code>
    <category>outlying area</category>
  </subcountry>
  <subcountry>
    <name>Puerto Rico (see also separate entry under PR)</name>
    <code>PR</code>
    <category>outlying area</category>
  </subcountry>
  <subcountry>
    <name>United States Minor Outlying Islands (see also separate entry under UM)</name>
    <code>UM</code>
    <category>outlying area</category>
  </subcountry>
  <subcountry>
    <name>Virgin Islands, U.S. (see also separate entry under VI)</name>
    <code>VI</code>
    <category>outlying area</category>
  </subcountry>
</country>

<country>
  <name>URUGUAY</name>
  <code>UY</code>
  <subcountry>
    <name>Artigas</name>
    <code>AR</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Canelones</name>
    <code>CA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Cerro Largo</name>
    <code>CL</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Colonia</name>
    <code>CO</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Durazno</name>
    <code>DU</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Flores</name>
    <code>FS</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Florida</name>
    <code>FD</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Lavalleja</name>
    <code>LA</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Maldonado</name>
    <code>MA</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Montevideo</name>
    <code>MO</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Paysand�</name>
    <code>PA</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>R�o Negro</name>
    <code>RN</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Rivera</name>
    <code>RV</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Rocha</name>
    <code>RO</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Salto</name>
    <code>SA</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>San Jos�</name>
    <code>SJ</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Soriano</name>
    <code>SO</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Tacuaremb�</name>
    <code>TA</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Treinta y Tres</name>
    <code>TT</code>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>UZBEKISTAN</name>
  <code>UZ</code>
  <subcountry>
    <name>Qoraqalpog�iston Respublikasi</name>
    <code>QR</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Andijon</name>
    <code>AN</code>
    <category>region</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Buxoro</name>
    <code>BU</code>
    <category>region</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Farg�ona</name>
    <code>FA</code>
    <category>region</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Jizzax</name>
    <code>JI</code>
    <category>region</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Namangan</name>
    <code>NG</code>
    <category>region</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Navoiy</name>
    <code>NW</code>
    <category>region</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Qashqadaryo</name>
    <code>QA</code>
    <category>region</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Samarqand</name>
    <code>SA</code>
    <category>region</category>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Sirdaryo</name>
    <code>SI</code>
    <category>region</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Surxondaryo</name>
    <code>SU</code>
    <category>region</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Toshkent</name>
    <code>TO</code>
    <category>region</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Xorazm</name>
    <code>XO</code>
    <category>region</category>
  </subcountry>
</country>

<country>
  <name>VENEZUELA</name>
  <code>VE</code>
  <subcountry>
    <name>Distrito Federal</name>
    <code>A</code>
    <category>federal district</category>
    <FIPS>25</FIPS>
  </subcountry>
  <subcountry>
    <name>Anzo�tegui</name>
    <code>B</code>
    <category>state</category>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Apure</name>
    <code>C</code>
    <category>state</category>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Aragua</name>
    <code>D</code>
    <category>state</category>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Barinas</name>
    <code>E</code>
    <category>state</category>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Bol�var</name>
    <code>F</code>
    <category>state</category>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Carabobo</name>
    <code>G</code>
    <category>state</category>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Cojedes</name>
    <code>H</code>
    <category>state</category>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Falc�n</name>
    <code>I</code>
    <category>state</category>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Gu�rico</name>
    <code>J</code>
    <category>state</category>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>Lara</name>
    <code>K</code>
    <category>state</category>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>M�rida</name>
    <code>L</code>
    <category>state</category>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Miranda</name>
    <code>M</code>
    <category>state</category>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Monagas</name>
    <code>N</code>
    <category>state</category>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Nueva Esparta</name>
    <code>O</code>
    <category>state</category>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Portuguesa</name>
    <code>P</code>
    <category>state</category>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Sucre</name>
    <code>R</code>
    <category>state</category>
    <FIPS>19</FIPS>
  </subcountry>
  <subcountry>
    <name>T�chira</name>
    <code>S</code>
    <category>state</category>
    <FIPS>20</FIPS>
  </subcountry>
  <subcountry>
    <name>Trujillo</name>
    <code>T</code>
    <category>state</category>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Yaracuy</name>
    <code>U</code>
    <category>state</category>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Zulia</name>
    <code>V</code>
    <category>state</category>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Amazonas</name>
    <code>Z</code>
    <category>state</category>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Delta Amacuro</name>
    <code>Y</code>
    <category>state</category>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Dependencias Federales</name>
    <code>W</code>
    <category>federal dependency</category>
    <FIPS>24</FIPS>
  </subcountry>
</country>

<country>
  <name>VIET NAM</name>
  <code>VN</code>
  <subcountry>
    <name>An Giang</name>
    <code>44</code>
    <FIPS>01</FIPS>
  </subcountry>
  <subcountry>
    <name>Ba Ria - Vung Tau</name>
    <code>43</code>
    <FIPS>45</FIPS>
  </subcountry>
  <subcountry>
    <name>Bac Can</name>
    <code>53</code>
    <FIPS>72</FIPS>
  </subcountry>
  <subcountry>
    <name>Bac Giang</name>
    <code>54</code>
    <FIPS>71</FIPS>
  </subcountry>
  <subcountry>
    <name>Bac Lieu</name>
    <code>55</code>
    <FIPS>73</FIPS>
  </subcountry>
  <subcountry>
    <name>Bac Ninh</name>
    <code>56</code>
    <FIPS>74</FIPS>
  </subcountry>
  <subcountry>
    <name>Ben Tre</name>
    <code>50</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Binh Dinh</name>
    <code>31</code>
    <FIPS>46</FIPS>
  </subcountry>
  <subcountry>
    <name>Binh Duong</name>
    <code>57</code>
    <FIPS>75</FIPS>
  </subcountry>
  <subcountry>
    <name>Binh Phuoc</name>
    <code>58</code>
    <FIPS>76</FIPS>
  </subcountry>
  <subcountry>
    <name>Binh Thuan</name>
    <code>40</code>
    <FIPS>47</FIPS>
  </subcountry>
  <subcountry>
    <name>Ca Mau</name>
    <code>59</code>
    <FIPS>77</FIPS>
  </subcountry>
  <subcountry>
    <name>Can Tho</name>
    <code>48</code>
    <FIPS>48</FIPS>
  </subcountry>
  <subcountry>
    <name>Cao Bang</name>
    <code>04</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Da Nang, thanh pho</name>
    <code>60</code>
  </subcountry>
  <subcountry>
    <name>Dac Lac</name>
    <code>33</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Dong Nai</name>
    <code>39</code>
    <FIPS>43</FIPS>
  </subcountry>
  <subcountry>
    <name>Dong Thap</name>
    <code>45</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>Gia Lai</name>
    <code>30</code>
    <FIPS>49</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha Giang</name>
    <code>03</code>
    <FIPS>50</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha Nam</name>
    <code>63</code>
    <FIPS>80</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha Noi, thu do</name>
    <code>64</code>
  </subcountry>
  <subcountry>
    <name>Ha Tay</name>
    <code>15</code>
    <FIPS>51</FIPS>
  </subcountry>
  <subcountry>
    <name>Ha Tinh</name>
    <code>23</code>
    <FIPS>52</FIPS>
  </subcountry>
  <subcountry>
    <name>Hai Duong</name>
    <code>61</code>
    <FIPS>79</FIPS>
  </subcountry>
  <subcountry>
    <name>Hai Phong, thanh pho</name>
    <code>62</code>
  </subcountry>
  <subcountry>
    <name>Hoa Binh</name>
    <code>14</code>
    <FIPS>53</FIPS>
  </subcountry>
  <subcountry>
    <name>Ho Chi Minh, thanh pho [Sai Gon]</name>
    <code>65</code>
  </subcountry>
  <subcountry>
    <name>Hung Yen</name>
    <code>66</code>
    <FIPS>81</FIPS>
  </subcountry>
  <subcountry>
    <name>Khanh Hoa</name>
    <code>34</code>
    <FIPS>54</FIPS>
  </subcountry>
  <subcountry>
    <name>Kien Giang</name>
    <code>47</code>
    <FIPS>21</FIPS>
  </subcountry>
  <subcountry>
    <name>Kon Tum</name>
    <code>28</code>
    <FIPS>55</FIPS>
  </subcountry>
  <subcountry>
    <name>Lai Chau</name>
    <code>01</code>
    <FIPS>22</FIPS>
  </subcountry>
  <subcountry>
    <name>Lam Dong</name>
    <code>35</code>
    <FIPS>23</FIPS>
  </subcountry>
  <subcountry>
    <name>Lang Son</name>
    <code>09</code>
    <FIPS>39</FIPS>
  </subcountry>
  <subcountry>
    <name>Lao Cai</name>
    <code>02</code>
    <FIPS>56</FIPS>
  </subcountry>
  <subcountry>
    <name>Long An</name>
    <code>41</code>
    <FIPS>24</FIPS>
  </subcountry>
  <subcountry>
    <name>Nam Dinh</name>
    <code>67</code>
    <FIPS>82</FIPS>
  </subcountry>
  <subcountry>
    <name>Nghe An</name>
    <code>22</code>
    <FIPS>58</FIPS>
  </subcountry>
  <subcountry>
    <name>Ninh Binh</name>
    <code>18</code>
    <FIPS>59</FIPS>
  </subcountry>
  <subcountry>
    <name>Ninh Thuan</name>
    <code>36</code>
    <FIPS>60</FIPS>
  </subcountry>
  <subcountry>
    <name>Phu Tho</name>
    <code>68</code>
    <FIPS>83</FIPS>
  </subcountry>
  <subcountry>
    <name>Phu Yen</name>
    <code>32</code>
    <FIPS>61</FIPS>
  </subcountry>
  <subcountry>
    <name>Quang Binh</name>
    <code>24</code>
    <FIPS>62</FIPS>
  </subcountry>
  <subcountry>
    <name>Quang Nam</name>
    <code>27</code>
    <FIPS>84</FIPS>
  </subcountry>
  <subcountry>
    <name>Quang Ngai</name>
    <code>29</code>
    <FIPS>63</FIPS>
  </subcountry>
  <subcountry>
    <name>Quang Ninh</name>
    <code>13</code>
    <FIPS>30</FIPS>
  </subcountry>
  <subcountry>
    <name>Quang Tri</name>
    <code>25</code>
    <FIPS>64</FIPS>
  </subcountry>
  <subcountry>
    <name>Soc Trang</name>
    <code>52</code>
    <FIPS>65</FIPS>
  </subcountry>
  <subcountry>
    <name>Son La</name>
    <code>05</code>
    <FIPS>32</FIPS>
  </subcountry>
  <subcountry>
    <name>Tay Ninh</name>
    <code>37</code>
    <FIPS>33</FIPS>
  </subcountry>
  <subcountry>
    <name>Thai Binh</name>
    <code>20</code>
    <FIPS>35</FIPS>
  </subcountry>
  <subcountry>
    <name>Thai Nguyen</name>
    <code>69</code>
    <FIPS>85</FIPS>
  </subcountry>
  <subcountry>
    <name>Thanh Hoa</name>
    <code>21</code>
    <FIPS>34</FIPS>
  </subcountry>
  <subcountry>
    <name>Thua Thien-Hue</name>
    <code>26</code>
    <FIPS>66</FIPS>
  </subcountry>
  <subcountry>
    <name>Tien Giang</name>
    <code>46</code>
    <FIPS>37</FIPS>
  </subcountry>
  <subcountry>
    <name>Tra Vinh</name>
    <code>51</code>
    <FIPS>67</FIPS>
  </subcountry>
  <subcountry>
    <name>Tuyen Quang</name>
    <code>07</code>
    <FIPS>68</FIPS>
  </subcountry>
  <subcountry>
    <name>Vinh Long</name>
    <code>49</code>
    <FIPS>69</FIPS>
  </subcountry>
  <subcountry>
    <name>Vinh Phuc</name>
    <code>70</code>
    <FIPS>86</FIPS>
  </subcountry>
  <subcountry>
    <name>Yen Bai</name>
    <code>06</code>
    <FIPS>70</FIPS>
  </subcountry>
</country>

<country>
  <name>VANUATU</name>
  <code>VU</code>
  <subcountry>
    <name>Malampa</name>
    <code>MAP</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>P�nama</name>
    <code>PAM</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Sanma</name>
    <code>SAM</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Sh�fa</name>
    <code>SEE</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Taf�a</name>
    <code>TAE</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Torba</name>
    <code>TOB</code>
    <FIPS>07</FIPS>
  </subcountry>
</country>

<country>
  <name>SAMOA</name>
  <code>WS</code>
  <subcountry>
    <name>A'ana</name>
    <code>AA</code>
  </subcountry>
  <subcountry>
    <name>Aiga-i-le-Tai</name>
    <code>AL</code>
  </subcountry>
  <subcountry>
    <name>Atua</name>
    <code>AT</code>
  </subcountry>
  <subcountry>
    <name>Fa'asaleleaga</name>
    <code>FA</code>
  </subcountry>
  <subcountry>
    <name>Gaga'emauga</name>
    <code>GE</code>
  </subcountry>
  <subcountry>
    <name>Gagaifomauga</name>
    <code>GI</code>
  </subcountry>
  <subcountry>
    <name>Palauli</name>
    <code>PA</code>
  </subcountry>
  <subcountry>
    <name>Satupa'itea</name>
    <code>SA</code>
  </subcountry>
  <subcountry>
    <name>Tuamasaga</name>
    <code>TU</code>
  </subcountry>
  <subcountry>
    <name>Va'a-o-Fonoti</name>
    <code>VF</code>
  </subcountry>
  <subcountry>
    <name>Vaisigano</name>
    <code>VS</code>
  </subcountry>
</country>

<country>
  <name>YEMEN</name>
  <code>YE</code>
  <subcountry>
    <name>Abyan</name>
    <code>AB</code>
  </subcountry>
  <subcountry>
    <name>Adan</name>
    <code>AD</code>
  </subcountry>
  <subcountry>
    <name>Al Bayha'</name>
    <code>BA</code>
  </subcountry>
  <subcountry>
    <name>Al Hudaydah</name>
    <code>HU</code>
  </subcountry>
  <subcountry>
    <name>Al Jawf</name>
    <code>JA</code>
  </subcountry>
  <subcountry>
    <name>Al Mahrah</name>
    <code>MR</code>
  </subcountry>
  <subcountry>
    <name>Al Mahwit</name>
    <code>MW</code>
  </subcountry>
  <subcountry>
    <name>Dhamar</name>
    <code>DH</code>
  </subcountry>
  <subcountry>
    <name>Hahramawt</name>
    <code>HD</code>
  </subcountry>
  <subcountry>
    <name>Hajjah</name>
    <code>HJ</code>
  </subcountry>
  <subcountry>
    <name>Ibb</name>
    <code>IB</code>
  </subcountry>
  <subcountry>
    <name>Lahij</name>
    <code>LA</code>
  </subcountry>
  <subcountry>
    <name>Ma'rib</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Sahdah</name>
    <code>SD</code>
  </subcountry>
  <subcountry>
    <name>Sanha'</name>
    <code>SN</code>
  </subcountry>
  <subcountry>
    <name>Shabwah</name>
    <code>SH</code>
  </subcountry>
  <subcountry>
    <name>Tahizz</name>
    <code>TA</code>
  </subcountry>
</country>

<country>
  <name>SERBIA AND MONTENEGRO</name>
  <code>CS</code>
  <subcountry>
    <name>Crna Gora</name>
    <code>CG</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Srbija</name>
    <code>SR</code>
    <category>republic</category>
  </subcountry>
  <subcountry>
    <name>Kosovo-Metohija</name>
    <code>KM</code>
    <regional_division>CS-SR</regional_division>
    <category>autonomous province</category>
  </subcountry>
  <subcountry>
    <name>Vojvodina</name>
    <code>VO</code>
    <regional_division>CS-SR</regional_division>
    <category>autonomous province</category>
  </subcountry>
</country>

<country>
  <name>SOUTH AFRICA</name>
  <code>ZA</code>
  <subcountry>
    <name>Eastern Cape</name>
    <code>EC</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Free State</name>
    <code>FS</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Gauteng</name>
    <code>GT</code>
    <FIPS>06</FIPS>
  </subcountry>
  <subcountry>
    <name>Kwazulu-Natal</name>
    <code>NL</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Mpumalanga</name>
    <code>MP</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern Cape</name>
    <code>NC</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>Northern Province</name>
    <code>NP</code>
    <FIPS>09</FIPS>
  </subcountry>
  <subcountry>
    <name>North-West</name>
    <code>NW</code>
    <FIPS>10</FIPS>
  </subcountry>
  <subcountry>
    <name>Western Cape</name>
    <code>WC</code>
    <FIPS>11</FIPS>
  </subcountry>
</country>

<country>
  <name>ZAMBIA</name>
  <code>ZM</code>
  <subcountry>
    <name>Central</name>
    <code>02</code>
  </subcountry>
  <subcountry>
    <name>Copperbelt</name>
    <code>08</code>
  </subcountry>
  <subcountry>
    <name>Eastern</name>
    <code>03</code>
  </subcountry>
  <subcountry>
    <name>Luapula</name>
    <code>04</code>
  </subcountry>
  <subcountry>
    <name>Lusaka</name>
    <code>09</code>
  </subcountry>
  <subcountry>
    <name>Northern</name>
    <code>05</code>
  </subcountry>
  <subcountry>
    <name>North-Western</name>
    <code>06</code>
  </subcountry>
  <subcountry>
    <name>Southern</name>
    <code>07</code>
  </subcountry>
  <subcountry>
    <name>Western</name>
    <code>01</code>
  </subcountry>
</country>

<country>
  <name>ZIMBABWE</name>
  <code>ZW</code>
  <subcountry>
    <name>Bulawayo</name>
    <code>BU</code>
  </subcountry>
  <subcountry>
    <name>Harare</name>
    <code>HA</code>
  </subcountry>
  <subcountry>
    <name>Manicaland</name>
    <code>MA</code>
  </subcountry>
  <subcountry>
    <name>Mashonaland Central</name>
    <code>MC</code>
  </subcountry>
  <subcountry>
    <name>Mashonaland East</name>
    <code>ME</code>
  </subcountry>
  <subcountry>
    <name>Mashonaland West</name>
    <code>MW</code>
  </subcountry>
  <subcountry>
    <name>Masvingo</name>
    <code>MV</code>
  </subcountry>
  <subcountry>
    <name>Matabeleland North</name>
    <code>MN</code>
  </subcountry>
  <subcountry>
    <name>Matabeleland South</name>
    <code>MS</code>
  </subcountry>
  <subcountry>
    <name>Midlands</name>
    <code>MI</code>
  </subcountry>
</country>

<country>
  <name>GEORGIA</name>
  <code>GE</code>
  <subcountry>
    <name>Abkhazia</name>
    <code>AB</code>
    <category>autonomous republic</category>
  </subcountry>
  <subcountry>
    <name>Ajaria</name>
    <code>AJ</code>
    <category>autonomous republic</category>
  </subcountry>
  <subcountry>
    <name>Guria</name>
    <code>GU</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Imereti</name>
    <code>IM</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Kakheti</name>
    <code>KA</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Kvemo Kartli</name>
    <code>KK</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Mtskheta-Mtianeti</name>
    <code>MM</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Racha-Lechkhumi [and] Kvemo Svaneti</name>
    <code>RL</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Samegrelo-Zemo Svaneti</name>
    <code>SZ</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Samtskhe-Javakheti</name>
    <code>SJ</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Shida Kartli</name>
    <code>SK</code>
    <category>region</category>
  </subcountry>
  <subcountry>
    <name>Tbilisi</name>
    <code>TB</code>
    <category>city</category>
  </subcountry>
</country>

<country>
  <name>TIMOR-LESTE</name>
  <code>TL</code>
  <subcountry>
    <name>Aileu</name>
    <code>AL</code>
  </subcountry>
  <subcountry>
    <name>Ainaro</name>
    <code>AN</code>
  </subcountry>
  <subcountry>
    <name>Baucau</name>
    <code>BA</code>
  </subcountry>
  <subcountry>
    <name>Bobonaro</name>
    <code>BO</code>
  </subcountry>
  <subcountry>
    <name>Cova Lima</name>
    <code>CO</code>
  </subcountry>
  <subcountry>
    <name>Dili</name>
    <code>DI</code>
  </subcountry>
  <subcountry>
    <name>Ermera</name>
    <code>ER</code>
  </subcountry>
  <subcountry>
    <name>Lautem</name>
    <code>LA</code>
  </subcountry>
  <subcountry>
    <name>Liqui�a</name>
    <code>LI</code>
  </subcountry>
  <subcountry>
    <name>Manatuto</name>
    <code>MT</code>
  </subcountry>
  <subcountry>
    <name>Manufahi</name>
    <code>MF</code>
  </subcountry>
  <subcountry>
    <name>Oecussi</name>
    <code>OE</code>
  </subcountry>
  <subcountry>
    <name>Viqueque</name>
    <code>VI</code>
  </subcountry>
</country>

<country>
  <name>UGANDA</name>
  <code>UG</code>
  <subcountry>
    <name>Adjumani</name>
    <code>301</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Bugiri</name>
    <code>201</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Busia</name>
    <code>202</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Katakwi</name>
    <code>207</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Nakasongola</name>
    <code>109</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Sembabule</name>
    <code>111</code>
    <regional_division>C</regional_division>
  </subcountry>
</country>

<country>
  <name>BURUNDI</name>
  <code>BI</code>
  <subcountry>
    <name>Mwaro</name>
    <code>MW</code>
  </subcountry>
</country>

<country>
  <name>ECUADOR</name>
  <code>EC</code>
  <subcountry>
    <name>Orellana</name>
    <code>D</code>
  </subcountry>
</country>

<country>
  <name>ETHIOPIA</name>
  <code>ET</code>
  <subcountry>
    <name>Dire Dawa</name>
    <code>DD</code>
    <category>administration</category>
  </subcountry>
</country>

<country>
  <name>KYRGYZSTAN</name>
  <code>KG</code>
  <subcountry>
    <name>Bishkek</name>
    <code>GB</code>
    <category>city</category>
  </subcountry>
  <subcountry>
    <name>Batken</name>
    <code>B</code>
    <category>region</category>
  </subcountry>
</country>

<country>
  <name>CAMBODIA</name>
  <code>KH</code>
  <subcountry>
    <name>Krong Pailin [Krong Pailin]</name>
    <code>24</code>
    <category>autonomous municipality</category>
  </subcountry>
</country>


<country>
  <name>ROMANIA</name>
  <code>RO</code>
  <subcountry>
    <name>Ilfov</name>
    <code>IF</code>
    <category>department</category>
  </subcountry>
</country>

<country>
  <name>SLOVENIA</name>
  <code>SI</code>
  <subcountry>
    <name>Ajdov�cina</name>
    <code>001</code>
  </subcountry>
  <subcountry>
    <name>Beltinci</name>
    <code>002</code>
  </subcountry>
  <subcountry>
    <name>Benedikt</name>
    <code>148</code>
  </subcountry>
  <subcountry>
    <name>Bistrica ob Sotli</name>
    <code>149</code>
  </subcountry>
  <subcountry>
    <name>Bled</name>
    <code>003</code>
  </subcountry>
  <subcountry>
    <name>Bloke</name>
    <code>150</code>
  </subcountry>
  <subcountry>
    <name>Bohinj</name>
    <code>004</code>
  </subcountry>
  <subcountry>
    <name>Borovnica</name>
    <code>005</code>
  </subcountry>
  <subcountry>
    <name>Bovec</name>
    <code>006</code>
  </subcountry>
  <subcountry>
    <name>Braslovce</name>
    <code>151</code>
  </subcountry>
  <subcountry>
    <name>Brda</name>
    <code>007</code>
  </subcountry>
  <subcountry>
    <name>Brezovica</name>
    <code>008</code>
  </subcountry>
  <subcountry>
    <name>Bre�ice</name>
    <code>009</code>
  </subcountry>
  <subcountry>
    <name>Cankova</name>
    <code>152</code>
  </subcountry>
  <subcountry>
    <name>Celje</name>
    <code>011</code>
  </subcountry>
  <subcountry>
    <name>Cerklje na Gorenjskem</name>
    <code>012</code>
  </subcountry>
  <subcountry>
    <name>Cerknica</name>
    <code>013</code>
  </subcountry>
  <subcountry>
    <name>Cerkno</name>
    <code>014</code>
  </subcountry>
  <subcountry>
    <name>Cerkvenjak</name>
    <code>153</code>
  </subcountry>
  <subcountry>
    <name>Cren�ovci</name>
    <code>015</code>
  </subcountry>
  <subcountry>
    <name>Crna na Koro�kem</name>
    <code>016</code>
  </subcountry>
  <subcountry>
    <name>Crnomelj</name>
    <code>017</code>
  </subcountry>
  <subcountry>
    <name>Destrnik</name>
    <code>018</code>
  </subcountry>
  <subcountry>
    <name>Divaca</name>
    <code>019</code>
  </subcountry>
  <subcountry>
    <name>Dobje</name>
    <code>154</code>
  </subcountry>
  <subcountry>
    <name>Dobrepolje</name>
    <code>020</code>
  </subcountry>
  <subcountry>
    <name>Dobrna</name>
    <code>155</code>
  </subcountry>
  <subcountry>
    <name>Dobrova-Polhov Gradec</name>
    <code>021</code>
  </subcountry>
  <subcountry>
    <name>Dobrovnik</name>
    <code>156</code>
  </subcountry>
  <subcountry>
    <name>Dol pri Ljubljani</name>
    <code>022</code>
  </subcountry>
  <subcountry>
    <name>Dolenjske Toplice</name>
    <code>157</code>
  </subcountry>
  <subcountry>
    <name>Dom�ale</name>
    <code>023</code>
  </subcountry>
  <subcountry>
    <name>Dornava</name>
    <code>024</code>
  </subcountry>
  <subcountry>
    <name>Dravograd</name>
    <code>025</code>
  </subcountry>
  <subcountry>
    <name>Duplek</name>
    <code>026</code>
  </subcountry>
  <subcountry>
    <name>Gorenja vas-Poljane</name>
    <code>027</code>
  </subcountry>
  <subcountry>
    <name>Gori�nica</name>
    <code>028</code>
  </subcountry>
  <subcountry>
    <name>Gornja Radgona</name>
    <code>029</code>
  </subcountry>
  <subcountry>
    <name>Gornji Grad</name>
    <code>030</code>
  </subcountry>
  <subcountry>
    <name>Gornji Petrovci</name>
    <code>031</code>
  </subcountry>
  <subcountry>
    <name>Grad</name>
    <code>158</code>
  </subcountry>
  <subcountry>
    <name>Grosuplje</name>
    <code>032</code>
  </subcountry>
  <subcountry>
    <name>Hajdina</name>
    <code>159</code>
  </subcountry>
  <subcountry>
    <name>Hoce-Slivnica</name>
    <code>160</code>
  </subcountry>
  <subcountry>
    <name>Hodo�</name>
    <code>161</code>
  </subcountry>
  <subcountry>
    <name>Horjul</name>
    <code>162</code>
  </subcountry>
  <subcountry>
    <name>Hrastnik</name>
    <code>034</code>
  </subcountry>
  <subcountry>
    <name>Hrpelje-Kozina</name>
    <code>035</code>
  </subcountry>
  <subcountry>
    <name>Idrija</name>
    <code>036</code>
  </subcountry>
  <subcountry>
    <name>Ig</name>
    <code>037</code>
  </subcountry>
  <subcountry>
    <name>Ilirska Bistrica</name>
    <code>038</code>
  </subcountry>
  <subcountry>
    <name>Ivancna Gorica</name>
    <code>039</code>
  </subcountry>
  <subcountry>
    <name>Izola</name>
    <code>040</code>
  </subcountry>
  <subcountry>
    <name>Jesenice</name>
    <code>041</code>
  </subcountry>
  <subcountry>
    <name>Jezersko</name>
    <code>163</code>
  </subcountry>
  <subcountry>
    <name>Jur�inci</name>
    <code>042</code>
  </subcountry>
  <subcountry>
    <name>Kamnik</name>
    <code>043</code>
  </subcountry>
  <subcountry>
    <name>Kanal</name>
    <code>044</code>
  </subcountry>
  <subcountry>
    <name>Kidricevo</name>
    <code>045</code>
  </subcountry>
  <subcountry>
    <name>Kobarid</name>
    <code>046</code>
  </subcountry>
  <subcountry>
    <name>Kobilje</name>
    <code>047</code>
  </subcountry>
  <subcountry>
    <name>Kocevje</name>
    <code>048</code>
  </subcountry>
  <subcountry>
    <name>Komen</name>
    <code>049</code>
  </subcountry>
  <subcountry>
    <name>Komenda</name>
    <code>164</code>
  </subcountry>
  <subcountry>
    <name>Koper</name>
    <code>050</code>
  </subcountry>
  <subcountry>
    <name>Kostel</name>
    <code>165</code>
  </subcountry>
  <subcountry>
    <name>Kozje</name>
    <code>051</code>
  </subcountry>
  <subcountry>
    <name>Kranj</name>
    <code>052</code>
  </subcountry>
  <subcountry>
    <name>Kranjska Gora</name>
    <code>053</code>
  </subcountry>
  <subcountry>
    <name>Kri�evci</name>
    <code>166</code>
  </subcountry>
  <subcountry>
    <name>Kr�ko</name>
    <code>054</code>
  </subcountry>
  <subcountry>
    <name>Kungota</name>
    <code>055</code>
  </subcountry>
  <subcountry>
    <name>Kuzma</name>
    <code>056</code>
  </subcountry>
  <subcountry>
    <name>La�ko</name>
    <code>057</code>
  </subcountry>
  <subcountry>
    <name>Lenart</name>
    <code>058</code>
  </subcountry>
  <subcountry>
    <name>Lendava</name>
    <code>059</code>
  </subcountry>
  <subcountry>
    <name>Litija</name>
    <code>060</code>
  </subcountry>
  <subcountry>
    <name>Ljubljana</name>
    <code>061</code>
  </subcountry>
  <subcountry>
    <name>Ljubno</name>
    <code>062</code>
  </subcountry>
  <subcountry>
    <name>Ljutomer</name>
    <code>063</code>
  </subcountry>
  <subcountry>
    <name>Logatec</name>
    <code>064</code>
  </subcountry>
  <subcountry>
    <name>Lo�ka dolina</name>
    <code>065</code>
  </subcountry>
  <subcountry>
    <name>Lo�ki Potok</name>
    <code>066</code>
  </subcountry>
  <subcountry>
    <name>Lovrenc na Pohorju</name>
    <code>167</code>
  </subcountry>
  <subcountry>
    <name>Luce</name>
    <code>067</code>
  </subcountry>
  <subcountry>
    <name>Lukovica</name>
    <code>068</code>
  </subcountry>
  <subcountry>
    <name>Maj�perk</name>
    <code>069</code>
  </subcountry>
  <subcountry>
    <name>Maribor</name>
    <code>070</code>
  </subcountry>
  <subcountry>
    <name>Markovci</name>
    <code>168</code>
  </subcountry>
  <subcountry>
    <name>Medvode</name>
    <code>071</code>
  </subcountry>
  <subcountry>
    <name>Menge�</name>
    <code>072</code>
  </subcountry>
  <subcountry>
    <name>Metlika</name>
    <code>073</code>
  </subcountry>
  <subcountry>
    <name>Me�ica</name>
    <code>074</code>
  </subcountry>
  <subcountry>
    <name>Miklav� na Dravskem polju</name>
    <code>169</code>
  </subcountry>
  <subcountry>
    <name>Miren-Kostanjevica</name>
    <code>075</code>
  </subcountry>
  <subcountry>
    <name>Mirna Pec</name>
    <code>170</code>
  </subcountry>
  <subcountry>
    <name>Mislinja</name>
    <code>076</code>
  </subcountry>
  <subcountry>
    <name>Moravce</name>
    <code>077</code>
  </subcountry>
  <subcountry>
    <name>Moravske Toplice</name>
    <code>078</code>
  </subcountry>
  <subcountry>
    <name>Mozirje</name>
    <code>079</code>
  </subcountry>
  <subcountry>
    <name>Murska Sobota</name>
    <code>080</code>
  </subcountry>
  <subcountry>
    <name>Muta</name>
    <code>081</code>
  </subcountry>
  <subcountry>
    <name>Naklo</name>
    <code>082</code>
  </subcountry>
  <subcountry>
    <name>Nazarje</name>
    <code>083</code>
  </subcountry>
  <subcountry>
    <name>Nova Gorica</name>
    <code>084</code>
  </subcountry>
  <subcountry>
    <name>Novo mesto</name>
    <code>085</code>
  </subcountry>
  <subcountry>
    <name>Odranci</name>
    <code>086</code>
  </subcountry>
  <subcountry>
    <name>Oplotnica</name>
    <code>171</code>
  </subcountry>
  <subcountry>
    <name>Ormo�</name>
    <code>087</code>
  </subcountry>
  <subcountry>
    <name>Osilnica</name>
    <code>088</code>
  </subcountry>
  <subcountry>
    <name>Pesnica</name>
    <code>089</code>
  </subcountry>
  <subcountry>
    <name>Piran</name>
    <code>090</code>
  </subcountry>
  <subcountry>
    <name>Pivka</name>
    <code>091</code>
  </subcountry>
  <subcountry>
    <name>Podcetrtek</name>
    <code>092</code>
  </subcountry>
  <subcountry>
    <name>Podlehnik</name>
    <code>172</code>
  </subcountry>
  <subcountry>
    <name>Podvelka</name>
    <code>093</code>
  </subcountry>
  <subcountry>
    <name>Polzela</name>
    <code>173</code>
  </subcountry>
  <subcountry>
    <name>Postojna</name>
    <code>094</code>
  </subcountry>
  <subcountry>
    <name>Prebold</name>
    <code>174</code>
  </subcountry>
  <subcountry>
    <name>Preddvor</name>
    <code>095</code>
  </subcountry>
  <subcountry>
    <name>Prevalje</name>
    <code>175</code>
  </subcountry>
  <subcountry>
    <name>Ptuj</name>
    <code>096</code>
  </subcountry>
  <subcountry>
    <name>Puconci</name>
    <code>097</code>
  </subcountry>
  <subcountry>
    <name>Race-Fram</name>
    <code>098</code>
  </subcountry>
  <subcountry>
    <name>Radece</name>
    <code>099</code>
  </subcountry>
  <subcountry>
    <name>Radenci</name>
    <code>100</code>
  </subcountry>
  <subcountry>
    <name>Radlje ob Dravi</name>
    <code>101</code>
  </subcountry>
  <subcountry>
    <name>Radovljica</name>
    <code>102</code>
  </subcountry>
  <subcountry>
    <name>Ravne na Koro�kem</name>
    <code>103</code>
  </subcountry>
  <subcountry>
    <name>Razkri�je</name>
    <code>176</code>
  </subcountry>
  <subcountry>
    <name>Ribnica</name>
    <code>104</code>
  </subcountry>
  <subcountry>
    <name>Ribnica na Pohorju</name>
    <code>177</code>
  </subcountry>
  <subcountry>
    <name>Roga�ka Slatina</name>
    <code>106</code>
  </subcountry>
  <subcountry>
    <name>Roga�ovci</name>
    <code>105</code>
  </subcountry>
  <subcountry>
    <name>Rogatec</name>
    <code>107</code>
  </subcountry>
  <subcountry>
    <name>Ru�e</name>
    <code>108</code>
  </subcountry>
  <subcountry>
    <name>Selnica ob Dravi</name>
    <code>178</code>
  </subcountry>
  <subcountry>
    <name>Semic</name>
    <code>109</code>
  </subcountry>
  <subcountry>
    <name>Sevnica</name>
    <code>110</code>
  </subcountry>
  <subcountry>
    <name>Se�ana</name>
    <code>111</code>
  </subcountry>
  <subcountry>
    <name>Slovenj Gradec</name>
    <code>112</code>
  </subcountry>
  <subcountry>
    <name>Slovenska Bistrica</name>
    <code>113</code>
  </subcountry>
  <subcountry>
    <name>Slovenske Konjice</name>
    <code>114</code>
  </subcountry>
  <subcountry>
    <name>Sodra�ica</name>
    <code>179</code>
  </subcountry>
  <subcountry>
    <name>Solcava</name>
    <code>180</code>
  </subcountry>
  <subcountry>
    <name>Star�e</name>
    <code>115</code>
  </subcountry>
  <subcountry>
    <name>Sveta Ana</name>
    <code>181</code>
  </subcountry>
  <subcountry>
    <name>Sveti Andra� v Slovenskih goricah</name>
    <code>182</code>
  </subcountry>
  <subcountry>
    <name>Sveti Jurij</name>
    <code>116</code>
  </subcountry>
  <subcountry>
    <name>�alovci</name>
    <code>033</code>
  </subcountry>
  <subcountry>
    <name>�empeter-Vrtojba</name>
    <code>183</code>
  </subcountry>
  <subcountry>
    <name>�encur</name>
    <code>117</code>
  </subcountry>
  <subcountry>
    <name>�entilj</name>
    <code>118</code>
  </subcountry>
  <subcountry>
    <name>�entjernej</name>
    <code>119</code>
  </subcountry>
  <subcountry>
    <name>�entjur pri Celju</name>
    <code>120</code>
  </subcountry>
  <subcountry>
    <name>�kocjan</name>
    <code>121</code>
  </subcountry>
  <subcountry>
    <name>�kofja Loka</name>
    <code>122</code>
  </subcountry>
  <subcountry>
    <name>�kofljica</name>
    <code>123</code>
  </subcountry>
  <subcountry>
    <name>�marje pri Jel�ah</name>
    <code>124</code>
  </subcountry>
  <subcountry>
    <name>�martno ob Paki</name>
    <code>125</code>
  </subcountry>
  <subcountry>
    <name>�martno pri Litiji</name>
    <code>194</code>
  </subcountry>
  <subcountry>
    <name>�o�tanj</name>
    <code>126</code>
  </subcountry>
  <subcountry>
    <name>�tore</name>
    <code>127</code>
  </subcountry>
  <subcountry>
    <name>Tabor</name>
    <code>184</code>
  </subcountry>
  <subcountry>
    <name>Ti�ina</name>
    <code>010</code>
  </subcountry>
  <subcountry>
    <name>Tolmin</name>
    <code>128</code>
  </subcountry>
  <subcountry>
    <name>Trbovlje</name>
    <code>129</code>
  </subcountry>
  <subcountry>
    <name>Trebnje</name>
    <code>130</code>
  </subcountry>
  <subcountry>
    <name>Trnovska vas</name>
    <code>185</code>
  </subcountry>
  <subcountry>
    <name>Tr�ic</name>
    <code>131</code>
  </subcountry>
  <subcountry>
    <name>Trzin</name>
    <code>186</code>
  </subcountry>
  <subcountry>
    <name>Turni�ce</name>
    <code>132</code>
  </subcountry>
  <subcountry>
    <name>Velenje</name>
    <code>133</code>
  </subcountry>
  <subcountry>
    <name>Velika Polana</name>
    <code>187</code>
  </subcountry>
  <subcountry>
    <name>Velike La�ce</name>
    <code>134</code>
  </subcountry>
  <subcountry>
    <name>Ver�ej</name>
    <code>188</code>
  </subcountry>
  <subcountry>
    <name>Videm</name>
    <code>135</code>
  </subcountry>
  <subcountry>
    <name>Vipava</name>
    <code>136</code>
  </subcountry>
  <subcountry>
    <name>Vitanje</name>
    <code>137</code>
  </subcountry>
  <subcountry>
    <name>Vodice</name>
    <code>138</code>
  </subcountry>
  <subcountry>
    <name>Vojnik</name>
    <code>139</code>
  </subcountry>
  <subcountry>
    <name>Vransko</name>
    <code>189</code>
  </subcountry>
  <subcountry>
    <name>Vrhnika</name>
    <code>140</code>
  </subcountry>
  <subcountry>
    <name>Vuzenica</name>
    <code>141</code>
  </subcountry>
  <subcountry>
    <name>Zagorje ob Savi</name>
    <code>142</code>
  </subcountry>
  <subcountry>
    <name>Zavrc</name>
    <code>143</code>
  </subcountry>
  <subcountry>
    <name>Zrece</name>
    <code>144</code>
  </subcountry>
  <subcountry>
    <name>�alec</name>
    <code>190</code>
  </subcountry>
  <subcountry>
    <name>�elezniki</name>
    <code>146</code>
  </subcountry>
  <subcountry>
    <name>�etale</name>
    <code>191</code>
  </subcountry>
  <subcountry>
    <name>�iri</name>
    <code>147</code>
  </subcountry>
  <subcountry>
    <name>�irovnica</name>
    <code>192</code>
  </subcountry>
  <subcountry>
    <name>�u�emberk</name>
    <code>193</code>
  </subcountry>
</country>

<country>
  <name>UZBEKISTAN</name>
  <code>UZ</code>
  <subcountry>
    <name>Toshkent</name>
    <code>TK</code>
    <category>city</category>
  </subcountry>
</country>

<country>
  <name>VENEZUELA</name>
  <code>VE</code>
  <subcountry>
    <name>Vargas</name>
    <code>X</code>
    <category>state</category>
  </subcountry>
</country>

<country>
  <name>HONDURAS</name>
  <code>HN</code>
  <subcountry>
    <name>Ocotepeque</name>
    <code>OC</code>
    <FIPS>14</FIPS>
  </subcountry>
</country>

<country>
  <name>MALAYSIA</name>
  <code>MY</code>
  <subcountry>
    <name>Wilayah Persekutuan Putrajaya</name>
    <code>16</code>
    <category>federal territory</category>
  </subcountry>
</country>

<country>
  <name>TANZANIA, UNITED REPUBLIC OF</name>
  <code>TZ</code>
  <subcountry>
    <name>Manyara</name>
    <code>26</code>
  </subcountry>
</country>

<country>
  <name>UGANDA</name>
  <code>UG</code>
  <subcountry>
    <name>Kaberamaido</name>
    <code>213</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Kamwenge</name>
    <code>413</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kanungu</name>
    <code>414</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Kayunga</name>
    <code>112</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Kyenjojo</name>
    <code>415</code>
    <regional_division>W</regional_division>
  </subcountry>
  <subcountry>
    <name>Mayuge</name>
    <code>214</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Nakapiripirit</name>
    <code>311</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Pader</name>
    <code>312</code>
    <regional_division>N</regional_division>
  </subcountry>
  <subcountry>
    <name>Sironko</name>
    <code>215</code>
    <regional_division>E</regional_division>
  </subcountry>
  <subcountry>
    <name>Wakiso</name>
    <code>113</code>
    <regional_division>C</regional_division>
  </subcountry>
  <subcountry>
    <name>Yumbe</name>
    <code>313</code>
    <regional_division>N</regional_division>
  </subcountry>
</country>

<country>
  <name>LIBYAN ARAB JAMAHIRIYA</name>
  <code>LY</code>
  <subcountry>
    <name>Ajdabiya</name>
    <code>AJ</code>
  </subcountry>
  <subcountry>
    <name>Al Hizam al Akhhar</name>
    <code>HZ</code>
  </subcountry>
  <subcountry>
    <name>Al Jifarah</name>
    <code>JI</code>
  </subcountry>
  <subcountry>
    <name>Al Kufrah</name>
    <code>KF</code>
  </subcountry>
  <subcountry>
    <name>Al Marj</name>
    <code>MJ</code>
  </subcountry>
  <subcountry>
    <name>Al Marqab</name>
    <code>MB</code>
  </subcountry>
  <subcountry>
    <name>Al Qatrun</name>
    <code>QT</code>
  </subcountry>
  <subcountry>
    <name>Al Qubbah</name>
    <code>QB</code>
  </subcountry>
  <subcountry>
    <name>An Nuqat al Khams</name>
    <code>NQ</code>
  </subcountry>
  <subcountry>
    <name>Ash Shati'</name>
    <code>SH</code>
  </subcountry>
  <subcountry>
    <name>Bani Walid</name>
    <code>BW</code>
  </subcountry>
  <subcountry>
    <name>Darnah</name>
    <code>DR</code>
  </subcountry>
  <subcountry>
    <name>Ghadamis</name>
    <code>GD</code>
  </subcountry>
  <subcountry>
    <name>Gharyan</name>
    <code>GR</code>
  </subcountry>
  <subcountry>
    <name>Ghat</name>
    <code>GT</code>
  </subcountry>
  <subcountry>
    <name>Jaghbub</name>
    <code>JB</code>
  </subcountry>
  <subcountry>
    <name>Mizdah</name>
    <code>MZ</code>
  </subcountry>
  <subcountry>
    <name>Murzuq</name>
    <code>MQ</code>
  </subcountry>
  <subcountry>
    <name>Nalut</name>
    <code>NL</code>
  </subcountry>
  <subcountry>
    <name>Sabha</name>
    <code>SB</code>
  </subcountry>
  <subcountry>
    <name>Sabratah Surman</name>
    <code>SS</code>
  </subcountry>
  <subcountry>
    <name>Surt</name>
    <code>SR</code>
  </subcountry>
  <subcountry>
    <name>Tajura' wa an Nawahi Arbah</name>
    <code>TN</code>
  </subcountry>
  <subcountry>
    <name>Tarhunah-Masallatah</name>
    <code>TM</code>
  </subcountry>
  <subcountry>
    <name>Wadi al Hayat</name>
    <code>WD</code>
  </subcountry>
  <subcountry>
    <name>Yafran-Jadu</name>
    <code>YJ</code>
  </subcountry>
</country>

<country>
  <name>TUNISIA</name>
  <code>TN</code>
  <subcountry>
    <name>Manouba</name>
    <code>14</code>
  </subcountry>
</country>

<country>
  <name>GUYANA</name>
  <code>GY</code>
  <subcountry>
    <name>Cuyuni-Mazaruni</name>
    <code>CU</code>
    <FIPS>11</FIPS>
  </subcountry>
  <subcountry>
    <name>Demerara-Mahaica</name>
    <code>DE</code>
    <FIPS>12</FIPS>
  </subcountry>
  <subcountry>
    <name>East Berbice-Corentyne</name>
    <code>EB</code>
    <FIPS>13</FIPS>
  </subcountry>
  <subcountry>
    <name>Essequibo Islands-West Demerara</name>
    <code>ES</code>
    <FIPS>14</FIPS>
  </subcountry>
  <subcountry>
    <name>Mahaica-Berbice</name>
    <code>MA</code>
    <FIPS>15</FIPS>
  </subcountry>
  <subcountry>
    <name>Pomeroon-Supenaam</name>
    <code>PM</code>
    <FIPS>16</FIPS>
  </subcountry>
  <subcountry>
    <name>Potaro-Siparuni</name>
    <code>PT</code>
    <FIPS>17</FIPS>
  </subcountry>
  <subcountry>
    <name>Upper Demerara-Berbice</name>
    <code>UD</code>
    <FIPS>18</FIPS>
  </subcountry>
  <subcountry>
    <name>Upper Takutu-Upper Essequibo</name>
    <code>UT</code>
    <FIPS>19</FIPS>
  </subcountry>
</country>

<country>
  <name>ANGUILLA</name>
  <code>AI</code>
</country>

<country>
  <name>SINGAPORE</name>
  <code>SG</code>
</country>

<country>
  <name>NETHERLANDS ANTILLES</name>
  <code>AN</code>
</country>

<country>
  <name>ANTARCTICA</name>
  <code>AQ</code>
</country>

<country>
  <name>ARUBA</name>
  <code>AW</code>
</country>

<country>
  <name>BOUVET ISLAND</name>
  <code>BV</code>
</country>

<country>
  <name>COCOS (KEELING) ISLANDS</name>
  <code>CC</code>
</country>

<country>
  <name>COOK ISLANDS</name>
  <code>CK</code>
</country>

<country>
  <name>VIRGIN ISLANDS, BRITISH</name>
  <code>VG</code>
</country>

<country>
  <name>VIRGIN ISLANDS, U.S.</name>
  <code>VI</code>
</country>

<country>
  <name>WALLIS AND FUTUNA</name>
  <code>WF</code>
</country>

<country>
  <name>MAYOTTE</name>
  <code>YT</code>
</country>

<country>
  <name>AMERICAN SAMOA</name>
  <code>AS</code>
</country>

<country>
  <name>HOLY SEE (VATICAN CITY STATE)</name>
  <code>VA</code>
</country>

<country>
  <name>MALTA</name>
  <code>MT</code>
</country>

<country>
  <name>NORTHERN MARIANA ISLANDS</name>
  <code>MP</code>
</country>

<country>
  <name>MONACO</name>
  <code>MC</code>
</country>

<country>
  <name>BRITISH INDIAN OCEAN TERRITORY</name>
  <code>IO</code>
</country>

<country>
  <name>HEARD ISLAND AND MCDONALD ISLANDS</name>
  <code>HM</code>
</country>

<country>
  <name>GUAM</name>
  <code>GU</code>
</country>


<country>
  <name>SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS</name>
  <code>GS</code>
</country>

<country>
  <name>GREENLAND/GROENLAND</name>
  <code>GL</code>
</country>

<country>
  <name>GIBRALTAR</name>
  <code>GI</code>
</country>

<country>
  <name>FAROE ISLANDS</name>
  <code>FO</code>
</country>

<country>
  <name>FALKLAND ISLANDS (MALVINAS)</name>
  <code>FK</code>
</country>

<country>
  <name>WESTERN SAHARA</name>
  <code>EH</code>
</country>

<country>
  <name>TOKELAU</name>
  <code>TK</code>
</country>

<country>
  <name>FRENCH SOUTHERN TERRITORIES</name>
  <code>TF</code>
</country>

<country>
  <name>TURKS AND CAICOS ISLANDS</name>
  <code>TC</code>
</country>

<country>
  <name>SVALBARD AND JAN MAYEN</name>
  <code>SJ</code>
</country>

<country>
  <name>PALESTINIAN TERRITORY</name>
  <code>PS</code>
</country>

<country>
  <name>PUERTO RICO</name>
  <code>PR</code>
</country>

<country>
  <name>PITCAIRN</name>
  <code>PN</code>
</country>

<country>
  <name>SAINT PIERRE AND MIQUELON</name>
  <code>PM</code>
</country>

<country>
  <name>NIUE</name>
  <code>NU</code>
</country>

<country>
  <name>NORFOLK ISLAND</name>
  <code>NF</code>
</country>

<country>
  <name>CHRISTMAS ISLAND</name>
  <code>CX</code>
</country>

<country>
  <name>ANTIGUA AND BARBUDA</name>
  <code>AG</code>
</country>

<country>
  <name>BERMUDA</name>
  <code>BM</code>
</country>

<country>
  <name>BARBADOS</name>
  <code>BB</code>
</country>

<country>
  <name>ANDORRA</name>
  <code>AD</code>
  <subcountry>
    <name>Andorra la Vella</name>
    <code>AN</code>
    <FIPS>07</FIPS>
  </subcountry>
  <subcountry>
    <name>Canillo</name>
    <code>CA</code>
    <FIPS>02</FIPS>
  </subcountry>
  <subcountry>
    <name>Encamp</name>
    <code>EN</code>
    <FIPS>03</FIPS>
  </subcountry>
  <subcountry>
    <name>Escaldes-Engordany</name>
    <code>EE</code>
    <FIPS>08</FIPS>
  </subcountry>
  <subcountry>
    <name>La Massana</name>
    <code>MA</code>
    <FIPS>04</FIPS>
  </subcountry>
  <subcountry>
    <name>Ordino</name>
    <code>OR</code>
    <FIPS>05</FIPS>
  </subcountry>
  <subcountry>
    <name>Sant Juli� de L�ria</name>
    <code>JL</code>
    <FIPS>06</FIPS>
  </subcountry>
</country>


<country>
  <name>MONTSERRAT</name>
  <code>MS</code>
</country>

<country>
  <name>MARTINIQUE</name>
  <code>MQ</code>
</country>

<country>
  <name>MACAO</name>
  <code>MO</code>
</country>

<country>
  <name>MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF</name>
  <code>MK</code>
</country>

<country>
  <name>LIECHTENSTEIN</name>
  <code>LI</code>
</country>

<country>
  <name>SAINT LUCIA</name>
  <code>LC</code>
</country>

<country>
  <name>CAYMAN ISLANDS</name>
  <code>KY</code>
</country>

<country>
  <name>SAINT VINCENT AND THE GRENADINES</name>
  <code>VC</code>
</country>

<country>
  <name>SAINT KITTS AND NEVIS</name>
  <code>KN</code>
</country>

<country>
  <name>GUADELOUPE</name>
  <code>GP</code>
</country>

<country>
  <name>FRENCH GUIANA</name>
  <code>GF</code>
</country>

<country>
  <name>GRENADA</name>
  <code>GD</code>
  <subcountry>
    <name>Carriacou</name>
    <code>CA</code>
    <FIPS></FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Andrew</name>
    <code>AN</code>
    <FIPS>1</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint David</name>
    <code>DA</code>
    <FIPS>2</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint George</name>
    <code>GE</code>
    <FIPS>3</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint John</name>
    <code>JO</code>
    <FIPS>4</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Mark</name>
    <code>MA</code>
    <FIPS>5</FIPS>
  </subcountry>
  <subcountry>
    <name>Saint Patrick</name>
    <code>PA</code>
    <FIPS>6</FIPS>
  </subcountry>
</country>

<country>
  <name>DOMINICA</name>
  <code>DM</code>
</country>

<country>
  <name>TUVALU</name>
  <code>TV</code>
</country>

<country>
  <name>NAURU</name>
  <code>NR</code>
</country>

<country>
  <name>SEYCHELLES</name>
  <code>SC</code>
</country>





</ISO_3166_2>
