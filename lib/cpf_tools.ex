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
end
