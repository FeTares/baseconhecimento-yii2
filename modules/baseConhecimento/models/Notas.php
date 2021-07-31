<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\modules\baseConhecimento\models;

use yii\db\ActiveRecord;

/**
 * Description of Notas
 *
 * @author root
 */
class Notas extends ActiveRecord {
    
    public function getCriadoPor() {
        return $this->hasOne(\app\models\User::className(),['id' => 'criado_por']);
    }
    
    public function getAtualizadoPor() {
        return $this->hasOne(\app\models\User::className(), ['id' => 'atualizado_por']);
    }
    
    public function getCategoria() {
        return $this->hasOne(\app\modules\baseConhecimento\models\Categoria::className(), ['id' => 'fk_categoria']);
    }
    
    public function getFiles() {
        return \app\modules\baseConhecimento\models\File::find()->where(['fk_notas' => $this->id])->all();
    }
}
