use Test::More tests => 5;

# Bold some words and hyperlink a few other things

use PDF::API2;
use PDF::TextBlock;

ok(my $pdf = PDF::API2->new( -file => "40-demo.pdf" ),   "PDF::API2->new()");
ok(my $tb  = PDF::TextBlock->new({
   pdf       => $pdf,
   fonts     => {
      b => PDF::TextBlock::Font->new({
         pdf  => $pdf,
         font => $pdf->corefont( 'Helvetica-Bold',    -encoding => 'latin1' ),
      }),
   },
}),                                                   "new()");
ok($tb->text(
   $tb->garbledy_gook . 
   ' <b>This fairly lengthy</b>, rather verbose sentence <b>is tagged</b> to appear ' .
   'in a <b>different font, specifically the one we tagged b for "bold".</b> ' .
   $tb->garbledy_gook . 
   ' <href="http://www.omnihotels.com">Click here to visit Omni Hotels.</href> ' .
   $tb->garbledy_gook . "\n\n" . 
   "New paragraph.\n\n" .
   "Another paragraph."
),                                                    "text()");
ok(($endw, $ypos) = $tb->apply(),                     "apply()");


$pdf->save;    # Doesn't return true, even when it succeeds. -sigh-
$pdf->end;     # Doesn't return true, even when it succeeds. -sigh-
ok(-r "40-demo.pdf",                                  "40-demo.pdf created");

diag( "Testing PDF::TextBlock $PDF::TextBlock::VERSION, Perl $], $^X" );



