defmodule App.Cpf_Tools do
    def validate(list_cpf, num \\ 10)

    def validate(list_cpf, 12) do
        Enum.slice(list_cpf, -2..-1)
    end
    def validate(list_cpf, num) do
        res = multiply(list_cpf, num)
              |> rem(11)
        
        if res >= 2 do
            validate(
                list_cpf ++ [11 - res], 
                num + 1
            )
        
        else
            validate(
                list_cpf ++ [0],
                num + 1
            )
        end    
    end



    defp multiply([], _num), do: 0
    defp multiply([head | tail], num) do
        (head * num) + multiply(tail, num - 1)
    end  


    
    defp generate(num \\ 0, cpf \\ [])
    defp generate(num, cpf) when num < 9 do
        generate(
            num + 1,
            [Enum.random(0..9) | cpf]
        )
    end
    defp generate(_num, cpf), do: cpf ++ validate(cpf)

    
    def miner(list \\ [], from \\ 0, to)
    def miner(list, from, to) when from < to do
        list = [
            generate()
            |> Enum.join
            |> String.to_integer

            | list
        ]

        miner(list, from + 1, to)
    end
    def miner(list, _from, _to), do: list
end
