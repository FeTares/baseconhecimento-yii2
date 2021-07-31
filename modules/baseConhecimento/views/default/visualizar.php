<?php

/* @var $this yii\web\View */

use yii\helpers\Html;
use yii\helpers\Url;

$this->title = 'Visualizando conteúdo de:';
//$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-about">
    <h1 style="color: #cfcfcf;"><?= Html::encode($this->title) ?></h1>

<?php 
    $url_editar = "";
    $url_excluir = "";
    if(isset($msg)) {
?>
        <h3>
            <?= $msg ?>
        </h3>
<?php
    } else {
?>
        <h3>
            <?= $nota->categoria->nome . " - " . $nota->titulo ?>
        </h3>
    <h5 style="color: #cfcfcf;">Criado por <?= $nota->criadoPor->username ?> em <?= date("d/m/Y",strtotime($nota->datahora_criado)) ?>.</h5>
    <?= !empty($nota->atualizadoPor)?'<h5 style="color: #cfcfcf;">Atualizado por '.$nota->atualizadoPor->username.' em '.date("d/m/Y",strtotime($nota->datahora_atualizado)).'.</h5>':'' ?>
        <p>
            <?= $nota->conteudo ?>
        </p>
        <h5 style="color: #cfcfcf;">Anexo(s):</h5>
        <ul>
            <?php
            foreach ($nota->files as $file) {
                echo Html::a("<li>$file->nome_arquivo</li>", $file->path, ['target' => '_blank']);
            }
            ?>
        </ul>
<?php
        $url_novo = Url::to(['default/novo']);
        $url_editar = Url::to(['default/editar','id' => $nota->id]);
        $url_excluir = Url::to(['default/excluir','id' => $nota->id]);
        $url_pesquisar = Url::to(['default/index']);
    }
?>
        <div id="mais">
        <a href="<?= $url_excluir ?>">
            <img src="<?= Yii::$app->request->baseUrl ?>/img/circulo_excluir.svg" align="right" />
        </a>
        <a href="<?= $url_editar ?>">
            <img src="<?= Yii::$app->request->baseUrl ?>/img/circulo_editar.svg" align="right" />
        </a>
        <a href="<?= $url_novo ?>">
            <img src="<?= Yii::$app->request->baseUrl ?>/img/circulo_mais.svg" align="right"/>
        </a>
        <a href="<?= $url_pesquisar ?>">
            <img src="<?= Yii::$app->request->baseUrl ?>/img/circulo_pesquisar.svg" align="right"/>
        </a>
    </div>
</div>
<?php
    $this->registerJs(
        '$(".flash-success").animate({opacity: 1.0}, 3000).fadeOut("slow");',
        $this::POS_READY,
        'myHideEffect'
    );
?>

<?php /* if(Yii::$app->session->hasFlash('success')):?>
    <div class="flash-success">
        <?php echo Yii::$app->session->getFlash('success'); ?>
    </div>
<?php endif; */ ?>