ENV["RAILS_ENV"] ||= "test"
ENV["FIXTURE_ORDER"] = 
  %w( pronomes_usuarios usuario_cargos usuarios turno_turmas modalidade_turmas turmas matriculas cursos disciplinas unidade_disciplinas conteudos leitura_conteudos comunicados reacao_comunicados ).join(' ')

require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :pronomes_usuarios, :usuario_cargos, :usuarios, :cursos,
  :turno_turmas, :modalidade_turmas, :turmas, :matriculas, :disciplinas, :unidade_disciplinas, :conteudos, :leitura_conteudos, :comunicados, :reacao_comunicados

  # Add more helper methods to be used by all tests here...
end
