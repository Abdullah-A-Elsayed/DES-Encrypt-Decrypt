use strict;
use warnings;
use List::MoreUtils 'first_index';

# input
my $in_out_sizes = <STDIN>;
chomp $in_out_sizes;

my $tbl = <STDIN>;
chomp $tbl;
# 
my @in_out_sizes_arr = split / /,$in_out_sizes;
my $tbl_size = $in_out_sizes_arr[1];
my $inv_size = $in_out_sizes_arr[0];
my @tbl_arr = split / /,$tbl;
my @inv_tbl = ();
my $irr = 0;
for (my $i=1; $i<=$inv_size; $i++){
    my $pos = first_index { /^$i$/ } @tbl_arr;
    if ($pos > -1){
        push @inv_tbl, $pos+1 ;
    }
    else{
        $irr = 1;
        last;
    }
}
if(!$irr){
    my $out = join " ", @inv_tbl;
    print ($out,"\n");
}
else{
    print("IMPOSSIBLE\n");
}