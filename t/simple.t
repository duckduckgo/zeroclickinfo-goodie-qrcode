#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use DDG::Test::Goodie;

zci answer_type => 'qrcode';
zci is_cached => 1;

ddg_goodie_test(
	[qw(
		DDG::Goodie::QRCode
	)],
	'qrcode https://duckduckgo.com/' => test_zci('', html => qr|<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,R0lGODlhdAB0AJEAAAAAAP.+UAAAOw==" alt="A QR Code" /></div>A QR code that means 'https://duckduckgo\.com/'\. <div class="clear"></div>|),
);

done_testing;
