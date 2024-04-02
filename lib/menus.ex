defmodule App.Menus do
    def main(list) do
        response = IO.gets("> ")
                   |> String.downcase
                   |> String.trim

        unless response in list do
            IO.puts("\nOpção inválida, tente novamente!\n")
            main(list)

        else
            IO.puts("\e[2J\e[H")
            response
        end
    end



    defp cpf_ask do
        response = IO.gets("> ")
                   |> String.replace("-", "")
                   |> String.replace(".", "")
                   |> String.replace(" ", "")
                   |> String.trim_trailing("\n")
        
        cpf_ask(:int, response)
    end

    defp cpf_ask(:int, response) do
        try do
            String.to_integer(response)
        rescue
            ArgumentError -> 
                IO.puts("\nNúmero inválido, tente novamente!\n")
                cpf_ask()
        else
           _ -> cpf_ask(:len, response)
        end
    end

    defp cpf_ask(:len, response) do
        if String.length(response) != 11 do
            IO.puts("\nTamanho do CPF inválido, tente novamente!\n")
            cpf_ask()
        else
            cpf_ask(:dig, response)
        end
    end

    defp cpf_ask(:dig, response) do
        if repite_char?(String.codepoints(response)) do
            IO.puts("\nTodos os dígitos foram repetidos, tente novamente!\n")
            cpf_ask()
        else
            IO.puts("\e[2J\e[H")

            String.to_integer(response)
            |> Integer.digits
        end
    end
 


    def repite_char?(list_string, first \\ "*")

    def repite_char?([], _first), do: true
    def repite_char?(list_string, first) do
        [head | tail] = list_string

        if first in ["*" | list_string] do
            repite_char?(tail, head)
        else
            false

        end
    end



    def cpf_validate do
        IO.puts("Digite o CPF:\n")

        cpf = cpf_ask()
        dv = App.Cpf_Tools.validate(
            Enum.slice(cpf, 0..-3)
        )

        if Enum.slice(cpf, -2..-1) == dv do
            IO.puts("CPF Válido!\n")
        else
            IO.puts("CPF Inválido!\n")
        end


        IO.puts("Digite '0' para continuar:")
        response = IO.gets("> ")
                   |> String.replace(" ", "")
                   |> String.trim_trailing("\n")
        
        if response == "0" do
            IO.puts("\e[2J\e[H")
            cpf_validate()
        end

    end
    
    
    defp number_ask do
        number = IO.gets("> ")
                 |> String.trim_trailing("\n")
                 |> String.replace("_", "")

        try do
            String.to_integer(number)
        rescue
            ArgumentError ->
                IO.puts("\nNúmero inválido, tente novamente!\n")
                number_ask()
        else
            _ -> String.to_integer(number)
        end

    end



    def cpf_file do
        number = number_ask()
        
        path = "#{__DIR__}/../cpf-list.txt"
        File.write(path, "")

        for item <- App.Cpf_Tools.miner(number) do
                    File.write(
                        path,
                        Integer.to_string(item) <> "\n",
                        [:append]
                    )
    
    
        end
    end
end
