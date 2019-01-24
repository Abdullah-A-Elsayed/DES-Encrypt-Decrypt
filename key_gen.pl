use strict;
use warnings;

# tables =============
our @PC1 = (57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 27, 19, 11, 3, 60, 52, 44, 36, 63, 55, 47, 39, 31, 23, 15, 7, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 28, 20, 12, 4 );
our @PC2 = (14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2, 41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32 );
our @ROTS = (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1 );
#======================
my $key = <STDIN>;
chomp $key;
#
my @keys = &gen_keys($key);
print((join "\n", @keys ), "\n");
#====== Functions:

sub gen_keys{
    my ($key) = @_;
    #perm (hexa) -> bin;
    my $pc1_bin = &perm ($key , @PC1);
    $key = $pc1_bin;

    my @keys = ();
    for (my $i=0;$i < 16; $i++){
        $key = &circulate_2_halfs($i,$key);
        # pc2 kexa -> bin
        my $key_hexa = BigIntTo("hex" , length($key) , "0b$key");
        my $round_key = &perm ($key_hexa , @PC2);
        $round_key = BigIntTo("hex" , length($round_key) , "0b$round_key");
        push @keys, $round_key;
    }
    return @keys;
}

sub circulate_2_halfs{
    my ($round , $key) = @_;
    my $div_len = length($key) / 2;
    my $half1 = substr $key, 0, $div_len ;
    my $half2 = substr $key, $div_len ;
    my $res1 = &circulate($round, $half1);
    my $res2 = &circulate($round, $half2);
    my $out = $res1.$res2;
    return $out;
}

sub circulate {
    my ($round , $key) = @_;
    for (my $i=0;$i < $ROTS[$round]; $i++){
        $key = (substr $key, 1) . (substr $key, 0 , 1);
    }
    return $key;
}

sub BigIntTo{
    # fills zeros if mode in = mode out
    # converts at equal lengths
    my ($mode, $max_len ,$int_str) = @_;
    $max_len = ($mode eq "bin")? $max_len : $max_len/4 ; #used at filling
    my $half_max_len =  $max_len / 2 ; #used at filling
    my $in_mode = ( (substr $int_str,0,2) eq "0b" )? "bin" : "hex";
    if ($mode eq $in_mode){
        return sprintf("%0${$max_len}s",(substr $int_str, 2));
    }
    my $div_len = (length($int_str) - 2) / 2 ;
    my $div1 = substr $int_str, 2, $div_len;
    my $div2 = substr $int_str, 2 + $div_len;

    my $res1 = '';
    my $res2 = '';
    if ($mode eq "bin"){
        $res1 = sprintf("%0${half_max_len}b",hex($div1));
        $res2 = sprintf("%0${half_max_len}b",hex($div2));
    }
    else{
        $res1 = sprintf("%0${half_max_len}X",oct("0b$div1"));
        $res2 = sprintf("%0${half_max_len}X",oct("0b$div2"));
    }
    my $out = $res1 . $res2;
    return $out;
}
sub perm {
    my ($input_hexa, @tbl_arr) = @_;
    my $input_size = length($input_hexa)*4;
    my $tbl_size = scalar @tbl_arr;
    # my $input_bin = sprintf("%0${input_size}b",hex($input_hexa));
    my $input_bin = BigIntTo("bin" , $input_size , "0X$input_hexa");
    my @input_arr = split //,$input_bin;
    my $out_bin = '';

    for (my $i=0; $i < $tbl_size; $i++) {
        $out_bin.= $input_arr [ $tbl_arr[$i] - 1 ] ;
    }
    return $out_bin;
}
