defmodule App.Exec do
    @home System.user_home

    @hep_msg """
    Como usar:
        cpfixer [argumento] {valor} (arquivo de saída)

    Argumentos:
        help -> Exibe esta tela de ajuda {Não recebe valor}.
        update -> Atualiza o executavel usando o git + escript {Não recebe valor}.
        validate -> Valida se o valor recbido é um CPF válido, retorna "True" ou "False".
        miner -> Gera o número do valor recebido em CPF's aleatórios.
        complete -> Gera todas as possibilidades de auto-completar o valor recebido como CPF.
    
    Ajuda:
        "Posso colocar 'acentuação' no número do CPF?" -> O executável ignora os carácteres: "." e "-".
        "Onde fica os outros arquivos para o executavel funcionar?" -> Na pasta ".cpfixer", dentro da sua pasta $HOME
        "Quero colocar a saída do arquivo em um arquivo, como faço?" -> Adicione no comando o arquivo, Ex: `cpfixer miner 1000 /diretorio/para/o/arquivo.txt`.
    """


    if File.exists?("#{@home}/.cpfixer/cpf_tools.ex"), do: Code.require_file("#{@home}/.cpfixer/cpf_tools.ex")

    def main([]) do
        IO.puts("cpfixer: Falta de argumento\nTente 'cpfixer help' para mais informações.")
    end

    def main(args) do
        case List.first(args) do
            "help" -> 
                IO.puts(@hep_msg)

            "update" ->
                IO.puts("Atualizando com o GIT.")
                System.cmd("mkdir", ["-p", "#{@home}/.cpfixer"])
                System.cmd("rm", ["-rf", "#{@home}/.cpfixer"])

                System.cmd(
                    "git",
                    [
                        "clone",
                        "-b",
                        "exec",
                        "https://github.com/ArthurSpeziali/CpFixer",
                        "#{@home}/.cpfixer"
                    ]
                )


            "validate" ->
                if length(args) == 1 do
                    IO.puts("cpfixer: Falta de valor\nTente 'cpfixer help' para mais informações.")
                else
                    validate(
                        args,
                        Enum.at(args, 1)
                    )
                end

            "miner" ->
                if length(args) == 1 do
                    IO.puts("cpfixer: Falta de valor\nTente 'cpfixer help' para mais informações.")

                else
                    try do
                        String.to_integer(Enum.at(args, 1))
                    rescue
                        ArgumentError ->
                            write(args, "False")
                    else
                        value ->
                            miner(
                                args,
                                App.Cpf_Tools.miner(value)
                            )
                    end
                end

            "complete" ->
                if length(args) == 1 do
                    IO.puts("cpfixer: Falta de valor\nTente 'cpfixer help' para mais informações.")
                else
                    complete(args, Enum.at(args, 1))
                end
               

            _ -> IO.puts("cpfixer: Argumento inválido\nTente 'cpfixer help' para mais informações.")
        end
    end

    defp validate(args, value) do
        value = String.replace(value, ".", "")
                |> String.replace("-", "")
                |> String.split("")
                |> Enum.slice(1..-2)

        try do
            Enum.map(
                value,
                &(&1 = String.to_integer(&1))
            )
        rescue
            ArgumentError ->
                write(args, "False")
        else
            value -> 
                if App.Cpf_Tools.validate(
                    Enum.slice(value, 0..-3)
                ) == Enum.slice(value, -2..-1) do
                    write(args, "True")
                else
                    write(args, "False")
                end
        end
    end


    defp write(args, value) when length(args) > 2 do
        File.write(
            Enum.at(args, 2),
            value <> "\n",
            [:append]
        )
    end

    defp write(_args, value), do: IO.puts(value)


    def miner(_args, []), do: nil
    def miner(args, [value | tail]) do
        write(args, value)
        miner(args, tail)
    end


    def complete(args, value) do
        if String.contains?(value, "?") do
            try do
                String.replace(value, "?", "")
                |> String.to_integer

            rescue
                ArgumentError ->
                    write(args, "False")
            else
                _ ->
                    list_cpf = App.Cpf_Tools.complete(
                        value
                    )
                    
                    int_list = for item <- list_cpf do
                        Enum.join(item)
                    end
                
                    cpf_list = Enum.filter(
                        int_list,
                        fn
                            (value) ->
                                App.Cpf_Tools.validate(
                                    String.split(value, "")
                                    |> Enum.slice(1..-2)
                                    |> Enum.slice(0..-3)
                                    |> Enum.map(&(String.to_integer(&1)))
                                
                                ) == String.split(value, "")
                                    |> Enum.slice(1..-2)
                                    |> Enum.slice(-2..-1)
                                    |> Enum.map(&(String.to_integer(&1)))
                        end
                    )
                    for item <- cpf_list do
                        write(args, item)
                    end
            end
        else
            write(args, "False")
        end
    end
end
