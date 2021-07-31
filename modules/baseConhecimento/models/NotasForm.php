<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

namespace app\modules\baseConhecimento\models;

use yii;
use yii\base\Model;
use yii\web\UploadedFile;
use Ramsey\Uuid\Uuid;
use app\modules\baseConhecimento\models\File;

/**
 * Description of NotasForm
 *
 * @author root
 */
class NotasForm extends Model {
    public $id;
    public $titulo;
    public $conteudo;
    public $fk_categoria;
    /**
     * @var UploadedFile[]
     */
    public $files;
    public $pathFile = "/var/www/html/baseconhecimento/web/files/";
    public $pathPublicFile = "files/";


    public function rules() {
        return[
            [['titulo','conteudo','fk_categoria'],'required','message'=>'Por favor, preencha o campo {attribute}.'],
            [['files'], 'file', 'skipOnEmpty' => true, 'maxFiles' => 5, 'maxSize' => 1024*1024*1024*20],
            [['titulo'],'string', 'max'=>100]
        ];
    }
    
    public function upload()
    {
        if ($this->validate()) { 
            foreach ($this->files as $file) {
                $uuid = Uuid::uuid1()->__toString();
                mkdir($this->pathFile . $uuid);
                //$this->pathFile .= '/'.$file->baseName . '.' . $file->extension;
                $file->saveAs($this->pathFile . $uuid .'/'. $file->baseName . '.' . $file->extension);
                $f = new File();
                $f->id = $uuid;
                $f->nome_arquivo = $file->baseName . '.' . $file->extension;
                $f->path = $this->pathPublicFile . $uuid .'/'. $file->baseName . '.' . $file->extension;
                $f->type = $file->type;
                $f->size = $file->size;
                $f->fk_notas = $this->id;
                //$f->data_criacao = null;
                if(!$f->validate()) return false;
                $f->save();
            }
            return true;
        } else {
            return false;
        }
    }
}
