<?php

use yii\db\Migration;

/**
 * Class m180524_172536_adicionar_coluna_criado_por
 */
class m180524_172536_adicionar_coluna_criado_por extends Migration
{
    /**
     * {@inheritdoc}
     */
    public function safeUp()
    {
        // $db = Yii::$app->getDb();
        // $this->addColumn("notas", "criado_por", $this->string(36));
        // $this->update("notas", ['criado_por'=>'4122a802-5ac6-11e8-86e0-0022b0615904']);
        // $this->alterColumn("notas", "criado_por", $this->string(36)->notNull());
        // $db->createCommand('alter table notas modify criado_por varchar(36) character set utf8 collate utf8_bin')->execute();
        // $this->addColumn("notas", "datahora_criado", $this->dateTime());
        // $this->update("notas", ['datahora_criado'=> date("Y-m-d H:i:s")]);
        // $this->alterColumn("notas", "datahora_criado", $this->dateTime()->notNull());
        // $this->addColumn("notas", "atualizado_por", $this->string(36));
        // $db->createCommand('alter table notas modify atualizado_por varchar(36) character set utf8 collate utf8_bin')->execute();
        // $this->addColumn("notas", "datahora_atualizado", $this->dateTime());
        // $this->addForeignKey('fk-nota-autor_id','notas','criado_por','users','id','CASCADE');
    }

    /**
     * {@inheritdoc}
     */
    public function safeDown()
    {
        // $this->dropForeignKey('fk-nota-autor_id','notas');
        // $this->dropColumn("notas", "criado_por");
        // $this->dropColumn("notas", "datahora_criado");
        // $this->dropColumn("notas", "atualizado_por");
        // $this->dropColumn("notas", "datahora_atualizado");
    
    }

    /*
    // Use up()/down() to run migration code without a transaction.
    public function up()
    {

    }

    public function down()
    {
        echo "m180524_172536_adicionar_coluna_criado_por cannot be reverted.\n";

        return false;
    }
    */
}
