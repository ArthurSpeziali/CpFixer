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
end
