defmodule App.Exec do
    @hep_msg """
    Como usar:
        cpfixer [argumento] {valor} (arquivo de saída)

    Argumentos:
        help -> Exibe esta tela de ajuda {Não recebe valor}.
        update -> Atualiza o executavel usando o git + mix {Não recebe valor}.
        validate -> Valida se o valor recbido é um CPF válido, retorna "True" ou "False".
        miner -> Gera o número do valor recebido em CPF's aleatórios.
        complete -> Gera todas as possibilidades de auto-completar o valor recebido como CPF.
    
    Ajuda:
        "Posso colocar 'acentuação' no número do CPF?" -> O executável ignora os carácteres: "." e "-".
        "Como acesso o executável de qualquer lugar?" -> Mova este executavel ao $PATH do seu sistema.
        "Quero colocar a saída do arquivo em um arquivo, como faço?" -> Adicione no comando o arquivo, Ex: `cpfixer miner 1000 /diretorio/para/o/arquivo.txt`.
    """


    def main([]) do
        IO.puts("cpfixer: Falta de argumento\nTente 'cpfixer help' para mais informações.")
    end

    def main(args) do
        case List.first(args) do
            "help" -> 
                IO.puts(@hep_msg)

            "update" ->
                IO.puts("Executável já atualizado!")

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
                true

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
        write(args, Integer.to_string(value))
        miner(args, tail)
    end
end
