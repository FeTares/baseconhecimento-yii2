<?php

namespace app\modules\baseConhecimento\models;

use Yii;

/**
 * This is the model class for table "categorias".
 *
 * @property string $id
 * @property string $nome
 * @property string $descricao
 */
class Categoria extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'categorias';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'nome', 'descricao'], 'required'],
            [['descricao'], 'string'],
            [['id'], 'string', 'max' => 36],
            [['nome'], 'string', 'max' => 100],
            [['id'], 'unique'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome' => 'Nome',
            'descricao' => 'Descricao',
        ];
    }
    
    /**
     * @return \yii\db\ActiveQuery
     */
    public function getNotas()
    {
        return $this->hasMany(Notas::className(), ['fk_categoria' => 'id']);
    }
}
