<?php

/* @var $this yii\web\View */

use yii\helpers\Html;
use yii\helpers\Url;
use QueryPath;

$this->title = 'Visualizando conteúdos da categoria: '.$categoria->nome;
//$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-about">
    <h1 style="color: #cfcfcf;"><?= Html::encode($this->title) ?></h1>
</div>
<?php
$notas = $categoria->notas;
foreach ($notas as $n) {
    $url = Url::to(['default/visualizar','id' => $n['id']]);
?>
    <div>
        <div><a href="<?= $url ?>"><h3><?= $n['titulo'] ?></h3></a></div>
        <div><?= substr(htmlqp($n['conteudo'])->text(),0,300) ?> ...</div>
    </div>
<?php 
}
?>
<?php
    $this->registerJs(
        '$(".flash-success").animate({opacity: 1.0}, 3000).fadeOut("slow");',
        $this::POS_READY,
        'myHideEffect'
    );
?>