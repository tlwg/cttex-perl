# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use ttool;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$foo = "Hello สวัสดีครับ สบายดีหรือเปล่าครับ";
print "Test String = $foo\n";
print "Space       = ",ttcut($foo),"\n";
ttsetcode(65);
print "Letter A    = ",ttcut($foo),"\n";
print "Hyphen      = ",join("-",ttcut2list($foo)),"\n";
print "<WBR>       = ",ttcutwbr($foo),"\n";
print "Letter A    = ",ttcut($foo),"\n";

$foo1 = "วันท่ี";  # Wrong Order
$foo2 = "วันที่";
print $foo1 eq $foo2 ? "not ok 3\n":"ok 3\n";
ttfixorder($foo1);
print $foo1 eq $foo2 ? "ok 4\n":"not ok 4\n";
