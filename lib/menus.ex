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


    def cpf do
        response = IO.gets("> ")
                   |> String.replace("-", "")
                   |> String.replace(".", "")
                   |> String.replace(" ", "")
                   |> String.trim_trailing("\n")
        
        cpf(:int, response)
    end

    defp cpf(:int, response) do
        try do
            String.to_integer(response)
        rescue
            ArgumentError -> 
                IO.puts("\nNúmero inválido, tente novamente!\n")
                cpf()
        else
           _ -> cpf(:len, response)
        end
    end

    defp cpf(:len, response) do
        if String.length(response) != 11 do
            IO.puts("\nTamanho do CPF inválido, tente novamente!\n")
            cpf()
        else
            cpf(:dig, response)
        end
    end

    defp cpf(:dig, response) do
        if repite_char?(String.codepoints(response)) do
            IO.puts("\nTodos os dígitos foram repetidos, tente novamente!\n")
            cpf()
        else
            IO.puts("\e[2J\e[H")
            response
        end
    end
 


    defp repite_char?(list_string, first \\ "*")

    defp repite_char?([], _first), do: true
    defp repite_char?(list_string, first) do
        [head | tail] = list_string

        if first in ["*" | list_string] do
            repite_char?(tail, head)
        else
            false

        end
    end
end
