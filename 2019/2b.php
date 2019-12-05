#!/usr/bin/php -q
<?php
array_shift($argv);
$aIntCodes= preg_split('#,#',$argv[0]);

function compute($aIntCodes) {
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
    
    return $aIntCodes[0];
}

function resetMemory($aIntCodes, $noun, $verb) {
    $aIntCodes[1]= $noun;
    $aIntCodes[2]= $verb;

    return $aIntCodes;
}

for($noun=0;$noun<=99;$noun++) {
    for($verb=0;$verb<=99;$verb++) {
        $newMemory= resetMemory($aIntCodes, $noun,$verb);
        $output= compute($newMemory);
        if(19690720 == $output) {
            echo "noun=$noun verb=$verb\n";
            echo 100*$noun + $verb."\n";
        }
    }
}