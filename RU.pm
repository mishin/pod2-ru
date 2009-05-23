package POD2::RU;
use utf8; # encoding="utf-8"
use strict;
use warnings;

use base 'Exporter';
our @EXPORT = qw(print_pod print_pods search_perlfunc_re);

our $VERSION = '0.01';

my $pods = {
	perlbook   => '5.10.0',
	perlpragma => '5.10.0',
	perldoc    => '5.10.0',
	perlstyle  => '5.10.0',
};

sub print_pods {
	print_pod(sort keys %$pods);
}

sub print_pod {
	my @args = @_ ? @_ : @ARGV;

	while (@args) {
		(my $pod = lc(shift @args)) =~ s/\.pod$//;
		if ( exists $pods->{$pod} ) {
			print "\t'$pod' translated from Perl $pods->{$pod}\n";
		}
		else {
			print "\t'$pod' doesn't yet exists\n";
		}
	}
}

sub search_perlfunc_re {
	return 'Список Perl-функций в алфавитном порядке';
}

1;

__END__

=encoding UTF-8

=head1 NAME

POD2::RU - Russian translation of Perl core documentation

=head1 SYNOPSIS

  %> perldoc POD2::RU::<podname>  

  use POD2::RU;
  print_pods();
  print_pod('pod_foo', 'pod_baz', ...); 

  %> perl -MPOD2::RU -e print_pods
  %> perl -MPOD2::RU -e print_pod <podname1> <podname2> ...

=head1 DESCRIPTION

pod2ru is the Russian translation project of core Perl pods. This has been (and
currently still is) a very big work! :-) 

See http://pod2ru.sf.net for more details about the project. 

Once the package has been installed, the translated documentation can be
accessed with: 

  %> perldoc POD2::RU::<podname>

=head1 EXTENDING perldoc

With the translated pods, unfortunately, the useful C<perldoc>'s C<-f> and C<-q> 
switches don't work no longer.

So, we made a simple patch to F<Pod/Perldoc.pm> 3.14 in order to allow also the
syntax: 

  %> perldoc -L RU <podname>
  %> perldoc -L RU -f <function>
  %> perldoc -L RU -q <FAQregex>

The patch adds the C<-L> switch that allows to define language code for desired
language translation. If C<POD2::E<lt>codeE<gt>> package doesn't exists, the
effect of the switch will be ignored.

If you are particularly lazy you can add a system alias like:

  perldoc-it="perldoc -L RU "

in order to avoid to write the C<-L> switch every time and to type directly:

  %> perldoc-ru -f map 
 

Note that the patch is for version 3.14 of L<Pod::Perldoc|Pod::Perldoc>
(included into Perl 5.8.7 and Perl 5.8.8). If you have a previous Perl distro
(but E<gt>= 5.8.1) and you are impatient to apply the patch, please upgrade
your L<Pod::Perldoc|Pod::Perldoc> module to 3.14! ;-) 

See C<search_perlfunc_re> API for more information.

I<Note: Perl 5.10 already contains this functionality, so you don't have to apply any patch.>

=head1 API

The package exports following functions:

=over 4

=item * C<print_pods>

Prints all translated pods and relative Perl original version.

=item * C<print_pod>

Prints relative Perl original version of all pods passed as arguments.

=item * C<search_perlfunc_re>

Since F<Pod/Perldoc.pm>'s C<search_perlfunc> method uses hard coded string
"Alphabetical Listing of Perl Functions" (as regexp) to skip introduction, in
order to make the patch to work with other languages with the option C<-L>,we
used a simple plugin-like mechanism. 

C<POD2::E<lt>codeE<gt>> language package must export C<search_perlfunc_re> that
returns a localized translation of the paragraph string above. This string will
be used to skip F<perlfunc.pod> intro. Again, if
C<POD2::E<lt>codeE<gt>-E<gt>search_perlfunc_re> fails (or doesn't exist), we'll
come back to the default behavoiur. This mechanism allows to add additional
C<POD2::*> translations without need to patch F<Pod/Perldoc.pm> every time.

=back

=head1 ONLINE TRANSLATION

L<http://translated.by/you/tags/pod2ru/>

=head1 AUTHORS

pod2ru is a larger translation project owned by

Анатолий Шарифулин (sharifulin)
Алексей Суриков (KSURi)
Михаил Любимов (mikhail.lyubimov)
Дмитрий Константинов (Dim_K)
Евгений Баранов (Baranov)
...

POD2::RU package is currently maintained by Anatoly Sharufulin

=head1 SEE ALSO

L<POD2::IT>, L<POD2::FR>, L<POD2::LT>, L<perl>.

=head1 COPYRIGHT AND LICENCE

Copyright (C) 2009 Anatoly Sharifulin.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
