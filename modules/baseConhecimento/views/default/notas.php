<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use dosamigos\tinymce\TinyMce;
use yii\web\View;
use yii\web\JsExpression;
use yii\helpers\ArrayHelper;
use app\modules\baseConhecimento\models\Categoria;

?>
<?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']]) ; ?>
<?= $form->field($model,'id')->hiddenInput()->label(false) ?>
<div class="row">
    <div class="col-md-8">
        <?= $form->field($model,'titulo')->label('Título') ?>
    </div>
    <div class="col-md-4">
        <?= $form->field($model,'fk_categoria')->dropdownlist(
            ArrayHelper::map(Categoria::find()->all(), 'id', 'nome')
        )->label('Categoria') ?>
    </div>
</div>
<?= $form->field($model, 'conteudo')->widget(TinyMce::className(), [
    'options' => ['rows' => 10],
    'language' => 'pt_BR',
    'clientOptions' => [
        'plugins' => [
            "advlist autolink lists link media charmap print preview anchor",
            "searchreplace visualblocks code fullscreen",
            "insertdatetime table contextmenu paste image"
        ],
        'toolbar' => "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image",
        //'file_browser_callback'=> new yii\web\JsExpression("function(field_name, url, type, win) {
        //    alert(field_name);
        //}"),
        'images_upload_url' => \yii\helpers\Url::to(['/baseConhecimento/default/upload']),
    ]
]);
$botao = empty($acao)?"Cadastrar":"Salvar";
$classe = empty($acao)?"btn btn-success":"btn btn-primary";
?>

<div class="row">
    <div class="col-md-12">
    <?php
    $files = $nota->files;
    echo "<lu>";
    foreach ($files as $file) { 
        $link = Html::a('', ['excluir-anexo','id'=>$file->id], ['class' => 'glyphicon glyphicon-trash']);
        echo "<li>$file->nome_arquivo $link</li>"; //<span class=\"glyphicon glyphicon-trash\"></span
    }
    echo "</lu>";
    ?>
    </div>
</div>
<div class="row">
    <div class="col-md-12">
        <?= $form->field($model, 'files[]')->fileInput(['multiple' => true]) ?>
    </div>
</div>
<div class="form-group">
    <?= Html::submitButton($botao,['class' => "$classe"]) ?>
</div>
<?php ActiveForm::end(); ?>
<?php
    $this->registerJs(
        '$(".flash-success").animate({opacity: 1.0}, 3000).fadeOut("slow");',
        View::POS_READY,
        'myHideEffect'
    );
?>

<?php /* if(Yii::$app->session->hasFlash('success')):?>
    <div class="flash-success">
        <?php echo Yii::$app->session->getFlash('success'); ?>
    </div>
<?php endif; */ ?>