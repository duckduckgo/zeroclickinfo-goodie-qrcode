package DDG::Goodie::QRCode;
# ABSTRACT: Generate a QR Code barcode.

use DDG::Goodie;
use Imager::QRCode;
use Imager;
use HTML::Entities;
use MIME::Base64; 

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

my $qrcode = Imager::QRCode->new(
    size          => 4,
    margin        => 2,
    version       => 1,
    level         => 'M',
    casesensitive => 1,
    lightcolor    => Imager::Color->new(255, 255, 255),
    darkcolor     => Imager::Color->new(0, 0, 0),
);

die "No GIF support available; install giflib (libgif-dev in Debian)" unless $Imager::formats{gif};

handle remainder => sub {
    my $image = $qrcode->plot($_);
    my $raw;
    $image->write(data => \$raw, type => 'gif');
    my $data = encode_base64($raw);
    $data =~ s/\n//g;
    my $html = '<div style="float:left;margin-right:10px;"><img src="data:image/gif;base64,'.$data.'" alt="A QR Code" /></div> A QR code that means \''.encode_entities($_).'\'. <div class="clear"></div>';
    return '', html => $html;
};

1;
