<?php

namespace app\controllers;

use Yii;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;
use app\models\LoginForm;
use app\models\ContactForm;
use app\models\BuscaForm;
use app\models\Notas;
use app\models\NotasForm;
use app\models\User;
use Ramsey\Uuid\Uuid;
use yii\helpers\Url;
use yii\db\Query;
use yii\web\ForbiddenHttpException;

class SiteController extends Controller
{
    public function actionIndex()
    {
        $model = new BuscaForm();
        if($model->load(Yii::$app->request->post()) && $model->validate()) {
            $query = new Query();
            $query->select('id, titulo, conteudo')
                    ->from('notas')
                    ->where(['like','titulo', $model->busca])
                    ->orWhere(['like','conteudo', $model->busca]);
            $notas = $query->all();
            //$notas = Notas::find()->where(['like', 'titulo', $model->busca])->all();
            if(count($notas)>0) 
                return $this->render('index',['model'=>$model,'notas'=>$notas]);
            return $this->render('index',['model'=>$model,'msg'=>'Nenhum registro encontrado, tente um outro termo para pesquisar.']);
      
        }
        return $this->render('index',['model'=>$model]);
    }

    /**
    * {@inheritdoc}
    */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout', 'index','login'],
                'rules' => [
                    [
                        'actions' => ['login'],
                        'allow' => true,
                        'roles'=>['?','@'],
                    ],
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@']
                    ],
                    [
                        'actions' => ['index'],
                        'allow' => true,
                        'roles' => ['Todos']
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

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Login action.
     *
     * @return Response|string
     */
    public function actionLogin()
    {
        $session = Yii::$app->session;
        if(empty($session['usr_login'])) {
            if (!Yii::$app->user->isGuest) {
                return $this->goHome();
            }

            $model = new LoginForm();
            if ($model->load(Yii::$app->request->post()) && $model->login()) {
                return $this->goBack();
            }

            $model->password = '';
            return $this->render('login', [
                'model' => $model,
            ]);
        } else {
            Yii::$app->user->login(User::findOne(['username' => $session['usr_login']]), true ? 3600*24*30 : 0);
            return $this->goBack();
        }
    }

    /**
     * Logout action.
     *
     * @return Response
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    /**
     * Displays contact page.
     *
     * @return Response|string
     */
    public function actionContact()
    {
        $model = new ContactForm();
        if ($model->load(Yii::$app->request->post()) && $model->contact(Yii::$app->params['adminEmail'])) {
            Yii::$app->session->setFlash('contactFormSubmitted');

            return $this->refresh();
        }
        return $this->render('contact', [
            'model' => $model,
        ]);
    }

    /**
     * Displays about page.
     *
     * @return string
     */
    public function actionAbout()
    {
        return $this->render('about');
    }
}
