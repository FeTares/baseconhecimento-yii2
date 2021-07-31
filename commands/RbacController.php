<?php

namespace app\commands;

use Yii;
use yii\console\Controller;
use app\models\User;
use app\rbac\AutorRule;
/**
 * Permite gerenciar o controle de acesso da aplicação.
 * Usage:
 * Note:
 */

class RbacController extends Controller
{
    /**
     * Cria permissões, rules de exemplo. Utilize apenas quando suas tabelas estiverem vazias.
     */
    public function actionInit()
   {
       $auth = Yii::$app->authManager;

       // adciona a permissão "createPost"
       $createPost = $auth->createPermission('criarProposta');
       $createPost->description = 'Criar uma proposta comercial';
       $auth->add($createPost);

       // adciona a permissão  "updatePost"
       $updatePost = $auth->createPermission('atualizarProposta');
       $updatePost->description = 'Atualizar uma proposta comercial';
       $auth->add($updatePost);

       // adciona a rule "author" e da a esta rule a permissão "createPost"
       $author = $auth->createRole('comercial');
       $auth->add($author);
       $auth->addChild($author, $createPost);

       // adciona a rule "admin" e da a esta rule a permissão "updatePost"
       // bem como as permissões da rule "author"
       $admin = $auth->createRole('admin');
       $auth->add($admin);
       $auth->addChild($admin, $updatePost);
       $auth->addChild($admin, $author);

       // Atribui rules para usuários. 1 and 2 são IDs retornados por IdentityInterface::getId()
       // normalmente implementado no seu model User.
       $auth->assign($author, 2);
       $auth->assign($admin, 1);
   }
   /**
    * Remove todas permissões do sistema (!!limpa todas tabelas de permissões!!).
    */
   public function actionDown()
    {
        Yii::$app->authManager->removeAll();
    }
    /**
     * Atribui um usuário existente a uma rule existente.
     * @param string $rule Nome da existente rule
     * @param string $username Existente username definido para um usuário.
     * @throws \yii\base\InvalidArgumentException
     */
    public function actionAssign($rule, $username)
    {
        $user = User::find()->where(['username' => $username])->one();
        if (!$user) {
            throw new \yii\base\InvalidArgumentException("Não existe o usuário \"$username\".");
        }

        $auth = Yii::$app->authManager;
        $ruleObject = $auth->getRole($rule);
        if (!$ruleObject) {
            throw new \yii\base\InvalidArgumentException("Não existe a rule \"$rule\".");
        }

        $auth->assign($ruleObject, $user->id);
    }
    /**
     * Cria uma nova permissão no sistema.
     * @param string $permName Nome da nova permissão.
     * @param string $permDescription1 Descrição para a nova permissão.
     */
    public function actionCreatePermission($permName, $permDescription)
    {
        $auth = Yii::$app->authManager;
        $permissao = $auth->createPermission($permName);
        $permissao->description = $permDescription;
        $auth->add($permissao);
    }
    /**
     * Cria uma nova rule no sistema.
     * @param string $ruleName Nome da nova rule.
     * @param string $ruleDescription Descrição da nova rule.
     */
    public function actionCreateRule($ruleName, $ruleDescription)
    {
        $auth = Yii::$app->authManager;
        $rule = $auth->createRole($ruleName);
        $rule->description = $ruleDescription;
        $auth->add($rule);
    }
    /**
     * Atribui uma herança de uma permissão ou rule a um rule filho. 
     * @param string $pai Nome de uma existente permissão ou rule.
     * @param string $filho Nome de um existente rule que receberá herança.
     */
    public function actionAssignHeranca($pai, $filho)
    {
        $auth = Yii::$app->authManager;
        $filhoObject = $auth->getRole($filho);
        if (!$filhoObject) {
            throw new \yii\base\InvalidArgumentException("Não existe a rule \"$filho\".");
        }
        $paiObject = $auth->getPermission($pai);
        if (!$paiObject) {
            $paiObject = $auth->getRole($pai);
            if (!$paiObject) {
                throw new \yii\base\InvalidArgumentException("Não existe a permissão ou rule \"$pai\".");
            }
        }
        $auth->addChild($filhoObject, $paiObject);
    }
}
