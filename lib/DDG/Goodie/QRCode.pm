package DDG::Goodie::QRCode;
# ABSTRACT: Generate a QR Code barcode.

use DDG::Goodie;
use HTML::Barcode::QRCode;
use HTML::Entities;

triggers start => 'qrcode', 'qr code';
zci is_cached => 1;
zci answer_type => "qrcode";

handle remainder => sub {
    my $html = HTML::Barcode::QRCode->new(text => $_)->render;
    $html = '<div style="float:left;margin-right:10px;">'.$html.'</div> A QR code that means \''.encode_entities($_).'\'. <div class="clear"></div>';
    return '', html => $html;
};

1;
