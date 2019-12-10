#!/usr/bin/php -q
<?php
array_shift($argv);
$programme = $argv[0];


// https://stackoverflow.com/questions/5506888/permutations-all-possible-sets-of-numbers
// like bash shuf -e {5..9}{5..9}{5..9}{5..9}{5..9}|grep -vE "(.).*\1{1,}"| sed -E "s/(.)/\1 /g"
function permutations($input, $path)
{
    // base case 1
    if (count($input) == 0) {
        return [$path];
    }

    $output = [];
    foreach ($input as $index => $num) {     # 1, 2,3, 4
        $copyPath = $path; # copy the path - []
        $copyPath[] = $num;  # append the number [1]

        # remove the current number
        $inputLocal = $input;
        unset($inputLocal[$index]); # [2, 3, 4]
        $permute = permutations($inputLocal, $copyPath); # call [2, 3, 4], [1]

        # for all element find add to output
        foreach ($permute as $ele) {
            # filter ouput
            // $output[] = filterElement($ele);
            $output[] = $ele;
        }
    }

    return $output;
}

$permuts = permutations([9, 8, 7, 6, 5], []);


$descriptorspec = array(
    0 => array("pipe", "r"),
    1 => array("pipe", "w"),
    2 => array("pipe", "w")
);

$pipes = array();
$procs = array();
// $stdouts= array();
$aNomsAmplisAssoc = array(0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e');
$aNomsAmplis = array_values($aNomsAmplisAssoc);

$ampli = './5b.php "' . $programme . '"';
// $ampli= './5b.php "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"';
// echo "$ampli\n"; die();

$max = 0;
foreach ($permuts as $sequence) {
    // print_r($sequence);
    // readline('dazd');
    $pipes = array();
    foreach ($aNomsAmplis as $nom) {
        $procs[$nom] = proc_open(
            $ampli,
            $descriptorspec,
            $pipes[$nom]
        );
    }

    $stdout = 0;

// $sequence= array(9,8,7,6,5);
// $sequence= array(4,3,2,1,0);
// $sequence= array(9,8,7,6,5);
// $sequence= [9,7,8,5,6];
    foreach ($sequence as $num_amp => $seq) {
        $nom_amp = $aNomsAmplisAssoc[$num_amp];
        echo implode($sequence) . " ampli=$nom_amp num_sequence=$seq entree=$stdout";
        fwrite($pipes[$nom_amp][0], "$seq\n$stdout\n");
        $stdout = fread($pipes[$nom_amp][1], 1024);
        echo " sortie=$stdout\n";
    }

    while (true) {

        foreach ($sequence as $num_amp => $seq) {
            $nom_amp = $aNomsAmplisAssoc[$num_amp];
            $status = proc_get_status($procs[$nom]); // print_r($status);
            $running = $status['running'];
            echo implode($sequence) . " ampli=$nom_amp entree=$stdout";
            fwrite($pipes[$nom_amp][0], "$stdout\n");
            $status = proc_get_status($procs[$nom]); // print_r($status);
            $running = $status['running'];
            // if($status['running'] != 1) {
            //     break 1;
            // }
            $stdout = fread($pipes[$nom_amp][1], 1024);
            // if(!$stdout) {
            //     break 1;
            // }
            echo " sortie=$stdout\n";
            if (!$stdout) {
                break 2;
            }
            if ($stdout > $max) {
                $max = $stdout;
            }
            // var_dump($stdout);

        }
    }

    foreach ($aNomsAmplis as $nom) {
        fclose($pipes[$nom][0]);
        fclose($pipes[$nom][1]);
        fclose($pipes[$nom][2]);
        $exit_status = proc_close($procs[$nom]);
        // echo "$nom : $exit_status\n";
    }

}
echo "max=$max";

