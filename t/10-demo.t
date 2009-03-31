use Test::More tests => 5;

use PDF::API2;
use PDF::TextBlock;

ok(my $pdf = PDF::API2->new( -file => "10-demo.pdf" ),   "PDF::API2->new()");
ok(my $tb  = PDF::TextBlock->new({
   pdf   => $pdf,
}),                                                   "new()");
ok(my ($endw, $ypos) = $tb->apply(),                  "apply()");

$tb->y($ypos);
$tb->text("Generated by t/10-demo.t");
$tb->fonts->{default}->fillcolor('darkblue');
ok($tb->apply(),                                      "apply()");


$pdf->save;    # Doesn't return true, even when it succeeds. -sigh-
$pdf->end;     # Doesn't return true, even when it succeeds. -sigh-
ok(-r "10-demo.pdf",                                  "10-demo.pdf created");

diag( "Testing PDF::TextBlock $PDF::TextBlock::VERSION, Perl $], $^X" );
