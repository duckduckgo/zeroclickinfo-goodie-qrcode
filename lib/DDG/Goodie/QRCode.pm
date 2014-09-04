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

my @skip_words = ('reader', 'generator', 'scanner' ,'maker', 'creator', 'builder');

my $qrcode = Imager::QRCode->new(
    size          => 4,
    margin        => 2,
    version       => 1,
    level         => 'M',
    casesensitive => 1,
    lightcolor    => Imager::Color->new(255, 255, 255),
    darkcolor     => Imager::Color->new(0, 0, 0),
);

die "No GIF support available; install giflib (libgif-dev in Debian), and then install Imager (to be built with GIF support)." unless $Imager::formats{gif};

sub html_output {
    my ($data, $string) = @_;
    return '<div style="float:left;margin-right:10px;">'
            .'<img src="data:image/gif;base64,'.$data.'" alt="A QR Code" /></div>'
            .'A QR code that means \''.encode_entities($_).'\'. '
            .'<div class="clear"></div>';
}

handle remainder => sub {
    s/^(of|for) (.*)$/$2/;    # Remove of or for in queries like 'qr of http://ddg.gg'
    my $var = $_;
    return if grep { $var =~ /^[^\w"']*\b($_)s?\b[^"'\w]*$/ } @skip_words;    # Skip queries like readers, scanner? etc
    s/^("|')(.*)("|')$/$2/;    # Remove quotes from queries like 'qr "reader"' to ignore skipped words
    if (/^\s*(.*)\s*$/) {
        return unless $1;
        my $str = $1;
        my $image = $qrcode->plot($str);
        my $raw;
        $image->write(data => \$raw, type => 'gif');
        my $data = encode_base64($raw);
        $data =~ s/\n//g;
        return '', html => html_output($data, $str);
    }
};

1;
