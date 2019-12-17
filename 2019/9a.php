#!/usr/bin/php -q
<?php
/**
 * Intcode
 */
require dirname(__FILE__).'/IntCode.php';

array_shift($argv);
$aIntCodes= preg_split('#,#', $argv[0]);

$intcode= new IntCode($aIntCodes, array(1));
// $intcode= new IntCode($aIntCodes);
$out= array();

$i=0;
do {
    $i+=1;
    // echo "i=$i\n";
    $output= $intcode->compute();
    echo " output=$output\n";
    $out[] = $output;

    // if($intcode->position < 300) die();

} while ($output !== null);

echo implode('', $out);
