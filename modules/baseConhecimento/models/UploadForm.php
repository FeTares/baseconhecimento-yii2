<?php
namespace app\modules\baseConhecimento\models;

use yii\base\Model;
use yii\web\UploadedFile;
use Ramsey\Uuid\Uuid;

class UploadForm extends Model
{
    /**
     * @var UploadedFile
     */
    public $file;
    public $pathImagem = "/var/www/html/baseconhecimento/web/img/uploads/";
    public $pathPublicImagem = "img/uploads/";

    public function rules()
    {
        return [
            [['file'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg, jpeg, gif, csv'],
        ];
    }
    
    public function upload()
    {
        $uuid = Uuid::uuid1();
        $this->pathPublicImagem .= $uuid;
        $this->pathImagem .= $uuid;
        mkdir($this->pathImagem);
        if ($this->validate()) {
            $this->pathImagem .= '/' . $this->file->baseName . '.' . $this->file->extension;
            $this->pathPublicImagem .= '/' . $this->file->baseName . '.' . $this->file->extension;
            $this->file->saveAs($this->pathImagem);
            return true;
        } else {
            return false;
        }
    }
}