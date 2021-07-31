<?php

namespace app\modules\baseConhecimento\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use app\modules\baseConhecimento\models\BuscaForm;
use app\modules\baseConhecimento\models\Notas;
use app\modules\baseConhecimento\models\NotasForm;
use app\modules\baseConhecimento\models\UploadForm;
use app\modules\baseConhecimento\models\File;
use app\modules\baseConhecimento\models\Categoria;
use yii\web\UploadedFile;
use app\models\User;
use Ramsey\Uuid\Uuid;
use yii\helpers\Url;
use yii\db\Query;
use yii\web\ForbiddenHttpException;
use yii\base\InvalidArgumentException;

/**
 * Default controller for the `baseCaonhecimento` module
 */
class DefaultController extends Controller
{
    /**
    * {@inheritdoc}
    */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['index','editar','excluir','novo','upload'],
                'rules' => [
                    /*[
                        'actions' => ['login'],
                        'allow' => true,
                        'roles'=>['?','@'],
                    ],
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@']
                    ],*/
                    [
                        'actions' => ['index'],
                        'allow' => true,
                        'roles' => ['Todos']
                    ],
                    [
                        'actions' => ['novo'],
                        'allow' => true,
                        'roles' => ['PROJ.Assumir solicitacao']
                    ],
                    [
                        'actions' => ['editar'],
                        'allow' => true,
                        'roles' => ['Desenvolvimento']
                    ],
                    [
                        'actions' => ['excluir'],
                        'allow' => true,
                        'roles' => ['Todos']
                    ],
                    [
                        'actions' => ['upload'],
                        'allow' => true,
                        'roles' => ['?','@']
                    ],
                    [
                        'actions' => ['excluir-anexo'],
                        'allow' => true,
                        'roles' => ['?','@']
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    public function beforeAction($action)
    {
        if($action->id =='upload')
        {
            $this->enableCsrfValidation = false;
        }
        //return true;
        return parent::beforeAction($action);
    }
    /**
     * Renders the index view for the module
     * @return string
     */
    public function actionIndex()
    {
        $model = new BuscaForm();
        $categorias = Categoria::find()->all();
        if($model->load(Yii::$app->request->get()) && $model->validate()) {
            $query = new Query();
            $query->select(['n.id', 'n.titulo', 'n.conteudo'])
                    ->from(['notas n'])
                    //->where(['n.fk_categoria' => new \yii\db\Expression('c.id'),
                    //->where(['n.fk_categoria'=> new \yii\db\Expression('c.id')])
                    ->where(new \yii\db\conditions\OrCondition([['like','n.titulo',$model->busca],['like','n.conteudo',$model->busca]]));
            $notas = $query->all();
            //$notas = Notas::find()->where(['like', 'titulo', $model->busca])->all();
            if(count($notas)>0) 
                return $this->render('index',['model'=>$model,'notas'=>$notas]);
            return $this->render('index',['model'=>$model, 'categorias'=>$categorias,'msg'=>'Nenhum registro encontrado, tente um outro termo para pesquisar.']);
        }
        return $this->render('index',['model'=>$model, 'categorias'=>$categorias]);
    }
    public function actionVisualizar()
    {
        if(Yii::$app->request->isGet) {
            $id = Yii::$app->request->get('id',false);
            if(empty($id))
                return $this->render('visualizar',['msg'=>'Você precisa selecionar um conteúdo para poder visualiza-lo, você não passou um parâmetro válido!']);

            $nota = Notas::find()->where(['id'=>$id])->one();
            if(empty($nota))
                return $this->render('visualizar',['msg'=>'Você está mau intencionado! Pois não passou um parâmetro válido!']);
        }
        return $this->render('visualizar',['nota'=>$nota]);
    }
    
    public function actionListarCategoria($id)
    {
        if(Yii::$app->request->isGet) {
            $id = Yii::$app->request->get('id',false);
            if(empty($id)) {
                Yii::$app->session->setFlash('warning','Você precisa selecionar uma categoria para visualizar os itens dela!');
                return $this->redirect('index');
            }

            $categoria = Categoria::find()->where(['id'=>$id])->one();
            if(empty($categoria)) {
                Yii::$app->session->setFlash('warning','Você está mau intencionado! Pois não passou um parâmetro válido!');
                return $this->redirect('index');
            }
        }
        return $this->render('listarCategoria',['categoria'=>$categoria]);
    }
    
    public function actionNovo()
    {
        $model = new NotasForm();
        $nota = new Notas();
        if($model->load(Yii::$app->request->post())) {
            // && $model->validate()
            $uuid1 = Uuid::uuid1();
            $nota->id = $uuid1->toString();
            $model->id = $nota->id;
            $nota->titulo = $model->titulo;
            $nota->conteudo = $model->conteudo;
            $nota->criado_por = Yii::$app->user->getId();
            $nota->datahora_criado = date("Y-m-d H:i:s");
            $nota->fk_categoria = $model->fk_categoria;
            $model->files = UploadedFile::getInstances($model, 'files');
            if(!$nota->validate()) {
                Yii::$app->session->setFlash('warning','Não foi possível gravar '
                    . ' a nota, tente novamentemais tarde, caso o problema persista, entre em contato comequipe de desenvolvimento!');
                
            } else {
                $nota->save();
                $model->upload();
                $model->id = $model->titulo = $model->fk_categoria = $model->files = $model->conteudo = "";
            }
            return $this->redirect(['visualizar', 'id'=>$nota->id]);
        }
        return $this->render('notas',['model'=>$model,'nota'=>$nota]);
    }
    
    public function actionEditar()
    {
        $model = new NotasForm();
        if($model->load(Yii::$app->request->post()) && $model->validate()) {
            $form = Yii::$app->request->post('NotasForm');
            $nota = Notas::find()->where(['id'=>$form['id']])->one();
            $model->files = UploadedFile::getInstances($model, 'files');
            if(!empty($nota)) {
                if(\Yii::$app->user->can('atualizaPropriaNota', ['nota'=> $nota])) {
                    $model->id = $nota->id;
                    $nota->conteudo = $model->conteudo;
                    $nota->atualizado_por = Yii::$app->user->getId();
                    $nota->datahora_atualizado = date("Y-m-d H:i:s");
                    $nota->fk_categoria = $model->fk_categoria;
                    $model->upload();
                    $nota->update();
                    Yii::$app->session->setFlash('success','Os dados foram salvos!');
                } else {
                    throw new ForbiddenHttpException("Não tem permissão para editar essa nota!");
                }
            } 
            return $this->render("visualizar",['nota'=>$nota]);
        }
        if(Yii::$app->request->isGet && !empty(Yii::$app->request->getQueryParam("id", ""))) {
            $id = Yii::$app->request->getQueryParam("id");
            $nota = Notas::find()->where(['id'=>$id])->one();
            if(!empty($nota)) {
                if(\Yii::$app->user->can('atualizaPropriaNota', ['nota'=> $nota])) {
                    $model->id = $nota->id;
                    $model->titulo = $nota->titulo;
                    $model->conteudo = $nota->conteudo;
                    $model->fk_categoria = $nota->fk_categoria;
                    return $this->render('notas',['model'=>$model, 'nota'=>$nota,'acao'=>'edit']);
                } else {
                    throw new ForbiddenHttpException("Não tem permissão para editar essa nota!");
                }
            }
        }
    }
    
    public function actionExcluir()
    {
        $id = Yii::$app->request->getQueryParam("id", "");
        if(Yii::$app->request->isGet && !empty($id)) {
            $nota = Notas::find()->where(['id'=>$id])->one();
            $files = File::find()->where(['fk_notas'=>$nota->id])->all();
            foreach ($files as $file) {
                $this->excluirAnexo($file->id);
            }
            $nota->delete();
            Yii::$app->session->setFlash('success','Registro excluído!');
        }
        return $this->redirect(Url::home());
    }

    public function actionUpload()
    {
         $model = new UploadForm();

        if (\Yii::$app->request->isPost) {
            $model->file = UploadedFile::getInstanceByName("file");
            if ($model->upload()) {
                //  retorno necessário { location : '/uploaded/image/path/image.png' };
                $array = ['location'=>$model->pathPublicImagem];
                return $this->asJson($array);
            }
            return $this->asJson($model->getErrors());
        }
        return $this->asJson(\Yii::$app->request->isPost);
    }
    
    public function actionExcluirAnexo($id) {
        if(empty($id))
            $id = Yii::$app->request->getQueryParam("id", "");
        $file = File::findOne($id);        
        $nota = $file->notas;
        if(Yii::$app->request->isGet && !empty($id)) {
            if($this->excluirAnexo($id))
                Yii::$app->session->setFlash('success','Anexo excluído!');
            else
                Yii::$app->session->setFlash('danger','Não foi possível excluir o anexo!');
        }
        return $this->redirect(['editar','id'=>$nota->id]);
    }
    
    private function excluirAnexo($id) {
        if(empty($id))
            throw new InvalidArgumentException('Parâmetro inválido.');
        $file = File::find()->where(['id'=>$id])->one();
        $arquivo = Yii::getAlias('@webroot')."/".$file->path;
        $diretorio = dirname($arquivo);
        if(file_exists($arquivo)) {
            if(unlink($arquivo) && rmdir($diretorio)) {
                $file->delete();
                return true;
            } else
                return false;
        } else 
            $file->delete();
        return true;
    }
}
