defmodule AppTest do
    use ExUnit.Case, async: true
    setup do
        %{cpf_num: 117_795_906_28, cpf_list: [1,1,7,7,9,5,9,0,6]}
    end
    
    @tag :validate
    test "Testando CPF é válido", %{cpf_list: cpf} do

        assert App.Cpf_Tools.validate(cpf, 10) == [2, 8]
    end


    @tag :miner
    test "Testando se consigo minerar os CPFs"do
        assert App.Cpf_Tools.miner(10)
            |> Enum.count == 10
    end
end
