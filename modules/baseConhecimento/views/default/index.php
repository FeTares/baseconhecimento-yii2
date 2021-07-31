<?php

use yii\widgets\ActiveForm;
use yii\helpers\Url;
use yii\helpers\Html;
//      use QueryPath;

/* @var $this yii\web\View */

$this->title = 'Base de Conhecimento Desenvolvimento';
?>
<div class="site-index">

    <style> 
        input[type=text] {
            width: 300px;
            height: 50px;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            background-color: white;
            background-image: url('img/searchicon.png');
            background-position: 10px 13px; 
            background-repeat: no-repeat;
            padding: 12px 20px 12px 40px;
            -webkit-transition: width 0.4s ease-in-out;
            transition: width 0.4s ease-in-out;
        }

        input[type=text]:focus {
            width: 500px;
        }
        #busca {
            text-align: center;
             position: relative;            
        }
    </style>
    
    <div class="jumbotron">
        <h1 style="color: grey;">Base de Conhecimento Desenvolvimento</h1>

        <p class="lead">Aqui você pode guardar e compartilhar suas anotações, para acessá-las a qualquer momento, de forma rápida e fácil! Obrigado por compartilhar o seu conhecimento!</p>

        <div id="busca">
            <?php $form = ActiveForm::begin(['options' => ['style' => 'display: inline-block;'], 'method' => 'get']); ?>
            <?= $form->field($model,'busca')->label(false) ?>
            <?php ActiveForm::end(); ?>
        </div>
    </div>
    <?php if(isset($msg)) { ?>
    <div style="text-align: center;">
        <h3>
            <?= $msg ?>
        </h3>
        <br />
    </div>
    <?php 
        }
        if(isset($categorias) && count($categorias)) {
            $i=1;
            foreach ($categorias as $key => $value) {
                if($i==1) echo '<div class="row" style="height:50px">';
                echo '<div class="col-md-3" style="text-align: center;">';
                echo Html::a($value->nome, Url::to(['listar-categoria', 'id' => $value->id]), ['class' => 'btn btn-default']);
                echo '</div>';
                if($i==4) { echo '</div>'; $i=0; }
                if(count($categorias) == $key+1) {echo '</div>';}
                $i++;
            }
        } else if(isset ($notas)) { 
            foreach ($notas as $n) {
                $url = Url::to(['default/visualizar','id' => $n['id']]);
    ?>
                <div>
                    <div><a href="<?= $url ?>"><h3><?= $n['titulo'] ?></h3></a></div>
                    <div><?= substr(htmlqp($n['conteudo'])->text(),0,300) ?> ...</div>
                </div>
    <?php 
            }
        }
    ?>
    <style>
        #mais {
            position: fixed;
            bottom: 100px;
            right: 50px;
        }
    </style>
    <div id="mais">
        <?php
        $urlNovo = Url::to(['default/novo']);
        ?>
        <a href="<?= $urlNovo ?>">
            <img src="<?= Yii::$app->request->baseUrl ?>/img/circulo_mais.svg" />
        </a>
    </div>
</div>
<?php
    $this->registerJs(
        '$("#buscaform-busca").focus();$(".flash-success").animate({opacity: 1.0}, 3000).fadeOut("slow");',
        $this::POS_READY,
        'myHideEffect'
    );
?>

<?php /* if(Yii::$app->session->hasFlash('success')):?>
    <div class="flash-success">
        <?php echo Yii::$app->session->getFlash('success'); ?>
    </div>
<?php endif; */ ?>
