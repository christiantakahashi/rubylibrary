  # Inicializando o array vazio,
  # ele vai representar ao array que guardara todos livros cadastrados.
livros = []

  # Repete o programa indefinidamente, exibindo o menu de opções e
  # lendo a escolha do usuário com o gets.chomp.strip. Só termina quando
  # a opção "0" aciona o break.
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

    # Aqui o case vai executar a opção que o usuário escolheu.
  case opcao  
  
    # Opção 1 - cadastrar livro, pede o título, autor e ano(convertido para inteiro com to_i)
    # monta um hash (chave e valor) com esses dados mais lido:false e o adiciona ao array livros
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

    # Opção 2 - Lista todos livros cadastrados. Se o array estiver vazio
    # avisa que não há livros, caso contrário, percorre cada livro
    # e implementa titulo, autor, ano e o status
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
      
    # Opção 3 - Busca livro pelo título. Pede um trecho do título e usa o select para
    # filtrar os livors cujo título (em mínusculas) contém o texto buscado
    # Tem como saída os encontrados com seus dados, ou avisa que nenhum foi encontrado
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
    
    # Opção 4 - Maca livro como lido. Pede o título exato e localiza o livro com find, ignorando
    # maisuculas/minusculas. Se  achar, altera lido para true; se não,
    # informa que não foi encontrado.
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
  
    # Opção 5 - Remove livro do array. Usa a mesma busca exata por título da opção 4.
    # Se o livro existir, remove-o do array com o delete, caso contrário
    # avisa que não foi encontrado.
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

    # Opção 6 - Ver estatísticas. Se houver livros, calcula o total, a quantidade
    # de lidos "count" e de não lidos (total menos lidos). Também encontra o 
    # livro mais antigo (min_by) e o mais recente(max_by) pelo ano, e exibe tudo formatado
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

    # Vai tratar qualquer entrada fora das opções do menu, exibindo "Opção inválida, tente novamente"
    # e voltando ao início do loop.
  else
    puts  "Opção inválida, tente novamente."
  end
end 
