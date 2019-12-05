#!/usr/bin/php -q
<?php
array_shift($argv);
$aIntCodes= preg_split('#,#',$argv[0]);

$position= 0;

$inst= array(1,2,5,6,7,8);
while (99 != $aIntCodes[$position]) {
    $pointeur=0;
    $opcode_raw= str_pad($aIntCodes[$position],5,0,STR_PAD_LEFT);
    // echo "ocr=$opcode_raw\n";
    $opcode= (int) substr($opcode_raw, -2);
    $aModes= array_reverse(str_split(substr($opcode_raw,0,3)));
    // echo "opcode=$opcode\n";
    // print_r($aModes);
    if(in_array($opcode, array(1,2,5,6,7,8))) {
       
        // echo $p1."(".(int)$aModes[0]."):$v1 [+*] ".$p2."(".(int)$aModes[1]."):$v2\n";
    } elseif(in_array($opcode, array(4))) {
        $p1= $aIntCodes[$position+1];
        $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];
    } else {
        $p1= $aIntCodes[$position+1];
    }
    $new_position= $position;
    switch ($opcode) {
        case '1':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            $position_cible= $aIntCodes[$position+3];

            $res=  $v1 + $v2;
            $aIntCodes[$position_cible]= $res;
            $pointeur=4;
            break;
        case '2':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            $position_cible= $aIntCodes[$position+3];

            $res=  $v1 * $v2;
            $aIntCodes[$position_cible]= $res;
            $pointeur=4;
            break;
        case '3':
            $p1= $aIntCodes[$position+1];
            $aIntCodes[$p1]= readline('?');
            $pointeur=2;
            break;
        case '4':
            $p1= $aIntCodes[$position+1];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1]; 
            echo $v1;
            $pointeur=2;
            break;
        case '5':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            if ($v1 != 0) {
                $new_position= $v2;
            } else {
                $pointeur=3;
            }
            break;
        case '6':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            if ($v1 == 0) {
                $new_position= $v2;
            } else {
                $pointeur=3;
            }
            break;
        case '7':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            $position_cible= $aIntCodes[$position+3];

            if ($v1 < $v2) {
                $aIntCodes[$position_cible]= 1;
            } else {
                $aIntCodes[$position_cible]= 0;
            }
            $pointeur=4;
            break;
        case '8':
            $p1= $aIntCodes[$position+1];
            $p2= $aIntCodes[$position+2];
            $v1= ($aModes[0] == 1) ? $p1 : $aIntCodes[$p1];   
            $v2= ($aModes[1] == 1) ? $p2 : $aIntCodes[$p2];
            $position_cible= $aIntCodes[$position+3];

            if ($v1 == $v2) {
                $aIntCodes[$position_cible]= 1;
            } else {
                $aIntCodes[$position_cible]= 0;
            }
            $pointeur=4;
            break;
        default:
            break;           
    }
    // print_r($aIntCodes);
    // print_r(implode(",",$aIntCodes));
    // readline('go');
    if($new_position == $position) {
        $position+= $pointeur;
    } else {
        $position= $new_position;
    }
}