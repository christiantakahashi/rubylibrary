livros = []

loop do 
  puts  "=== Biblioteca Pessoal ==="
  puts  "[1] - Cadastrar livro"
  puts  "[2] - Listar todos os livros"
  puts  "[3] - Buscar livro por título"
  puts  "[4] - Marcar um livro como lido"
  puts  "[5] - Remover livro"
  puts  "[6] - Ver estatísticas"
  puts  "[0] - Sair"
  puts  "=========================="
  puts  "Digite a opção desejada: "
  opcao = gets.chomp.strip

  if opcao == "0"
    puts "=========="
    puts "Saindo..."
    puts "=========="
    break
  end

  case opcao  
  when "1"
    puts  "Digite o título do livro: "
    titulo = gets.chomp

    puts  "Digite o autor do livro: "
    autor = gets.chomp

    puts  "Digite o ano de publicação: "
    ano = gets.chomp.to_i
      
    livro = {
      titulo: titulo,
      autor: autor,
      ano: ano,
      lido: false
    }

    livros << livro
      
    puts  "============================="
    puts "Livro cadastrado com sucesso!"
    puts  "============================="

  when "2"
    if livros.empty?
      puts  "=============================="
      puts  "Nenhum livro cadastrado ainda"
      puts  "=============================="
    else
      livros.each do |livro|
        status = livro[:lido]? "[Lido]" : "[Não lido]"
        puts  "#{livro[:titulo]} - #{livro[:autor]} #{livro[:ano]} #{status}"
        puts  "=" * 30
      end
    end
      
    
  when "3"
    puts  "Digite a parte do título que deseja buscar: "
    busca = gets.chomp.downcase

    encontrados = livros.select { |livro| livro[:titulo].downcase.include?(busca)}

    if encontrados.empty?
      puts "========================================="
      puts "Nenhum livro encontrados com esse título"
    else
      encontrados.each do |livro|
        status = livro[:lido]? "[Lido]" : "[Não lido]"
        puts  "=" * 30
        puts  "#{livro[:titulo]} - #{livro[:autor]} #{livro[:ano]} #{status}"
        puts  "=" * 30
      end
    end
    

  when "4"
    puts  "Digite o título exato do livro que deseja marcar como lido: "
    titulo_busca = gets.chomp

    livro = livros.find{|l| l[:titulo].downcase == titulo_busca.downcase}
      
    if livro.nil?
      puts "====================="
      puts "Livro não encontrado"
      puts "====================="
    else
      livro[:lido] = true
      puts "========================="
      puts "Livro marcado como lido!"
      puts "========================="
    end

  when "5"
    puts  "Digite o título do livro que deseja remover: "
    titulo_busca = gets.chomp

    livro = livros.find{|l| l[:titulo].downcase == titulo_busca.downcase}
      
    if livro.nil?
      puts "====================="
      puts "Livro não encontrado"
      puts "====================="
    else
      livros.delete(livro)
      puts "==========================="
      puts "Livro removido com sucesso!"
      puts "==========================="
    end

  when "6"
    if livros.empty?
      puts "Nenhum livro cadastrado ainda."
    else
      total = livros.size
      lidos = livros.count {|l| l[:lido]}
      nao_lidos = total - lidos

      mais_antigo = livros.min_by{|l| l[:ano]}
      mais_recente = livros.max_by{|l| l[:ano]}

      puts "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
      puts "Total de livros: #{total}"
      puts "Total de livros lidos #{lidos}"
      puts "Total de livros não lidos: #{nao_lidos}"
      puts "Livro mais mais antigo: #{mais_antigo[:titulo]} (#{mais_antigo[:ano]})"
      puts "Livro mais recente: #{mais_recente[:titulo]} (#{mais_recente[:ano]})"
      puts "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-="
    end
  else
    puts  "Opção inválida, tente novamente."
  end
end 
