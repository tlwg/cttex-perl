package ttool;

use strict;
use Carp;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK $AUTOLOAD);

require Exporter;
require DynaLoader;
require AutoLoader;

@ISA = qw(Exporter DynaLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(ttcut ttcutwbr ttcut2list ttsetcode ttfixorder
	
);
$VERSION = '0.5';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.  If a constant is not found then control is passed
    # to the AUTOLOAD in AutoLoader.

    my $constname;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    my $val = constant($constname, @_ ? $_[0] : 0);
    if ($! != 0) {
	if ($! =~ /Invalid/) {
	    $AutoLoader::AUTOLOAD = $AUTOLOAD;
	    goto &AutoLoader::AUTOLOAD;
	}
	else {
		croak "Your vendor has not defined ttool macro $constname";
	}
    }
    eval "sub $AUTOLOAD { $val }";
    goto &$AUTOLOAD;
}

bootstrap ttool $VERSION;

# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

ttool - Perl extension for CTTEX (Thai Word Segmentation)

=head1 SYNOPSIS

  use ttool;

=head1 DESCRIPTION

ThaiTool is a perl wrapper for universal Thai Word segmentation
program "cttex". As of version 0.5, the following functions
are available : ttcut(), ttcutwbr(), ttcut2list(), ttsetcode(), 
and ttfixorder().

=head1 SAMPLE

  ttsetcode(32);          # Set separator to character code 32 (space)
  $out = ttcut($in);      # Separate words by the given code (default 32)
  $out = ttcutwbr($in);   # Separate words by <WBR> HTML tag
  @out = ttcut2list($in); # Separate words into an array

  # To separate words by an arbitrary string $sep, use
  $out = join($sep, ttcut2list($in));

  ttfixorder($str);       # Fix the order of alphabet/vowels in $str,
                          # also remove redundant toners/vowels 

=head1 AUTHOR

Vuthichai Ampornaramveth <vuthi@ctrl.titech.ac.jp>

=head1 SEE ALSO

http://thaigate.nacsis.ac.jp/

=cut
