use strict;
use warnings;

# tables =============
our @IP = (58, 50, 42, 34, 26, 18, 10, 2, 60, 52, 44, 36, 28, 20, 12, 4, 62, 54, 46, 38, 30, 22, 14, 6, 64, 56, 48, 40, 32, 24, 16, 8, 57, 49, 41, 33, 25, 17, 9, 1, 59, 51, 43, 35, 27, 19, 11, 3, 61, 53, 45, 37, 29, 21, 13, 5, 63, 55, 47, 39, 31, 23, 15, 7);
our @IP_i = (40, 8, 48, 16, 56, 24, 64, 32, 39, 7, 47, 15, 55, 23, 63, 31, 38, 6, 46, 14, 54, 22, 62, 30, 37, 5, 45, 13, 53, 21, 61, 29, 36, 4, 44, 12, 52, 20, 60, 28, 35, 3, 43, 11, 51, 19, 59, 27, 34, 2, 42, 10, 50, 18, 58, 26, 33, 1, 41, 9, 49, 17, 57, 25);
our @PC1 = (57, 49, 41, 33, 25, 17, 9, 1, 58, 50, 42, 34, 26, 18, 10, 2, 59, 51, 43, 35, 27, 19, 11, 3, 60, 52, 44, 36, 63, 55, 47, 39, 31, 23, 15, 7, 62, 54, 46, 38, 30, 22, 14, 6, 61, 53, 45, 37, 29, 21, 13, 5, 28, 20, 12, 4 );
our @PC2 = (14, 17, 11, 24, 1, 5, 3, 28, 15, 6, 21, 10, 23, 19, 12, 4, 26, 8, 16, 7, 27, 20, 13, 2, 41, 52, 31, 37, 47, 55, 30, 40, 51, 45, 33, 48, 44, 49, 39, 56, 34, 53, 46, 42, 50, 36, 29, 32 );
our @ROTS = (1, 1, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 1 );
our @s_box = ([
  [14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7],
  [0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8],
  [4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0],
  [15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13],
  ],
  [[15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10],
  [3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5],
  [0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15],
  [13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9],
  ],
  [[10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8],
  [13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1],
  [13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7],
  [1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12],
  ],
  [[7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15],
  [13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9],
  [10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4],
  [3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14],
  ],
  [[2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9],
  [14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6],
  [4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14],
  [11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3],
  ],
  [[12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11],
  [10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8],
  [9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6],
  [4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13],
  ],
  [[4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1],
  [13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6],
  [1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2],
  [6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12],
  ],
  [[13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7],
  [1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2],
  [7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8],
  [2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11],
  ]
);
our @EP = (32, 1, 2, 3, 4, 5, 4, 5, 6, 7, 8, 9, 8, 9, 10, 11, 12, 13, 12, 13, 14, 15, 16, 17, 16, 17, 18, 19, 20, 21,20, 21, 22, 23, 24, 25, 24, 25, 26, 27, 28, 29, 28, 29, 30, 31, 32, 1);
our @SP = (16, 7, 20, 21, 29, 12, 28, 17, 1, 15, 23, 26, 5, 18, 31, 10, 2, 8, 24, 14, 32, 27, 3, 9, 19, 13, 30, 6, 22, 11, 4, 25);
#======================
my $long_key_hexa = <STDIN> ;
chomp $long_key_hexa;

my $long_plain_hexa = <STDIN> ;
chomp $long_plain_hexa;

my $repeat = <STDIN> ;
chomp $repeat;

my $enc = &multi_encrypt ($long_key_hexa , $long_plain_hexa , 16, $repeat);
print $enc."\n";

#====== Functions ======================:

#=== des fn ======
sub multi_encrypt{
    my ($long_key_hexa , $long_plain_hexa , $rounds , $repeat) = @_;
    for (my $i=0; $i<$repeat ; $i++){
        $long_plain_hexa = &encrypt ($long_key_hexa , $long_plain_hexa , 16);
    }
    return $long_plain_hexa;
}
sub encrypt{
    my ($long_key_hexa , $long_plain_hexa , $rounds) = @_;
    #IP
    my $long_plain_bin = &perm($long_plain_hexa,@IP); #64 bit bin
    $long_plain_hexa = BigIntTo ("hex", 64 ,"0b$long_plain_bin"); #16 bit hexa
    #
    my @round_keys = &gen_keys ($long_key_hexa , $rounds);
    # print "test: ".$round_keys[5]."\n";
    #
    my $LH = substr $long_plain_hexa, 0 , 8;
    my $RH = substr $long_plain_hexa, 8;
    # print $long_plain_hexa."\n";
    # print "============================\n";
    for (my $i=0; $i<$rounds ; $i++){
        my $fn = &des_fn($RH, $round_keys[$i]);
        my $temp = $RH;
        # print "XORING: ".$LH."\n";
        # print "        ".$fn."\n";
        $RH = &xor_hexa($LH , $fn);
        # print "        ".$RH."\n";
        $LH = $temp;
        # print "after round ".($i+1).", LH: ".$LH."  RH: ".$RH."\n";
    }
    my $cipher = $RH . $LH;
    # IP_inverse
    $cipher = &perm($cipher,@IP_i); #64 bit bin
    $cipher = BigIntTo ("hex", 64 ,"0b$cipher"); #16 bit hexa
    # print $cipher."\n";
    return $cipher;
}
sub des_fn{
    #takes up to 8 bit hex plain, up to 12 bit hex key -> returns hexa
    my ($plain_hexa, $key_hexa) = @_;
    $plain_hexa = sprintf("%08s",$plain_hexa);
    $key_hexa = sprintf("%012s",$key_hexa);
    #
    my $permuted_bin = &perm($plain_hexa,@EP); #48 bit bin
    my $key_bin = &BigIntTo("bin", 48  , "0x$key_hexa");
    my $xor_res = &xor($key_bin, $permuted_bin);
    my $sbox_res = &get_whole_sbox($xor_res); #hexadecimal
    my $straight_permuted = &perm($sbox_res,@SP);
    my $fn = &BigIntTo("hex",  32  , "0b$straight_permuted");
    return $fn;
}

sub get_whole_sbox {
    my ($bin_str) = @_;
    my $out = '';
    for (my $i=0; $i<48; $i+=6){
        use integer;
        $out.= &s_box_dealer($i/6,(substr $bin_str, $i,6));
    }
    return $out;
}
sub s_box_dealer {
    my($box_index, $str) = @_;
    my $row = (substr $str, 0, 1) . (substr $str , 5,1) ;
    my $col = substr $str, 1, 4 ;
    my $n = $s_box[$box_index][oct("0b$row")][oct("0b$col")];
    return sprintf("%X",$n);
}

sub xor_hexa{
    #2 strings must be equal length and hexa:
    my ($st1,$st2) = @_;
    my $bin1 = BigIntTo ("bin", length($st1)*4 ,"0X$st1");
    my $bin2 = BigIntTo ("bin", length($st2)*4 ,"0X$st2");
    my $xored_bin = &xor ($bin1 , $bin2);
    my $res = BigIntTo ("hex", length($xored_bin) ,"0b$xored_bin");
    return $res;
}
sub xor{
    #2 strings must be equal length and binary:
    my ($st1,$st2) = @_;
    my $len = length($st1);
    my $out = '';
    for (my $i=0; $i < $len; $i++){
        if((substr $st1, $i, 1) ne (substr $st2, $i, 1)){
            $out.="1";
        }
        else{
            $out.="0";
        }
    }
    return $out;
}

#================

sub gen_keys{
    my ($key , $rounds) = @_;
    #perm (hexa) -> bin;
    my $pc1_bin = &perm ($key , @PC1);
    $key = $pc1_bin;

    my @keys = ();
    for (my $i=0;$i < $rounds; $i++){
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
