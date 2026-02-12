class CreateAvaliacaoAlfabetizacaoUfs < ActiveRecord::Migration[8.0]
  def change
    create_table :avaliacao_alfabetizacao_ufs do |t|
      t.integer :ano
      t.string :sigla_uf
      t.integer :serie
      t.integer :rede
      t.decimal :taxa_alfabetizacao, precision: 5, scale: 2
      t.decimal :media_portugues, precision: 7, scale: 4
      t.decimal :proporcao_aluno_nivel_0, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_1, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_2, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_3, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_4, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_5, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_6, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_7, precision: 5, scale: 2
      t.decimal :proporcao_aluno_nivel_8, precision: 5, scale: 2

      t.timestamps
    end
  end
end
