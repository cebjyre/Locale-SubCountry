use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.

warn "\n"
   . "Locale::SubCountry will not be installed as it requires perl 5.005\n"
   . "or later and you only have $]\n"
   if $] < 5.005;

WriteMakefile
(

   'VERSION_FROM'    => 'SubCountry.pm',
   'clean'           =>
   {
      'FILES'        => 'blib/* Makefile MANIFEST Locale-SubCountry-*'
   },
   'dist'            =>
   {
      'COMPRESS'     => 'gzip',
      'SUFFIX'       => 'gz'
   },
   'DISTNAME'        => 'Locale-SubCountry',

   ( $] >= 5.005 ?
      (
          ABSTRACT => 'convert state, province, county ... names to/from ISO 3166-2 code',
          AUTHOR   => 'Kim Ryan <kimryan at cpan org>',
      ) : ()
   ),

   'NAME'            => 'Locale::SubCountry',
   'PM'              =>
   {
      'SubCountry.pm' => '$(INST_LIBDIR)/SubCountry.pm',
   },
);
