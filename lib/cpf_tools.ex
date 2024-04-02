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


    def list_repeat(list, char, num \\ 0)
    def list_repeat([], _char, num), do: num

    def list_repeat([head | tail], char, num) when head == char do
        list_repeat(tail, char, num + 1)
    end
    
    def list_repeat([_ | tail], char, num) do
        list_repeat(tail, char, num)
    end



    def complete(cpf_str) do
        num_cpf = String.split(cpf_str, "")
                 |> Enum.slice(1..-2)
                 |> list_repeat("?")

        digits = 10 ** num_cpf
                 |> Integer.to_string
                 |> String.slice(1..-1)

        limit = 10 ** num_cpf - 1
                |> Integer.to_string


        cpf_list = cpf_str
                   |> String.split("")
                   |> Enum.slice(1..-2)

        organize(digits, cpf_list, limit)
    end
    

    defp organize(digits, cpf_list, all_list \\ [], limit)
    defp organize(digits, cpf_list, all_list, limit) when digits != limit do
        all_list = [
            organize(
                cpf_list,
                String.split(digits, "")
                |> Enum.slice(1..-2)
            )
            | all_list
        ]

        organize(
            String.to_integer(digits) + 1
            |> Integer.to_string
            |> String.pad_leading(String.length(limit), "0"),

            cpf_list,
            all_list,
            limit
        )
    end
    defp organize(_digits, _cpf_list, all_list, _limit), do: all_list

    defp organize(list, [head | tail]) do
        pos = Enum.find_index(list, &(&1 == "?"))
        list = List.update_at(
            list, 
            pos, 
            &(&1 = head)
        )

        organize(list, tail)

    end
    defp organize(list, []), do: list
end
