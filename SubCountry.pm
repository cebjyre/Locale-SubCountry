=head1 NAME

Locale::SubCountry - convert state, province, county etc names to/from code

=head1 SYNOPSIS

   use Locale::SubCountry;
   
   $UK_counties = new Locale::SubCountry('UK');
   print($UK_counties->full_name('DUMGAL'));  # Dumfries & Galloway
   
   $country = 'AUSTRALIA';
   @all_countries = &all_countries;
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
region to the code commonly used for postal addressing. The reverse conversion
can also be done.

Sub countries are termed as states in the US and Australia, provinces 
in Canada and counties in the UK.

Additionally, names and codes for all sub countries in a country can be 
returned as either a hash or an array. 

=head1 METHODS

=head2 new

The C<new> method creates an instance of a sub country object. This must be 
called before any of the following methods are invoked. The method takes a 
single argument, the name of the country that contains the sub countries 
that you want to work with. These are currently:

   Australia
   Belarus
   Brazil
   Canada
   Denmark
   Dominican Republic
   Eritrea
   France
   Germany
   Indonesia
   Italy
   Netherlands
   Nigeria
   Poland
   Romania
   Russia
   South Korea
   Spain
   Turkey
   UK
   USA
   Vietnam
   Yugoslavia
   
All forms of upper/lower case are acceptable in the country's spelling. If a 
country name is supplied that the module doesn't recognise, it will die.


=head2 code

The C<code> method takes the full name of a sub country in the currently
assigned country and returns the sub country's code. The full name can appear
in mixed case. All white space and non alphabetic characters are ignored, 
except the single space used to separate sub country names such as 
"New South Wales". The code is returned as a capitalised string, or 
"unknown" if no match is found.

=head2 full_name

The C<name> method takes the code of a sub country in the currently
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

=head2 all_countries

Returns an array of all country names that SubCountry can do lookups for,
sorted alphabetically. This is implemented as a conventional subroutine rather 
than a method. This allows us to check if lookups can be done for a given country
before actually creating the lookup object.

=head1 SEE ALSO

ISO 3166-2:1998, Standard for naming sub country codes
Locale::Country
Geography::States


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

The Indonesian sub region of Kalimantan Timur has two codes, KI and KT.

=head1 BUGS

  

=head1 COPYRIGHT


Copyright (c) 2000 Kim Ryan. All rights reserved.
This program is free software; you can redistribute it 
and/or modify it under the terms of the Perl Artistic License
(see http://www.perl.com/perl/misc/Artistic.html).


=head1 AUTHOR

Locale::SubCountry was written by Kim Ryan <kimaryan@ozemail.com.au> in 2000.

=head1 CREDITS

Terrence Brannon produced Locale::US, which was the starting point for
this module. 

Codes for Canadian, Netherlands and Brazilian sub countries were taken from 
the Geography::States module.

Mark Summerfield and Guy Fraser provided the list of UK counties.

Alastair McKinstry provided the data for Belarus, Denmark, the Dominican
Republic, Eritrea, France, Germany, Indonesia, Ireland, Italy, Japan, Nigera, 
Poland, Romania, Russia, South Korea, Spain, Turkey, Vietnam and Yugoslavia.

=cut

#------------------------------------------------------------------------------

package Locale::SubCountry;

use strict;
require 5.005;  # Needed for use of the INIT subroutine
use locale;


use Exporter;
use vars qw (@ISA $VERSION @EXPORT);

$VERSION = '1.03';
@ISA     = qw(Exporter);
@EXPORT  = qw(&all_countries);

#------------------------------------------------------------------------------
# Create new instance of a sub country object

sub new
{
   my $class = shift;
   my ($country) = @_;
   
   $country = uc($country);
   unless ( exists $::lookup{$country} )
   {
      die "Invalid country name: $country chosen";
   }
   
   my $sub_country = {};
   bless($sub_country,$class);
   $sub_country->{country} = $country;
   
   return($sub_country);
}

#------------------------------------------------------------------------------
# Given the full name for a sub country, return the code

sub code
{
   my $sub_country = shift;
   my ($full_name) = @_;
   
   my $orig = $full_name;
   
   $full_name = _clean($full_name);
   
   my $code = $::lookup{$sub_country->{country}}{full_name_keyed}{$full_name};
   
   # If a code wasn't found, it could be because the user's capitalization
   # does not match the one in the look up data of this module. For example,
   # the user may have supplied the sub country "Ag R" (in Turkey) but the 
   # ISO standard defines the spelling as "Ag r".
   
   unless ( $code )
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
            $code = $::lookup{$sub_country->{country}}{full_name_keyed}{$current_name};
         }
      }
   }
   
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
# Given the code for a sub country, return the full name.
# Parameters are the code and a flag, which if set to true
# will cause the full name to be uppercased

sub full_name
{
   my $sub_country = shift;
   my ($code,$uc_name) = @_;
   
   $code = _clean($code);
   $code = uc($code);
   
   my $full_name = $::lookup{$sub_country->{country}}{code_keyed}{$code};
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
   my $sub_country = shift;
   return( %{ $::lookup{$sub_country->{country}}{code_keyed} } );
}
#------------------------------------------------------------------------------
sub full_name_code_hash
{
   my $sub_country = shift;
   return( %{ $::lookup{$sub_country->{country}}{full_name_keyed} } );
}
#------------------------------------------------------------------------------
# Returns sorted array of all sub country full names for the current country

sub all_full_names
{
   my $sub_country = shift;
   my %all_full_names = $sub_country->full_name_code_hash;
   return( sort keys %all_full_names );
}
#------------------------------------------------------------------------------
# Returns sorted array of all sub country codes for the current country

sub all_codes
{
   my $sub_country = shift;
   my %all_codes = $sub_country->code_full_name_hash;
   return( sort keys %all_codes );
}
#------------------------------------------------------------------------------
# Returns sorted array of all countries that we can do lookups for

sub all_countries
{
   return( sort keys %::lookup );
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
      unless ( /^#/ or /^s*$/ )  # ignore commented and empty lines
      {
         chomp;
         if ( /^Country=(.*)/ )
         {
            $country = $1;
         }
         else
         {
            my ($code,$name) = split(/:/,$_);
            
            $code = _clean($code);
            $name = _clean($name);
            
            # Create two hashes, both grouped by country, one keyed by
            # abbrevaiton and one by full name. Although data is duplicated,
            # this provided the fastest lookup and simplest code.
            
            $::lookup{$country}{code_keyed}{$code} = $name;
            $::lookup{$country}{full_name_keyed}{$name} = $code;
         }
      }
   }
}
#------------------------------------------------------------------------------
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

Country=BELARUS

BR:Brèsckaja voblasc
HO:Homel'skaja voblasc
HR:Hrodzenskaja voblasc
MA:Mahilëuskaja voblasc'
MI:Minskaja voblasc'
VI:Vicebskaja voblasc'

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

Country=DENMARK

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

Country=DOMINICAN REPUBLIC

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

Country=ERITREA

AN:Anseba
DU:Debub
DK:Debubawi Keyih Bahri [Debub-Keih-Bahri]
GB:Gash-Barka
MA:Maakel [Maekel]
SK:Semenawi Keyih Bahri [Semien-Keih-Bahri]

Country=FRANCE

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

Country=GERMANY

BW:Baden-Wuerttemberg
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
TH:Thueringen

Country=INDONESIA

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

Country=JAPAN

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


Country=SOUTH KOREA

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

Country=NIGERIA

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

Country=POLAND

DS:Dolnos ´ l a skie
KP:Kujawsko-pomorskie
LU:Lubelskie
LB: Lubuskie
LD:ódzkie
MA:Ma opolskie
MZ:Mazowieckie
OP:Opolskie
PK:Podkarpackie
PD:Podlaskie
PM:Pomorskie
SL:S ´ l a skie
SK:S ´ wi e tokrzyskie
WN:Warmi´ n sko-mazurskie
WP:Wielkopolskie
ZP:Zachodniopomorskie

Country=ROMANIA

B:Bucures ¸ ti
AB:Alba
AR:Arad
AG:Arges ¸
BC:Baca u
BH:Bihor
BN:Bistrit ¸ a-Na sa ud
BT:Botos ¸ ani
BV:Bras ¸ ov
BR:Bra ila
BZ:Buza u
CS:Caras ¸ -Severin
CL:Ca la ras ¸ i
CJ:Cluj
CT:Constant ¸ a
CV:Covasna
DB:Dâmbovit ¸ a
DJ:Dolj
GL:Galat ¸ i
GR:Giurgiu
GJ:Gorj
HR:Harghita
HD:Hunedoara
IL:Ialomit ¸ a
IS:Ias ¸ i
MM:Maramures ¸
MH:Mehedint ¸ i
MS:Mures ¸
NT:Neamt ¸
OT:Olt
PH:Prahova
SM:Satu Mare
SJ:Sa laj
SB:Sibiu
SV:Suceava
TR:Teleorman
TM:Timis ¸
TL:Tulcea
VS:Vaslui
VL:Vâlcea
VN:Vrancea

Country=RUSSIA

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

Country=SPAIN

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

Country=TURKEY

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
26:Eskis ¸ ehir
27:Gaziantep
28:Giresun
29:Gümüs ¸ hane
30:Hakkâri
31:Hatay
76:Ig d r
32:Isparta
33:I çel
34:I stanbul
35:I zmir
46:Kahramanmaras ¸
78:Karabük
70:Karaman
36:Kars
37:Kastamonu
38:Kayseri
71:K r kkale
39:K rklareli
40:K rs ¸ ehir
79:Kilis
41:Kocaeli
42:Konya
43:Kütahya
44:Malatya
45:Manisa
47:Mardin
48:Mug la
49:Mus ¸
50:Nevs ¸ ehir
51:Nig de
52:Ordu
80: Osmaniye
53:Rize
54:Sakarya
55:Samsun
56:Siirt
57:Sinop
58:Sivas
63:S ¸ anl urfa
73:S ¸ rnak
59:Tekirdag
60:Tokat
61:Trabzon
62:Tunceli
64:Us ¸ ak
65:Van
77:Yalova
66:Yozgat
67:Zonguldak

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
CO FERMANAGH:County Fermanagh
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

Country=VIETNAM

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

CG:Crna Gora
SR:Srbija
KM:Kosovo-Metohija
VO:Vojvodina
