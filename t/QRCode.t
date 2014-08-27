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
	'qr http://facebook.com' => test_zci('', html => qr|<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,R0lGODlhdAB0AJEAAAAAAP.+QQEAOw==" alt="A QR Code" /></div>A QR code that means 'http://facebook\.com'\. <div class="clear"></div>|),
	'qr code https://ddg.gg' => test_zci('', html => qr|<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,R0lGODlhZABkAJEAAAAAAP.+KAkFAAA7" alt="A QR Code" /></div>A QR code that means 'https://ddg\.gg'\. <div class="clear"></div>|),
	'qr code "reader"' => test_zci('', html => qr|<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,R0lGODlhZABkAJEAAAAAAP.+owgUAAA7" alt="A QR Code" /></div>A QR code that means 'reader'\. <div class="clear"></div>|),
	'qr code of http://twitch.tv' => test_zci('', html => qr|<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,R0lGODlhdAB0AJEAAAAAAP.+SSntVAAA7" alt="A QR Code" /></div>A QR code that means 'http://twitch\.tv'\. <div class="clear"></div>|),
	'qr code reader' => undef,
	'qr code scanners!' => undef,
	'qr code    maker      ' => undef,
);

done_testing;
