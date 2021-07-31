<?php

namespace app\modules\baseConhecimento\models;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\modules\baseConhecimento\models\Categoria;

/**
 * CategoriaSearch represents the model behind the search form of `app\modules\baseConhecimento\models\Categoria`.
 */
class CategoriaSearch extends Categoria
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['id', 'nome', 'descricao'], 'safe'],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = Categoria::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere(['like', 'id', $this->id])
            ->andFilterWhere(['like', 'nome', $this->nome])
            ->andFilterWhere(['like', 'descricao', $this->descricao]);

        return $dataProvider;
    }
}
