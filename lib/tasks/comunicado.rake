namespace :comunicado do
  desc "Cria um comunicado automático para conteúdos liberados"
  task conteudo_liberado: :environment do
    Conteudo.all.each do |conteudo|
      puts "NOVO COMUNICADO: "
    end
  end
end
