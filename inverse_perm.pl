use strict;
use warnings;
use List::MoreUtils 'first_index';

# input
my $tbl_size = <STDIN>;
my $tbl = <STDIN>;
chomp $tbl_size;
chomp $tbl;
# 
my @tbl_arr = split / /,$tbl;
my @inv_tbl = ();
my $irr = 0;
for (my $i=1; $i<=$tbl_size; $i++){
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