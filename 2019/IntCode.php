<?php
/**
 * Aoc2019 intcode
 * 
 * @category Aoc
 * @package  Aoc
 * @author   fte <fte+github@575.be>
 * @license  https://creativecommons.org/publicdomain/zero/1.0/ CC-0
 * @link     https://github.com/fte/adventofcode/tree/master/2019
 */

class IntCode
{

    public $code;

    public $position;

    public $relative_base= 0;

    public $input;

    public $instructionByOpcode= array(
        1 => array('name' => 'add', 'nb_params' => 2)
        ,2 => array('name' =>'mul', 'nb_params' => 2)
        ,3 => array('name' =>'read', 'nb_params' => 0)
        ,4 => array('name' => 'print', 'nb_params' => 1)
        ,5 => array('name' => 'jump-if-true','nb_params' => 1)
        ,6 => array('name' => 'jump-if-false','nb_params' => 1)
        ,7 => array('name' => 'less-than','nb_params' => 2)
        ,8 => array('name' => 'equals', 'nb_params' => 2)
        ,9 => array('name' => 'rebase', 'nb_params' => 1)
        ,99 => array('name' => 'exit', 'nb_params' => 0)
    );

    public $modes= array(
        0 => 'position', 1 => 'immediate', 2 => 'relative'
    );

    /**
     * IntCode constructor.
     */
    public function __construct($code, $input= array())
    {
        $this->code= $code;
        $this->position= 0;
        $this->input= $input;
    }

    /**
     * Get the value
     * 
     * @param  current_mode $cur_mode : integer
     * @param  param        $param    : param
     * @return value
     */
    public function handleParam($cur_mode, $param) 
    {
        $mode= $this->modes[$cur_mode];
        switch($mode) {
        case 'position':
            $v= $this->code[$param];
            break;
    
        case 'immediate':
            $v= $param;
            break;
            
        case 'relative':
            $v= $this->code[$this->relative_base + $param];
            break;
        default:
            $v= null;
            break;
        }
        // echo " $param $mode v=$v\n";

        return $v;
    }

    /**
     * 
     */
    public function writeTo($cur_mode,$pos,$val)
    {
        if($pos < 0) {
            $pos= 0;
        }
        $mode= $this->modes[$cur_mode];
        switch($mode) {
        case 'position':
            $position_cible= $this->code[$this->position + $pos];
            $this->code[$position_cible]= $val;
            
            break;
    
        case 'immediate':
            $position_cible= $this->position + $pos;
            $this->code[$position_cible]= $val;
            break;
            
        case 'relative':
            $position_cible= $this->code[$this->position + $pos] + $this->relative_base;
            $this->code[$position_cible]= $val;
            break;
        default:
            $v= null;
            break;
        }
        // echo "\t $mode v=$val:::pos=$position_cible";
    }

    /**
     * 
     */
    public function compute($input= array())
    {
        $this->input = array_merge($this->input, $input);
        while ($this->position < count($this->code)) {
            $pointeur=0;
            $aIntCodes= & $this->code;
            $position= & $this->position;
            $new_position= $position;
            $opcode_raw= str_pad($aIntCodes[$position], 5, 0, STR_PAD_LEFT);
            
            // echo "ocr=$opcode_raw pos=".$this->position." rel=".$this->relative_base;
            
            $opcode= (int) substr($opcode_raw, -2);
            $instruction= $this->instructionByOpcode[$opcode]['name'];
            $nb_params= $this->instructionByOpcode[$opcode]['nb_params'];
            $aModes= array_reverse(str_split(substr($opcode_raw, 0, 3)));
            
            // echo "\t*$instruction*\tp1:".$aIntCodes[$position+1]."(".$this->modes[$aModes[0]].")";
            // if ( isset($aIntCodes[$position+2]) ) {
            //     echo ",\tp2:".$aIntCodes[$position+2]."(".$this->modes[$aModes[1]].")";
            // }
            // if ( isset($aIntCodes[$position+3]) ) {
            //     echo ",\tp3:".$aIntCodes[$position+3]."(".$this->modes[$aModes[2]].")";
            // }
            
            switch ($instruction) {
            case 'add':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                
                $this->writeTo($aModes[2], $nb_params+1, $v1 + $v2);
                $pointeur= $nb_params + 2;
                break;
            case 'mul':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                $this->writeTo($aModes[2], $nb_params+1, $v1 * $v2);
                $pointeur= $nb_params + 2;
                break;
            case 'read':
                if (count($this->input) == 0) {
                    $r= readline('?');
                } else {
                    $r= array_shift($this->input);
                }
                $this->writeTo($aModes[0], $nb_params+1, $r);
                $pointeur= 2;
                break;
            case 'print':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $position+= 2;
                return $v1;
                break;
            case 'jump-if-true':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                
                if ($v1 != 0) {
                    $new_position= $v2;
                } else {
                    $pointeur=3;
                }
                break;
            case 'jump-if-false':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                if ($v1 == 0) {
                    $new_position= $v2;
                } else {
                    $pointeur=3;
                }
                break;
            case 'less-than':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                if ($v1 < $v2) {
                    $this->writeTo($aModes[2], $nb_params+1, 1);
                } else {
                    $this->writeTo($aModes[2], $nb_params+1, 0);
                }
                $pointeur=4;
                break;
            case 'equals':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $v2= $this->handleParam($aModes[1], $aIntCodes[$position+2]);
                $position_cible= $aIntCodes[$position+3];
                if ($v1 == $v2) {
                    $this->writeTo($aModes[2], $nb_params+1, 1);
                } else {
                    $this->writeTo($aModes[2], $nb_params+1, 0);
                }
                $pointeur=4;
                break;
            case 'rebase':
                $v1= $this->handleParam($aModes[0], $aIntCodes[$position+1]);
                $this->relative_base+= $v1;
                $pointeur=2;
                break;
                
            case 'exit':
                // print_r($this->code);
                return null;

                    break;
            default:
                return null;
                    break;           
            }
            // echo "\n";
            if ($new_position == $position) {
                $position+= $pointeur;
            } else {
                $position= $new_position;
            }
        }
    }

}