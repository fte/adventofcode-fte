#!/usr/bin/php -q
<?php
array_shift($argv);
$aIntCodes= preg_split('#,#',$argv[0]);

$position= 0;
while (99 != $aIntCodes[$position]) {
    $p1= $aIntCodes[$position+1];
    $p2= $aIntCodes[$position+2];

    $position_cible= $aIntCodes[$position+3];
    
    switch ($aIntCodes[$position]) {
        case '1':
            $res= $aIntCodes[$p1] + $aIntCodes[$p2];
            break;
        case '2':
            $res= $aIntCodes[$p1] * $aIntCodes[$p2];
            break;
        default:
            break;           
    }
    $aIntCodes[$position_cible]= $res;

    $position+=4;
}
echo implode(',',$aIntCodes)."\n";