<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\modules\baseConhecimento\models;

use yii;
use yii\base\Model;

/**
 * Description of NotasForm
 *
 * @author root
 */
class BuscaForm extends Model {
    public $busca;
    
    public function rules() {
        return[
            [['busca'],'required','message'=>'Por favor, informe o que deseja procurar!']
        ];
    }
}
