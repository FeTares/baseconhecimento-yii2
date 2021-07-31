<?php

namespace app\modules\baseConhecimento\models;

use Yii;

/**
 * This is the model class for table "files".
 *
 * @property string $id
 * @property string $nome_arquivo
 * @property string $path
 * @property string $type
 * @property int $size
 * @property string $data_criacao
 * @property string $fk_notas
 *
 * @property Notas $fkNotas
 */
class File extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'files';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'nome_arquivo', 'path', 'type', 'fk_notas'], 'required'],
            [['path'], 'string'],
            [['size'], 'integer'],
            [['data_criacao'], 'safe'],
            [['id', 'fk_notas'], 'string', 'max' => 36],
            [['nome_arquivo', 'type'], 'string', 'max' => 255],
            [['id'], 'unique'],
            [['fk_notas'], 'exist', 'skipOnError' => true, 'targetClass' => Notas::className(), 'targetAttribute' => ['fk_notas' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'nome_arquivo' => 'Nome Arquivo',
            'path' => 'Path',
            'type' => 'Type',
            'size' => 'Size',
            'data_criacao' => 'Data Criação',
            'fk_notas' => 'Nota',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getNotas()
    {
        return $this->hasOne(Notas::className(), ['id' => 'fk_notas']);
    }
}
