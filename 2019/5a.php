#!/usr/bin/php -q
<?php
array_shift($argv);
$aIntCodes= preg_split('#,#',$argv[0]);

$position= 0;

while (99 != $aIntCodes[$position]) {
    $pointeur=0;
    $opcode_raw= str_pad($aIntCodes[$position],5,0,STR_PAD_LEFT);
    // echo "ocr=$opcode_raw\n";
    $opcode= (int) substr($opcode_raw, -2);
    $aModes= array_reverse(str_split(substr($opcode_raw,0,3)));
    // echo "opcode=$opcode\n";
    // print_r($aModes);

    if(in_array($opcode, array(1,2))) {
        $p1= $aIntCodes[$position+1];
        $p2= $aIntCodes[$position+2];
        $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
        $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
        $position_cible= $aIntCodes[$position+3];
        // echo $p1."(".(int)$aModes[0]."):$v1 [+*] ".$p2."(".(int)$aModes[1]."):$v2\n";
        $pointeur=4;
    } else {
        $p1= $aIntCodes[$position+1];
        $pointeur=2;
    }

    switch ($opcode) {
        case '1':
            $res=  $v1 + $v2;
            $aIntCodes[$position_cible]= $res;
            break;
        case '2':
            $res=  $v1 * $v2;
            $aIntCodes[$position_cible]= $res;
            break;
        case '3':
            $aIntCodes[$p1]= readline('?');
            break;
        case '4':
            echo $aIntCodes[$p1];
            break;
        default:
            break;           
    }
    // print_r($aIntCodes);
    $position+=$pointeur;
}