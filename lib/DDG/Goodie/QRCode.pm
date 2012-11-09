package DDG::Goodie::QRCode;
# ABSTRACT: Generate a QR Code barcode.

use DDG::Goodie;
use HTML::Barcode::QRCode;
use HTML::Entities;

triggers start => 'qrcode', 'qr code', 'qr';
zci is_cached => 1;
zci answer_type => "qrcode";

attribution github => ['https://github.com/mstratman', 'mstratman'];
primary_example_queries 'qrcode http://ddg.gg';
description 'generate a QR code from your query';
name 'QRCode';
code_url 'https://github.com/duckduckgo/zeroclickinfo-goodie-qrcode/blob/master/lib/DDG/Goodie/QRCode.pm';
category 'computing_tools';
topics 'cryptography';

handle remainder => sub {
    my $html = HTML::Barcode::QRCode->new(text => $_)->render;
    $html = '<div style="float:left;margin-right:10px;">'.$html.'</div> A QR code that means \''.encode_entities($_).'\'. <div class="clear"></div>';
    return '', html => $html;
};

1;
