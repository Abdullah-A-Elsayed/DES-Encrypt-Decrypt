use strict;
use warnings;

my $tbl_size = <STDIN>;
my $tbl = <STDIN>;
my $input_size = <STDIN>;
my $input_hexa = <STDIN>;

chomp $tbl_size;
chomp $tbl;
chomp $input_size;
chomp $input_hexa;

my @tbl_arr = split / /,$tbl;
my $input_bin = sprintf("%0${input_size}b",hex($input_hexa));
my @input_arr = split //,$input_bin;
my $out_bin = '';

for (my $i=0; $i < $tbl_size; $i++) {
    $out_bin.= $input_arr [ $tbl_arr[$i] - 1 ] ;
}

my $out_hex = sprintf("%X",oct("0b$out_bin"));
print($out_hex,"\n");